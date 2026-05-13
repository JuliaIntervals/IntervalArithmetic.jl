# Construction and composability with numbers
include("construction.jl")
    export BareInterval, bareinterval, decoration, Decoration, ill, trv, def, dac, com,
        Interval, interval, isguaranteed, @interval, @I_str
include("parsing.jl")
include("real_interface.jl")
    export numtype
include("exact_literals.jl")
    export ExactReal, exact, @exact, has_exact_display

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
    export isequal_interval, issetequal_interval, issubset_interval, isstrictsubset, isinterior,
        isdisjoint_interval, isweakless, isstrictless, precedes, strictprecedes,
        in_interval, isempty_interval, isentire_interval, isnai, isbounded,
        isunbounded, iscommon, isatomic, isthin, isthinzero, isthinone,
        isthininteger

include("interval_operations/overlap.jl")
    export Overlap, overlap
include("interval_operations/numeric.jl")
    export inf, sup, bounds, mid, diam, radius, midradius, mag, mig, dist
include("interval_operations/set_operations.jl")
    export intersect_interval, hull, interiordiff, union_interval
include("interval_operations/bisect.jl")
    export bisect, mince, mince!
include("interval_operations/reverse.jl")
    export sqr_rev, abs_rev, pown_rev, sin_rev, cos_rev, tan_rev, cosh_rev,
        mul_rev, mul_rev_to_pair,
        add_rev, sub_rev1, sub_rev2, div_rev1, div_rev2,
        sqrt_rev, cbrt_rev,
        exp_rev, exp2_rev, exp10_rev, expm1_rev,
        log_rev, log2_rev, log10_rev, log1p_rev,
        sinh_rev, tanh_rev,
        asin_rev, acos_rev, atan_rev,
        asinh_rev, acosh_rev, atanh_rev,
        inv_rev, sign_rev, pow_rev1, pow_rev2,
        plus_rev, minus_rev, times_rev, div_rev, power_rev,
        max_rev, min_rev
