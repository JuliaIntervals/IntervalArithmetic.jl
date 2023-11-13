# This file contains the functions described as "Integer functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3



# bare intervals

for f ∈ (:sign, :ceil, :floor, :trunc)
    @eval begin
        """
            $($f)(a::BareInterval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function $f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return _unsafe_bareinterval(T, $f(lo), $f(hi))
        end
    end
end

# not strictly required by the IEEE Standard 1788-2015
const RoundTiesToEven = RoundNearest
const RoundTiesToAway = RoundNearestTiesAway

"""
    round(a::BareInterval[, RoundingMode])

Return the interval with limits rounded to an integer.

Implement the functions `roundTiesToEven` and `roundTiesToAway` of the IEEE
Standard 1788-2015.
"""
round(a::BareInterval) = round(a, RoundNearest)

round(a::BareInterval, ::RoundingMode{:ToZero}) = trunc(a)

round(a::BareInterval, ::RoundingMode{:Up}) = ceil(a)

round(a::BareInterval, ::RoundingMode{:Down}) = floor(a)

function round(a::BareInterval{T}, ::RoundingMode{:Nearest}) where {T<:NumTypes}
    isempty_interval(a) && return a
    lo, hi = bounds(a)
    return _unsafe_bareinterval(T, round(lo), round(hi))
end

function round(a::BareInterval{T}, ::RoundingMode{:NearestTiesAway}) where {T<:NumTypes}
    isempty_interval(a) && return a
    lo, hi = bounds(a)
    return _unsafe_bareinterval(T, round(lo, RoundNearestTiesAway), round(hi, RoundNearestTiesAway))
end



# decorated intervals

function sign(xx::Interval)
    r = sign(bareinterval(xx))
    d = decoration(xx)
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end
function ceil(xx::Interval)
    x = bareinterval(xx)
    r = ceil(x)
    d = decoration(xx)
    d = min(d, ifelse(isinteger(sup(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end
function floor(xx::Interval)
    x = bareinterval(xx)
    r = floor(x)
    d = decoration(xx)
    d = min(d, ifelse(isinteger(inf(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end
function trunc(xx::Interval)
    x = bareinterval(xx)
    r = trunc(x)
    d = decoration(xx)
    d = min(d, ifelse((isinteger(inf(x)) && inf(x) < 0) | (isinteger(sup(x)) && sup(x) > 0), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end

function round(xx::Interval, ::RoundingMode{:Nearest})
    x = bareinterval(xx)
    r = round(x)
    d = decoration(xx)
    d = min(d, ifelse(isinteger(2*inf(x)) | isinteger(2*sup(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end
function round(xx::Interval, ::RoundingMode{:NearestTiesAway})
    x = bareinterval(xx)
    r = round(x,RoundNearestTiesAway)
    d = decoration(xx)
    d = min(d, ifelse(isinteger(2*inf(x)) | isinteger(2*sup(x)), dac, d))
    d = min(d, ifelse(isthin(r), d, def))
    return _unsafe_interval(r, d, guarantee(xx))
end
round(xx::Interval) = round(xx, RoundNearest)
round(xx::Interval, ::RoundingMode{:ToZero}) = trunc(xx)
round(xx::Interval, ::RoundingMode{:Up}) = ceil(xx)
round(xx::Interval, ::RoundingMode{:Down}) = floor(xx)
