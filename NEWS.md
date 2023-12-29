# News

## 0.22.2

- add `sind`, `cosd` and `sincosd`
- pointwise boolean functions are re-introduced (cf. PR [#604](https://github.com/JuliaIntervals/IntervalArithmetic.jl/pull/604)), namely: `iszero`, `isone`, `isinteger`, and `==(::Interval, ::Number)`/`==(::Number, ::Interval)`

## 0.22

Major changes since 0.20 and 0.21:

- interval structures:
  - new bare (i.e. no decorations) interval structure `BareInterval`, which is not a subtype of `Real`
  - `Interval` is now decorated (`DecoratedInterval` is removed) and has a new boolean field `isguaranteed`; the `Interval` type is a subtype of `Real`

- constructors:
  - `@floatinterval` and `@biginterval` are removed; `@interval` accepts a bound type as its first parameter
  - the recommended interval type is `Interval` and its constructors are `interval`, `@interval`, `parse(T<:Interval, string)`, `I"string"`. A `bareinterval` constructor is also available for `BareInterval`, as well as `parse(T<:BareInterval, string)`
  - warning is prompted when trying to construct invalid intervals

- conversion/promotion:
  - numbers cannot be converted to `BareInterval` to prevent silent errors
  - numbers can be converted to `Interval` but the `isguaranteed` field is set to false to indicate that an error may have happened

- unicode alias (e.g. `..`, `±`, `∅`, `ℝ`, etc.) are now contained in an unexported submodule `Symbols` to prevent conflicts (e.g. `..` is exported by [Makie.jl](https://github.com/MakieOrg/Makie.jl))

- display:
  - fixed previous matrix alignment issues
  - `setformat` has been renaed `setdisplay`; the display format `:standard` has been renamed `:infsup`

- set-based flavor is supported; some ground work on a flavor mechanism has been laid out to support others, e.g. cset flavor

- partial support for `Complex{<:Interval}`; some elementary functions are still missing

- ambiguous boolean `Base` functions (e.g. `==`, `issubset`, `<`, etc.) are no longer overloaded and throw an error; new counterparts methods have been defined (e.g. `isequal_interval`, `issubset_interval`, etc.)

tests:
  - all non-"rev" tests from [ITF1788](https://github.com/oheim/ITF1788) are successful (except a broken test for the `dot` function, which should be irrelevant to interval arithmetic)
  - the ITF1788 test suite is automatically generated during CI
