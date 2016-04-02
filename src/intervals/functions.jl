# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Powers

# CRlibm does not contain a correctly-rounded ^ function for Float64
# Use the BigFloat version from MPFR instead, which is correctly-rounded:

# Write explicitly like this to avoid ambiguity warnings:
for T in (:Integer, :Rational, :Float64, :BigFloat, :Interval)

    @eval ^(a::Interval{Float64}, x::$T) = convert(Interval{Float64}, big53(a)^x)
end


# Integer power:

function ^(a::Interval{BigFloat}, n::Integer)
    isempty(a) && return a
    n == 0 && return one(a)
    n == 1 && return a
    n == 2 && return sqr(a)
    n < 0 && a == zero(a) && return emptyinterval(a)

    T = BigFloat

    if isodd(n) # odd power
        isentire(a) && return a
        if n > 0
            a.lo == zero(T) && return @round(T, zero(T), a.hi^n)
            a.hi == zero(T) && return @round(T, a.lo^n, zero(T))
            return @round(T, a.lo^n, a.hi^n)
        else
            if a.lo ≥ zero(T)
                a.lo == zero(T) && return @round(T, a.hi^n, convert(T, Inf))
                return @round(T, a.hi^n, a.lo^n)

            elseif a.hi ≤ zero(T)
                a.hi == zero(T) && return @round(T, convert(T, -Inf), a.lo^n)
                return @round(T, a.hi^n, a.lo^n)
            else
                return entireinterval(a)
            end
        end

    else # even power
        if n > 0
            if a.lo ≥ zero(T)
                return @round(T, a.lo^n, a.hi^n)
            elseif a.hi ≤ zero(T)
                return @round(T, a.hi^n, a.lo^n)
            else
                return @round(T, mig(a)^n, mag(a)^n)
            end

        else
            if a.lo ≥ zero(T)
                return @round(T, a.hi^n, a.lo^n)
            elseif a.hi ≤ zero(T)
                return @round(T, a.lo^n, a.hi^n)
            else
                return @round(T, mag(a)^n, mig(a)^n)
            end
        end
    end
end

function sqr{T<:Real}(a::Interval{T})
    isempty(a) && return a
    if a.lo ≥ zero(T)
        return @round(T, a.lo^2, a.hi^2)

    elseif a.hi ≤ zero(T)
        return @round(T, a.hi^2, a.lo^2)
    end

    return @round(T, mig(a)^2, mag(a)^2)
end

# Floating-point power of a BigFloat interval:
function ^(a::Interval{BigFloat}, x::AbstractFloat)
    T = BigFloat
    domain = Interval(zero(T), convert(T, Inf))

    if a == zero(a)
        a = a ∩ domain
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(x) && return a^(round(Int, x))
    x == one(T)/2 && return sqrt(a)

    a = a ∩ domain
    (isempty(x) || isempty(a)) && return emptyinterval(a)

    xx = @interval(x)

    lo = @round(T, a.lo^xx.lo, a.lo^xx.lo)
    lo1 = @round(T, a.lo^xx.hi, a.lo^xx.hi)
    hi = @round(T, a.hi^xx.lo, a.hi^xx.lo)
    hi1 = @round(T, a.hi^xx.hi, a.hi^xx.hi)

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function ^{T<:Integer,}(a::Interval{Rational{T}}, x::AbstractFloat)
    a = Interval(a.lo.num/a.lo.den, a.hi.num/a.hi.den)
    a = a^x
    convert(Interval{Rational{T}}, a)
end

# Rational power
function ^{S<:Integer}(a::Interval{BigFloat}, r::Rational{S})
    T = BigFloat
    domain = Interval(zero(a.lo), convert(T, Inf))

    if a == zero(a)
        a = a ∩ domain
        r > zero(r) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(r) && return convert(Interval{T}, a^round(S,r))
    r == one(S)//2 && return sqrt(a)

    a = a ∩ domain
    (isempty(r) || isempty(a)) && return emptyinterval(a)

    r = r.num / r.den
    a = a^r

    convert(Interval{T}, a)
end

# Interval power of an interval:
function ^(a::Interval{BigFloat}, x::Interval)
    T = BigFloat
    domain = Interval(zero(T), convert(T, Inf))

    a = a ∩ domain

    (isempty(x) || isempty(a)) && return emptyinterval(a)

    lo1 = a^x.lo
    lo2 = a^x.hi
    lo1 = hull(lo1, lo2)

    hi1 = a^x.lo
    hi2 = a^x.hi
    hi1 = hull(hi1, hi2)

    hull(lo1, hi1)
end


Base.inf(x::Rational) = 1//0  # to allow sqrt()


function sqrt{T}(a::Interval{T})
    domain = Interval(zero(T), convert(T, Inf))
    a = a ∩ domain

    isempty(a) && return a

    @round(T, sqrt(a.lo), sqrt(a.hi))  # `sqrt` is correctly-rounded
end


for f in (:exp, :expm1)
    @eval begin
        function ($f){T}(a::Interval{T})
            isempty(a) && return a
            Interval( ($f)(a.lo, RoundDown), ($f)(a.hi, RoundUp) )
        end
    end
end

for f in (:exp2, :exp10)

    @eval function ($f)(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
            setrounding(BigFloat, r) do
                ($f)(x)
            end
        end

    @eval ($f)(a::Interval{Float64}) = float($f(big53(a)))  # no CRlibm version

    @eval function ($f)(a::Interval{BigFloat})
            isempty(a) && return a
            Interval( ($f)(a.lo, RoundDown), ($f)(a.hi, RoundUp) )
        end
end


for f in (:log, :log2, :log10, :log1p)

    @eval function ($f){T}(a::Interval{T})
            domain = Interval(zero(T), convert(T, Inf))
            a = a ∩ domain

            (isempty(a) || a.hi ≤ zero(T)) && return emptyinterval(a)

            Interval( ($f)(a.lo, RoundDown), ($f)(a.hi, RoundUp) )
        end
end
