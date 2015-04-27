# Newton method

function guarded_mid(x::Interval)
    m = mid(x)
    if m == zero(x.lo)  # midpoint exactly 0
        alpha = 0.46875 # close to 0.5, but exactly representable as a floating point
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


function newton_refine{T<:Real}(f::Function, f_prime::Function, x::Interval{T};
    tolerance=eps(one(T)), debug=false)

    debug && (print("Entering newton_refine:"); @show x)

    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        deriv = f_prime(x)
        Nx = N(f, x, deriv)
        debug && show(x, Nx)
        Nx = Nx ∩ x
        Nx == x && break
        x = Nx
    end

    Any[(x, :unique)]
end


# use automatic differentiation if no derivative function given
newton{T<:Real}(f::Function, x::Interval{T}; tolerance=eps(one(T)), debug=false) =
    newton(f, D(f), x, 0, tolerance=tolerance, debug=debug)

function newton{T<:Real}(f::Function, f_prime::Function, x::Interval{T}, level::Int=0;
    tolerance=eps(one(T)), debug=false)

    debug && (print("Entering newton:"); @show (x, level))

    # Maximum level of bisection
    level >= 30 && return Any[(x, :unknown)]

    isempty(x) && return Any[(x, :none)]

    # Shall we make sure tolerance>=eps(1.0) ?
    z = zero(x.lo)
    tolerance = abs(tolerance)
    if diam(x) < tolerance
        z in f(x) && newton(f, f_prime, x, level+1, tolerance=tolerance, debug=debug)
        println("Error: ", z in f(x), " ", x, " ", f(x))
        return Any[(x, :error)]
    end

    # deriv = differentiate(f, x)
    deriv = f_prime(x)

    if !(z in deriv)
        Nx = N(f, x, deriv)

        isempty(Nx ∩ x) && return Any[(x,:none)]

        if Nx ⊆ x
            debug && (print("Refining "); @show(x))
            return newton_refine(f, f_prime, Nx, tolerance=tolerance, debug=debug)
        end

        m = guarded_mid(x)  # must be careful with rounding of m ?

        debug && @show(x,m)

        # bisecting
        rootsN = vcat(
            newton(f, f_prime, Interval(x.lo, m), level+1, tolerance=tolerance, debug=debug),
            newton(f, f_prime, Interval(m, x.hi), level+1, tolerance=tolerance, debug=debug)
            )

    else  # 0 in deriv; this does extended interval division by hand

        y1 = Interval(deriv.lo, -z)
        y2 = Interval(z, deriv.hi)

        if debug
            println("0 in deriv")
            @show deriv
            @show (y1, y2)
            @show N(f, x, y1)
            @show N(f, x, y2)
        end

        y1 = N(f, x, y1) ∩ x
        y2 = N(f, x, y2) ∩ x

        debug && @show(y1, y2)

        rootsN = vcat(
            newton(f, f_prime, y1, level+1, tolerance=tolerance, debug=debug),
            newton(f, f_prime, y2, level+1, tolerance=tolerance, debug=debug)
            )

        debug && @show(rootsN)

    end

    # This cleans-up the tuples with `:none` or `:empty` from the rootsN vector
    rrootsN = Any[]
    for i in 1:length(rootsN)
        tup = copy(rootsN[i])
        (tup[2] == symbol(:none) || tup[2] == symbol(:empty)) && continue
         push!(rrootsN, tup)
    end

    return sort!(rrootsN)
end
