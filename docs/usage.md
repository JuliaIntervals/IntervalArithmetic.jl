# Basic usage

Intervals are created using the `@interval` macro, which takes one or two expressions:

```
julia> using ValidatedNumerics

julia> a = @interval(1)
[1.0, 1.0]

julia> typeof(ans)
Interval{Float64} (constructor with 1 method)

julia>

julia> b = @interval(1, 2)
[1.0, 2.0]
```

These return objects of type `Interval`, parametrized by the type of the elements.

The constructor of the `Interval` type may be used directly, but this is generally not recommended, for the following reason -- which is why the macros are made available:

```
julia> a = Interval(0.1, 0.3)
[0.1, 0.3]

julia> b = @interval(0.1, 0.3)
[0.09999999999999999, 0.30000000000000004]
```
What is going on here?
Due to the way floating-point arithmetic works, it turns out that the interval
`a` created by the constructor *does not contains neither the true real number 0.1, nor 0.3*.
The `@interval` macro, however, uses **directed rounding** to *guarantee*
that the true 0.1 and 0.3 *are* included in the result.

Behind the scenes, what is going on is that the `@interval` macro rewrites the expression(s)
passed to it, replacing the literals (0.1, 1, etc.) by calls to create directly-rounded intervals
(handled internally by the `make_interval` function).

This allows us to write, for example

    julia> @interval sin(0.1) + cos(0.2)

and get a resulting interval that is equivalent to writing

    julia> sin(@interval(0.1)) + cos(@interval(0.2))

Internally, this is converted into

We can also use this with user-defined functions:

    julia> f(x) = 2x
    f (generic function with 1 method)

    julia> @interval f(0.1)


## Arithmetic

Basic arithmetic operations (`+`, `-`, `*`, `/`, `^`) acting on a combination of intervals with
intervals or intervals with numbers are defined in a standard way (see, e.g. the book by Tucker):

TODO

## Elementary functions

Some elementary functions, currently `exp`, `log`, `sin`, `cos` and `tan` are defined, acting on
interval arguments.
