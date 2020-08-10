# This file is part of the IntervalArithmetic.jl package; MIT licensed

# The order in which files are included is important,
# since certain things need to be defined before others use them

if haskey(ENV, "IA_VALID")
    const validity_check = true
else
    const validity_check = false
end

abstract type AbstractRealFlavor{T}<:Real end
abstract type AbstractNonRealFlavor{T} end

"""
    AbstractFlavor

Supertype of all interval flavors (*interval Flavor* is the IEEE-Standard term
for a type of interval).

For most practical purposes it acts as an abstract type from which all flavors
are derived. It is however an abstract union and can therefore not be directly
subtyped. A new Flavor should instead subtype either `AbstractRealFlavor` or
`AbstractNonRealFlavor`, depending on wether the Flavor should be a subtype of
`Real`.
"""
const AbstractFlavor{T} = Union{AbstractRealFlavor{T}, AbstractNonRealFlavor{T}}

eltype(x::AbstractFlavor{T}) where {T<:Real} = T
size(x::AbstractFlavor) = (1,)

for (Flavor, Supertype) in [(:SetBasedFlavoredInterval, AbstractRealFlavor), (:GenericFlavoredInterval, AbstractNonRealFlavor)]
    flavordef = quote
        struct $Flavor{T}<:$Supertype{T}
            lo :: T
            hi :: T

            function $Flavor{T}(a::Real, b::Real) where {T<:Real}
                !validity_check && return new(a, b)
                !is_valid_interval(a, b) && throw(ArgumentError("Interval of form [$a, $b] not allowed. Must have a ≤ b to construct interval(a, b)."))

                new(a, b)
            end
        end

        ## Outer constructors
        $Flavor(a::T, b::T) where {T<:Real} = $Flavor{T}(a, b)
        $Flavor(a::T) where {T<:Real} = $Flavor(a, a)
        $Flavor(a::Tuple) = $Flavor(a...)
        $Flavor(a::T, b::S) where {T<:Real, S<:Real} = $Flavor(promote(a, b)...)

        ## Concrete constructors for Interval, to effectively deal only with Float64,
        # BigFloat or Rational{Integer} intervals.
        $Flavor(a::T, b::T) where {T<:Integer} = $Flavor(float(a), float(b))

        $Flavor(x::AbstractFlavor) = $Flavor(x.lo, x.hi)
        $Flavor(x::$Flavor) = x
        $Flavor(x::Complex) = $Flavor(real(x)) + im*$Flavor(imag(x))

        # TODO check if that gives correct results
        $Flavor{T}(x) where T = $Flavor(convert(T, x))
        $Flavor{T}(x::$Flavor) where T = atomic($Flavor{T}, x)

        # Constructors for Irrational
        # Single argument Irrational constructor are in IntervalArithmetic.jl
        # as generated functions need to be define last.
        $Flavor{T}(a::Irrational, b::Irrational) where {T<:Real} = $Flavor{T}(T(a, RoundDown), T(b, RoundUp))
        $Flavor{T}(a::Irrational, b::Real) where {T<:Real} = $Flavor{T}(T(a, RoundDown), b)
        $Flavor{T}(a::Real, b::Irrational) where {T<:Real} = $Flavor{T}(a, T(b, RoundUp))

        $Flavor(a::Irrational, b::Irrational) = $Flavor{Float64}(a, b)
        $Flavor(a::Irrational, b::Real) = $Flavor{Float64}(a, b)
        $Flavor(a::Real, b::Irrational) = $Flavor{Float64}(a, b)

        function $Flavor{T}(a, b; check=false) where {T}
            if check && !is_valid_interval(a, b)
                throw(ArgumentError("`[$a, $b]` is not a valid interval. Need `a ≤ b` to construct `interval(a, b)`."))
            end
        
            return $Flavor(a, b)
        end

        function $Flavor(a, b; check=false)
            if check && !is_valid_interval(a, b)
                throw(ArgumentError("`[$a, $b]` is not a valid interval. Need `a ≤ b` to construct `interval(a, b)`."))
            end
        
            return $Flavor(a, b)
        end

        $Flavor(a; check=false) = $Flavor(a, a, check=check)

        # Flavor without parametrization, allows reparametrization
        flavortype(::Type{$Flavor{T}}) where T = $Flavor

        convert(::Type{$Flavor{T}}, x::$Flavor{S}) where {T, S} = atomic($Flavor{T}, x)
    end

    # TODO Add documentations for flavors
    @eval $flavordef
