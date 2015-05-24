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

One such algorithm is the **interval Newton method**. This is a version of the
standard Newton (or Newton-Raphson) algorithm for finding roots of equations.
The interval version, however, is fundamentally different from its standard
counterpart, in that it can (under the best circumstances) provide rigorous
*guarantees* about the presence or absence and uniqueness of roots of a given
function in a given interval.

The idea of the Newton method is to calculate a root $x^\ast$ of a function $f$ [i.e., a value such that $f(x^*) = 0$] from an initial guess $x$ using

$$x^* = x - \frac{f(x)}{f'(\xi)},$$

for some $\xi$ between $x$ and $x^*$. Since $\xi$ is unknown, we can bound it as

$$f'(\xi) \in F'(X),$$

where $X$ is a containing interval and $F'(X)$ denotes the **interval extension** of the function $f$, consisting of applying the same operations as the function $f$ to the interval $X$.

This allows us to create an interval Newton operator that acts on an interval and tells us *rigorously*  if there is a unique root or no root in the interval. There is also an extension to intervals in which the derivative $F'(X)$ contains $0$.

The upshot is a rigorous algorithm that is *guaranteed to find all roots* of a real function in a given interval (or to inform us if it is unable to do so, for example at a multiple root); see the book of Tucker for more details.

## Interval Newton method

The interval Newton method is implemented for real functions of a single variable as the function `newton`. For example, we can calculate rigorously the square roots of 2:

```julia
julia> f(x) = x^2 - 2
f (generic function with 1 method)

julia> newton(f, @interval(-5, 5))
2-element Array{Tuple{ValidatedNumerics.Interval{Float64},Symbol},1}:
 ([-1.4142135623730951, -1.414213562373095],:unique)
 ([1.414213562373095, 1.4142135623730951],:unique)  
```
The function `newton`  is passed the function and the interval in which to search for roots; it returns an array of tuples, giving the interval and a symbol that tells us if the root is unique.  Automatic differentiation is used if no explicit derivative function is given.

For example, the basic Newton method fails to guarantee the presence or absence of a double root, although the single roots are found without difficulty:
```julia
julia> g(x) = (x^2-2)*(x-2)^2
g (generic function with 1 method)

julia> newton(g, @interval(-5, 5))
8-element Array{Tuple{ValidatedNumerics.Interval{Float64},Symbol},1}:
 ([-1.4142135623730951, -1.414213562373095],:unique)
 ([1.414213562373095, 1.4142135623730951],:unique)  
 ([1.9999999953782792, 1.9999999967603888],:unknown)
 ([1.9999999967603888, 1.9999999981424985],:unknown)
 ([1.9999999981806982, 1.9999999987913273],:unknown)
 ([1.9999999987913273, 1.9999999994019564],:unknown)
 ([1.999999999589721, 2.000000000202166],:unknown)  
 ([2.000000000299439, 2.000000000876634],:unknown)  
```

An interface `find_roots` is provided, which does not require an interval to be passed:

```julia
julia> find_roots(g, -5, 5)
8-element Array{Tuple{ValidatedNumerics.Interval{Float64},Symbol},1}:
 ([-1.4142135623730951, -1.414213562373095],:unique)
 ([1.4142135623730947, 1.4142135623730954],:unique)
 ([1.9999999953782792, 1.9999999967603888],:unknown)
 ([1.9999999967603888, 1.9999999981424985],:unknown)
 ([1.9999999981806982, 1.9999999987913273],:unknown)
 ([1.9999999987913273, 1.9999999994019564],:unknown)
 ([1.999999999589721, 2.000000000202166],:unknown)  
 ([2.000000000299439, 2.000000000876634],:unknown)  
```
