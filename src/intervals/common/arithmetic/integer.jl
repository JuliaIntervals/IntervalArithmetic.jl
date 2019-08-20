# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the functions described as "Integer functions"
    in the IEEE Std 1788-2015 (section 9.1) and required for set-based flavor
    in section 10.5.3.
=#

for f in (:sign, :ceil, :floor, :trunc)
    @eval begin
        function ($f)(a::F) where {F<:AbstractFlavor}
            isempty(a) && return emptyinterval(F)
            return F(($f)(a.lo), ($f)(a.hi))
        end

    docstring = """
        $f(a::AbstractFlavor)
    
    Implement the `$f` function of the IEEE Std 1788-2015 (Table 9.1).
    """

    @doc ($f) docstring
end 

const RoundTiesToEven = RoundNearest
const RoundTiesToAway = RoundNearestTiesAway

"""
    round(a::AbstractFlavor[, RoundingMode])

Return the interval with rounded to an integer limits.

Implement the functions `roundTiesToEven` and `roundTiesToAway` requested by
the IEEE Std 1788-2015. `roundTiesToEven` corresponds
to `round(a)` or `round(a, RoundNearest)`, and `roundTiesToAway`
to `round(a, RoundNearestTiesAway)`.
"""
round(a::AbstractFlavor) = round(a, RoundNearest)
round(a::AbstractFlavor, ::RoundingMode{:ToZero}) = trunc(a)
round(a::AbstractFlavor, ::RoundingMode{:Up}) = ceil(a)
round(a::AbstractFlavor, ::RoundingMode{:Down}) = floor(a)

function round(a::F, ::RoundingMode{:Nearest}) where {F<:AbstractFlavor}
    isempty(a) && return emptyinterval(F)
    return F(round(a.lo), round(a.hi))
end

function round(a::F, ::RoundingMode{:NearestTiesAway}) where {F<:AbstractFlavor}
    isempty(a) && return emptyinterval(F)
    return F(round(a.lo, RoundNearestTiesAway), round(a.hi, RoundNearestTiesAway))
end
