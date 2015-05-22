# Newton method

# What is this guarded_mid for? Shouldn't it be checking if f(m)==0?
@doc doc"""Returns the midpoint of the interval x, slightly shifted in case
it is zero""" ->
function guarded_mid{T}(x::Interval{T})
    m = mid(x)
    if m == zero(T)                     # midpoint exactly 0
        α = convert(T, 0.46875)      # close to 0.5, but exactly representable as a floating point
        m = α*x.lo + (one(T)-α)*x.hi   # displace to another point in the interval
    end

    @assert m ∈ x

    m
end


function N{T}(f::Function, x::Interval{T}, deriv::Interval{T})
    m = guarded_mid(x)
    m = Interval(m)

    m - (f(m) / deriv)
end


@doc doc"""If a root is known to be inside an interval, `newton_refine`
just iterates the interval Newton method until that root is found.""" ->
function newton_refine{T}(f::Function, f_prime::Function, x::Interval{T};
                          tolerance = 10*eps(T), debug = false)

    debug && (print("Entering newton_refine:"); @show x)

    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        deriv = f_prime(x)
        Nx = N(f, x, deriv)

        debug && @show(x, Nx)

        Nx = Nx ∩ x
        Nx == x && break

        x = Nx
    end

    debug && @show "Refined root", x

    return [(x, :unique)]
end


# use automatic differentiation if no derivative function given:
newton{T}(f::Function, x::Interval{T};
          tolerance = eps(T), debug = false, maxlevel=30) =
    newton(f, D(f), x, 0, tolerance=tolerance, debug=debug, maxlevel=maxlevel)


function newton{T}(f::Function, f_prime::Function, x::Interval{T}, level::Int=0;
                   tolerance=eps(T), debug=false, maxlevel=30)

    debug && (print("Entering newton:"); @show(level); @show(x))

    # Maximum level of bisection
    level >= maxlevel && return [(x, :unknown)]

    isempty(x) && return [(x, :none)]

    # Shall we make sure tolerance>=eps(1.0) ?
    z = zero(x.lo)
    tolerance = abs(tolerance)

    if diam(x) < tolerance
        z in f(x) && newton(f, f_prime, x, level+1, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
        println("Error: ", z in f(x), " ", x, " ", f(x))
        return [(x, :error)]
    end

    deriv = f_prime(x)

    if !(z in deriv)
        Nx = N(f, x, deriv)

        isempty(Nx ∩ x) && return [(x, :none)]

        if Nx ⊆ x
            debug && (print("Refining "); @show(x))
            return newton_refine(f, f_prime, Nx, tolerance=tolerance, debug=debug)
        end

        m = guarded_mid(x)  # must be careful with rounding of m ?

        debug && @show(x,m)

        # bisecting
        roots = vcat(
            newton(f, f_prime, Interval(x.lo, m), level+1, tolerance=tolerance, debug=debug, maxlevel=maxlevel),
            newton(f, f_prime, Interval(m, x.hi), level+1, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
            )

        debug && @show(roots)

    else  # 0 in deriv; this does extended interval division by hand

        y1 = Interval(deriv.lo, -z)
        y2 = Interval(z, deriv.hi)

        if debug
            @show (z in deriv, deriv)
            @show (y1, y2)
            @show N(f, x, y1)
            @show N(f, x, y2)
        end

        y1 = N(f, x, y1) ∩ x
        y2 = N(f, x, y2) ∩ x

        debug && @show(y1, y2)

        roots = vcat(
            newton(f, f_prime, y1, level+1, tolerance=tolerance, debug=debug, maxlevel=maxlevel),
            newton(f, f_prime, y2, level+1, tolerance=tolerance, debug=debug, maxlevel=maxlevel)
            )

        debug && @show(roots)

    end

    # This cleans-up the tuples with `:none` from the roots vector
    debug && (println("Entering clean_roots"); @show(roots))

    new_roots = clean_roots(roots)
    debug && @show(new_roots)

    new_roots
end

#is_possibly_root(root::Root) = root[2] != :none  # :unknown or :unique

