# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Powers
# Integer power:
function ^{T<:Real}(a::Interval{T}, n::Integer)
    isempty(a) && return a
    n == 0 && return one(a)
    n == 1 && return a
    n == 2 && return sqr(a)
    n < 0 && a == zero(a) && return emptyinterval(a)

    if isodd(n) # odd power
        isentire(a) && return a
        if n > 0
            a.lo == zero(T) && return @controlled_round(T, zero(T), a.hi^n)
            a.hi == zero(T) && return @controlled_round(T, a.lo^n, zero(T))
            return @controlled_round(T, a.lo^n, a.hi^n)
        else
            if a.lo ≥ zero(T)
                a.lo == zero(T) && return @round(T, a.hi^n, convert(T,Inf))
                return @round(T, a.hi^n, a.lo^n)
            elseif a.hi ≤ zero(T)
                a.hi == zero(T) && return @round(T, convert(T,-Inf), a.lo^n)
                return @round(T, a.hi^n, a.lo^n)
            else
                return entireinterval(a)
            end
        end
    else # even power
        if n > 0
            if a.lo ≥ zero(T)
                return @controlled_round(T, a.lo^n, a.hi^n)
            elseif a.hi ≤ zero(T)
                return @controlled_round(T, a.hi^n, a.lo^n)
            else
                return @controlled_round(T, mig(a)^n, mag(a)^n)
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
        !isthin(a) && return @controlled_round(T, a.lo^2, a.hi^2)
        return a*a
    elseif a.hi ≤ zero(T)
        !isthin(a) && return @controlled_round(T, a.hi^2, a.lo^2)
        return a*a
    else
        return @controlled_round(T, mig(a)^2, mag(a)*mag(a))
    end
end

# Floatingpoint power of a Float64/BigFloat interval:
function ^{T<:Union{Float64,BigFloat}}(a::Interval{T}, x::AbstractFloat)
    domain = Interval(zero(T), Inf)

    if a == zero(a)
        a = a ∩ domain
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end
    isinteger(x) && return a^(round(Int,x))
    x == one(T)/2 && return sqrt(a)

    a = a ∩ domain
    (isempty(x) || isempty(a)) && return emptyinterval(a)

    if T == BigFloat
        xx  = @biginterval(x)
        lo = @controlled_round(T, a.lo^xx.lo, a.lo^xx.lo)
        lo1 = @controlled_round(T, a.lo^xx.hi, a.lo^xx.hi)
        hi = @controlled_round(T, a.hi^xx.lo, a.hi^xx.lo)
        hi1 = @controlled_round(T, a.hi^xx.hi, a.hi^xx.hi)
        lo = hull(lo, lo1)
        hi = hull(hi, hi1)
    else
        lo, hi = with_bigfloat_precision(53) do
            aa = Interval(big(a.lo), big(a.hi)) # before: @biginterval(a)
            xx = @biginterval(x)
            lo = @controlled_round(BigFloat, a.lo^xx.lo, a.lo^xx.lo)
            lo1 = @controlled_round(BigFloat, a.lo^xx.hi, a.lo^xx.hi)
            hi = @controlled_round(BigFloat, a.hi^xx.lo, a.hi^xx.lo)
            hi1 = @controlled_round(BigFloat, a.hi^xx.hi, a.hi^xx.hi)
            float(hull(lo, lo1)), float(hull(hi, hi1))
        end
    end
    return hull(lo, hi)
end
function ^{T<:Integer,}(a::Interval{Rational{T}}, x::AbstractFloat)
    a = Interval(a.lo.num/a.lo.den, a.hi.num/a.hi.den)
    a = a^x
    make_interval(Rational{T}, a)
end

# Rational power
function ^{T<:Real, S<:Integer}(a::Interval{T}, r::Rational{S})
    domain = Interval(zero(a.lo), Inf)

    if a == zero(a)
        a = a ∩ domain
        r > zero(r) && return zero(a)
        return emptyinterval(a)
    end
    isinteger(r) && return make_interval(T, a^(round(S,r)))
    r == one(S)//2 && return make_interval(T, sqrt(a))

    a = a ∩ domain
    (isempty(r) || isempty(a)) && return emptyinterval(a)

    r = r.num / r.den
    a = a^r
    make_interval(T, a)
end

# Interval power of an interval:
function ^{T<:Real}(a::Interval{T}, x::Interval)
    domain = Interval(zero(T), Inf)

    a = a ∩ domain

    (isempty(x) || isempty(a)) && return emptyinterval(a)

    lo1 = a^x.lo
    lo2 = a^x.hi
    lo1 = hull( lo1, lo2 )

    hi1 = a^x.lo
    hi2 = a^x.hi
    hi1 = hull( hi1, hi2 )

    hull(lo1, hi1)
end


Base.inf(x::Rational) = 1//0  # to allow sqrt()


function sqrt{T}(a::Interval{T})
    domain = Interval(zero(T), Inf)
    a = a ∩ domain

    isempty(a) && return a

    @controlled_round(T, sqrt(a.lo), sqrt(a.hi))
end


function exp(a::Interval{Float64})
    isempty(a) && return a
    Interval(exp(a.lo, RoundDown), exp(a.hi, RoundUp))
end

for fn in (:exp2, :exp10)
    @eval begin
        function ($fn)(a::Interval{Float64})
            isempty(a) && return a
            res = with_bigfloat_precision(53) do
                res = ($fn)(Interval(big(a.lo), big(a.hi)))
            end
            float(res)
        end
    end
end

for fn in (:exp, :exp2, :exp10)
    @eval begin
        function ($fn)(a::Interval{BigFloat})
            isempty(a) && return a
            @round(BigFloat, ($fn)(a.lo), ($fn)(a.hi))
        end
    end
end

for fn in (:log, :log2, :log10)
    @eval begin
        function ($fn)(a::Interval{Float64})
            domain = Interval(0.0, Inf)
            a = a ∩ domain

            (isempty(a) || a.hi ≤ 0.0) && return emptyinterval(a)

            Interval(($fn)(a.lo, RoundDown), ($fn)(a.hi, RoundUp))
        end
        function ($fn)(a::Interval{BigFloat})
            domain = Interval(big(0.0), Inf)
            a = a ∩ domain

            (isempty(a) || a.hi ≤ big(0.0)) && return emptyinterval(a)

            @round(BigFloat, ($fn)(a.lo), ($fn)(a.hi))
        end
    end
end
