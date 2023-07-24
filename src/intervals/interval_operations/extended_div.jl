# This file contains the two-output division requested for set-based flavor in
# Section 10.5.5 of the IEEE Standard 1788-2015

"""
    extended_div(a::Interval, b::Interval)

Two-output division.

Implement the `mulRevToPair` function of the IEEE Standard 1788-2015 (Section 10.5.5).
"""
function extended_div(a::Interval{T}, b::Interval{T}) where {T<:NumTypes}
    alo, ahi = bounds(a)
    blo, bhi = bounds(b)
    z = zero(T)
    if 0 < bhi && 0 > blo && 0 ∉ a
        if ahi < 0
            return (a / unsafe_interval(T, z, bhi), a / unsafe_interval(T, blo, z))
            # return (unsafe_interval(T, T(-Inf), ahi / bhi), unsafe_interval(T, ahi / blo, T(Inf)))
        elseif alo > 0
            return (a / unsafe_interval(T, blo, z), a / unsafe_interval(T, z, bhi))
            # return (unsafe_interval(T, T(-Inf), alo / blo), unsafe_interval(T, alo / bhi, T(Inf)))
        end

    elseif 0 ∈ a && 0 ∈ b
        return (entireinterval(T), emptyinterval(T))

    else
        return (a / b, emptyinterval(T))
    end
end
