"""
    signbit(a::Interval)

Return an interval containing 1 if any element in `a` is negative and containing
0 if any element in `a` is positive. An empty interval is returned if `a` is
empty.

# Examples
```jldoctest
julia> setformat(:full);

julia> signbit(interval(-4.0))
Interval{Float64}(1.0, 1.0)

julia> signbit(interval(5.0))
Interval{Float64}(0.0, 0.0)

julia> signbit(interval(-4.0, 5.0))
Interval{Float64}(0.0, 1.0)
```
"""
function signbit(a::Interval{T}) where {T<:NumTypes}
    isempty(a) && return a
    lo, hi = bounds(a)
    return interval(T, signbit(hi), signbit(lo))
end

for T ∈ (:Interval, :Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::$T, b::Interval) = abs(a) * (1 - 2 * signbit(b))
        flipsign(a::$T, b::Interval) = a * (1 - 2 * signbit(b))
    end
end

for T ∈ (:Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::Interval, b::$T) = abs(a) * (1 - 2 * signbit(b))
        flipsign(a::Interval, b::$T) = a * (1 - 2 * signbit(b))
    end
end
