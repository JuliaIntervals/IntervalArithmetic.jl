# This file is part of the IntervalArithmetic.jl package; MIT licensed

real(a::Interval) = a
zero(a::F) where {T<:Real, F<:AbstractFlavor{T}} = F(zero(T))
zero(::Type{F}) where {T<:Real, F<:AbstractFlavor{T}} = F(zero(T))
one(a::F) where {T<:Real, F<:AbstractFlavor{T}} = F(one(T))
one(::Type{F}) where {T<:Real, F<:AbstractFlavor{T}} = F(one(T))
typemin(::Type{F}) where {T<:Real, F<:AbstractFlavor{T}} = wideinterval(F, typemin(T))
typemax(::Type{F}) where {T<:Real, F<:AbstractFlavor{T}} = wideinterval(F, typemax(T))
typemin(::Type{F}) where {T<:Integer, F<:AbstractFlavor{T}} = F(typemin(T))
typemax(::Type{F}) where {T<:Integer, F<:AbstractFlavor{T}} = F(typemax(T))

dist(a::AbstractFlavor, b::AbstractFlavor) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))
eps(a::F) where {F<:AbstractFlavor} = F(max(eps(a.lo), eps(a.hi)))
eps(::Type{F}) where {T, F<:AbstractFlavor{T}} = F(eps(T))

# TODO use the function return midpoint and radius for that
interval_from_midpoint_radius(midpoint, radius) = Interval(midpoint-radius, midpoint+radius)

isinteger(a::AbstractFlavor) = (a.lo == a.hi) && isinteger(a.lo)
