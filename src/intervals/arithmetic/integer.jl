# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Integer functions"
    in the IEEE Std 1788-2015 (section 9.1) and required for set-based flavor
    in section 10.5.3.
=#

for f in (:sign, :ceil, :floor, :trunc)
    @eval begin
        """
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Std 1788-2015 (Table 9.1).
        """
        function ($f)(a::F) where {F<:Interval}
            isempty(a) && return emptyinterval(F)
            return F(($f)(inf(a)), ($f)(sup(a)))
        end
    end
end

# NOTE this is note strictly needed as per the standard. It is documented
# in the docstring of round and could be removed
const RoundTiesToEven = RoundNearest
const RoundTiesToAway = RoundNearestTiesAway

"""
    round(a::Interval[, RoundingMode])

Return the interval with rounded to an integer limits.

Implement the functions `roundTiesToEven` and `roundTiesToAway` requested by
the IEEE Std 1788-2015. `roundTiesToEven` corresponds
to `round(a)` or `round(a, RoundNearest)`, and `roundTiesToAway`
to `round(a, RoundNearestTiesAway)`.
"""
round(a::Interval) = round(a, RoundNearest)
round(a::Interval, ::RoundingMode{:ToZero}) = trunc(a)
round(a::Interval, ::RoundingMode{:Up}) = ceil(a)
round(a::Interval, ::RoundingMode{:Down}) = floor(a)

function round(a::F, ::RoundingMode{:Nearest}) where {F<:Interval}
    isempty(a) && return emptyinterval(F)
    return F(round(inf(a)), round(sup(a)))
end

function round(a::F, ::RoundingMode{:NearestTiesAway}) where {F<:Interval}
    isempty(a) && return emptyinterval(F)
    return F(round(inf(a), RoundNearestTiesAway), round(sup(a), RoundNearestTiesAway))
end
