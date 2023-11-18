# This file contains the functions described as "Absmax functions" in Section
# 9.1 of the IEEE Standard 1788-2015 and required for set-based flavor in
# Section 10.5.3

"""
    abs(a::BareInterval)
    abs(a::Interval)

Implement the `abs` function of the IEEE Standard 1788-2015 (Table 9.1).
"""
function abs(a::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    return _unsafe_bareinterval(T, mig(a), mag(a))
end

abs(a::Interval) = _unsafe_interval(abs(bareinterval(a)), decoration(a), guarantee(a))

"""
    abs2(a::BareInterval)
    abs2(a::Interval)

Implement the square absolute value; this is semantically equivalent to `nthpow(a, 2)`.
"""
abs2(a::BareInterval) = nthpow(a, 2) # not in the IEEE Standard 1788-2015

abs2(a::Interval) = _unsafe_interval(abs2(bareinterval(a)), decoration(a), guarantee(a))

for f ∈ (:min, :max)
    @eval begin
        """
            $($f)(a::BareInterval, b::BareInterval)
            $($f)(a::Interval, b::Interval)

        Implement the `$($f)` function of the IEEE Standard 1788-2015 (Table 9.1).
        """
        function $f(a::BareInterval{T}, b::BareInterval{T}) where {T<:NumTypes}
            isempty_interval(a) && return a
            isempty_interval(b) && return b
            return _unsafe_bareinterval(T, $f(inf(a), inf(b)), $f(sup(a), sup(b)))
        end
        $f(a::BareInterval, b::BareInterval) = $f(promote(a, b)...)

        function $f(a::Interval, b::Interval)
            r = $f(bareinterval(a), bareinterval(b))
            d = min(decoration(a), decoration(b))
            t = guarantee(a) & guarantee(b)
            return _unsafe_interval(r, d, t)
        end
    end
end
