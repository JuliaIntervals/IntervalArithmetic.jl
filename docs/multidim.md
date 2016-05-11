# Multi-dimensional boxes

Starting with v0.3, multi-dimensional (hyper-)boxes are implemented in the
`IntervalBox` type.
These represent Cartesian products of intervals, i.e. rectangles (in 2D),
cuboids (in 3D), etc.

`IntervalBox`es are constructed from an array of `Interval`s; it is
often convenient to use the `..` notation:

```julia
julia> X = IntervalBox(1..3, 2..4)
[1, 3] × [2, 4]

julia> Y = IntervalBox(2.1..2.9, 3.1..4.9)
[2.09999, 2.90001] × [3.09999, 4.90001]
```

Several operations are defined on `IntervalBox`es, for example:

```
julia> X ∩ Y
[2.09999, 2.90001] × [3.09999, 4]

julia> X ⊆ Y
false
```

To facilitate working with `IntervalBox`es, a macro `@intervalbox` is defined.
Given a multi-dimensional function taking several inputs, this creates both the original form and a
version that works with a single `IntervalBox` argument, e.g.

```julia
julia> @intervalbox f(x, y) = (x + y, x - y)
f (generic function with 2 methods)

julia> f(1..1, 2..2)  
([3.0, 3.0],[-1.0, -1.0])

julia> X = IntervalBox(1..1, 2..2)
[1.0, 1.0] × [2.0, 2.0]

julia> f(X)
[3.0, 3.0] × [-1.0, -1.0]
```
The first version takes a tuple of `Interval`s and returns another tuple of `Interval`s;
the second version takes a single `IntervalBox` and automatically does the
necessary unpacking and packing to return an `IntervalBox.`
