
const D = differentiate

function guarded_deriv_midpoint(f, f_prime, x::Interval)
    # avoid 0 derivative

    alpha = 0.5
    m = alpha*x.lo + (1-alpha)*x.hi

    while f_prime(m) == 0
        alpha /= 2
        m = alpha*x.lo + (1-alpha)*x.hi
    end

    m = Interval(m)
    return m, 1./f_prime(m)
end



K(f::Function, f_prime::Function, xx::Interval, m, C) = (
                            # m = Interval(m);
                            # C = Interval(C);
                            m - C*f(m) + (1. - C*f_prime(xx)) * (xx - m)
                            )

K(f::Function, f_prime::Function, x::Interval) =
    (
        (m, C) = guarded_deriv_midpoint(f, f_prime, x);
        K(f, f_prime, x, m, C)
    )

K(f::Function, x::Interval) = K(f, D(f), x)

function krawczyk_refine(f::Function, f_prime::Function, x::Interval, tolerance=1e-18)
    #println("Refining $x")
    i = 0
    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root

        Kx = K(f, f_prime, x) ∩ x

        if Kx == x
            return (x, :unique)
        end

        x = Kx
    end

    (x, :unique)
end




function krawczyk(f::Function, f_prime::Function, x::Interval)

    Kx = K(f, f_prime, x) ∩ x

    if isempty(Kx)
        return []
    end

    if Kx ⊊ x
        return krawczyk_refine(f, f_prime, Kx)
    end

    m = mid(x)

    return vcat(
                krawczyk(f, f_prime, Interval(x.lo, m)),
                krawczyk(f, f_prime, Interval(m, x.hi))
                )
end

krawczyk(f::Function, x::Interval) = krawczyk(f, D(f), x)
