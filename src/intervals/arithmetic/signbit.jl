"""
    signbit(x::Interval)

Returns an interval containing `true` (`1`) if the value of the sign of any
element in `x` is negative, containing `false` (`0`) if any element in `x`
is non-negative, and an empy interval if `x` is empty.

# Examples
```jldoctest
julia> signbit(@interval(-4))
[1, 1]
julia> signbit(@interval(5))
[0, 0]
julia> signbit(@interval(-4,5))
[0, 1]
```
"""
function signbit(a::Interval) 
    isempty(a) && return emptyinterval(a)
    return Interval(signbit(a.hi), signbit(a.lo))
end

for Typ in (:Interval, :Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::$Typ, b::Interval) = abs(a)*(1-2signbit(b))
        flipsign(a::$Typ, b::Interval) = a*(1-2signbit(b))
    end
end

for Typ in (:Real, :Float64, :Float32, :Signed, :Unsigned)
    @eval begin
        copysign(a::Interval, b::$Typ) = abs(a)*(1-2signbit(b))
        flipsign(a::Interval, b::$Typ) = a*(1-2signbit(b))
    end
end
