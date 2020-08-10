"""
    ∅

Empty interval of default flavor and `Float64` bounds. Can be typed as
`\\emptyset<TAB>`.
"""
const ∅ = emptyinterval()

"""
    ≺(a, b)

Alias of `strictPrecedes`. Can be typed as `\\prec<TAB>`.
"""
const ≺ = strictprecedes

"""
    ⪽(a, b)

Alias of `isinterior`. Can be typed as `\\subsetdot<TAB>`.
"""
const ⪽ = isinterior

"""
    ∞

Alias of `Inf`. Can be typed as `\\inf<TAB>`.
"""
const ∞ = Inf

"""
    ℝ

Alias of `RR`. Can be typed as `\\bbR<TAB>`.
"""
const ℝ = RR
