# This file contains the functions described as "Integer functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

"""
    sign(x::BareInterval)
    sign(x::Interval)

Implement the `sign` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.sign(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return _unsafe_bareinterval(T, sign(lo), sign(hi))
end

function Base.sign(x::Interval)
    r = sign(bareinterval(x))
    d = decoration(x)
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    ceil(x::BareInterval)
    ceil(x::Interval)

Implement the `ceil` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.ceil(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return _unsafe_bareinterval(T, ceil(lo), ceil(hi))
end

function Base.ceil(x::Interval)
    r = ceil(bareinterval(x))
    d = decoration(x)
    d = min(d, ifelse(isinteger(sup(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    floor(x::BareInterval)
    floor(x::Interval)

Implement the `floor` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.floor(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return _unsafe_bareinterval(T, floor(lo), floor(hi))
end

function Base.floor(x::Interval)
    r = floor(bareinterval(x))
    d = decoration(x)
    d = min(d, ifelse(isinteger(sup(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    trunc(x::BareInterval)
    trunc(x::Interval)

Implement the `trunc` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.trunc(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    lo, hi = bounds(x)
    return _unsafe_bareinterval(T, trunc(lo), trunc(hi))
end

function Base.trunc(x::Interval)
    r = trunc(bareinterval(x))
    d = decoration(x)
    d = min(d, ifelse((isinteger(inf(x)) & (inf(x) < 0)) | (isinteger(sup(x)) & (sup(x) > 0)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, isguaranteed(x))
end

"""
    round(x::BareInterval, [RoundingMode])
    round(x::Interval, [RoundingMode])

Return an interval with the bounds of `x` rounded to an integer.

Implement the functions `roundTiesToEven` and `roundTiesToAway` of the IEEE Standard 1788-2015.
"""
Base.round(x::Union{BareInterval,Interval}) = round(x, RoundNearest)
Base.round(x::Union{BareInterval,Interval}, ::RoundingMode{:ToZero}) = trunc(x)
Base.round(x::Union{BareInterval,Interval}, ::RoundingMode{:Up}) = ceil(x)
Base.round(x::Union{BareInterval,Interval}, ::RoundingMode{:Down}) = floor(x)

for (S, R) ∈ ((:(:Nearest), :RoundNearest), (:(:NearestTiesAway), :RoundNearestTiesAway))
    @eval begin
        function Base.round(x::BareInterval{T}, ::RoundingMode{$S}) where {T<:NumTypes}
            isempty_interval(x) && return x
            lo, hi = bounds(x)
            return _unsafe_bareinterval(T, round(lo, $R), round(hi, $R))
        end

        function Base.round(x::Interval, ::RoundingMode{$S})
            r = round(bareinterval(x), $R)
            d = decoration(x)
            d = min(d, ifelse(isinteger(2*inf(x)) | isinteger(2*sup(x)), dac, d))
            d = min(d, ifelse(isthin(r), d, def))
            return _unsafe_interval(r, d, isguaranteed(x))
        end
    end
end
