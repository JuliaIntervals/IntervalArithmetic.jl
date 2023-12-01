# This file contains the functions described as
# "Cancellative addition and subtraction" in Section 9.2 of the
# IEEE Standard 1788-2015 and required for set-based flavor in Section 10.5.6

"""
    cancelminus(x, y)

Compute the unique interval `z` such that `y + z == x`.

The result is decorated by at most `trv` (Section 11.7.1).

Implement the `cancelMinus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
function cancelminus(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) & (isempty_interval(y) | !isunbounded(y)) && return emptyinterval(BareInterval{T})

    isunbounded(x) | isunbounded(y) | isempty_interval(y) && return entireinterval(BareInterval{T})

    diam(x) < diam(y) && return entireinterval(BareInterval{T})

    z_lo, z_hi = bounds(@round(T, inf(x) - inf(y), sup(x) - sup(y)))
    z_lo > z_hi && return entireinterval(BareInterval{T})

    # corner case 2 (page 62), involving unbounded z
    z_lo == typemax(T) && return _unsafe_bareinterval(T, prevfloat(z_lo), z_hi)
    z_hi == typemin(T) && return _unsafe_bareinterval(T, z_lo, nextfloat(z_hi))

    z = _unsafe_bareinterval(T, z_lo, z_hi)
    isunbounded(z) && return z

    # Corner case 1 (page 62) involving finite precision for diam(x) and diam(y)
    w_lo, w_hi = bounds(@round(T, inf(y) + z_lo, sup(y) + z_hi))
    (diam(x) == diam(y)) & ((prevfloat(inf(x)) > w_lo) | (nextfloat(sup(x)) < w_hi)) && return entireinterval(BareInterval{T})

    return z
end
cancelminus(x::BareInterval, y::BareInterval) = cancelminus(promote(x, y)...)

function cancelminus(x::Interval, y::Interval)
    r = cancelminus(bareinterval(x), bareinterval(y))
    d = min(decoration(x), decoration(y), decoration(r), trv)
    t = isguaranteed(x) & isguaranteed(y)
    return _unsafe_interval(r, d, t)
end

"""
    cancelplus(x, y)

Compute the unique interval `z` such that `y - z == x`; this is semantically
equivalent to `cancelminus(x, -y)`.

The result is decorated by at most `trv` (Section 11.7.1).

Implement the `cancelPlus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
cancelplus(x::BareInterval, y::BareInterval) = cancelminus(x, -y)

cancelplus(x::Interval, y::Interval) = cancelminus(x, -y)
