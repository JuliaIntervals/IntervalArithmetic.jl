using AutomaticDifferentiation

# subset:
⊆(a::Interval, b::Interval) = b.lo <= a.lo && a.hi <= b.hi
⊊(a::Interval, b::Interval) = b.lo < a.lo && a.hi < b.hi


include("newton.jl")
include("krawczyk.jl")
