# What's new in ValidatedNumerics.jl

## 0.1.3

- Improvements to (eventually) get conformance with the [IEEE-1788](https://standards.ieee.org/findstds/standard/1788-2015.html) standard for Interval Arithmetic:
 - New `special_intervals.jl` file, with the definitions of `emptyinterval`, `entireinterval` and `nai` and some related functions. Add new interval functions (`<=`, `radius`, `precedes`, `strictprecedes`, `≺`, etc). All these include tests.
 - Control rounding tighter for the arithmetic operations; `*`, `inv` and `/` have been rewritten; this includes changes in `make_interval` and `convert` to get consistent behavior. Now, all these functions pass the corresponding tests in the [ITF1788](https://github.com/oheim/ITF1788) test suite.
- Deprecate the use of `⊊` in favor of `interior` (`⪽`).
- **Important notice:** Once this version is tagged, this will be the **last version** compatible with Julia v0.3.

## 0.1.2

- Increase test coverage and corresponding bug fixes
- Enable pre-compilation for Julia v0.4

## 0.1.1

- Re-enable tests for `Interval{Float64}` (`e0f3c1506f`)

# v0.1

v0.1 is the first public release of the package.

### Interval arithmetic
- Two methods for interval rounding are available:
 (i) narrow/slow (which uses hardward rounding mode changes for `Float64` intervals, and (ii) wide/fast (which does not change the rounding mode)
- The current interval precision and rounding mode are stored in the `interval_parameters` object
- The macro `@interval` generates intervals based on the current interval precision
- Trigonometric functions are "nearly" rigorous (for `Float64` intervals, correct rounding is not currently guaranteed)
- Inverse trigonometric functions are available
- Intervals of `BigFloat`s are displayed with the precision as a subscript numeral

### Root finding
- Newton and Krawczyk methods are implemented for rigorously finding simple roots of 1D real functions
- Stringent tests are performed, with various precision settings ( Float64` and `BigFloat )
