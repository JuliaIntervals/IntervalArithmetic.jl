# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Power functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3, with addition of the `sqr` function.
=#

# CRlibm does not contain a correctly-rounded ^ function for Float64
# Use the BigFloat version from MPFR instead, which is correctly-rounded:

# Write explicitly like this to avoid ambiguity warnings:
for T in (:Integer, :Float64, :BigFloat, :Interval)
    @eval ^(a::Interval{Float64}, x::$T) = Interval{Float64}((@biginterval(a))^x)
end


# Integer power:

# overwrite new behaviour for small integer powers from
# https://github.com/JuliaLang/julia/pull/24240:

Base.literal_pow(::typeof(^), x::Interval{T}, ::Val{p}) where {T,p} = x^p

# CRlibm does not contain a correctly-rounded ^ function for Float64
# Use the BigFloat version from MPFR instead, which is correctly-rounded.
"""
    ^(a::Interval, b::Interval)
    ^(a::Interval, b)

Implement the `pow` function of the IEEE Std 1788-2015 (Table 9.1).
"""
^(a::F, b::F) where {F<:Interval} = F((@biginterval(a))^b)
^(a::F, x::AbstractFloat) where {F<:Interval{BigFloat}} = a^big(x)

for T in (:AbstractFloat, :Integer)
    @eval ^(a::F, x::$T) where {F<:Interval} = F((@biginterval(a))^x)
end

function ^(a::F, n::Integer) where {F<:Interval{BigFloat}}
    isempty(a) && return a
    iszero(n) && return one(F)
    n == 1 && return a
    n < 0 && isthinzero(a) && return emptyinterval(F)

    if isodd(n) # odd power
        isentire(a) && return a
        if n > 0
            iszero(inf(a)) && return @round(F, 0, sup(a)^n)
            iszero(sup(a)) && return @round(F, inf(a)^n, 0)
            return @round(F, inf(a)^n, sup(a)^n)
        else
            if inf(a) ≥ 0
                iszero(inf(a)) && return @round(F, sup(a)^n, Inf)
                return @round(F, sup(a)^n, inf(a)^n)

            elseif sup(a) ≤ 0
                iszero(sup(a)) && return @round(F, -Inf, inf(a)^n)
                return @round(F, sup(a)^n, inf(a)^n)
            else
                return entireinterval(a)
            end
        end

    else # even power
        if n > 0
            if inf(a) ≥ 0
                return @round(F, inf(a)^n, sup(a)^n)
            elseif sup(a) ≤ 0
                return @round(F, sup(a)^n, inf(a)^n)
            else
                return @round(F, mig(a)^n, mag(a)^n)
            end

        else
            if inf(a) ≥ 0
                return @round(F, sup(a)^n, inf(a)^n)
            elseif sup(a) ≤ 0
                return @round(F, inf(a)^n, sup(a)^n)
            else
                return @round(F, mag(a)^n, mig(a)^n)
            end
        end
    end
end

function ^(a::F, x::BigFloat) where {F<:Interval{BigFloat}}
    domain = F(0, Inf)

    if isthinzero(a)
        a = a ∩ domain
        x > zero(x) && return zero(F)
        return emptyinterval(F)
    end

    isinteger(x) && return a^(round(Int, x))
    x == 0.5 && return sqrt(a)

    a = a ∩ domain
    (isempty(x) || isempty(a)) && return emptyinterval(F)

    xx = F(x)

    lo = @round(F, inf(a)^inf(xx), inf(a)^inf(xx))
    lo = (inf(lo) == Inf) ? F(prevfloat(Inf), Inf) : lo

    lo1 = @round(F, inf(a)^sup(xx), inf(a)^sup(xx))
    lo1 = (inf(lo1) == Inf) ? F(prevfloat(Inf), Inf) : lo1

    hi = @round(F, sup(a)^inf(xx), sup(a)^inf(xx))
    hi = (inf(hi) == Inf) ? F(prevfloat(Inf), Inf) : hi

    hi1 = @round(F, sup(a)^sup(xx), sup(a)^sup(xx))
    hi1 = (inf(hi1) == Inf) ? F(prevfloat(Inf), Inf) : hi1

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function ^(a::Interval{Rational{T}}, x::AbstractFloat) where {T<:Integer}
    a = Interval{Float64}(inf(a).num/inf(a).den, sup(a).num/sup(a).den)
    return F(a^x)
end

