# This file contains the functions described as "Integer functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

for f ∈ (:sign, :ceil, :floor, :trunc)
    @eval begin
        """
            $($f)(a::BareInterval)
            $($f)(a::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function $f(a::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return _unsafe_bareinterval(T, $f(lo), $f(hi))
        end

        function $f(a::Interval)
            r = $f(bareinterval(a))
            d = decoration(a)
            d = min(d, ifelse(isthin(r), d, def))
            return _unsafe_interval(r, d, isguaranteed(a))
        end
    end
end

"""
    round(a::BareInterval[, RoundingMode])
    round(a::Interval[, RoundingMode])

Return the interval with limits rounded to an integer.

Implement the functions `roundTiesToEven` and `roundTiesToAway` of the
IEEE Standard 1788-2015.
"""
round(a::Union{BareInterval,Interval}) = round(a, RoundNearest)
round(a::Union{BareInterval,Interval}, ::RoundingMode{:ToZero}) = trunc(a)
round(a::Union{BareInterval,Interval}, ::RoundingMode{:Up}) = ceil(a)
round(a::Union{BareInterval,Interval}, ::RoundingMode{:Down}) = floor(a)

for (S, R) ∈ ((:(:Nearest), :RoundNearest), (:(:NearestTiesAway), :RoundNearestTiesAway))
    @eval begin
        function round(a::BareInterval{T}, ::RoundingMode{$S}) where {T<:NumTypes}
            isempty_interval(a) && return a
            lo, hi = bounds(a)
            return _unsafe_bareinterval(T, round(lo, $R), round(hi, $R))
        end

        function round(a::Interval, ::RoundingMode{$S})
            r = round(bareinterval(a), $R)
            d = decoration(a)
            d = min(d, ifelse(isthin(r), d, def))
            return _unsafe_interval(r, d, isguaranteed(a))
        end
    end
end
