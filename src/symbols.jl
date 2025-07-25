module Symbols

    using IntervalArithmetic
    export .., ±, ≛, ⊑, ⋤, ⪽, ⪯, ≺, ⊓, ⊔, ∅, ℝ

"""
    ..(a, b)
    a .. b

Create the interval ``[a, b]`` according to the IEEE Standard 1788-2015. This is
semantically equivalent to [`interval(a, b)`](@ref).

!!! danger
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. `0.1`). In such cases, parse the
    string containing the desired value to ensure its tight enclosure.

See also: [`interval`](@ref), [`±`](@ref) and [`@I_str`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> using IntervalArithmetic.Symbols

julia> setdisplay(:full);

julia> (1//1)..π
Interval{Rational{Int64}}(1//1, 85563208//27235615, com, true)

julia> 0.1..0.3
Interval{Float64}(0.1, 0.3, com, true)
```
"""
..(a, b) = interval(a, b; format = :infsup)

"""
    ±(m, r)
    m ± r

Create the interval ``[m - r, m + r]`` according to the IEEE Standard 1788-2015.
Despite using the midpoint-radius notation, the returned interval is still an
[`Interval`](@ref) represented by its bounds.

!!! danger
    Nothing is done to compensate for the fact that floating point literals are
    rounded to the nearest when parsed (e.g. `0.1`). In such cases, parse the
    string containing the desired value to ensure its tight enclosure.

See also: [`interval`](@ref), [`..`](@ref) and [`@I_str`](@ref).

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> using IntervalArithmetic.Symbols

julia> setdisplay(:full);

julia> 0 ± π
Interval{Float64}(-3.1415926535897936, 3.1415926535897936, com, true)

julia> 0//1 ± π
Interval{Rational{Int64}}(-85563208//27235615, 85563208//27235615, com, true)
```
"""
±(m, r) = interval(m, r; format = :midpoint)

"""
    ≛(x, y)
    x ≛ y

Unicode alias of [`isequal_interval`](@ref).
"""
const ≛ = isequal_interval

"""
    ⊑(x, y)
    x ⊑ y

Unicode alias of [`issubset_interval`](@ref).
"""
const ⊑ = issubset_interval

"""
    ⋤(x, y)
    x ⋤ y

Unicode alias of [`isstrictsubset`](@ref).
"""
const ⋤ = isstrictsubset

"""
    ⪽(x, y)
    x ⪽ y

Unicode alias of [`isinterior`](@ref).
"""
const ⪽ = isinterior

"""
    ⪯(x, y)
    x ⪯ y

Unicode alias of [`precedes`](@ref).
"""
const ⪯ = precedes

"""
    ≺(x, y)
    x ≺ y

Unicode alias of [`strictprecedes`](@ref).
"""
const ≺ = strictprecedes

"""
    ⊔(x, y)
    x ⊔ y

Unicode alias of [`hull`](@ref).
"""
const ⊔ = hull

"""
    ⊓(x, y)
    x ⊓ y

Unicode alias of [`intersect_interval`](@ref).
"""
const ⊓ = intersect_interval

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
