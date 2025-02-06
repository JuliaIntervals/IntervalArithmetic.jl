struct Domain{T <: NumTypes, L, R}
    lo::T
    hi::T
end

Domain(lo, hi) = Domain{:open, :closed}(lo, hi)
Domain(lo::Tuple, hi::Tuple) = Domain{lo[2], hi[2]}(lo[1], lo[2])
Domain() = Domain{:open, :open}(Inf, -Inf)
Domain(X::Interval) = Domain{:closed, :closed}(inf(X), sup(X))

lowerbound(x::Domain{L, R}) where {L, R} = (x.lo, L)
upperbound(x::Domain{L, R}) where {L, R} = (x.hi, R)

inf(x::Domain) = x.lo
sup(x::Domain) = x.hi

function rightof(x, (val, bound))
    bound == :closed && return val <= x
    return val < x
end

function rightof((val1, bound1), (val2, bound2))
    if val1 < val2 || (val1 == val2 && bound1 == bound2 == :closed)
        return false
    end

    return true
end

function leftof(x, (val, bound))
    bound == :closed && return x <= val
    return x < val
end

function leftof((val1, bound1), (val2, bound2))
    if val2 < val1 || (val1 == val2 && bound1 == bound2 == :closed)
        return false
    end

    return true
end

Base.in(x::Real, domain::Domain) = rightof(x, lowerbound(domain)) && leftof(x, upperbound(domain))

function Base.intersect(d1::Domain, d2::Domain)
    left = max(lowerbound(d1), lowerbound(d2))
    right = min(upperbound(d1), upperbound(d2))

    left > right && return Domain()
    return Domain(left, right)
end

struct Constant{T}
    value::T
end

(constant::Constant)(::Any) = constant.value
(constant::Constant)(::Interval) = interval(constant.value)

struct Piecewise
    domain::IntervalSet
    fs
    continuity::Vector{Int}
    singularities::Vector
end

function Piecewise(
        subdomains::Vector{<:Domain},
        fs,
        continuity::Vector{Int} = fill(-1, length(subdomains) - 1))

    if length(subdomains) != length(fs)
        throw(ArgumentError("the number of domains and the number of functions don't match"))
    end
    
    if length(subdomains) - 1 != length(continuity)
        n = length(subdomains)
        throw(ArgumentError("$(length(sub)) junction points but $(n - 1) are expected based on the number of domains ($n)"))
    end

    for k in 1:length(subdomains) - 1
        s1 = subdomains[k]
        s2 = subdomains[k + 1]

        if rightof(upperbound(s1), lowerbound(s2))
           throw(ArgumentError("domains are either not ordered or not disjoint"))
        end
    end

    singularities = sup.(subdomains[1:end-1])

    return Piecewise(IntervalSet(subdomains), fs, continuity, singularities)
end

function Piecewise(pairs::Vararg{<:Pair} ; continuity = fill(-1, length(pairs) - 1))
    pairs = collect(pairs)
    return Piecewise(first.(pairs), last.(pairs), continuity)
end

subdomains(piecewise::Piecewise) = convert(Vector, piecewise.domain)
domain(piecewise::Piecewise) = piecewise.domain
pieces(piecewise::Piecewise) = zip(subdomains(piecewise), piecewise.fs)
discontinuities(piecewise::Piecewise, order = 0) = piecewise.singularities[piecewise.continuity .< order]

domain_string(x::Domain) = repr(x ; context = IOContext(stdout, :compact => true))

function domain_string(S::IntervalSet)
    r = repr("text/plain", S ; context = IOContext(stdout, :compact => true))
    return join(split(r, "\n")[2:end], " ∪ ")
end

domain_string(piecewise::Piecewise) = domain_string(domain(piecewise))

function Base.show(io::IO, ::MIME"text/plain", piecewise::Piecewise)
    n = length(pieces(piecewise))
    print(io, "Piecewise function with $n pieces:")
    
    for (subdomain, f) in pieces(piecewise)
        println(io)
        print(io, "  $(domain_string(subdomain)) -> $(repr(f))")
    end
end

function (piecewise::Piecewise)(X::Interval{T}) where {T}
    set = Domain(X)
    all(isempty, intersect.(Ref(set), subdomains(piecewise))) && return emptyinterval(T)

    # This logic exploits the fact that subdomains are ordered
    lo = lowerbound(set)
    istrivial = false
    for subdomain in subdomains(piecewise)
        if leftof(lo, lowerbound(subdomain))
            istrivial = true
            break
        end

        val, bound = lowerbound(subdomain)

        if bound == :closed
            lo = (val, :open)
        else
            lo = (val, :closed)
        end
    end

    if rightof(upperbound(set), upperbound(subdomains(piecewise)[end]))
        istrivial = true
    end

    if istrivial
        dec = trv
    elseif any(in(set), discontinuities(piecewise))
        dec = def 
    else
        dec = com
    end

    results = Interval{T}[]
    for (subdomain, f) in pieces(piecewise)
        subset = intersect(set, subdomain)
        isempty(subset) && continue
        push!(results, f(interval(inf(subset), sup(subset), decoration(X))))
    end

    dec = min(dec, minimum(decoration.(results)))
    return IntervalArithmetic.setdecoration(reduce(hull, results), dec)
end

function (piecewise::Piecewise)(x::Real)
    for (subdomain, f) in pieces(piecewise)
        (x in subdomain) && return f(x)
    end
    throw(DomainError(x, "piecewise function was called outside of its domain $(domain_string(piecewise))"))
end