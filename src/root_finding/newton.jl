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


@doc doc"""If a root is known to be inside an interval,
`newton_refine` iterates the interval Newton method until that root is found.""" ->
function newton_refine{T}(f::Function, f_prime::Function, x::Interval{T};
                          tolerance=eps(T), debug=false)

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

    return [Root(x, :unique)]
end




@doc doc"""`newton` performs the interval Newton method on the given function `f`
with its optional derivative `f_prime` and initial interval `x`.
Optional keyword arguments give the `tolerance`, `maxlevel` at which to stop
subdividing, and a `debug` boolean argument that prints out diagnostic information.""" ->

function newton{T}(f::Function, f_prime::Function, x::Interval{T}, level::Int=0;
                   tolerance=eps(T), debug=false, maxlevel=30)

    debug && (print("Entering newton:"); @show(level); @show(x))

    isempty(x) && return Root{T}[]  #[(x, :none)]


    # Maximum level of bisection
    level >= maxlevel && return [Root(x, :unknown)]


    z = zero(x.lo)
    tolerance = abs(tolerance)

    if diam(x) < tolerance
        return [(x, :unknown)]
    end

    deriv = f_prime(x)

    if !(z in deriv)
        Nx = N(f, x, deriv)

        isempty(Nx ∩ x) && return Root{T}[]

        if Nx ⊆ x
            debug && (print("Refining "); @show(x))
            return newton_refine(f, f_prime, Nx, tolerance=tolerance, debug=debug)
        end

        m = guarded_mid(x)

        debug && @show(x,m)

        # bisect:
        roots = vcat(
            newton(f, f_prime, Interval(x.lo, m), level+1,
                   tolerance=tolerance, debug=debug, maxlevel=maxlevel),

            newton(f, f_prime, Interval(nextfloat(m), x.hi), level+1,
                   tolerance=tolerance, debug=debug, maxlevel=maxlevel)
            # note the nextfloat here to prevent repetition
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
            newton(f, f_prime, y1, level+1,
                   tolerance=tolerance, debug=debug, maxlevel=maxlevel),

            newton(f, f_prime, y2, level+1,
                   tolerance=tolerance, debug=debug, maxlevel=maxlevel)
            )

        debug && @show(roots)

    end


    sort!(roots, lt=lexless)
    roots
end


# use automatic differentiation if no derivative function given:
newton{T}(f::Function, x::Interval{T};  args...) = newton(f, D(f), x; args...)



# newton for vector of intervals:
newton{T}(f::Function, f_prime::Function, xx::Vector{Interval{T}}; args...) =

    vcat([newton(f, f_prime, @interval(x); args...) for x in xx]...)

newton{T}(f::Function,  xx::Vector{Interval{T}}, level; args...) =

    newton(f, D(f), xx, 0, args...)

newton{T}(f::Function,  xx::Vector{Root{T}}; args...) =

    newton(f, D(f), [x.interval for x in xx], args...)
