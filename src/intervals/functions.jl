# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Powers
# Integer power:
function ^{T<:Real}(a::Interval{T}, n::Integer)
    isempty(a) && return a
    n < 0  && return inv(a^(-n))
    n == 0 && return one(a)
    n == 1 && return a

    iseven(n) && return @round(T, mig(a)^n, mag(a)^n)  # even power

    @round(T, a.lo^n, a.hi^n)  # odd power
end

function ^{T<:Real}(a::Interval{T}, r::Rational)
    isempty(a) && return a
    r < zero(r)  && return inv(a^(-r))
    r == zero(r) && return one(a)
    r == one(r)  && return a
    isinteger(r) && return a^(round(Int,r))

    root = one(T)/r.den

    if a.lo > zero(a.lo)
        nth_root = @round(T, a.lo^root, a.hi^root)
    else
        if iseven(r.den)
            nth_root = @round(T, mig(a)^root, mag(a)^root)
        else
            nth_root = @round(T, sign(a.lo)*abs(a.lo)^root, sign(a.hi)*abs(a.hi)^root)
        end
    end

    nth_root^r.num
end

# Real power of an interval:
function ^{T<:Real}(a::Interval{T}, x::AbstractFloat)
    isinteger(x)  && return a^(round(Int,x))
    x < zero(x)  && return inv(a^(-x))
    x == 0.5  && return sqrt(a)

    domain = Interval{T}(0, Inf)
    a = a ∩ domain
    isempty(a) && return a

    @round(T, a.lo^x, a.hi^x)
end

# Interval power of an interval:
function ^{T<:Real}(a::Interval{T}, x::Interval)
    isempty(a) && return a
    diam(x) < eps(mid(x)) && return a^(mid(x))  # thin interval

    domain = Interval{T}(0, Inf)

    a = a ∩ domain
    isempty(a) && return a

    @round(T, min(a.lo^(x.lo), a.lo^(x.hi)), max(a.hi^(x.lo), a.hi^(x.hi)) )
end


Base.inf(x::Rational) = 1//0  # to allow sqrt()


function sqrt{T}(a::Interval{T})
    domain = Interval{T}(0, Inf)

    a = a ∩ domain

    isempty(a) && return a

    @round(T, sqrt(a.lo), sqrt(a.hi))
end


exp{T}(a::Interval{T}) = @round(T, exp(a.lo), exp(a.hi))

function log{T}(a::Interval{T})
    domain = Interval{T}(0, Inf)

    a = a ∩ domain

    isempty(a) && return a

    @round(T, log(a.lo), log(a.hi))
end