end


"""
    reparametrize(F::Type{AbstractFlavor}, ::Type{ELTYPE})

Return the type corresponding to flavor `F` with bounds of type `ELTYPE`.
"""
reparametrize(::Type{F}, ::Type{ELTYPE}) where {F<:AbstractFlavor, ELTYPE} = flavortype(F){ELTYPE}

const supported_flavors = (SetBasedFlavoredInterval, GenericFlavoredInterval)

# TODO Properly test that this works
if haskey(ENV, "IA_DEFAULT_FLAVOR")
    @eval quote
        const Interval = $(ENV["IA_DEFAULT_FLAVOR"])
    end
else
    const Interval = SetBasedFlavoredInterval
end

if haskey(ENV, "IA_DEFAULT_BOUND_TYPE")
    @eval quote
        const DefaultBound = $(ENV["IA_DEFAULT_BOUND_TYPE"])
    end
else
    const DefaultBound = Float64
end

defaultdoc = """
    Interval

Default type of interval, currently set to `$Interval`.

To change this set the environnment variable `ENV["IA_DEFAULT_FLAVOR"]` to a
`Symbol` matching the desired flavor name. Then rebuild the package (`build IntervalArithmetic`
in a REPL in pkg mode).
"""
@doc defaultdoc Interval

"""
    is_valid_interval(a::Real, b::Real)

Check if `(a, b)` constitute a valid interval.
"""
function is_valid_interval(a::Real, b::Real)
    if isnan(a) || isnan(b)
        return false
    end

    if a > b
        if isinf(a) && isinf(b)
            return true  # empty interval = [∞,-∞]
        else
            return false
        end
    end

    # TODO Check if this is necessary
    if a == Inf || b == -Inf
        return false
    end

    return true
end


"""
    interval(a, b)

`interval(a, b)` checks whether [a, b] is a valid `Interval`, which is the case if `-∞ <= a <= b <= ∞`, using the (non-exported) `is_valid_interval` function. If so, then an `Interval(a, b)` object is returned; if not, then an error is thrown.
"""
interval(a::Real, b::Real) = Interval(a, b, check=true)
interval(a::Real) = interval(a, a)

"Make an interval even if a > b"
function force_interval(a, b)
    a > b && return interval(b, a)  # check == true to check for NaN
    return interval(a, b)
end


## Include files
include("macros.jl")
include("rounding_macros.jl")
include("rounding.jl")
include("conversion.jl")
include("precision.jl")

include("common/arithmetic/absmax.jl")
include("common/arithmetic/basic.jl")
include("common/arithmetic/hyperbolic.jl")
include("common/arithmetic/integer.jl")
include("common/arithmetic/power.jl")
include("common/arithmetic/signbit.jl")
include("common/arithmetic/trigonometric.jl")

include("common/boolean.jl")
include("common/cancellative.jl")
include("common/constants.jl")
include("common/extended_div.jl")
include("common/misc.jl")
include("common/numeric.jl")
include("common/set_operations.jl")
include("common/special.jl")

include("flavors/arithmetic.jl")
include("flavors/boolean.jl")
include("flavors/special.jl")

"""
    a..b
    ..(a, b)

Create the interval `[a, b]` of the default interval type.

See the documentation of `Interval` for more information about the default
interval type.
"""
function ..(a::T, b::S) where {T, S}
    R = promote_type(T, S)
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::T, b::Irrational{S}) where {T, S}
    R = promote_type(T, Irrational{S})
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::Irrational{T}, b::S) where {T, S}
    R = promote_type(Irrational{T}, S)
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

function ..(a::Irrational{T}, b::Irrational{S}) where {T, S}
    R = promote_type(Irrational{T}, Irrational{S})
    return Interval(atomic(Interval{R}, a).lo, atomic(Interval{R}, b).hi, check=true)
end

a ± b = (a-b)..(a+b)
±(a::AbstractFlavor, b) = (a.lo - b)..(a.hi + b)

"""
    hash(x, h)

Computes the integer hash code for an interval using the method for composite
types used in `AutoHashEquals.jl`

Note that in `IntervalArithmetic.jl`, equality of interval is given by
`≛` rather than the `==` operator.
"""
hash(x::F, h::UInt) where {F<:AbstractFlavor} = hash(x.hi, hash(x.lo, hash(flavortype(F), h)))
