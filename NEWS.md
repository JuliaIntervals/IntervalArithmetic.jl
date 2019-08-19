# What's new in `IntervalArithmetic.jl`

## v0.17

### Supported versions of Julia
- The package now supports only Julia v1.3 and later.

### Breaking changes
- Changed from using `FastRounding.jl` to `RoundingEmulator.jl` for the defalt rounding mode. [#370](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/370)


## v0.15

### Supported versions of Julia
- Julia 0.6 is no longer supported. The package is now fully compatible with Julia 0.7 and 1.0. [#201](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/201)

### Breaking changes
- `showall` has been removed from Julia. We now export the function `showfull` instead. [#203](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/203

- In keeping with the change to base Julia, `atan2` has been replaced by the 2-argument method of `atan`. [#192](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/192)

### First contributions
Caroline Wormell and Mohamed Tarek made first contributions to the package.


## v0.14

### Breaking changes
- `IntervalBox` is no longer a subtype of `StaticVector` or of `AbstractArray`,
but rather contains an `SVector` of `Interval`s. The internal `SVector` of an `IntervalBox` `X` is available as `X.v`.  [#152](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/152)

### New functions
- Various functions, including `bisect`, were moved here from `IntervalRootFinding.jl`. [#160](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/160)

- The set operations `⊂`, `⊃` and `⊇` were added [#154](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/154)

### Supported versions of Julia
- This is slated to be the last minor release supporting Julia 0.6.

### First contributions
- @mforets and @Kolaru made first contributions to the package.

## v0.13

### Breaking changes
- `convert(Interval{T}, x::T)` no longer does any rounding: it creates
the thin (zero-width) interval `[x, x]`. [#114](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/114)

  Note that this implies that numbers are no longer rounded in operations combining them with intervals, such as `0.1 + interval(0.2, 0.3)`, since `0.1` is `convert`ed to an `Interval` by Julia's promotion machinery.

### New functions
- The unexported function `IntervalArithmetic.atomic(Interval{T}, x)` creates the smallest atomic interval obtained by directed rounding, treating `x` as representing a real number (the old behaviour
of `convert`). [#114](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/114)

### Performance
- `sin` and `cos` are over 6 times faster.  [#117](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/117)

- Various operations with `IntervalBox`es are faster, due to consistent use of
broadcasting. [#106](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/114)


### Documentation
- Documentation about interval arithmetic in general and construction of intervals
was improved.

### First contributions
- @tkoolen and @eeshan9815 made their first contributions to the package. Many thanks!


## v0.12

### API changes:

- The constructor `Interval(a, b)` has **had checks removed**, so **should not be used directly**; use `interval(a, b)` instead. This is for performance reasons. [#26](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/26)

- The changes to `a..b` and `a±b` were reverted; these operations are now slow again, but give the narrowest possible interval when interpreting `a` and `b` as the human version (rather than the machine version). E.g. `0.3` is treated as `3/10`, not the exactly-representable floating-point number closest to 0.3.  [#97](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/97)

- Constructor `IntervalBox(II, Val{n})` added to easily make `IntervalBox`es that are `n` copies of a given interval [#79](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/79)


## v0.11

### Supported versions of Julia
- The package now supports only Julia v0.6 and later.
The only change in this version is to remove code supporting previous versions and
update syntax, e.g. `immutable` -> `struct`.

## v0.10

### Supported versions of Julia
- This is the last version that will support Julia v0.5.

### Performance

- Between 2x and 3x speedup for basic arithmetic operations, using [FastRounding.jl](https://github.com/JeffreySarnoff/FastRounding.jl) [#25](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/25)

- A fast version of the power function is available, with the name `pow`
[#42](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/42)


### API changes:

- The `Interval` rounding mode may be changed *only on Julia 0.6 and later* using e.g.
`setrounding(Interval, :accurate)`. The mode on Julia 0.5 is fixed to `:tight`
[#25](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/25)

- Renamed `infimum` -> `inf` and `supremum` -> `sup` [#48](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/48)

- The operators `..` and `±` for interval creation are now fast, but may give results that are slightly wider
[#37]([#30](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/30)

### v0.9.1

#### Docs

- Docs have been moved to use `Documenter.jl` [#31](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/31)

#### Bug fixes
- Bug fix for `mid` [#24](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/24)

- Bug fix for `tan` [#22](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/22)

#### API changes

- `mid` of `IntervalBox` now returns an `SVector`  [#30](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/30)

#### Dependency changes
- The dependency on `ForwardDiff` has been removed [#13](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/13)

## v0.9
- The former `ValidatedNumerics.jl` package has been split into `ValidatedNumerics.jl` and `IntervalRootFinding.jl`.

`ValidatedNumerics.jl` will now be a meta-package that re-exports both of these packages.

## v0.8

### Supported versions of Julia
- Julia v0.5 and higher are supported

### Breaking API changes
- **Only on Julia 0.6**, it is now possible to change the interval rounding type again, using `setrounding(Interval, :accurate)`; #220

- Changed `setdisplay` to `setformat`. Added `@format` macro to simplify interface, e.g.
`@format standard 5 true`; #251

- `mid` is now IEEE-1788 compliant, which changes the behaviour for semi-infinite intervals #253

### Other
- Changed from using `FixedSizeArrays.jl` to `StaticArrays.jl` for `IntervalBox`;
this should be invisible to the end user #245

- Fixed a bug in 1D interval Newton;  #254


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
- Many tests use `Test` instead of `FactCheck` #205
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
[#154](https://github.com/dpsanders/ValidatedNumeris.jl/pull/154).

New usage:

    using ValidatedNumerics
    RootFinding.newton(...)

or
    using ValidatedNumerics
    using ValidatedNumerics.RootFinding
    newton(...)

- Neighbouring root intervals are merged in the Newton and Krawczyk methods: [#156](https://github.com/dpsanders/ValidatedNumerics.jl/pull/156)


### v0.4.3
- Fix display of intervals with different setdisplay options; [#146](https://github.com/dpsanders/ValidatedNumerics.jl/pull/146)

- Add emptyinterval(x::IntervalBox); [#145](https://github.com/dpsanders/ValidatedNumerics.jl/pull/145)

### v0.4.2
- Add `setdiff` for n-dimensional `IntervalBox`es; [#144](https://github.com/dpsanders/ValidatedNumerics.jl/pull/144)

### v0.4.1
- Fix incompatibility for `IntervalBox` with latest tagged versions of `FixedSizeArrays.jl`
- Add `setdiff` for 2D `IntervalBox`es  [#143](https://github.com/dpsanders/ValidatedNumerics.jl/pull/143)
- Make integer powers of complex intervals work [#142](https://github.com/dpsanders/ValidatedNumerics.jl/pull/142)

## v0.4
- Added decorated intervals [#112](https://github.com/dpsanders/ValidatedNumerics.jl/pull/112)

- Added `setdisplay` function for modifying how intervals are displayed [#115](https://github.com/dpsanders/ValidatedNumerics.jl/pull/115)

- Added `±` syntax for creating intervals as e.g. `1.3 ± 0.1` [#116](https://github.com/dpsanders/ValidatedNumerics.jl/pull/116)


## v0.3

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

## v0.2

- Significant progress has been made towards conformance with the [IEEE 1788-2015 - IEEE Standard for Interval Arithmetic] (https://standards.ieee.org/findstds/standard/1788-2015.html), with many functions added, including hyperbolic functions (`cosh`, etc.)

- The [CRlibm.jl](https://github.com/dpsanders/CRlibm.jl) (Correctly-Rounded mathematics library) is now used to obtain correctly-rounded elementary functions (`sin`, `exp`, etc.) for `Float64` arguments. Functions that are not available in `CRlibm.jl` are taken from MPFR, and are hence slower; note that this includes the `^` function.

- Julia versions of files from the comprehensive [ITF1788 test suite](https://github.com/oheim/ITF1788) by Marco Nehmeier and Maximilian Kiesner have been included in our own test suite, thanks to the efforts of Oliver Heimlich. All relevant tests pass.

- Documentation has been enhanced.

- v0.2 **supports only Julia v0.4 and later**.

- Changes are detailed in [issue #31](https://github.com/dpsanders/ValidatedNumerics.jl/issues/31)


### 0.1.3

- Improvements towards conformance with the [IEEE-1788](https://standards.ieee.org/findstds/standard/1788-2015.html) standard for Interval Arithmetic:

 - New `special_intervals.jl` file, with definitions of `emptyinterval`, `RR`, `nai` and related functions. Add new interval functions (`<=`, `radius`, `precedes`, `strictprecedes`, `≺`, etc).

 - Control rounding tighter for arithmetic operations; `*`, `inv` and `/` have been rewritten; this includes changes in `make_interval` and `convert` to get consistent behavior. These functions pass the corresponding tests in the [ITF1788](https://github.com/oheim/ITF1788) test suite.
- Deprecate the use of `⊊` in favor of `isinterior` (`⪽`).

**Important notice:** This is the **last version** of the package that
supports Julia v0.3.

### 0.1.2

- Increase test coverage and corresponding bug fixes
- Enable pre-compilation for Julia v0.4

### 0.1.1

- Re-enable tests for `Interval{Float64}` (`e0f3c1506f`)

## v0.1

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
