Changelog

- File structure changed to match the IEEE standard
- Symbols that alias another function moved to `symbols.jl`
- Removed global precision
- `make_interval` renamed `wrap_literals`
- Removed `pi_interval(T)` in favor of `Interval{T}(π)`
- Renamed `multiply_by_positive_constant` to `scale`
- `@round` now take the interval type of the returned interval as first argument
- Removed `find_quadrants_tan` as it was a duplicate of `find_quadrants`
- Renamed `mid(a, α)` -> `scaled_mid(a, α)` (to avoid discrepency with default parameter)
- Functions returning intervals based on bound type now require an interval type as parameter
- Renamed `entireinterval` -> `RR`
- Rewritten and much simplified parser for interval from string, using CombinedParsers.jl
- Rewritten and simplified `atomic`
- Introduced overwrittable functions for default flavor, bound type and pointwise politic
- Removed `setrounding(Interval, mode)` and simplified `rouding.jl`
- Introduced the concept of pointwise politic i.e. what to do with boolean operation generally used for control flow, like `==`. Use ternary logic as default
- Identity of intervals now use the `\stareq` infix operator, `==` being reserved for pointwise equality test
- Removed all promotion mechanism involving intervals (to more easily ensure correctness, most of the things not explicitly define now error)