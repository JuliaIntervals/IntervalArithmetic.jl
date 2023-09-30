module Symbols

    using IntervalArithmetic
    export .., ≛, ≺, ⪽, ∅, ℝ, ∞

"""
    ..(a, b)

Create an interval according to the IEEE Standard 1788-2015. This is
semantically equivalent to [`interval(a, b)`](@ref).

See also: [`interval`](@ref), [`±`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> using IntervalArithmetic

julia> using IntervalArithmetic.Symbols

julia> setformat(:full);

julia> (1//1)..π
Interval{Rational{Int64}}(1//1, 85563208//27235615)

julia> 0.1..0.3
Interval{Float64}(0.1, 0.3)
```
```
"""
const .. = interval

"""
    ≛(a, b)

Unicode alias of [`isequalinterval`](@ref).
"""
const ≛ = isequalinterval

"""
    ≺(a, b)

Unicode alias of [`strictprecedes`](@ref).
"""
const ≺ = strictprecedes

"""
    ⪽(a, b)

Unicode alias of [`isstrictinterior`](@ref).
"""
const ⪽ = isstrictinterior

"""
    ∅

Unicode alias of `emptyinterval()` representing an empty interval of default
flavor and default bound type.

See also: [`emptyinterval`](@ref).
"""
const ∅ = emptyinterval()

"""
    ℝ

Unicode alias of `entireinterval()` representing an entire interval of default
flavor and default bound type.

See also: [`entireinterval`](@ref).
"""
const ℝ = entireinterval()

"""
    ∞

Unicode alias of `Inf`.
"""
const ∞ = Inf

end
