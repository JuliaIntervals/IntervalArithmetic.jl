# This file is part of the IntervalArithmetic.jl package; MIT licensed


Base.eltype(x::Interval{T}) where {T<:Real} = Interval{T}

"""
    numtype(::Interval{T}) where {T<:Real} = T

Returns the type of the bounds of the interval.

### Example

```julia
julia> numtype(1..2)
Float64
```
"""
numtype(::Interval{T}) where {T<:Real} = T



function sqrt(a::Interval{T}) where T
    domain = Interval{T}(0, Inf)
    a = a ∩ domain

    isempty(a) && return a

    @round(sqrt(a.lo), sqrt(a.hi))  # `sqrt` is correctly-rounded
end




for f in (:exp, :expm1)
    @eval begin
        function ($f)(a::Interval{T}) where T
            isempty(a) && return a
            @round( ($f)(a.lo), ($f)(a.hi) )
        end
    end
end


for f in (:exp2, :exp10, :cbrt)

    @eval function ($f)(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
            setrounding(BigFloat, r) do
                ($f)(x)
            end
        end

    @eval ($f)(a::Interval{T}) where T = atomic(Interval{T}, $f(bigequiv(a)))  # no CRlibm version

    @eval function ($f)(a::Interval{BigFloat})
            isempty(a) && return a
            @round( ($f)(a.lo), ($f)(a.hi) )
        end
end


for f in (:log, :log2, :log10)

    @eval function ($f)(a::Interval{T}) where T
            domain = Interval{T}(0, Inf)
            a = a ∩ domain

            (isempty(a) || a.hi ≤ zero(T)) && return emptyinterval(a)

            @round( ($f)(a.lo), ($f)(a.hi) )

        end
end

function log1p(a::Interval{T}) where T
    domain = Interval{T}(-1, Inf)
    a = a ∩ domain

    (isempty(a) || a.hi ≤ -one(T)) && return emptyinterval(a)

    @round( log1p(a.lo), log1p(a.hi) )
end

hypot(a::Interval{BigFloat}, b::Interval{BigFloat}) = sqrt(a^2 + b^2)

hypot(a::Interval{T}, b::Interval{T}) where T= atomic(Interval{T}, hypot(bigequiv(a), bigequiv(b)))

"""
nthroot(a::Interval{BigFloat}, n::Integer)
Compute the real n-th root of Interval.
"""
function nthroot(a::Interval{BigFloat}, n::Integer)
    n == 1 && return a
    n < 0 && a == zero(a) && return emptyinterval(a)
    isempty(a) && return a
    if n > 0
        a.hi < 0 && iseven(n) && return emptyinterval(BigFloat)
        if a.lo < 0 && a.hi >= 0 && iseven(n)
            a = a ∩ Interval{BigFloat}(0, Inf)
        end
        ui = convert(Culong, n)
        low = BigFloat()
        high = BigFloat()
        ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , a.lo , ui, MPFRRoundDown)
        ccall((:mpfr_rootn_ui, :libmpfr), Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , a.hi , ui, MPFRRoundUp)
        b = interval(low , high)
        return b
    elseif n < 0
        return inv(nthroot(a, -n))
    elseif n == 0
        return emptyinterval(a)
    end
end

function nthroot(a::Interval{T}, n::Integer) where T
    b = nthroot(bigequiv(a), n)
    return convert(Interval{T}, b)
end
