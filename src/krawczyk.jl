using ValidatedNumerics
using AutoDiff

const D = differentiate


# subset:
⊆(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
#⊆(a::Nothing, b::Interval) = false

# strict subset:
⊂(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi
#⊂(a::Nothing, b::Interval) = false


K(f, xx::Interval, x, C) = x - C*f(x) + (1 - C*D(f, xx)) * (xx - x)

K(f, x::Interval) = ( m = mid(x);
                      C = 1/D(f, m);
                      K(f, x, m, C)
                     )

function refine(f::Function, x::Interval, tolerance=1e-16)
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

    if Kx ⊂ x
        return refine(f, Kx)
    end

    m = mid(x)

    return vcat(
                krawczyk(f, Interval(x.lo, m)),
                krawczyk(f, Interval(m, x.hi))
                )
end

