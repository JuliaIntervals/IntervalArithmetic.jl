struct Constant{T}
    value::T
end

(constant::Constant)(::Any) = constant.value
(constant::Constant)(::Interval) = interval(constant.value)

struct Piece{T}
    f
    domain::Interval{T}
    left_continuity::Int
end

Piece(f, domain::Interval) = Piece(f, domain, -1)
Piece(x::Real, domain::Interval) = Piece(Constant(x), domain)

struct Piecewise{T}
    pieces::Vector{Piece{T}}
    holes::Vector{Interval{T}}
end

function Piecewise(pieces...)
    pieces = sort(collect(pieces) ; lt = (p1, p2) -> precedes(p1.domain, p2.domain))
    subdomains = domain.(pieces)

    for (S1, S2) in zip(subdomains[1:end-1], subdomains[2:end])
        sup(S1) > inf(S2) && throw(ArgumentError("pieces are not disjoint"))
    end

    holes = [entireinterval()]

    for S in subdomains
        holes = mapreduce(vcat, holes) do hole
            return interval_diff(hole, S)
        end
    end

    return Piecewise(pieces, holes)
end

domain(piece::Piece) = piece.domain
domain(piecewise::Piecewise) = domain.(piecewise.pieces)

intersecting(X::Interval, Y::Interval) = !isempty_interval(intersect_interval(X, Y))

function interior_intersecting(X::Interval, Y::Interval)
    inter = intersect_interval(X, Y)
    (inter == inf(X) || inter == sup(X)) && return false
    return !isempty_interval(inter)
end

# TODO This is not true for interval bordering a hole.
function (piecewise::Piecewise)(X::Interval)
    if any(interior_intersecting.(X, piecewise.holes))
        dec = trv
    else
        dec = com
        for piece in piecewise.pieces
            if in_interval(inf(domain(piece)), X) && piece.left_continuity < 0
                dec = def
            end
        end
    end

    used_pieces = filter(piece -> intersecting(X, domain(piece)), piecewise.pieces)
    outputs = map(used_pieces) do piece
        S = IntervalArithmetic.setdecoration(intersect_interval(X, domain(piece)), decoration(X))
        return piece.f(S)
    end

    dec = min(dec, minimum(decoration.(outputs)))
    return IntervalArithmetic.setdecoration(reduce(hull, outputs), dec)
end

function (piecewise::Piecewise)(x::Real)
    for piece in piecewise.pieces
        in_interval(x, domain(piece)) && return piece.f(x)
    end
    throw(DomainError("piecewise function was called with $x which is outside of its domain $(domain(piecewise))"))
end