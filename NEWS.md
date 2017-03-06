# What's new in ValidatedNumerics.jl

## v0.7

### End of support for Julia v0.4
- v0.7 is the last version to include support for Julia v0.4

### Breaking API changes
- Deprecate `displaymode`, replacing it with `setdisplay`, with simplified syntax #210:
```
setdisplay(:full)
```

### Added features
- Fast integer power function `pow` #208
- `parse(Interval, string)` (extends and exports previously internal function) #215
- `bisect` function in `ValidatedNumerics.RootFinding` for bisecting `Interval`s and `IntervalBox`es #217

### Other
- Many tests use `Base.Test` instead of `FactCheck` #205
- Miscellaneous bugfixes

## v0.6
- Add a plot recipe for (only) 2D `IntervalBox`es using `RecipesBase.jl`.
This enables plotting using `Plots.jl`: an individual `IntervalBox` `X` using `plot(X)`,
and a `Vector` of them using `plot([X, Y])`

- Rewritten rounding functionality which gives type-stable interval functions, and hence
better performance

- `(1..2) × (3..4)` syntax for constructing `IntervalBox`es

- `@interval` now always returns an `Interval`.
Before e.g. `@interval mid(X)` for `X` an interval returned a number instead.



## v0.5
- Root finding has been moved into a separate submodule
[#154](https://github.com/dpsanders/ValidatedNumerics.jl/pull/154).

New usage:

    using ValidatedNumerics
    RootFinding.newton(...)

or
    using ValidatedNumerics
    using ValidatedNumerics.RootFinding
    newton(...)

- Neighbouring root intervals are merged in the Newton and Krawczyk methods: [#156](https://github.com/dpsanders/ValidatedNumerics.jl/pull/156)


## v0.4.3
- Fix display of intervals with different setdisplay options; [#146](https://github.com/dpsanders/ValidatedNumerics.jl/pull/146)

- Add emptyinterval(x::IntervalBox); [#145](https://github.com/dpsanders/ValidatedNumerics.jl/pull/145)

## v0.4.2
- Add `setdiff` for n-dimensional `IntervalBox`es; [#144](https://github.com/dpsanders/ValidatedNumerics.jl/pull/144)

## v0.4.1
- Fix incompatibility for `IntervalBox` with latest tagged versions of `FixedSizeArrays.jl`
- Add `setdiff` for 2D `IntervalBox`es  [#143](https://github.com/dpsanders/ValidatedNumerics.jl/pull/143)
- Make integer powers of complex intervals work [#142](https://github.com/dpsanders/ValidatedNumerics.jl/pull/142)

# v0.4
- Added decorated intervals [#112](https://github.com/dpsanders/ValidatedNumerics.jl/pull/112)

- Added `setdisplay` function for modifying how intervals are displayed [#115](https://github.com/dpsanders/ValidatedNumerics.jl/pull/115)

- Added `±` syntax for creating intervals as e.g. `1.3 ± 0.1` [#116](https://github.com/dpsanders/ValidatedNumerics.jl/pull/116)


# v0.3

- [Added `IntervalBox` type](https://github.com/dpsanders/ValidatedNumerics.jl/pull/88), representing a multi-dimensional (hyper-)box as a `FixedSizeArray` of `Interval`s.

- Internal clean-up, including rewriting what was the internal, unexported `make_interval`
function as (exported) methods for `convert`, so that you can now write e.g.
`convert(Interval{Float64}, "0.1")`; this is used by `@interval`.

- [Replaced](https://github.com/dpsanders/ValidatedNumerics.jl/pull/101) the simple automatic differentiation functionality that was part of
the package with the sophisticated `ForwardDiff` package.

- [Unified](https://github.com/dpsanders/ValidatedNumerics.jl/pull/102) the names of the
precision and rounding functions with the
new, [flexible names](https://github.com/JuliaLang/julia/pull/13232) in Julia v0.5:

- `set_interval_precision(x)` -> `setprecision(Interval, x)`.
- `get_interval_precision()` -> `precision(Interval)`
- `set_interval_rounding(x)` -> `setrounding(Interval, x)`
- `get_interval_rounding()` -> `rounding(Interval)`

- The ITF1788 test suite has been temporarily disabled on Julia v0.5 due to a
performance regression in parsing long test suites.

- `convert(Interval, x)` has been removed. You must specify the element type of
the interval, e.g. `convert(Interval{Float64}, 0.1)`

# v0.2

- Significant progress has been made towards conformance with the [IEEE 1788-2015 - IEEE Standard for Interval Arithmetic] (https://standards.ieee.org/findstds/standard/1788-2015.html), with many functions added, including hyperbolic functions (`cosh`, etc.)

- The [CRlibm.jl](https://github.com/dpsanders/CRlibm.jl) (Correctly-Rounded mathematics library) is now used to obtain correctly-rounded elementary functions (`sin`, `exp`, etc.) for `Float64` arguments. Functions that are not available in `CRlibm.jl` are taken from MPFR, and are hence slower; note that this includes the `^` function.

- Julia versions of files from the comprehensive [ITF1788 test suite](https://github.com/oheim/ITF1788) by Marco Nehmeier and Maximilian Kiesner have been included in our own test suite, thanks to the efforts of Oliver Heimlich. All relevant tests pass.

- Documentation has been enhanced.

- v0.2 **supports only Julia v0.4 and later**.

- Changes are detailed in [issue #31](https://github.com/dpsanders/ValidatedNumerics.jl/issues/31)


## 0.1.3

- Improvements towards conformance with the [IEEE-1788](https://standards.ieee.org/findstds/standard/1788-2015.html) standard for Interval Arithmetic:

 - New `special_intervals.jl` file, with definitions of `emptyinterval`, `entireinterval`, `nai` and related functions. Add new interval functions (`<=`, `radius`, `precedes`, `strictprecedes`, `≺`, etc).

 - Control rounding tighter for arithmetic operations; `*`, `inv` and `/` have been rewritten; this includes changes in `make_interval` and `convert` to get consistent behavior. These functions pass the corresponding tests in the [ITF1788](https://github.com/oheim/ITF1788) test suite.
- Deprecate the use of `⊊` in favor of `isinterior` (`⪽`).

**Important notice:** This is the **last version** of the package that
supports Julia v0.3.

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
- The current interval precision and rounding mode are stored in the `parameters` object
- The macro `@interval` generates intervals based on the current interval precision
- Trigonometric functions are "nearly" rigorous (for `Float64` intervals, correct rounding is not currently guaranteed)
- Inverse trigonometric functions are available
- Intervals of `BigFloat`s are displayed with the precision as a subscript numeral

### Root finding
- Newton and Krawczyk methods are implemented for rigorously finding simple roots of 1D real functions
- Stringent tests are performed, with various precision settings ( Float64` and `BigFloat )
