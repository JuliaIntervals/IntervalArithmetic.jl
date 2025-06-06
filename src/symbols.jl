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
Interval{Rational{Int64}}(1//1, 85563208//27235615, com)

julia> 0.1..0.3
Interval{Float64}(0.1, 0.3, com)
```
"""
..(a, b) = interval(a, b; format = :infsup)

"""
    ±(m, r)
    m ± r

Create the interval ``[m - r, m + r]`` according to the IEEE Standard 1788-2015.
Despite using the midpoint-radius notation, the returned interval is still an
[`Interval`](@ref) represented by its bounds. The unicode caracter ± is obtained
using `\\pm`.

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
Interval{Float64}(-3.1415926535897936, 3.1415926535897936, com)

julia> 0//1 ± π
Interval{Rational{Int64}}(-85563208//27235615, 85563208//27235615, com)
```
"""
±(m, r) = interval(m, r; format = :midpoint)

"""
    ≛(x, y)
    x ≛ y

Unicode alias of [`isequal_interval`](@ref); the unicode caracter ≛ is obtained
using `\\starequal`.
"""
const ≛ = isequal_interval

"""
    ⊑(x, y)
    x ⊑ y

Unicode alias of [`issubset_interval`](@ref); the unicode caracter ⊑ is obtained
using `\\sqsubseteq`.
"""
const ⊑ = issubset_interval

"""
    ⋤(x, y)
    x ⋤ y

Unicode alias of [`isstrictsubset`](@ref); the unicode caracter for ⋤ is obtained
using `\\sqsubsetneq`.
"""
const ⋤ = isstrictsubset

"""
    ⪽(x, y)
    x ⪽ y

Unicode alias of [`isinterior`](@ref); the unicode caracter for ⪽ is obtained
using `\\subsetdot`.
"""
const ⪽ = isinterior

"""
    ⪯(x, y)
    x ⪯ y

Unicode alias of [`precedes`](@ref); the unicode caracter for ⪯ is obtained
using `\\preceq`.
"""
const ⪯ = precedes

"""
    ≺(x, y)
    x ≺ y

Unicode alias of [`strictprecedes`](@ref); the unicode caracter for ≺ is obtained
using `\\prec`.
"""
const ≺ = strictprecedes

"""
    ⊔(x, y)
    x ⊔ y

Unicode alias of [`hull`](@ref); the unicode caracter for ⊔ is obtained
using `\\sqcup`.
"""
const ⊔ = hull

"""
    ⊓(x, y)
    x ⊓ y

Unicode alias of [`intersect_interval`](@ref); the unicode caracter for ⊓ is obtained
using `\\sqcap`.
"""
const ⊓ = intersect_interval

"""
    ∅

Unicode alias of `emptyinterval()` representing an empty interval of default
flavor and default bound type. The unicode caracter for ∅ is obtained
using `\\emptyset`.

See also: [`emptyinterval`](@ref).
"""
const ∅ = emptyinterval()

"""
    ℝ

Unicode alias of `entireinterval()` representing an entire interval of default
flavor and default bound type.

See also: [`entireinterval`](@ref). The unicode caracter for ℝ is obtained
using `\\bbR`.
"""
const ℝ = entireinterval()

end
