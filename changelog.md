# Changelog

## Structure
Changed to match the IEEE standard, with corresponding docstring to every function when it is in the standard.

Overall restructuring of the files to try to be more organized.

Symbols that alias another function moved to `symbols.jl`

Only minimal changes to `multdim/`.

## Global precision
Removed. It was causing problems and was agreed upon at some point.

## Rounding
Removed `setrounding(Interval, mode)` and redefinition of function to change the rounding mode.

Instead the default rounding is given by the (not exported) function `IntervalArithmetic.rounding_mode()` and can be changed by redefining the function.

This allow to simplify the management of the rounding mode.

`@round` now take the interval type of the returned interval as first argument. The old fallback to the default bound still exists.

## Flavors
Only Cset flavor is available.

The mechanism for more flavor is however introduced, in a similar way to the new rounding mechanism. The current flavor is given by the (not exported) `IntervalArithmetic.current_flavor()` and can be overwritten to change flavor.

## Default bound
Introduced the same mechanism as rounding and flavor, with the default bound given and possible changed through the not exported `IntervalArithmetic.default_bound()`.

## Pointwise politic
Introduced the concept of pointwise politic, that is what to do with the pointwise extension of boolean function like `==` to intervals.

Uses the same mechanism as rounding, flavor and default bounds, using the function `IntervalArithmetic.pointwise_politic()` to define the current mode.

By default uses ternary logic, similar to what is done in `NumberIntervals.jl`.

Also implemented boolean intervals (always erroring in conditional) and the old behavior (often silently breaking `if .. else` clauses).

Identity of intervals now use the `\stareq` infix operator, `==` being reserved for pointwise equality test.

## Promotion and conversion
Removed all promotion and conversion involving intervals.

This makes the tracking of correctness easier as generic `Number` or `Real` methods now errors with intervals if they are not redefined in the package.

## Construction
The constructors definitions have been overall and, to an extend, redesigned.

Now only `@interval` is trying to be smart and widen decimal inputs to guarantee their inclusion, leading to 2 eps wide interval built from single decimal literals. Guaranteeing inclusion is still better done by using either the `I""` string macro or `parse(Interval, str)`.

All others constructors take floating point at face value.

Consequently, `atomic` has been massively simplified.

Introduced the alias `checked_interval` to be more specific than just lowercase `interval`. Both are now equivalent to `..`.

`Interval(::Irrational)` works with generated function and is tight and correct.

## Complex and Rational
Support drop as it caused problems. It could be restored.

## Parser
Rewritten using `CombinedParsers.jl`.

It is now much simpler and also slightly tighter.

Unfortunately the new dependency seems to error on nightly, which is what causes the CI to fail.

Some extension of parsing that are not in the standard still need to be restored.

## Docstrings
Added a ton of docstrings.

## Others
- Removed `widen` and `wideinterval`.
- Removed `interval_from_midpoint_radius`. It is implemented by `±`.
- Removed `force_interval`
- Removed `find_quadrants_tan` as it was a duplicate of `find_quadrants`
- `make_interval` renamed `wrap_literals`
- Removed `pi_interval(T)` in favor of `Interval{T}(π)`
- Renamed `multiply_by_positive_constant` to `scale`
- Renamed `mid(a, α)` -> `scaled_mid(a, α)` to avoid discrepancy with default parameter.
- Tests that seemed to have been tailored to the behavior of the old `@interval` have been modified or marked as `@test_broken` when the expected value can not be easily derived
- `@interval` changed to `Interval` in tests as much as possible.
