
const D = differentiate

function guarded_deriv_midpoint(f, f_prime, x::Interval)
    # avoid 0 derivative



    alpha = 0.5
    m = alpha*x.lo + (1-alpha)*x.hi

    i = 0

    while abs(f(m)) < 1e-10   # don't bisect at/near a root
        alpha /= 1.1
        m = alpha*x.lo + (1-alpha)*x.hi
        i += 1
        if i>10
            break
        end
    end

    m = Interval(m)
    return m, 1./f_prime(m)
end



K(f::Function, f_prime::Function, xx::Interval, m, C) = (
                            # m = Interval(m);
                            # C = Interval(C);
                            m - C*f(m) + (1 - C*f_prime(xx)) * (xx - m)
                            )

K(f::Function, f_prime::Function, x::Interval) =
    (
        (m, C) = guarded_deriv_midpoint(f, f_prime, x);
        K(f, f_prime, x, m, C)
    )

K(f::Function, x::Interval) = K(f, D(f), x)

function krawczyk_refine(f::Function, f_prime::Function, x::Interval, tolerance=1e-18)

    print("Entering krawczyk_refine: ")
    @show x

    i = 0
    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root

        @show x
        Kx = K(f, f_prime, x) ∩ x

        if Kx == x
            return (x, :unique)
        end

        if isempty(Kx)   # shouldn't happen?
            return []
        end

        x = Kx
    end

    (x, :unique)
end




function krawczyk(f::Function, f_prime::Function, x::Interval)

    print("Entering Krawczyk: ")
    @show x

    Kx = K(f, f_prime, x) ∩ x

    if isempty(Kx)
        return []
    end

    if Kx ⊊ x
        return krawczyk_refine(f, f_prime, Kx)
    end

    if isthin(x)
        return [(x, :unknown)]
    end

    m = mid(x)

    return vcat(
                krawczyk(f, f_prime, Interval(x.lo, m)),
                krawczyk(f, f_prime, Interval(m, x.hi))
                )
end

krawczyk(f::Function, x::Interval) = krawczyk(f, D(f), x)
