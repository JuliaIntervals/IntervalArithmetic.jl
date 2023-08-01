# This file contains the functions described as "Power functions" in Section 9.1
# of the IEEE Standard 1788-2015 and required for set-based flavor in Section
# 10.5.3, with addition of the `sqr` function.

# CRlibm does not contain a correctly-rounded `^` function for Float64
# use the BigFloat version from MPFR instead, which is correctly-rounded

for T in (:Integer, :Float64, :BigFloat, :Interval) # need explicit signatures to avoid method ambiguities
    @eval ^(a::Interval{Float64}, x::$T) = Interval{Float64}((bigequiv(a))^x)
end

# overwrite behaviour for small integer powers from
# https://github.com/JuliaLang/julia/pull/24240
Base.literal_pow(::typeof(^), x::Interval{T}, ::Val{p}) where {T<:NumTypes,p} = x^p

"""
    ^(a::Interval, b::Interval)
    ^(a::Interval, b)

Implement the `pow` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
^(a::F, b::F) where {F<:Interval} = F(bigequiv(a)^b)

for T ∈ (:AbstractFloat, :Integer)
    @eval ^(a::F, b::$T) where {F<:Interval} = F(bigequiv(a)^b)
end

^(a::F, b::AbstractFloat) where {F<:Interval{BigFloat}} = a^big(b)

function ^(a::Interval{BigFloat}, n::Integer)
    isemptyinterval(a) && return a
    iszero(n) && return one(Interval{BigFloat})
    n == 1 && return a
    (n < 0 && issingletonzero(a)) && return emptyinterval(BigFloat)

    if isodd(n) # odd power
        isentireinterval(a) && return a
        if n > 0
            inf(a) == 0 && return @round(BigFloat, zero(BigFloat), sup(a)^n)
            sup(a) == 0 && return @round(BigFloat, inf(a)^n, zero(BigFloat))
            return @round(BigFloat, inf(a)^n, sup(a)^n)
        else
            if inf(a) ≥ 0
                inf(a) == 0 && return @round(BigFloat, sup(a)^n, typemax(BigFloat))
                return @round(BigFloat, sup(a)^n, inf(a)^n)

            elseif sup(a) ≤ 0
                sup(a) == 0 && return @round(BigFloat, typemin(BigFloat), inf(a)^n)
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            else
                return entireinterval(a)
            end
        end

    else # even power
        if n > 0
            if inf(a) ≥ 0
                return @round(BigFloat, inf(a)^n, sup(a)^n)
            elseif sup(a) ≤ 0
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            else
                return @round(BigFloat, mig(a)^n, mag(a)^n)
            end

        else
            if inf(a) ≥ 0
                return @round(BigFloat, sup(a)^n, inf(a)^n)
            elseif sup(a) ≤ 0
                return @round(BigFloat, inf(a)^n, sup(a)^n)
            else
                return @round(BigFloat, mag(a)^n, mig(a)^n)
            end
        end
    end
end

function ^(a::Interval{BigFloat}, x::BigFloat)
    domain = unsafe_interval(BigFloat, zero(BigFloat), typemax(BigFloat))

    if issingletonzero(a)
        x > 0 && return zero(Interval{BigFloat})
        return emptyinterval(BigFloat)
    end

    isinteger(x) && return a^(round(Int, x))
    x == 0.5 && return sqrt(a)

    a = intersection(a, domain)
    isemptyinterval(a) && return a

    M = typemax(BigFloat)
    MM = typemax(Interval{BigFloat})

    lo = @round(BigFloat, inf(a)^x, inf(a)^x)
    lo = (inf(lo) == M) ? MM : lo

    lo1 = @round(BigFloat, inf(a)^x, inf(a)^x)
    lo1 = (inf(lo1) == M) ? MM : lo1

    hi = @round(BigFloat, sup(a)^x, sup(a)^x)
    hi = (inf(hi) == M) ? MM : hi

    hi1 = @round(BigFloat, sup(a)^x, sup(a)^x)
    hi1 = (inf(hi1) == M) ? MM : hi1

    lo = convexhull(lo, lo1)
    hi = convexhull(hi, hi1)

    return convexhull(lo, hi)
end

function ^(a::Interval{T}, x::AbstractFloat) where {T<:Rational}
    a = unsafe_interval(float(T), inf(a).num/inf(a).den, sup(a).num/sup(a).den)
    return Interval{T}(a^x)
end

# Rational power
function ^(a::F, x::Rational{R}) where {T<:NumTypes,F<:Interval{T},R<:Integer}
    p = x.num
    q = x.den

    isemptyinterval(a) && return a
    iszero(x) && return one(a)
    # x < 0 && return inv(a^(-x))
    x < 0 && return F( inv( (bigequiv(a))^(-x) ) )

    if issingletonzero(a)
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(x) && return a^R(x)

    x == (1//2) && return sqrt(a)

    alo, ahi = bounds(a)

    if ahi < 0
        return emptyinterval(T)
    end

    if alo < 0 && ahi ≥ 0
        a = intersection(a, unsafe_interval(T, zero(T), typemax(T)))
    end

    b = nthroot( bigequiv(a), q)

    p == 1 && return F(b)

    return F(b^p)
end

# Interval power of an interval:
function ^(a::Interval{BigFloat}, x::Interval)
    isemptyinterval(x) && return x
    domain = unsafe_interval(BigFloat, zero(BigFloat), typemax(BigFloat))
    a = intersection(a, domain)
    isemptyinterval(a) && return a
    return convexhull(a^inf(x), a^sup(x))
end

sqr(a::Interval) = a^2

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
function pow(x::Interval{T}, n::Integer) where {T<:NumTypes}
    n < 0 && return 1/pow(x, -n)
    isemptyinterval(x) && return x

    if iseven(n) && ismember(0, x)
        xmig = mig(x)
        xmag = mag(x)
        return convexhull(zero(x),
                    Base.power_by_squaring(unsafe_interval(T, xmig, xmig), n),
                    Base.power_by_squaring(unsafe_interval(T, xmag, xmag), n))
    else
        xinf = inf(x)
        xsup = sup(x)
        return convexhull(Base.power_by_squaring(unsafe_interval(T, xinf, xinf), n),
                    Base.power_by_squaring(unsafe_interval(T, xsup, xsup), n))
    end
end

function pow(x::Interval, y::Interval)  # fast real power, including for y an Interval
    isemptyinterval(x) && return x
    issingletoninteger(y) && return pow(x, Int(inf(y)))
    return exp(y * log(x))
end

function pow(x::Interval, y)  # fast real power, including for y an Interval
    isemptyinterval(x) && return x
    isinteger(y) && return pow(x, Int(inf(y)))
    return exp(y * log(x))
end

for f in (:exp, :expm1)
    @eval begin
        function ($f)(a::Interval{T}) where {T<:NumTypes}
            isemptyinterval(a) && return a
            return @round( T, ($f)(inf(a)), ($f)(sup(a)) )
        end
    end
end


for f in (:exp2, :exp10, :cbrt)
    @eval function ($f)(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
            setrounding(BigFloat, r) do
                ($f)(x)
            end
        end

    @eval ($f)(a::F) where {F<:Interval} = F($f(bigequiv(a)))  # no CRlibm version

    @eval function ($f)(a::Interval{BigFloat})
            isemptyinterval(a) && return a
            return @round( BigFloat, ($f)(inf(a)), ($f)(sup(a)) )
        end
end

for f in (:log, :log2, :log10)
    @eval function ($f)(a::Interval{T}) where {T<:NumTypes}
            domain = unsafe_interval(T, zero(T), typemax(T))
            a = intersection(a, domain)

            (isemptyinterval(a) || sup(a) ≤ zero(T)) && return emptyinterval(T)

            return @round( T, ($f)(inf(a)), ($f)(sup(a)) )
        end
end

function log1p(a::Interval{T}) where {T<:NumTypes}
    domain = unsafe_interval(T, -one(T), typemax(T))
    a = intersection(a, domain)

    (isemptyinterval(a) || sup(a) ≤ -1) && return emptyinterval(T)

    @round( T, log1p(inf(a)), log1p(sup(a)) )
end

"""
    nthroot(a::Interval, n::Integer)

