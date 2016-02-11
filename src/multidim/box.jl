# Multidimensional intervals, called IntervalBox

#using ValidatedNumerics
#using FixedSizeArrays

import Base:
    ⊆, ∩, isempty

export IntervalBox

#typealias IntervalBox{N,T} Vec{N, Interval{T}}  # Vec from FixedSizeArrays
doc"""A `IntervalBox` is a Cartesian product of an arbitrary number of `Interval`s,
representing an $N$-dimensional rectangular IntervalBox."""
immutable IntervalBox{N, T} <: FixedVector{N, Interval{T}} # uses FixedSizeArrays package
    intervals :: NTuple{N, Interval{T}}
end

mid(X::IntervalBox) = [mid(x) for x in X.intervals]

⊆(X::IntervalBox, Y::IntervalBox) = all([x ⊆ y for (x,y) in zip(X.intervals, Y.intervals)])

∩(X::IntervalBox, Y::IntervalBox) = IntervalBox([x ∩ y for (x,y) in zip(X.intervals, Y.intervals)]...)
isempty(X::IntervalBox) = any(map(isempty, X.intervals))

a = IntervalBox(1..2, 3..4)
b = IntervalBox(0..2, 3..6)

@assert a ⊆ b

X = IntervalBox(1..2, 3..4)
Y = IntervalBox(3..4, 3..4)

@assert isempty(X ∩ Y)


function Base.show(io::IO, X::IntervalBox)
    for (i, x) in enumerate(X)
        print(io, x)
        if i != length(X)
            print(io, " × ")
        end
    end
end
