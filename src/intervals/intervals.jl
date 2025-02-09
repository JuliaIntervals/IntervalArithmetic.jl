# Construction and composability with numbers
include("construction.jl")
    export BareInterval, bareinterval, decoration, ill, trv, def, dac, com,
        Interval, interval, isguaranteed, @interval, @I_str
include("parsing.jl")
include("real_interface.jl")
include("exact_literals.jl")
    export ExactReal, @exact, has_exact_display

# Rounding
include("rounding.jl")

# Flavor
include("flavor.jl")

# Arithmetic
include("arithmetic/absmax.jl")
include("arithmetic/basic.jl")
include("arithmetic/hyperbolic.jl")
include("arithmetic/integer.jl")
include("arithmetic/power.jl")
    export pow, pown, rootn, fastpow, fastpown
include("arithmetic/trigonometric.jl")

# Other functions
include("interval_operations/cancellative.jl")
    export cancelminus, cancelplus
include("interval_operations/constants.jl")
    export emptyinterval, entireinterval, nai
include("interval_operations/extended_div.jl")
    export extended_div
include("interval_operations/boolean.jl")
    export isequal_interval, issubset_interval, isstrictsubset, isinterior,
        isdisjoint_interval, isweakless, isstrictless, precedes, strictprecedes,
        in_interval, isempty_interval, isentire_interval, isnai, isbounded,
        isunbounded, iscommon, isatomic, isthin, isthinzero, isthinone,
        isthininteger

include("interval_operations/overlap.jl")
    export Overlap, overlap
include("interval_operations/numeric.jl")
    export inf, sup, bounds, mid, diam, radius, midradius, mag, mig, dist
include("interval_operations/set_operations.jl")
    export intersect_interval, hull, interiordiff
include("interval_operations/bisect.jl")
    export bisect, mince, mince!



# Note: generated functions must be defined after all the methods they use
@generated function bareinterval(::Type{T}, a::AbstractIrrational) where {T<:NumTypes}
    x = _unsafe_bareinterval(T, a(), a()) # precompute the interval
    return :($x) # set body of the function to return the precomputed result
end
