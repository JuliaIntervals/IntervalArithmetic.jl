# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Power functions"
    in the IEEE Std 1788-2015 (sections 9.1) and required for set-based flavor
    in section 10.5.3, with addition of the `sqr` function.
=#

# CRlibm does not contain a correctly-rounded ^ function for Float64
# Use the BigFloat version from MPFR instead, which is correctly-rounded:

# Write explicitly like this to avoid ambiguity warnings:
for T in (:Integer, :Float64, :BigFloat, :Interval)
    @eval ^(a::Interval{Float64}, x::$T) = Interval{Float64}(big53(a)^x)
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
^(a::F, b::F) where {F<:Interval} = F(big53(a)^b)
^(a::F, x::AbstractFloat) where {F<:Interval{BigFloat}} = a^big(x)

for T in (:AbstractFloat, :Integer)
    @eval ^(a::F, x::$T) where {F<:Interval} = F(big53(a)^x)
end

function ^(a::F, n::Integer) where {F<:Interval{BigFloat}}
    isempty(a) && return a
    iszero(n) && return one(F)
    n == 1 && return a
    n < 0 && isthinzero(a) && return emptyinterval(F)

    if isodd(n) # odd power
        isentire(a) && return a
        if n > 0
            iszero(a.lo) && return @round(F, 0, a.hi^n)
            iszero(a.hi) && return @round(F, a.lo^n, 0)
            return @round(F, a.lo^n, a.hi^n)
        else
            if a.lo ≥ 0
                iszero(a.lo) && return @round(F, a.hi^n, Inf)
                return @round(F, a.hi^n, a.lo^n)

            elseif a.hi ≤ 0
                iszero(a.hi) && return @round(F, -Inf, a.lo^n)
                return @round(F, a.hi^n, a.lo^n)
            else
                return RR(a)
            end
        end

    else # even power
        if n > 0
            if a.lo ≥ 0
                return @round(F, a.lo^n, a.hi^n)
            elseif a.hi ≤ 0
                return @round(F, a.hi^n, a.lo^n)
            else
                return @round(F, mig(a)^n, mag(a)^n)
            end

        else
            if a.lo ≥ 0
                return @round(F, a.hi^n, a.lo^n)
            elseif a.hi ≤ 0
                return @round(F, a.lo^n, a.hi^n)
            else
                return @round(F, mag(a)^n, mig(a)^n)
            end
        end
    end
end

# Floating-point power of a BigFloat interval:
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

    lo = @round(F, a.lo^xx.lo, a.lo^xx.lo)
    lo = (lo.lo == Inf) ? F(prefloat(Inf), Inf) : lo

    lo1 = @round(F, a.lo^xx.hi, a.lo^xx.hi)
    lo1 = (lo1.lo == Inf) ? F(prefloat(Inf), Inf) : lo1

    hi = @round(F, a.hi^xx.lo, a.hi^xx.lo)
    hi = (hi.lo == Inf) ? F(prefloat(Inf), Inf) : hi

    hi1 = @round(F, a.hi^xx.hi, a.hi^xx.hi)
    hi1 = (hi1.lo == Inf) ? F(prefloat(Inf), Inf) : hi1

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function ^(a::Interval{Rational{T}}, x::AbstractFloat) where {T<:Integer}
    # TODO Check wheter the type should be hardcoded here or be the 
    # default bound type
    a = Interval{Float64}(a.lo.num/a.lo.den, a.hi.num/a.hi.den)
    return F(a^x)
end

# Rational power
function ^(a::F, x::Rational) where {F<:Interval}
    domain = F(0, Inf)

    p = x.num
    q = x.den

    isempty(a) && return emptyinterval(a)
    iszero(x) && return one(a)

    if isthinzero(a)
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    x == (1//2) && return sqrt(a)

    if x >= 0
        if a.lo ≥ 0
            isinteger(x) && return a ^ Int64(x)
            a = @biginterval(a)
            ui = convert(Culong, q)
            low = BigFloat()
            high = BigFloat()
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , a.lo , ui, MPFRRoundDown)
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , a.hi , ui, MPFRRoundUp)
            b = interval(low, high)
            b = convert(F, b)
            return b^p
        end

        if a.lo < 0 && a.hi ≥ 0
            isinteger(x) && return a ^ Int64(x)
            a = a ∩ F(0, Inf)
            a = @biginterval(a)
            ui = convert(Culong, q)
            low = BigFloat()
            high = BigFloat()
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , a.lo , ui, MPFRRoundDown)
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , a.hi , ui, MPFRRoundUp)
            b = interval(low, high)
            b = convert(Interval{T}, b)
            return b^p
        end

        if a.hi < 0
            isinteger(x) && return a ^ Int64(x)
            return emptyinterval(a)
        end

    end

    if x < 0
        return inv(a^(-x))
    end
end

# Interval power of an interval:
function ^(a::F, x::Interval) where {F<:Interval{BigFloat}}
    T = BigFloat
    domain = F(0, Inf)

    a = a ∩ domain

    (isempty(x) || isempty(a)) && return emptyinterval(F)

    lo1 = a^x.lo
    lo2 = a^x.hi
    lo1 = hull(lo1, lo2)

    hi1 = a^x.lo
    hi2 = a^x.hi
    hi1 = hull(hi1, hi2)

    return hull(lo1, hi1)
end

function sqr(a::Interval)
    return a^2
end

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
                    hull(Base.power_by_squaring(F(mig(x)), n),
                        Base.power_by_squaring(F(mag(x)), n))
            )
    else
      return hull( Base.power_by_squaring(F(x.lo), n),
                    Base.power_by_squaring(F(x.hi), n) )
    end
end

function pow(x::Interval, y)  # fast real power, including for y an Interval
    isempty(x) && return x
    isinteger(y) && return pow(x, Int(y.lo))
    return exp(y * log(x))
end

for f in (:exp, :expm1)
    @eval begin
        function ($f)(a::F) where {F<:Interval}
            isempty(a) && return a
            return @round( F, ($f)(a.lo), ($f)(a.hi) )
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
            return @round( F, ($f)(a.lo), ($f)(a.hi) )
        end
end

for f in (:log, :log2, :log10)
    @eval function ($f)(a::F) where {T, F<:Interval{T}}
            domain = F(0, Inf)
            a = a ∩ domain

            (isempty(a) || a.hi ≤ zero(T)) && return emptyinterval(F)

            return @round( F, ($f)(a.lo), ($f)(a.hi) )
        end
end

function log1p(a::F) where {T, F<:Interval{T}}
    domain = Interval{T}(-1, Inf)
    a = a ∩ domain

    (isempty(a) || a.hi ≤ -one(T)) && return emptyinterval(a)

    @round( F, log1p(a.lo), log1p(a.hi) )
end
