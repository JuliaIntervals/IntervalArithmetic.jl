# Multi-dimensional boxes

Multi-dimensional (hyper-)boxes are implemented in the
`IntervalBox` type.
These represent Cartesian products of intervals, i.e. rectangles (in 2D),
cuboids (in 3D), etc.

`IntervalBox`es are constructed from an array of `Interval`s; it is
often convenient to use the `..` notation:

```jldoctest multidim
julia> using IntervalArithmetic # hide

julia> X = IntervalBox(1..3, 2..4)
[1, 3] × [2, 4]

julia> Y = IntervalBox(2.1..2.9, 3.1..4.9)
[2.09999, 2.90001] × [3.09999, 4.90001]
```

Several operations are defined on `IntervalBox`es, for example:

```jldoctest multidim
julia> X ∩ Y
[2.09999, 2.90001] × [3.09999, 4]

julia> X ⊆ Y
false
```

Given a multi-dimensional function taking several inputs, and interval box can be constructed as follows:

```jldoctest multidim
julia> f(x, y) = (x + y, x - y)
f (generic function with 1 method)

julia> X = IntervalBox(1..1, 2..2)
[1, 1] × [2, 2]

julia> f(X...)  
([3, 3],[-1, -1])

julia> IntervalBox(f(X...))
[3, 3] × [-1, -1]
```

```@meta
DocTestSetup = nothing
```
