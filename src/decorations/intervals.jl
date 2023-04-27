# This file is part of the IntervalArithmetic.jl package; MIT licensed

# Decorated intervals, following the IEEE 1758-2015 standard

"""
    DECORATION

Enumeration constant for the types of interval decorations. The nomenclature
follows Section 11.2 of the IEEE Standard 1788-2015:
- `com -> 4`: non-empty, continuous and bounded (common)
- `dac -> 3`: non-empty and continuous (defined and continuous)
- `def -> 2`: non-empty (defined)
- `trv -> 1`: always true (trivial)
- `ill -> 0`: not an interval (ill-formed)
"""
@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# Note that `isweaklyless`, and hence `<` and `min`, are automatically defined for enums

"""
    DecoratedInterval{T<:NumTypes}

Wraps an `Interval` together with a `DECORATION`, i.e. a flag that records the
status of the interval when thought of as the result of a previously executed
sequence of functions acting on an initial interval.
"""
struct DecoratedInterval{T<:NumTypes}
    interval::Interval{T}
    decoration::DECORATION

    DecoratedInterval{T}(x::Interval{T}, d::DECORATION) where {T<:NumTypes} = new{T}(x, d)
end

function DecoratedInterval{T}(x::Interval{T}) where {T<:NumTypes}
    d = decoration(x)
    d ≤ trv && return DecoratedInterval{T}(x, d)
    d == ill && return DecoratedInterval{T}(nai(T), d)
    return DecoratedInterval{T}(x, d)
end

DecoratedInterval(x::Interval{T}, d::DECORATION) where {T<:NumTypes} = DecoratedInterval{T}(x, d)

DecoratedInterval(x::Interval{T}) where {T<:NumTypes} = DecoratedInterval{T}(x)

DecoratedInterval(x::DecoratedInterval, d::DECORATION) = DecoratedInterval(x.interval, d) # do we want this behaviour?

DecoratedInterval(a, b, d::DECORATION) =
    DecoratedInterval(unsafe_interval(promote_numtype(numtype(a), numtype(b)), a, b),
        ifelse(is_valid_interval(a, b), d, ill))

function DecoratedInterval(a, b)
    T = promote_numtype(numtype(a), numtype(b))
    is_valid_interval(a, b) || return DecoratedInterval(unsafe_interval(T, a, b), ill)
    return DecoratedInterval(unsafe_interval(T, a, b))
end

DecoratedInterval(a, d::DECORATION) = DecoratedInterval(a, a, d)

DecoratedInterval(a) = DecoratedInterval(a, a)

DecoratedInterval(a::Tuple, d::DECORATION) = DecoratedInterval(a..., d)

DecoratedInterval(a::Tuple) = DecoratedInterval(a...)

#

interval(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

function decoration(x::Interval)
    isnai(x) && return ill        # nai()
    isempty(x) && return trv      # emptyinterval
    isunbounded(x) && return dac  # unbounded
    return com                    # common
end

#

float(x::DecoratedInterval) = DecoratedInterval(float(interval(x)), decoration(x))
big(x::DecoratedInterval) = DecoratedInterval(big(interval(x)), decoration(x))

macro decorated(ex...)
    if !(ex[1] isa String)
        if length(ex) == 1
            x = :(@interval($(esc(ex[1]))))
            lo = :(inf($x))
            hi = :(sup($x))
        else
            lo, hi = ex
        end

        return :(DecoratedInterval($lo, $hi))
    else
        s = ex[1]
        parse(DecoratedInterval{Float64}, s)
    end
end
