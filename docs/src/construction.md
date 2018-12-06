# Constructing intervals

Constructing an interval is the most basic operation in the library. There are several methods to construct intervals listed below.

Note that a valid interval `[a, b]` must have `a ≤ b`.

- `interval(x)`

  `interval(x, y)`

  This is the most fundamental way to build an interval for a user. It accepts one or two floating-point values and constructs the resulting interval with lower and upper endpoints exactly equal to those floating-point values, checking that the resulting interval is valid:  

  ```

  julia> using IntervalArithmetic

  julia> @format full  # print out literal interval values in full
  Display parameters:
  - format: full
  - decorations: false
  - significant figures: 6

  julia> interval(0.1)
  Interval(0.1, 0.1)

  julia> interval(0.1, 0.2)
  Interval(0.1, 0.2)

  julia> interval(3.1f0)
  Interval(3.1, 3.1)

  julia> typeof(ans)
  IntervalArithmetic.Interval{Float32}

  julia> interval(Inf)
  ERROR: ArgumentError: `[Inf, Inf]` is not a valid interval. Need `a ≤ b` to construct `interval(a, b)`.

  julia> interval(3, 2)
  ERROR: ArgumentError: `[3, 2]` is not a valid interval. Need `a ≤ b` to construct `interval(a, b)`.
  ```

  Note that `interval` *does not perform any rounding of the end-points*. E.g.
  ```
  julia> x = interval(0.1)
  Interval(0.1, 0.1)

  julia> big(x)
  Interval(1.000000000000000055511151231257827021181583404541015625000000000000000000000000e-01, 1.000000000000000055511151231257827021181583404541015625000000000000000000000000e-01)

  julia> big"0.1" ∈ x
  false
  ```
  See [here](rounding.md) for more on the need for rounding.


- `x..y`

  This is a convenient syntax, and tries to be "clever" by interpreting the values as user-friendly numbers, rather than strict floating-point, and performing [directed rounding](rounding.md) automatically to give an interval that is guaranteed to contain the corresponding true real numbers. For example:

  ```
  julia> 0.1..0.2
  Interval(0.09999999999999999, 0.2)

  julia> big(ans)
  Interval(9.999999999999999167332731531132594682276248931884765625000000000000000000000000e-02, 2.000000000000000111022302462515654042363166809082031250000000000000000000000000e-01)
  ```

  So `0.1..0.2` contains both the true real number `1/10` and `2/10`.

  To do so, floating-point values like `0.1` are treated as the smallest interval containing the true real number 1/10, given by the unexported `atomic` function:

  ```
  julia> IntervalArithmetic.atomic(Interval{Float64}, 0.1)
  Interval(0.09999999999999999, 0.1)

  julia> 0.1..0.1
  Interval(0.09999999999999999, 0.1)
  ```

- `m ± r`

  The `±` operator (typed as `\pm<TAB>`) creates the interval with midpoint `m` and radius `r`, and is equivalent to
  `(m - r) .. (m + r)`:

  ```
  julia> 1 ± 0.1
  Interval(0.8999999999999999, 1.1)
  ```

- `@interval expr`

  The `@interval` macro takes a Julia expression and calculates an interval that is guaranteed to contain the true result of the calculation, treating literals in the same way as the `..` operator, e.g.

  ```
  julia> x = @interval sin(0.1) + cos(0.2)
  Interval(1.0798999944880696, 1.07989999448807)

  julia> sin(big"0.1") + cos(big"0.2") ∈ x
  true
  ```


- `Interval(x)`

  `Interval(x1, x2)`

  `Interval` is the underlying interval constructor. Since v0.12 of the package, however, *for efficiency reasons this performs no tests on the validity of the interval, and allows invalid intervals to be created*. As a result, we recommend that *this should not be used in user code*; it should only be used in library functions which guarantee that the interval is already of the correct form.

  For example, the following creates an invalid interval which will cause problems later:

  ```
  julia> Interval(3, 2)  # do *not* do this
  [3, 2]
  ```
