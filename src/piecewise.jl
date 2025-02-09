struct Domain{L, R, T, S}
    lo::T
    hi::S

    function Domain{L, R, T, S}(lo::T, hi::S) where {L, R, T, S}
        (!(L in (:open, :closed)) || !(R in (:open, :closed))) && throw(ErrorException(
            "Domain bound must be either :open or :closed, got $L and $R instead"
        ))
        return new{L, R, T, S}(lo, hi)
    end
end

Domain{L, R}(lo::T, hi::S) where {T, S, L, R} = Domain{L, R, T, S}(lo, hi)
Domain(lo::Tuple, hi::Tuple) = Domain{lo[2], hi[2]}(lo[1], hi[1])
Domain(X::Interval) = Domain{:closed, :closed}(inf(X), sup(X))
Domain() = Domain{:open, :open}(Inf, -Inf)

lowerbound(x::Domain{L, R}) where {L, R} = (x.lo, L)
upperbound(x::Domain{L, R}) where {L, R} = (x.hi, R)

inf(x::Domain) = x.lo
sup(x::Domain) = x.hi

"""
    rightof(val, lowerbound)

Determine if a value is on the right of a lower bound.
"""
function rightof(x::Real, (val, bound))
    bound == :closed && return val <= x
    return val < x
end

function rightof((val1, bound1), (val2, bound2))
    if val1 < val2 || (val1 == val2 && bound1 == bound2 == :closed)
        return false
    end

    return true
end

"""
    leftof(val, upperbound)

Determine if a value is on the left of an upper bound.
"""
function leftof(x::Real, (val, bound))
    bound == :closed && return x <= val
    return x < val
end

function leftof((val1, bound1), (val2, bound2))
    if val2 < val1 || (val1 == val2 && bound1 == bound2 == :closed)
        return false
    end

    return true
end

function leftof(d1::Domain, d2::Domain)
    val1, bound1 = upperbound(d1)
    val2, bound2 = lowerbound(d2)

    val1 == val2 && return !(bound1 == bound2 == :closed)
    return val1 < val2
end

Base.in(x::Real, domain::Domain) = rightof(x, lowerbound(domain)) && leftof(x, upperbound(domain))

function Base.intersect(d1::Domain, d2::Domain)
    left = max(lowerbound(d1), lowerbound(d2))
    right = min(upperbound(d1), upperbound(d2))

    left > right && return Domain()
    return Domain(left, right)
end

function Base.isempty(domain::Domain)
    lo, lobound = lowerbound(domain)
    hi, hibound = upperbound(domain)

    lo == hi && return !(lobound == hibound == :closed)
    return lo > hi
end


struct Constant{T}
    value::T
end

(constant::Constant)(::Any) = constant.value
(constant::Constant)(::Interval) = interval(constant.value)

struct Piecewise{N, D<:Tuple, F<:Tuple, S<:Tuple}
    domains::D
    fs::F
    continuity::NTuple{N, Int}
    singularities::S

    function Piecewise(domains::D, fs::F, continuity::NTuple{N, Int}, singularities::S) where {D, F, N, S}
        if !(N + 1 == length(domains) == length(fs))
            throw(ArgumentError(
                "a Piecewise function must have as many domains as functions, " *
                "and one less continuity point. " *
                "Given: $(length(domains)) domains, $(length(fs)) functions, " *
                "$N continuity points."))
        end

        return new{N, D, F, S}(domains, fs, continuity, singularities)
    end
end

function Piecewise(
        domains::Vector{<:Domain},
        fs,
        continuity::Vector{Int} = fill(-1, length(domains) - 1))

    if length(domains) != length(fs)
        throw(ArgumentError("the number of domains and the number of functions don't match"))
    end
    
    if length(domains) - 1 != length(continuity)
        n = length(domains)
        throw(ArgumentError("$(length(sub)) junction points but $(n - 1) are expected based on the number of domains ($n)"))
    end

    for k in 1:length(domains) - 1
        s1 = domains[k]
        s2 = domains[k + 1]

        if !leftof(s1, s2)
           throw(ArgumentError("domains are either not ordered or not disjoint"))
        end
    end

    singularities = sup.(domains[1:end-1])

    return Piecewise(Tuple(domains), Tuple(fs), Tuple(continuity), Tuple(singularities))
end

function Piecewise(pairs::Vararg{Pair} ; continuity = fill(-1, length(pairs) - 1))
    pairs = collect(pairs)
    return Piecewise(first.(pairs), last.(pairs), continuity)
end

domains(piecewise::Piecewise) = piecewise.domains
pieces(piecewise::Piecewise) = zip(domains(piecewise), piecewise.fs)

function discontinuities(piecewise::Piecewise, order = 0)
    return [s for (s, C) in zip(piecewise.singularities, piecewise.continuity) if C .< order]
end

function domain_string(domain::Domain{L, R}) where {L, R}
    left = (L == :closed) ? "[" : "("
    right = (R == :closed) ? "]" : ")"

    return "$left$(domain.lo), $(domain.hi)$right"
end

function domain_string(piecewise::Piecewise)
    join(domain_string.(domains(piecewise)), " ∪ ")
end

function Base.show(io::IO, ::MIME"text/plain", piecewise::Piecewise)
    n = length(pieces(piecewise))
    print(io, "Piecewise function with $n pieces:")
    
    for (domain, f) in pieces(piecewise)
        println(io)
        print(io, "  $(domain_string(domain)) -> $(repr(f))")
    end
end

function indomain(domain, piecewise)
    rightof(upperbound(domain), upperbound(domains(piecewise)[end])) && return false

    # This relies on the fact that domains are ordered
    lo = lowerbound(domain)

    for domain in domains(piecewise)
        if !rightof(lo, lowerbound(domain))
            return false
        end

        val, bound = upperbound(domain)

        val > upperbound(domain)[1] && break

        if bound == :closed
            lo = (val, :open)
        else
            lo = (val, :closed)
        end
    end

    return true
end

overlapdomain(domain, piecewise) = any(!isempty, intersect.(Ref(domain), domains(piecewise)))

function (piecewise::Piecewise)(X::Interval{T}) where {T}
    set = Domain(X)
    !overlapdomain(set, piecewise) && return emptyinterval(T)

    if !indomain(set, piecewise)
        dec = trv
    elseif any(in(set), discontinuities(piecewise))
        dec = def 
    else
        dec = com
    end

    results = Interval{T}[]
    for (domain, f) in pieces(piecewise)
        subset = intersect(set, domain)
        isempty(subset) && continue
        push!(results, f(interval(inf(subset), sup(subset), decoration(X))))
    end

    dec = min(dec, minimum(decoration.(results)))
    return IntervalArithmetic.setdecoration(reduce(hull, results), dec)
end

function (piecewise::Piecewise)(x::Real)
    for (domain, f) in pieces(piecewise)
        (x in domain) && return f(x)
    end
    throw(DomainError(x, "piecewise function was called outside of its domain $(domain_string(piecewise))"))
end