# This file contains the functions described as "Integer functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

for f in (:sign, :ceil, :floor, :trunc)
    @eval begin
        """
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function ($f)(a::Interval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return unsafe_interval(T, ($f)(lo), ($f)(hi))
        end
    end
end

# not strictly required by the IEEE Standard 1788-2015
const RoundTiesToEven = RoundNearest
const RoundTiesToAway = RoundNearestTiesAway

"""
    round(a::Interval[, RoundingMode])

Return the interval with limits rounded to an integer.

Implement the functions `roundTiesToEven` and `roundTiesToAway` of the IEEE
Standard 1788-2015.
"""
round(a::Interval) = round(a, RoundNearest)

round(a::Interval, ::RoundingMode{:ToZero}) = trunc(a)

round(a::Interval, ::RoundingMode{:Up}) = ceil(a)

round(a::Interval, ::RoundingMode{:Down}) = floor(a)

function round(a::Interval{T}, ::RoundingMode{:Nearest}) where {T<:NumTypes}
    isempty_interval(a) && return a
    lo, hi = bounds(a)
    return unsafe_interval(T, round(lo), round(hi))
end

function round(a::Interval{T}, ::RoundingMode{:NearestTiesAway}) where {T<:NumTypes}
    isempty_interval(a) && return a
    lo, hi = bounds(a)
    return unsafe_interval(T, round(lo, RoundNearestTiesAway), round(hi, RoundNearestTiesAway))
end
