# Newton method


@doc doc"""Returns the midpoint of the interval x, slightly shifted in case
it is zero""" ->
function guarded_mid{T}(x::Interval{T})
    m = mid(x)
    if m == zero(T)                     # midpoint exactly 0
        alpha = convert(T,0.46875)      # close to 0.5, but exactly representable as a floating point
        m = alpha*x.lo + (one(m)-alpha)*x.hi   # displace to another point in the interval
    end

    m
end


function N(f::Function, x::Interval, deriv::Interval)
    m = guarded_mid(x)
    m = Interval(m)
    Nx = m - f(m) / deriv
    Nx
end


function newton_refine{T}(f::Function, f_prime::Function, x::Interval{T};
    tolerance=eps(one(T)), debug=false)

    debug && (print("Entering newton_refine:"); @show x)

    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        deriv = f_prime(x)
        Nx = N(f, x, deriv)
        debug && @show(x, Nx)
        Nx = Nx ∩ x
        Nx == x && break
        x = Nx
    end

    return [(x, :unique)]
end


# use automatic differentiation if no derivative function given
newton{T}(f::Function, x::Interval{T}; tolerance=eps(one(T)), debug=false, maxlevel=30) =
    newton(f, D(f), x, 0, tolerance=tolerance, debug=debug, maxlevel=maxlevel)

function newton{T}(f::Function, f_prime::Function, x::Interval{T}, level::Int=0;
    tolerance=eps(one(T)), debug=false, maxlevel=30)

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

    # deriv = differentiate(f, x)
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
    debug && (println("Entering clean_roots!"); @show(roots))
    clean_roots!(roots)
    return roots
end


# This cleans-up the tuples with `:none` from the roots vector
function clean_roots!(roots)
    for i in length(roots):-1:1
        x = roots[i]
        if x[2] == :none
            deleteat!(roots,i)
        end
    end
    return sort!(roots)
end
