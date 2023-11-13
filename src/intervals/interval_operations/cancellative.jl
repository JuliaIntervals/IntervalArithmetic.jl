# This file contains the functions described as
# "Cancellative addition and subtraction" in Section 9.2 of the
# IEEE Standard 1788-2015 and required for set-based flavor in Section 10.5.6



# bare intervals

"""
    cancelminus(a, b)

Return the unique interval `c` such that `b + c = a`.

Implement the `cancelMinus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
function cancelminus(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
    (isempty_interval(a) && (isempty_interval(b) || !isunbounded(b))) && return emptyinterval(BareInterval{T})

    (isunbounded(a) || isunbounded(b) || isempty_interval(b)) && return entireinterval(BareInterval{T})

    diam(a) < diam(b) && return entireinterval(BareInterval{T})

    c_lo, c_hi = bounds(@round(T, inf(a) - inf(b), sup(a) - sup(b)))
    c_lo > c_hi && return entireinterval(BareInterval{T})

    # Corner case 2 (page 62), involving unbounded c
    c_lo == typemax(T) && return _unsafe_bareinterval(T, prevfloat(c_lo), c_hi)
    c_hi == typemin(T) && return _unsafe_bareinterval(T, c_lo, nextfloat(c_hi))

    c = _unsafe_bareinterval(T, c_lo, c_hi)
    isunbounded(c) && return c

    # Corner case 1 (page 62) involving finite precision for diam(a) and diam(b)
    a_lo, a_hi = bounds(@round(T, inf(b) + c_lo, sup(b) + c_hi))
    (diam(a) == diam(b)) && (nextfloat(sup(a)) < a_hi || prevfloat(inf(a)) > a_lo) && return entireinterval(BareInterval{T})

    return c
end
cancelminus(a::BareInterval, b::BareInterval) = cancelminus(promote(a, b)...)

"""
    cancelplus(a, b)

Return the unique interval `c` such that `b - c = a`.

Equivalent to `cancelminus(a, -b)`.

Implement the `cancelPlus` function of the IEEE Standard 1788-2015 (Section 9.2).
"""
cancelplus(a::BareInterval, b::BareInterval) = cancelminus(a, -b)



# decorated intervals

for f ∈ (:cancelplus, :cancelminus)
    @eval begin
        """
            $($f)(x, y)

        Decorated interval extension; the result is decorated by at most `trv`,
        following the IEEE-1788 Standard (see Sect. 11.7.1, pp 47).
        """
        function $f(x::Interval, y::Interval)
            r = $f(bareinterval(x), bareinterval(y))
            d = min(decoration(x), decoration(y), decoration(r), trv)
            t = guarantee(x) & guarantee(y)
            return _unsafe_interval(r, d, t)
        end
    end
end
