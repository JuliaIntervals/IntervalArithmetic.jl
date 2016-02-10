# Multidimensional intervals, called Box

typealias Box{N,T} Vec{N, Interval{T}}  # Vec from FixedSizeArrays

    intervals::Vector{Interval{T}}

end

# implement array interface for Box
# (see http://julia.readthedocs.org/en/latest/manual/interfaces/):

Base.size(X::Box) = size(X.intervals)
Base.linearindexing{T}(::Type{Box{T}}) = Base.LinearFast()
Base.getindex(X::Box, i::Int) = X.intervals[i]
Base.setindex!(X::Box, x, i::Int) = X.intervals[i] = x

..(a, b) = @interval(a, b)
export ..


Box(a...) = Box([a...;])

Box{T<:FloatingPoint}(a::Vector{T}) = Box(Interval{T}[@interval(x) for x in a])


-(X::Box, Y::Box) = Box(Interval{eltype(X)}[x-y for (x,y) in zip(X.intervals, Y.intervals)])


mid(X::Box) = [mid(x) for x in X.intervals]

⊆(X::Box, Y::Box) = all([x ⊆ y for (x,y) in zip(X.intervals, Y.intervals)])

∩(X::Box, Y::Box) = Box([x ∩ y for (x,y) in zip(X.intervals, Y.intervals)])
isempty(X::Box) = any(map(isempty, X.intervals))

a = Box(1..2, 3..4)
b = Box(0..2, 3..6)

@assert a ⊆ b


function Base.show(io::IO, X::Box)
    for (i, x) in enumerate(X)
        print(io, x)
        if i != length(X)
            print(io, " × ")
        end
    end
end
