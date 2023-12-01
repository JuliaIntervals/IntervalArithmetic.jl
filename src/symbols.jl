module Symbols

    using IntervalArithmetic
    export .., ±, ≛, ≺, ⪽, ∅, ℝ

"""
    ..(a, b)

Create an interval according to the IEEE Standard 1788-2015. This is
semantically equivalent to [`interval(a, b)`](@ref).

See also: [`interval`](@ref), [`±`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> using IntervalArithmetic

julia> using IntervalArithmetic.Symbols

julia> setdisplay(:full);

julia> (1//1)..π
Interval{Rational{Int64}}(1//1, 85563208//27235615, com)

julia> 0.1..0.3
Interval{Float64}(0.1, 0.3, com)
```
```
"""
.. = interval

"""
    ±(m, r)
    m ± r

Create the interval ``[m - r, m + r]`` according to the IEEE Standard 1788-2015.
Despite using the midpoint-radius notation, the returned interval is still an
[`Interval`](@ref) represented by its bounds.

!!! warning
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. 0.1). In such cases, use the string
    macro [`@I_str`](@ref) to ensure tight enclosure around the typed numbers.

See also: [`interval`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples
```jldoctest
julia> using IntervalArithmetic

julia> using IntervalArithmetic.Symbols

julia> setdisplay(:full);

julia> 0 ± π
Interval{Float64}(-3.1415926535897936, 3.1415926535897936, com)

julia> 0//1 ± π
Interval{Rational{Int64}}(-85563208//27235615, 85563208//27235615, com)
```
"""
±(m, r) = interval(m, r; format = :midpoint)

"""
    ≛(a, b)

Unicode alias of [`isequal_interval`](@ref).
"""
≛ = isequal_interval

"""
    ≺(a, b)

Unicode alias of [`strictprecedes`](@ref).
"""
≺ = strictprecedes

"""
    ⪽(a, b)

Unicode alias of [`isstrictsubset_interval`](@ref).
"""
⪽ = isstrictsubset_interval

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

end
