module Symbols

    using IntervalArithmetic
    export .., ≺, ⪽, ∅, ℝ, ∞

"""
    a..b
    ..(a, b)

Create an interval according to the IEEE Standard 1788-2015. This is
semantically equivalent to [`interval(a, b)`](@ref).

See also: [`interval`](@ref), [`±`](@ref) and [`@I_str`](@ref).
```
"""
const .. = interval

"""
    ≺(a, b)

Unicode alias of [`strictprecedes`](@ref).
"""
const ≺ = strictprecedes

"""
    ⪽(a, b)

Unicode alias of [`isinterior`](@ref).
"""
const ⪽ = isinterior

"""
    ∅

Unicode alias of `emptyinterval()` representing an empty interval of
default flavor and default bound type.

See also: [`emptyinterval`](@ref).
"""
const ∅ = emptyinterval()

"""
    ℝ

Unicode alias of `entireinterval()` representing an entire interval of
default flavor and default bound type.

See also: [`entireinterval`](@ref).
"""
const ℝ = entireinterval()

"""
    ∞

Unicode alias of `Inf`.
"""
const ∞ = Inf

end
