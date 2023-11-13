# This file contains the two-output division requested for set-based flavor in
# Section 10.5.5 of the IEEE Standard 1788-2015



# bare intervals

"""
    extended_div(a::BareInterval, b::BareInterval)

Two-output division.

Implement the `mulRevToPair` function of the IEEE Standard 1788-2015 (Section 10.5.5).
"""
function extended_div(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    alo, ahi = bounds(a)
    blo, bhi = bounds(b)
    z = zero(T)
    if 0 < bhi && 0 > blo && !in_interval(0, a)
        if ahi < 0
            return (a / _unsafe_bareinterval(T, z, bhi), a / _unsafe_bareinterval(T, blo, z))
            # return (_unsafe_bareinterval(T, T(-Inf), ahi / bhi), _unsafe_bareinterval(T, ahi / blo, T(Inf)))
        elseif alo > 0
            return (a / _unsafe_bareinterval(T, blo, z), a / _unsafe_bareinterval(T, z, bhi))
            # return (_unsafe_bareinterval(T, T(-Inf), alo / blo), _unsafe_bareinterval(T, alo / bhi, T(Inf)))
        end

    elseif in_interval(0, a) && in_interval(0, b)
        return (entireinterval(BareInterval{T}), emptyinterval(BareInterval{T}))

    else
        return (a / b, emptyinterval(BareInterval{T}))
    end
end



# decorated intervals

function extended_div(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r1, r2 = extended_div(bx, by)
    d = min(decoration(x), decoration(y))
    d1 = min(d, decoration(r1), ifelse(!isempty_interval(bx) & !isempty_interval(by) & !in_interval(0, x), d, trv))
    d2 = min(d, decoration(r2), trv)
    t = guarantee(x) & guarantee(y)
    return _unsafe_interval(r1, d1, t), _unsafe_interval(r2, d2, t)
end
