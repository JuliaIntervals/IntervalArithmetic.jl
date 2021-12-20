# This file is part of the IntervalArithmetic.jl package; MIT licensed

real(a::Interval) = a
zero(a::F) where {T<:Real, F<:Interval{T}} = F(zero(T))
zero(::Type{F}) where {T<:Real, F<:Interval{T}} = F(zero(T))
one(a::F) where {T<:Real, F<:Interval{T}} = F(one(T))
one(::Type{F}) where {T<:Real, F<:Interval{T}} = F(one(T))
typemin(::Type{F}) where {T<:Real, F<:Interval{T}} = wideinterval(F, typemin(T))
typemax(::Type{F}) where {T<:Real, F<:Interval{T}} = wideinterval(F, typemax(T))
typemin(::Type{F}) where {T<:Integer, F<:Interval{T}} = F(typemin(T))
typemax(::Type{F}) where {T<:Integer, F<:Interval{T}} = F(typemax(T))

dist(a::Interval, b::Interval) = max(abs(a.lo-b.lo), abs(a.hi-b.hi))
eps(a::F) where {F<:Interval} = F(max(eps(a.lo), eps(a.hi)))
eps(::Type{F}) where {T, F<:Interval{T}} = F(eps(T))

interval_from_midpoint_radius(midpoint, radius) = Interval(midpoint-radius, midpoint+radius)

isinteger(a::Interval) = (a.lo == a.hi) && isinteger(a.lo)