Compute the real n-th root of Interval.
"""
function nthroot(a::Interval{BigFloat}, n::Integer)
    isemptyinterval(a) && return a
    n == 1 && return a
    n == 2 && return sqrt(a)
    n == 0 && return emptyinterval(a)
    # n < 0 && issingletonzero(a) && return emptyinterval(a)
    n < 0 && return inv(nthroot(a, -n))

    alo, ahi = bounds(a)
    ahi < 0 && iseven(n) && return emptyinterval(BigFloat)
    if alo < 0 && ahi ≥ 0 && iseven(n)
        a = intersection(a, unsafe_interval(BigFloat, zero(BigFloat), typemax(BigFloat)))
        alo, ahi = bounds(a)
    end
    ui = convert(Culong, n)
    low = BigFloat()
    high = BigFloat()
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , alo , ui, MPFRRoundDown)
    ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , ahi , ui, MPFRRoundUp)
    return interval(BigFloat, low , high)
end

function nthroot(a::F, n::Integer) where {F<:Interval}
    n == 1 && return a
    n == 2 && return sqrt(a)

    abig = bigequiv(a)
    if n < 0
        issubnormal(mag(a)) && return inv(nthroot(a, -n))
        return F( inv(nthroot(abig, -n)) )
    end

    b = nthroot(abig, n)
    return F(b)
end
