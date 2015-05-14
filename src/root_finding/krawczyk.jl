# Krawczyk method, following Tucker

# const D = differentiate

@doc doc"""Returns two intervals, the first being a point within the
interval x such that the interval corresponding to the derivative of f there
does not contain zero, and the second is the inverse of its derivative""" ->
function guarded_derivative_midpoint{T}(f::Function, f_prime::Function, x::Interval{T})

    α = convert(T, 0.46875)   # close to 0.5, but exactly representable as a floating point
    m = Interval( guarded_mid(x) )

    C = inv(f_prime(m))

    # Check that 0 is not in C; if so, consider another point rather than m
    i = 0
    while zero(T) ∈ C
        m = Interval( α*x.lo + (one(T)-α)*x.hi )
        C = inv(f_prime(m))

        i += 1
        α /= 2
        i > 20 && error("""Error in guarded_deriv_midpoint:
            the derivative of the function seems too flat""")
    end

    return m, C
end


function K{T}(f::Function, f_prime::Function, x::Interval{T})
    m, C = guarded_derivative_midpoint(f, f_prime, x)
    deriv = f_prime(x)
    Kx = m - C*f(m) + (one(T) - C*deriv) * (x - m)
    Kx
end


function krawczyk_refine{T}(f::Function, f_prime::Function, x::Interval{T};
    tolerance=eps(one(T)), debug=false)

    debug && (print("Entering krawczyk_refine:"); @show x)

    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        Kx = K(f, f_prime, x)
        debug && @show(x, Kx)
        Kx = Kx ∩ x
        Kx == x && break
        x = Kx
    end

    return [(x, :unique)]
end


# use automatic differentiation if no derivative function given
krawczyk{T}(f::Function,x::Interval{T}; tolerance=eps(one(T)),
    debug=false, maxlevel=30) =
    krawczyk(f, D(f), x, 0, tolerance=tolerance, debug=debug, maxlevel=maxlevel)

function krawczyk{T}(f::Function, f_prime::Function, x::Interval{T}, level::Int=0;
    tolerance=eps(one(T)), debug=false, maxlevel=30)

    debug && (print("Entering krawczyk:"); @show(level); @show(x))

    # Maximum level of bisection
    level >= maxlevel && return [(x, :unknown)]

    isempty(x) && return [(x, :none)]
    Kx = K(f, f_prime, x) ∩ x

    isempty(Kx ∩ x) && return [(x, :none)]

    if Kx ⊊ x
        debug && (print("Refining "); @show(x))
        return krawczyk_refine(f, f_prime, Kx, tolerance=tolerance, debug=debug)
    end

    m = guarded_mid(x)

    debug && @show(x,m)

    isthin(x) && return [(x, :unknown)]

    # bisecting
    roots = vcat(
        krawczyk(f, f_prime, Interval(x.lo, m), level+1, tolerance=tolerance,
            debug=debug, maxlevel=maxlevel),
        krawczyk(f, f_prime, Interval(m, x.hi), level+1, tolerance=tolerance,
            debug=debug, maxlevel=maxlevel)
        )

    # This cleans-up the tuples with `:none` from the roots vector
    debug && @show(roots)

    clean_roots(roots)
end
