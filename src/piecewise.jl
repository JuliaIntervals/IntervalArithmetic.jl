import Intervals
import Intervals: IntervalSet, less_than_disjoint

const Domain = Intervals.Interval

inf(x::Domain) = first(x)
sup(x::Domain) = last(x)

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

        !less_than_disjoint(s1, s2) && throw(ArgumentError("domains are either not ordered or not disjoint"))
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
discontinuities(piecewise::Piecewise) = piecewise.singularities[piecewise.continuity .< 0]

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
    set = Domain(inf(X), sup(X), true, true)
    isdisjoint(set, domain(piecewise)) && return emptyinterval(T)

    if !isempty(setdiff(set, domain(piecewise)))
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