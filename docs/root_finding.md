<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: { equationNumbers: { autoNumber: "AMS" } }
  });
  MathJax.Hub.Config({
    TeX: { extensions: ["AMSmath.js", "AMSsymbols.js", "autobold.js", "autoload-all.js"] }
  });
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [['$','$'], ['\\(','\\)']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML">
</script>

# Root finding

Interval arithmetic not only provides guaranteed numerical calculations; it also
makes possible fundamentally new algorithms.

## Interval Newton method
One such algorithm is the **interval Newton method**. This is a version of the
standard Newton (or Newton-Raphson) algorithm, an iterative method for finding
roots (zeros) of functions.
The interval version, however, is fundamentally different from its standard
counterpart, in that it can (under the best circumstances) provide rigorous
*guarantees* about the presence or absence and uniqueness of roots of a given
function in a given interval, and tells us explicitly when it is unable to
provide such a guarantee.

The idea of the Newton method is to calculate a root $x^\ast$ of a function
$f$ [i.e., a value such that $f(x^*) = 0$] from an initial guess $x$ using

$$x^* = x - \frac{f(x)}{f'(\xi)},$$

for some $\xi$ between $x$ and $x^*$. Since $\xi$ is unknown, we can bound it as

$$f'(\xi) \in F'(X),$$

where $X$ is a containing interval and $F'(X)$ denotes the **interval extension**
of the function $f$, consisting of applying the same operations as the function
$f$ to the interval $X$.

We define an *interval Newton operator* $\mathcal{N}$ as follows:

$$\mathcal{N}(X) := m(X) - \frac{F(m(X))}{F'(X)},$$

where $m(X)$  is the midpoint of $X$ converted into an interval.

It turns out that $\mathcal{N}$ tells us precisely whether there is a root of $f$ in
the interval $X$: there is no root if $\mathcal{N}(X) \cap X = \emptyset$, and there is
a unique root if $\mathcal{N}(X) \subseteq X$.
There is also an extension to intervals in which the derivative $F'(X)$ contains $0$,
in which case the Newton operator returns a union of two intervals.

Iterating the Newton operator on the resulting sets gives a rigorous algorithm
that is *guaranteed to find all roots* of a
real function in a given interval (or to inform us if it is unable to do so,
for example at a multiple root); see Tucker's book for more details.

## Usage of the interval Newton method

Root-finding routines are in a separate `RootFinding` submodule of `IntervalArithmetic.jl`, 
which must be loaded with
```julia
julia> using ValidatedNumerics, ValidatedNumerics.RootFinding
```

The interval Newton method is implemented for real functions of a single
variable as the function `newton`. For example, we can calculate rigorously the square roots of 2:

```julia
julia> using ValidatedNumerics

julia> f(x) = x^2 - 2
f (generic function with 1 method)

julia> newton(f, @interval(-5, 5))
2-element Array{ValidatedNumerics.Root{Float64},1}:
 Root([-1.4142135623730951, -1.414213562373095], :unique)
 Root([1.414213562373095, 1.4142135623730951], :unique)
```
The function `newton`  is passed the function and the interval in which to search for roots;
it returns an array of `Root` objects, that contain the interval where a root is found,
together with a symbol `:unique` if there is guaranteed to be a unique root in that
interval, or `:unknown` if the Newton method is unable to make a guarantee, for example,
when there is a double root:

```julia
julia> newton(f, @interval(-5,5))
6-element Array{ValidatedNumerics.Root{Float64},1}:
 Root([0.9999999968789343, 0.999999997726216], :unknown)
 Root([0.9999999977262161, 0.9999999985734976], :unknown)
 Root([0.9999999987089422, 0.9999999993384274], :unknown)
 Root([0.9999999993384275, 0.9999999999679127], :unknown)
 Root([0.9999999999687099, 1.0000000004524654], :unknown)
 Root([2.0, 2.0], :unique)
```

The Newton method may be applied directly to a vector of known roots,
for example to refine them with higher precision:
```julia
julia> f(x) = x^2 - 2
f (generic function with 1 method)

julia> roots = newton(f, @interval(-5, 5))
2-element Array{ValidatedNumerics.Root{Float64},1}:
 Root([-1.4142135623730951, -1.414213562373095], :unique)
 Root([1.414213562373095, 1.4142135623730951], :unique)

julia> setprecision(Interval, 256)
256

julia> newton(f, roots)
2-element Array{ValidatedNumerics.Root{Base.MPFR.BigFloat},1}:
 Root([-1.414213562373095048801688724209698078569671875376948073176679737990732478462119, -1.414213562373095048801688724209698078569671875376948073176679737990732478462102]₂₅₆, :unique)
 Root([1.414213562373095048801688724209698078569671875376948073176679737990732478462102, 1.414213562373095048801688724209698078569671875376948073176679737990732478462119]₂₅₆, :unique)

julia> abs(roots2[2].interval.lo - sqrt(big(2)))
0.000000000000000000000000000000000000000000000000000000000000000000000000000000

```

## Krawczyk method

An alternative method is the *Krawczyk method*, implemented in the function
`krawczyk`, with the same interface as the Newton method:
```julia
julia> f(x) = x^2 - 2
f (generic function with 1 method)

julia> krawczyk(f, @interval(-5, 5))
2-element Array{Root{Float64},1}:
 Root([-1.4142135623730954, -1.4142135623730947], :unique)
 Root([1.4142135623730947, 1.4142135623730954], :unique)

julia> newton(f, @interval(-5, 5))
2-element Array{Root{Float64},1}:
 Root([-1.4142135623730951, -1.414213562373095], :unique)
 Root([1.414213562373095, 1.4142135623730951], :unique)
```

The Krawczyk method really comes into its own for higher-dimensional functions;
this is planned to be implemented in the future.


## `find_roots` interface
Automatic differentiation is used to calculate the derivative used in the Newton method
if the derivative function is not given explicitly as the second argument to `newton`.

An interface `find_roots` is provided, which does not require an interval to be passed:
```
julia> find_roots(f, -5, 5)
6-element Array{ValidatedNumerics.Root{Float64},1}:
 Root([0.9999999968789343, 0.999999997726216], :unknown)
 Root([0.9999999977262161, 0.9999999985734976], :unknown)
 Root([0.9999999987089422, 0.9999999993384274], :unknown)
 Root([0.9999999993384275, 0.9999999999679127], :unknown)
 Root([0.9999999999687099, 1.0000000004524654], :unknown)
 Root([1.9999999999999998, 2.0000000000000004], :unique)
```


There is also a version `find_roots_midpoint` that returns three vectors:
the midpoint of each interval; the radius of the interval; and the symbol.
This may be useful for someone who just wishes to find roots of a function,
without wanting to understand how to manipulate interval objects:
```julia
julia> find_roots_midpoint(f, -5, 5)
([-1.4142135623730951,1.414213562373095],[2.220446049250313e-16,4.440892098500626e-16],[:unique,:unique])
```

This uses the function `midpoint_radius`, that returns the midpoint and radius
of a given interval:
```julia
julia> a = @interval(0.1, 0.2)
[0.09999999999999999, 0.2]

julia> midpoint_radius(a)
(0.15,0.05000000000000002)
```
