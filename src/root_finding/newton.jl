
isthin(x) = (m = (x.lo + x.hi) / 2; m == x.lo || m == x.hi)  # no more precision
# this won't ever be the case with BigFloat if the interval is centered around 0?

function guarded_mid(x)
    m = (x.lo + x.hi) / 2
    if m == 0.0  # midpoint exactly 0
        alpha = 0.45
        m = alpha*x.lo + (1-alpha)*x.hi   # displace to another point in the interval
    end

    m

end

function N(f::Function, x::Interval, deriv=None)

    if deriv==None
        deriv = differentiate(f, x)
    end

    m = guarded_mid(x)
    m = Interval(m)

    Nx = m - ( f(m) / deriv )

end


function newton_refine(f::Function, x::Interval, tolerance=1e-16)
    #println("Refining $x")
    i = 0
    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        Nx = N(f, x)
        Nx = Nx ∩ x

        if Nx == x
            return (x, :unique)
        end
        x = Nx

    end

    (x, :unique)
end

#newton(f::Function, x::Nothing) = []

function newton(f::Function, x::Interval, tolerance=1e-16)

    if isempty(x)
        return []
    end

    if diam(x) < tolerance
        return (x, :unknown)
    end


    deriv = differentiate(f, x)

    if !(0 in deriv)
        Nx = N(f, x, deriv)

        if isempty(Nx ∩ x)
            return []
        end

        if Nx ⊆ x
            return newton_refine(f, Nx)
        end


        if isthin(x)
            return (x, :unknown)
        end

        # bisect:

        #println("Bisecting...")

        m = mid(x)
        return vcat(newton(f, Interval(x.lo, m)),  # must be careful with rounding of m ?
                    newton(f, Interval(m, x.hi))
                    )

    else  # 0 in deriv; this does extended interval division by hand
        y1 = Interval(deriv.lo, -0.0)
        y2 = Interval(0.0, deriv.hi)

        y1 = N(f, x, y1) ∩ x
        y2 = N(f, x, y2) ∩ x


        return sort!(vcat(
                         newton(f, y1),
                         newton(f, y2)
                         )
                     )
    end
end

# function process_newton(f::Function, x::Interval)

#     roots = newton(f, x)

#     unique_roots = Interval[]
#     unknown_roots = Interval[]

#     for root in roots
#         @show root
#         if root[2] == :unique
#             push!(unique_roots, root[1])
#         else
#             push!(unknown_roots, root[1])
#         end
#     end

#     sort!(unique_roots)
#     sort!(unknown_roots)

#     unique_roots, unknown_roots
# end

#import Base.show
#show(io::IO, x::Interval) = print(io, "[$(round(float(x.lo), 5)), $(round(float(x.hi), 5))]")
