# What's new in ValidatedNumerics.jl

### 0.1:
- A new `interval_parameters` object stores information about the current interval precision and rounding mode
- Macros for interval creation completely reworked: `@interval` generates intervals based on the current type
  stored in `interval_parameters`
- Newton and Krawczyk methods improved and stringent tests added
- Two types of interal rounding methods are now available:
  - narrow / slow;  wide / fast   (Though they are not really very wide at all)
- Trigonometric functions are now "nearly" rigorous (for `Float64` intervals correct rounding is not guaranteed)
- Inverse trigonometric functions added

### 0.0.3: April 4, 2015
- Intervals are now parametrised by type, allowing intervals of `BigFloat`, `Float64`, `Rational`, etc.
- Source files reorganised
- Macros for creating intervals (still needs work)
- Initial implementations of interval Newton and Krawczyk methods for rigorous root finding for 1D functions

### 0.0.2: October 11, 2014
- Added functions allowing generic linear algebra routines to work with matrices containing intervals (see `lin_alg_tests.jl` for an example).

- Reorganised code into several `.jl` files.

### 0.0.1:  September 30, 2014
- Initial pre-release contains routines for interval arithmetic with intervals containing `BigFloat`.
