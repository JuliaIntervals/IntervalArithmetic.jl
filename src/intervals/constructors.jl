struct Interval{T<:Real}
    lo :: T
    hi :: T

    function Interval{T}(a::Real, b::Real) where T<:Real
        if validity_check
            if is_valid_interval(a, b)
                new(a, b)
            else
                throw(ArgumentError("Interval of form [$a, $b] not allowed. Must have a ≤ b to construct interval(a, b)."))
            end
        end
        new(a, b)
    end
end

## Outer constructors
Interval(a::T, b::T) where {T<:Real} = Interval{T}(a, b)
Interval(a::T) where {T<:Real} = Interval(a, a)
Interval(a::Tuple) = Interval(a...)
Interval(a::T, b::S) where {T<:Real, S<:Real} = Interval(promote(a,b)...)

## Concrete constructors for Interval, to effectively deal only with Float64,
# BigFloat or Rational{Integer} intervals.
Interval(a::T, b::T) where {T<:Integer} = Interval(float(a), float(b))
Interval(a::T, b::T) where {T<:Irrational} = Interval(float(a), float(b))

Interval(x::Interval) = x
Interval(x::Complex) = Interval(real(x)) + im*Interval(imag(x))

Interval{T}(x) where T = Interval(convert(T, x))
Interval{T}(x::Interval) where T = atomic(Interval{T}, x)