# Rational power
function ^(a::F, x::Rational{R}) where {F<:Interval, R<:Integer}
    p = x.num
    q = x.den

    isempty(a) && return emptyinterval(a)
    iszero(x) && return one(a)
    # x < 0 && return inv(a^(-x))
    x < 0 && return F( inv( (@biginterval(a))^(-x) ) )

    if isthinzero(a)
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(x) && return a^R(x)

    x == (1//2) && return sqrt(a)

    alo, ahi = bounds(a)

    if ahi < 0
        return emptyinterval(a)
    end

    if alo < 0 && ahi ≥ 0
        a = a ∩ F(0, Inf)
    end

    b = nthroot( @biginterval(a), q)

    p == 1 && return F(b)

    return F(b^p)
end

# Interval power of an interval:
function ^(a::F, x::Interval) where {F<:Interval{BigFloat}}
    domain = F(0, Inf)

    a = a ∩ domain

    (isempty(x) || isempty(a)) && return emptyinterval(F)

    lo1 = a^inf(x)
    lo2 = a^sup(x)
    lo1 = hull(lo1, lo2)

    hi1 = a^inf(x)
    hi2 = a^sup(x)
    hi1 = hull(hi1, hi2)

    return hull(lo1, hi1)
end

function sqr(a::Interval)
    return a^2
end

"""
    hypot(x::Interval, n::Integer)

Direct implemntation of `hypot` using intervals.
"""
hypot(x::Interval, y::Interval) = sqrt(sqr(x) + sqr(y))


"""
    pow(x::Interval, n::Integer)

A faster implementation of `x^n`, currently using `power_by_squaring`.
`pow(x, n)` will usually return an interval that is slightly larger than that
calculated by `x^n`, but is guaranteed to be a correct
enclosure when using multiplication with correct rounding.
"""
function pow(x::F, n::Integer) where {F<:Interval}
    n < 0 && return 1/pow(x, -n)
    isempty(x) && return x

    if iseven(n) && 0 ∈ x
        return hull(zero(x),
                    Base.power_by_squaring(F(mig(x)), n),
                    Base.power_by_squaring(F(mag(x)), n)
            )
    else
      return hull( Base.power_by_squaring(F(inf(x)), n),
                    Base.power_by_squaring(F(sup(x)), n) )
    end
end

function pow(x::Interval, y::Interval)  # fast real power, including for y an Interval
    isempty(x) && return x
    isthininteger(y) && return pow(x, Int(inf(y)))
    return exp(y * log(x))
end

function pow(x::Interval, y)  # fast real power, including for y an Interval
    isempty(x) && return x
    isinteger(y) && return pow(x, Int(inf(y)))
    return exp(y * log(x))
end

for f in (:exp, :expm1)
    @eval begin
        function ($f)(a::F) where {F<:Interval}
            isempty(a) && return a
            return @round( F, ($f)(inf(a)), ($f)(sup(a)) )
        end
    end
end


for f in (:exp2, :exp10, :cbrt)
    @eval function ($f)(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
            setrounding(BigFloat, r) do
                ($f)(x)
            end
        end

    @eval ($f)(a::F) where {F<:Interval} = F($f(big(a)))  # no CRlibm version

    @eval function ($f)(a::F) where {F<:Interval{BigFloat}}
            isempty(a) && return a
            return @round( F, ($f)(inf(a)), ($f)(sup(a)) )
        end
end

for f in (:log, :log2, :log10)
    @eval function ($f)(a::F) where {T, F<:Interval{T}}
            domain = F(0, Inf)
            a = a ∩ domain

            (isempty(a) || sup(a) ≤ zero(T)) && return emptyinterval(F)

            return @round( F, ($f)(inf(a)), ($f)(sup(a)) )
        end
end

function log1p(a::F) where {T, F<:Interval{T}}
    domain = Interval{T}(-1, Inf)
    a = a ∩ domain

    (isempty(a) || sup(a) ≤ -one(T)) && return emptyinterval(a)

    @round( F, log1p(inf(a)), log1p(sup(a)) )
end

"""
    nthroot(a::Interval, n::Integer)

Compute the real n-th root of Interval.
"""
function nthroot(a::F, n::Integer) where {F<:Interval{BigFloat}}
    isempty(a) && return a
    n == 1 && return a
    n == 2 && return sqrt(a)
    n == 0 && return emptyinterval(a)
    # n < 0 && isthinzero(a) && return emptyinterval(a)
    n < 0 && return inv(nthroot(a, -n))

    alo, ahi = bounds(a)
    ahi < 0 && iseven(n) && return emptyinterval(BigFloat)
    if alo < 0 && ahi >= 0 && iseven(n)
        a = a ∩ F(0, Inf)
        alo, ahi = bounds(a)
    end
    ui = convert(Culong, n)
    low = BigFloat()
    high = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , alo , ui, MPFRRoundDown)
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , ahi , ui, MPFRRoundUp)
    return interval(low , high)
end

function nthroot(a::F, n::Integer) where {T, F<:Interval{T}}
    n == 1 && return a
    n == 2 && return sqrt(a)

    abig = @biginterval(a)
    if n < 0
        issubnormal(mag(a)) && return inv(nthroot(a, -n))
        return F( inv(nthroot(abig, -n)) )
    end

    b = nthroot(abig, n)
    return F(b)
end
