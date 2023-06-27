using IntervalArithmetic

include("atan2.jl")
include("c-xsc.jl")
include("fi_lib.jl")
include("ieee1788-constructors.jl")
include("ieee1788-exceptions.jl")
include("libieeep1788_bool.jl")
include("libieeep1788_cancel.jl")
include("libieeep1788_class.jl")
include("libieeep1788_elem.jl")
include("libieeep1788_num.jl")
include("libieeep1788_overlap.jl")
include("libieeep1788_rec_bool.jl")
include("libieeep1788_reduction.jl")
include("libieeep1788_set.jl")
include("mpfi.jl")
include("abs_rev.jl")

# Need to adapt IntervalContractors for the following
# using IntervalContractors
#
# include("libieeep1788_rev.jl")
# include("libieeep1788_mul_rev.jl")
# include("pow_rev.jl")
