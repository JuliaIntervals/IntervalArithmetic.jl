# This file contains the two-output division requested for set-based flavor in
# Section 10.5.5 of the IEEE Standard 1788-2015

"""
    extended_div(x, y)

Two-output division.

Implement the `mulRevToPair` function of the IEEE Standard 1788-2015 (Section 10.5.5).
"""
function extended_div(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    ylo, yhi = bounds(y)
    if 0 < yhi && 0 > ylo && !in_interval(0, x)
        if sup(x) < 0
            return (x / _unsafe_bareinterval(T, zero(T), yhi), x / _unsafe_bareinterval(T, ylo, zero(T)))
        elseif inf(x) > 0
            return (x / _unsafe_bareinterval(T, ylo, zero(T)), x / _unsafe_bareinterval(T, zero(T), yhi))
        end
    elseif in_interval(0, x) && in_interval(0, y)
        return (entireinterval(BareInterval{T}), emptyinterval(BareInterval{T}))
    else
        return (x / y, emptyinterval(BareInterval{T}))
    end
end

function extended_div(x::Interval, y::Interval)
    bx = bareinterval(x)
    by = bareinterval(y)
    r1, r2 = extended_div(bx, by)
    d = min(decoration(x), decoration(y))
    d1 = min(d, decoration(r1), ifelse(!isempty_interval(bx) & !isempty_interval(by) & !in_interval(0, x), d, trv))
    d2 = min(d, decoration(r2), trv)
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r1, d1, t), _unsafe_interval(r2, d2, t)
end
