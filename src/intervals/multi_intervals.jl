using IntervalArithmetic
import Base: getindex, ∪
import Base: +, -, *, /, min, max, ^, log, <, >

abstract type MultiInterval{T} <: AbstractInterval{T} end

###
#   Multi-Interval constructor. Consists of a vector of intervals
###
struct IntervalM{T<:Real} <: MultiInterval{T} 
    v :: Array{Interval{T}}
end


###
#   Outer constructors
###
function intervalM(x) 
    x = IntervalM(x)
    x = removeEmpties(x)
    return condense(x)
end

intervalM(x :: Interval) = IntervalM([x])
∪(x :: Interval) = intervalM(x)

∪(x :: Interval, y :: Interval) = intervalM([x; y])
∪(x :: Array{Interval{T}}) where T <:Real = intervalM(x)

intervalM(x :: Interval, y :: IntervalM) = intervalM([x; y.v])
∪(x :: Interval, y :: IntervalM) = intervalM(x,y)

intervalM(x :: IntervalM, y :: Interval) = intervalM([x.v; y])
∪(x :: IntervalM, y :: Interval) = intervalM(x,y)

intervalM(x :: IntervalM, y :: IntervalM) = intervalM([x.v; y.v])
∪(x :: IntervalM, y :: IntervalM) = intervalM(x,y)

# Get index from multi-interval array
getindex(x :: IntervalM, ind :: Integer) = getindex(x.v,ind)
getindex(x :: IntervalM, ind :: Array{ <:Integer}) = getindex(x.v,ind)

# Remove ∅ from Multi-Interval
function removeEmpties(x :: IntervalM)
    v = x.v
    Vnew = v[v .!= ∅]
    return IntervalM(Vnew)
end

# Recursively envolpe intervals which intersect
function condense(x :: IntervalM)

    if isCondensed(x); return x; end

    v = sort(x.v)
    v = unique(v)

    Vnew = Interval{Float64}[]
    for i =1:length(v)
        these = findall( intersect.(v[i],v ) .!= ∅)
        push!(Vnew, hull(v[these]))
    end
    return condense( intervalM(Vnew) )
end

function isCondensed(x :: IntervalM)
    v = sort(x.v)
    for i=1:length(v)
        intersects = findall( intersect.(v[i],v[1:end .!= i]) .!= ∅)
        if !isempty(intersects); return false; end
    end
    return true
end

# Envolpe/hull. Keeps it as a multi interval
env(x :: IntervalM) = IntervalM(hull(x.v))
hull(x :: IntervalM) = IntervalM(hull(x.v))


###
#   Multi-Interval Arithmetic
###

for op in (:+, :-, :*, :/, :min, :max, :^, :log, :<, :>)
    
    @eval ($op)( x::IntervalM, y::IntervalM) = intervalM([$op(xv, yv) for xv in x.v, yv in y.v][:])

    @eval ($op)( x::IntervalM, y::Interval) = intervalM(broadcast($op, x.v, y))
    @eval ($op)( x::Interval, y::IntervalM) = intervalM(broadcast($op, y, x.v))

    @eval ($op)( x::IntervalM, n::Real) = intervalM(broadcast($op, x.v, n))
    @eval ($op)( n::Real, x::IntervalM) = intervalM(broadcast($op, n, x.v))
    
end


function Base.show(io::IO, this::IntervalM)
    v = sort(this.v)
    print(io, join(v, " ∪ "));
end
