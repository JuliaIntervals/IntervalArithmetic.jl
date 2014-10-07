
const D = differentiate

function guarded_deriv(f, x::Interval)
    # avoid 0 derivative

    alpha = 0.5
    m = alpha*x.lo + (1-alpha)*x.hi

    while D(f, m) == 0
        alpha /= 2
        m = alpha*x.lo + (1-alpha)*x.hi
    end

    return m, 1./D(f, m)
end

K(f, xx::Interval, x, C) = x - C*f(x) + (1 - C*D(f, xx)) * (xx - x)

K(f, x::Interval) = ( (m, C) = guarded_deriv(f, x);
                      K(f, x, m, C)
                     )

function krawczyk_refine(f::Function, x::Interval, tolerance=1e-18)
    #println("Refining $x")
    i = 0
    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        Kx = K(f, x) ∩ x

        if Kx == x
            return (x, :unique)
        end

        x = Kx
    end

    (x, :unique)
end


function krawczyk(f::Function, x::Interval)

    Kx = K(f, x) ∩ x

    if isempty(Kx)
        return []
    end

    if Kx ⊊ x
        return krawczyk_refine(f, Kx)
    end

    m = mid(x)

    return vcat(
                krawczyk(f, Interval(x.lo, m)),
                krawczyk(f, Interval(m, x.hi))
                )
end

