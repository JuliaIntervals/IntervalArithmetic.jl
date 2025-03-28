# This file contains the functions described as "Absmax functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

"""
    abs(x::BareInterval)
    abs(x::Interval)

Implement the `abs` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function Base.abs(x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(x) && return x
    return _unsafe_bareinterval(T, mig(x), mag(x))
end

Base.abs(x::Interval) = _unsafe_interval(abs(bareinterval(x)), decoration(x), isguaranteed(x))

Base.abs(x::Complex{<:Interval}) = hypot(real(x), imag(x))

"""
    abs2(x::BareInterval)
    abs2(x::Interval)

Implement the square absolute value.

!!! note
    This function calls `^` internally, hence it depends on
    `IntervalArithmetic.power_mode()`.
"""
Base.abs2(x::BareInterval) = _select_pown(x, 2) # not in the IEEE Standard 1788-2015

function Base.abs2(x::Interval)
    r = abs2(bareinterval(x))
    d = min(decoration(x), decoration(r))
    return _unsafe_interval(r, d, isguaranteed(x))
end

Base.abs2(x::Complex{<:Interval}) = abs2(real(x)) + abs2(imag(x))

for f ∈ (:min, :max)
    @eval begin
        """
            $($f)(x::BareInterval, y::BareInterval)
            $($f)(x::Interval, y::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function Base.$f(x::BareInterval{T}, y::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(x) && return x
            isempty_interval(y) && return y
            return _unsafe_bareinterval(T, $f(inf(x), inf(y)), $f(sup(x), sup(y)))
        end
        Base.$f(x::BareInterval, y::BareInterval) = $f(promote(x, y)...)

        function Base.$f(x::Interval, y::Interval)
            r = $f(bareinterval(x), bareinterval(y))
            d = min(decoration(x), decoration(y))
            t = isguaranteed(x) & isguaranteed(y)
            return _unsafe_interval(r, d, t)
        end
    end
end
