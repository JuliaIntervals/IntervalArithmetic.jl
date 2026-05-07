# Reverse-mode elementary functions for interval constraint propagation.
#
# For an n-ary forward function `f`, the reverse function on argument `k`
# returns an enclosure of
#
#     { y_k ∈ x_k : ∃ y_i ∈ x_i (i ≠ k) with f(y_1, …, y_n) ∈ c }
#
# where `c` is an enclosure of admissible values for `f`. The functions
# `sqrRev`, `absRev`, `pownRev`, `sinRev`, `cosRev`, `tanRev`, `coshRev` and
# `mulRev` of Section 10.5.4 of the IEEE Standard 1788-2015 are provided
# under the names `sqr_rev`, `abs_rev`, …, `mul_rev`. A few additional
# reverses commonly used in interval constraint propagation are also
# included: `add_rev`, `sub_rev1`/`sub_rev2`, `div_rev1`/`div_rev2`. The
# algorithm formulations follow F. Goualard's work on interval constraint
# propagation.
#
# Each reverse comes in two forms:
#   - `f_rev(c, …)`       — equivalent to `x = entireinterval()`
#   - `f_rev(c, …, x)`    — the result is intersected with `x`
#
# Per Section 11.7.1 of the standard, the decoration of an `Interval`
# result is `trv` whenever no input is NaI.

# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------

# Bridge a `BareInterval` reverse implementation to the decorated `Interval`
# API: propagate NaI, strip decorations to call `bare_impl`, then re-attach
# the `trv` decoration mandated by §11.7.1.
function _rev_dispatch(bare_impl, intervals::Tuple, extras::Tuple, dec)
    any(isnai, intervals) && return nai(promote_type(map(numtype, intervals)...))
    r = bare_impl(map(bareinterval, intervals)..., extras...)
    guaranteed = mapreduce(isguaranteed, &, intervals)
    return _set_decoration(_unsafe_interval(r, decoration(r), guaranteed), dec)
end

# Largest `|k|` for which `T(k)` and `T(2k)` are exactly representable.
# Beyond this scale the period of sin/cos/tan is unresolvable in `T` and the
# trigonometric reverses fall back to returning `x` unchanged.
_safe_period_index(::Type{T}) where {T<:AbstractFloat} = T(2)^(precision(T) - 4)
_safe_period_index(::Type{T}) where {T<:Rational} = T(typemax(Int) >> 4)

# For a periodic forward function with period `period_int`, return the range
# `k_min:k_max` of integer period indices to scan so that every period whose
# canonical window `[period_lo*k - lo_offset, period_hi*k + hi_offset]`
# intersects `x` is covered. Returns `nothing` when `x` is unbounded on both
# sides, the indices would overflow `T`, or the range exceeds 1024 periods
# (in which case the caller should fall back to returning `x`).
#
# `a_ok`/`b_ok` flag whether `inf(x)`/`sup(x)` lies inside the safe range; an
# `_ok = false` side means the iteration only constrains the *other* side
# and the unbounded side must be patched back to `±∞` afterwards.
function _trig_period_range(x::BareInterval{T}, lo_offset::T, hi_offset::T,
                            period_int::BareInterval{T}) where {T<:AbstractFloat}
    a, b = bounds(x)
    a_finite = isfinite(a)
    b_finite = isfinite(b)
    !a_finite & !b_finite && return nothing

    cap = _safe_period_index(T)
    a_ok = a_finite && abs(a) ≤ cap
    b_ok = b_finite && abs(b) ≤ cap
    !a_ok & !b_ok && return nothing

    a_ref = a_ok ? a : b
    b_ref = b_ok ? b : a
    period_lo = inf(period_int)
    k_min = floor(Int, (a_ref - hi_offset) / period_lo) - 1
    k_max = ceil(Int,  (b_ref + lo_offset) / period_lo) + 1
    (k_max - k_min > 1024) && return nothing
    return (k_min, k_max, a_ok, b_ok)
end

# After an iteration that only covered the bounded side(s) of `x`, restore
# `±∞` on whichever side is actually unbounded.
function _extend_unbounded(r::BareInterval{T}, a_ok::Bool, b_ok::Bool) where {T<:NumTypes}
    isempty_interval(r) && return r
    (a_ok & b_ok) && return r
    lo = a_ok ? inf(r) : typemin(T)
    hi = b_ok ? sup(r) : typemax(T)
    return _unsafe_bareinterval(T, lo, hi)
end

# Symmetric ±-fold of a non-negative interval against `x`, used by the
# even-parity reverses `sqr_rev`, `abs_rev`, `pown_rev` (even `n`) and
# `cosh_rev`. `magnitude ⊆ [0, ∞)` describes `|y|`; the preimage is
# `±magnitude ∩ x`.
function _pm_fold(magnitude::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(magnitude) && return magnitude
    negative = _unsafe_bareinterval(T, -sup(magnitude), -inf(magnitude))
    return hull(intersect_interval(negative, x), intersect_interval(magnitude, x))
end

# ------------------------------------------------------------------
# `sqr_rev` — Section 10.5.4 (`sqrRev`)
# ------------------------------------------------------------------

"""
    sqr_rev(c)
    sqr_rev(c, x)

Reverse function for `pown(·, 2)`. Returns an enclosure of
``\\{y ∈ x : y^2 ∈ c\\}``; the single-argument form takes `x = entireinterval()`.

Implements the `sqrRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function sqr_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    nonneg = _unsafe_bareinterval(T, zero(T), typemax(T))
    c_clipped = intersect_interval(c, nonneg)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return _pm_fold(sqrt(c_clipped), x)
end
sqr_rev(c::BareInterval, x::BareInterval) = sqr_rev(promote(c, x)...)

sqr_rev(c::BareInterval{T}) where {T<:NumTypes} = sqr_rev(c, entireinterval(BareInterval{T}))

sqr_rev(c::Interval; dec = :default) = _rev_dispatch(sqr_rev, (c,), (), dec)
sqr_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(sqr_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `abs_rev` — Section 10.5.4 (`absRev`)
# ------------------------------------------------------------------

"""
    abs_rev(c)
    abs_rev(c, x)

Reverse function for `abs`. Returns an enclosure of
``\\{y ∈ x : |y| ∈ c\\}``; the single-argument form takes `x = entireinterval()`.

Implements the `absRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function abs_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    nonneg = _unsafe_bareinterval(T, zero(T), typemax(T))
    c_clipped = intersect_interval(c, nonneg)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return _pm_fold(c_clipped, x)
end
abs_rev(c::BareInterval, x::BareInterval) = abs_rev(promote(c, x)...)

abs_rev(c::BareInterval{T}) where {T<:NumTypes} = abs_rev(c, entireinterval(BareInterval{T}))

abs_rev(c::Interval; dec = :default) = _rev_dispatch(abs_rev, (c,), (), dec)
abs_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(abs_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `pown_rev` — Section 10.5.4 (`pownRev`)
# ------------------------------------------------------------------

"""
    pown_rev(c, n)
    pown_rev(c, x, n)

Reverse function for `pown(·, n)`. Returns an enclosure of
``\\{y ∈ x : y^n ∈ c\\}``; the two-argument form takes `x = entireinterval()`.

Implements the `pownRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function pown_rev(c::BareInterval{T}, x::BareInterval{T}, n::Integer) where {T<:NumTypes}
    isempty_interval(c) && return c
    isempty_interval(x) && return x

    if n == 0
        # `y^0 ≡ 1` by convention, so `y ∈ {y : 1 ∈ c}`.
        in_interval(one(T), c) && return x
        return emptyinterval(BareInterval{T})
    end

    magnitude = _pown_root_preimage(c, n)
    isempty_interval(magnitude) && return emptyinterval(BareInterval{T})

    # For odd `n`, `magnitude` already carries a sign and is the full
    # preimage. For even `n`, `magnitude ⊆ [0, ∞)` and the preimage is the
    # symmetric ±-fold.
    return iseven(n) ? _pm_fold(magnitude, x) : intersect_interval(magnitude, x)
end
pown_rev(c::BareInterval, x::BareInterval, n::Integer) = pown_rev(promote(c, x)..., n)

pown_rev(c::BareInterval{T}, n::Integer) where {T<:NumTypes} =
    pown_rev(c, entireinterval(BareInterval{T}), n)

pown_rev(c::Interval, n::Integer; dec = :default) =
    _rev_dispatch(pown_rev, (c,), (n,), dec)
pown_rev(c::Interval, x::Interval, n::Integer; dec = :default) =
    _rev_dispatch(pown_rev, (c, x), (n,), dec)

# Enclosure of the n-th-root preimage of `c`. For positive `n` this is
# simply `rootn(c, n)`. For negative `n` two formulations are valid and
# have *complementary* precision regimes:
#
#   - root_then_inv = inv(rootn(c, |n|)) loses 1 ulp through compounded
#     outward rounding when `c` is bounded away from zero.
#   - inv_then_root = rootn(inv(c), |n|) clamps to `[floatmax, ∞)` when `c`
#     straddles zero with subnormal endpoints, losing many digits.
#
# Their intersection is therefore at least as tight as either alone.
function _pown_root_preimage(c::BareInterval{T}, n::Integer) where {T<:NumTypes}
    abs_n = abs(n)
    n > 0 && return rootn(c, abs_n)

    root_then_inv = rootn(c, abs_n)
    isempty_interval(root_then_inv) || (root_then_inv = inv(root_then_inv))
    inv_then_root = inv(c)
    isempty_interval(inv_then_root) || (inv_then_root = rootn(inv_then_root, abs_n))

    isempty_interval(root_then_inv) && return inv_then_root
    isempty_interval(inv_then_root) && return root_then_inv
    return intersect_interval(root_then_inv, inv_then_root)
end

# ------------------------------------------------------------------
# `sin_rev`, `cos_rev`, `tan_rev` — Section 10.5.4
# ------------------------------------------------------------------

# In each period of sin/cos/tan we list the increasing/decreasing branches
# (parametrised by `asin(c)`, `acos(c)`, `atan(c)`), shift each by an integer
# multiple of the period, intersect with `x`, and accumulate the hull. For
# huge `|x|` or unbounded `x`, the iteration is skipped and the result is
# patched up to `x` (sin/cos/tan_rev's hull tends to `x` once many periods
# fit inside `x`, so this is a tight fallback in that regime).

"""
    sin_rev(c)
    sin_rev(c, x)

Reverse function for `sin`. Returns an enclosure of
``\\{y ∈ x : \\sin(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.

Implements the `sinRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function sin_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    sin_range = _unsafe_bareinterval(T, -one(T), one(T))
    c_clipped = intersect_interval(c, sin_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})

    π_int = bareinterval(T, π)
    twoπ = bareinterval(T, 2) * π_int
    half_π_hi = sup(π_int) / convert(T, 2)
    # Period `k` covers the asymmetric window `[2πk - π/2, 2πk + 3π/2]`.
    range = _trig_period_range(x, half_π_hi, 3*half_π_hi, twoπ)
    range === nothing && return x
    k_min, k_max, a_ok, b_ok = range

    asin_c = asin(c_clipped)        # ⊆ [-π/2, π/2]
    result = emptyinterval(BareInterval{T})
    for k in k_min:k_max
        shift = bareinterval(T, 2k) * π_int
        increasing = asin_c + shift             # ⊆ [2πk - π/2, 2πk + π/2]
        decreasing = (π_int + shift) - asin_c   # ⊆ [2πk + π/2, 2πk + 3π/2]
        result = hull(result, intersect_interval(increasing, x))
        result = hull(result, intersect_interval(decreasing, x))
    end
    return _extend_unbounded(result, a_ok, b_ok)
end
sin_rev(c::BareInterval, x::BareInterval) = sin_rev(promote(c, x)...)
sin_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = sin_rev(float(c), float(x))

sin_rev(c::BareInterval{T}) where {T<:NumTypes} = sin_rev(c, entireinterval(BareInterval{T}))

sin_rev(c::Interval; dec = :default) = _rev_dispatch(sin_rev, (c,), (), dec)
sin_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(sin_rev, (c, x), (), dec)

"""
    cos_rev(c)
    cos_rev(c, x)

Reverse function for `cos`. Returns an enclosure of
``\\{y ∈ x : \\cos(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.

Implements the `cosRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function cos_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    cos_range = _unsafe_bareinterval(T, -one(T), one(T))
    c_clipped = intersect_interval(c, cos_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})

    π_int = bareinterval(T, π)
    twoπ = bareinterval(T, 2) * π_int
    π_hi = sup(π_int)
    # Period `k` covers the symmetric window `[2πk - π, 2πk + π]`.
    range = _trig_period_range(x, π_hi, π_hi, twoπ)
    range === nothing && return x
    k_min, k_max, a_ok, b_ok = range

    acos_c = acos(c_clipped)        # ⊆ [0, π]
    result = emptyinterval(BareInterval{T})
    for k in k_min:k_max
        shift = bareinterval(T, 2k) * π_int
        decreasing = acos_c + shift             # ⊆ [2πk, 2πk + π]
        increasing = shift - acos_c             # ⊆ [2πk - π, 2πk]
        result = hull(result, intersect_interval(decreasing, x))
        result = hull(result, intersect_interval(increasing, x))
    end
    return _extend_unbounded(result, a_ok, b_ok)
end
cos_rev(c::BareInterval, x::BareInterval) = cos_rev(promote(c, x)...)
cos_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = cos_rev(float(c), float(x))

cos_rev(c::BareInterval{T}) where {T<:NumTypes} = cos_rev(c, entireinterval(BareInterval{T}))

cos_rev(c::Interval; dec = :default) = _rev_dispatch(cos_rev, (c,), (), dec)
cos_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(cos_rev, (c, x), (), dec)

"""
    tan_rev(c)
    tan_rev(c, x)

Reverse function for `tan`. Returns an enclosure of
``\\{y ∈ x : \\tan(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.

Implements the `tanRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function tan_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x

    π_int = bareinterval(T, π)
    half_π_hi = sup(π_int) / convert(T, 2)
    # Period `k` covers the symmetric window `[πk - π/2, πk + π/2]`.
    range = _trig_period_range(x, half_π_hi, half_π_hi, π_int)
    range === nothing && return x
    k_min, k_max, a_ok, b_ok = range

    atan_c = atan(c)                # ⊆ (-π/2, π/2)
    result = emptyinterval(BareInterval{T})
    for k in k_min:k_max
        shift = bareinterval(T, k) * π_int
        result = hull(result, intersect_interval(atan_c + shift, x))
    end
    return _extend_unbounded(result, a_ok, b_ok)
end
tan_rev(c::BareInterval, x::BareInterval) = tan_rev(promote(c, x)...)
tan_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = tan_rev(float(c), float(x))

tan_rev(c::BareInterval{T}) where {T<:NumTypes} = tan_rev(c, entireinterval(BareInterval{T}))

tan_rev(c::Interval; dec = :default) = _rev_dispatch(tan_rev, (c,), (), dec)
tan_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(tan_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `cosh_rev` — Section 10.5.4 (`coshRev`)
# ------------------------------------------------------------------

"""
    cosh_rev(c)
    cosh_rev(c, x)

Reverse function for `cosh`. Returns an enclosure of
``\\{y ∈ x : \\cosh(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.

Implements the `coshRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function cosh_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    cosh_range = _unsafe_bareinterval(T, one(T), typemax(T))
    c_clipped = intersect_interval(c, cosh_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return _pm_fold(acosh(c_clipped), x)
end
cosh_rev(c::BareInterval, x::BareInterval) = cosh_rev(promote(c, x)...)
cosh_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = cosh_rev(float(c), float(x))

cosh_rev(c::BareInterval{T}) where {T<:NumTypes} = cosh_rev(c, entireinterval(BareInterval{T}))

cosh_rev(c::Interval; dec = :default) = _rev_dispatch(cosh_rev, (c,), (), dec)
cosh_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(cosh_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `mul_rev` — Section 10.5.4 (`mulRev`)
# ------------------------------------------------------------------

"""
    mul_rev(b, c)
    mul_rev(b, c, x)

Reverse function for multiplication. Returns an enclosure of
``\\{y ∈ x : ∃ b' ∈ b,\\ b' \\cdot y ∈ c\\}``; the two-argument form takes
`x = entireinterval()`.

Uses the IEEE Standard 1788-2015 two-output extended division (`extended_div`)
to handle the case ``0 \\in b``, then takes the hull to deliver a single
interval.

Implements the `mulRev` function of the IEEE Standard 1788-2015 (§10.5.4).
"""
function mul_rev(b::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(b) && return b
    isempty_interval(c) && return c
    r1, r2 = extended_div(c, b)
    return hull(r1, r2)
end
mul_rev(b::BareInterval, c::BareInterval) = mul_rev(promote(b, c)...)

mul_rev(b::BareInterval{T}, c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes} =
    intersect_interval(mul_rev(b, c), x)
mul_rev(b::BareInterval, c::BareInterval, x::BareInterval) = mul_rev(promote(b, c, x)...)

mul_rev(b::Interval, c::Interval; dec = :default) =
    _rev_dispatch(mul_rev, (b, c), (), dec)
mul_rev(b::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(mul_rev, (b, c, x), (), dec)

# ------------------------------------------------------------------
# Monotonic-inverse reverses
# ------------------------------------------------------------------
#
# For each forward `f` whose continuous inverse `f_inv` is monotonic on its
# full domain, the reverse is simply
#
#     f_rev(c, x) = f_inv(c) ∩ x
#
# Some `f_inv` already restrict their input to `f`'s range (e.g. `log` clips
# its input to `[0, ∞)`, `atanh` to `[-1, 1]`); in those cases no extra
# clipping is needed. The remaining cases need to clip `c` to `f`'s range
# before applying `f_inv`, otherwise `f_inv(c)` may include spurious values
# that `f` could not have produced.
#
# The functions below are not in the IEEE Standard 1788-2015 but are
# standard in the interval constraint propagation literature.

# `f_inv` already restricts its input — no extra clipping needed.
for (rev_name, f_inv) in (
    (:cbrt_rev,   :(c -> pown(c, 3))),
    (:exp_rev,    :log),
    (:exp2_rev,   :log2),
    (:exp10_rev,  :log10),
    (:expm1_rev,  :log1p),
    (:log_rev,    :exp),
    (:log2_rev,   :exp2),
    (:log10_rev,  :exp10),
    (:log1p_rev,  :expm1),
    (:sinh_rev,   :asinh),
    (:tanh_rev,   :atanh),
    (:asinh_rev,  :sinh),
    (:atanh_rev,  :tanh),
)
    @eval begin
        $rev_name(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes} =
            intersect_interval($f_inv(c), x)
        $rev_name(c::BareInterval, x::BareInterval) = $rev_name(promote(c, x)...)
        $rev_name(c::BareInterval{T}) where {T<:NumTypes} =
            $rev_name(c, entireinterval(BareInterval{T}))
        $rev_name(c::Interval; dec = :default) =
            _rev_dispatch($rev_name, (c,), (), dec)
        $rev_name(c::Interval, x::Interval; dec = :default) =
            _rev_dispatch($rev_name, (c, x), (), dec)
    end
end

"""
    sqrt_rev(c)
    sqrt_rev(c, x)

Reverse function for `sqrt`. Returns an enclosure of
``\\{y ∈ x : \\sqrt{y} ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.
"""
function sqrt_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    sqrt_range = _unsafe_bareinterval(T, zero(T), typemax(T))
    c_clipped = intersect_interval(c, sqrt_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return intersect_interval(pown(c_clipped, 2), x)
end
sqrt_rev(c::BareInterval, x::BareInterval) = sqrt_rev(promote(c, x)...)
sqrt_rev(c::BareInterval{T}) where {T<:NumTypes} = sqrt_rev(c, entireinterval(BareInterval{T}))
sqrt_rev(c::Interval; dec = :default) = _rev_dispatch(sqrt_rev, (c,), (), dec)
sqrt_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(sqrt_rev, (c, x), (), dec)

"""
    acosh_rev(c)
    acosh_rev(c, x)

Reverse function for `acosh`. Returns an enclosure of
``\\{y ∈ x : \\mathrm{acosh}(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`. The constraint `c` is first intersected with
`acosh`'s range `[0, ∞)` to avoid the spurious enclosure that `cosh(c)`
would produce on the negative half (cosh is even).
"""
function acosh_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    acosh_range = _unsafe_bareinterval(T, zero(T), typemax(T))
    c_clipped = intersect_interval(c, acosh_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return intersect_interval(cosh(c_clipped), x)
end
acosh_rev(c::BareInterval, x::BareInterval) = acosh_rev(promote(c, x)...)
acosh_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = acosh_rev(float(c), float(x))
acosh_rev(c::BareInterval{T}) where {T<:NumTypes} = acosh_rev(c, entireinterval(BareInterval{T}))
acosh_rev(c::Interval; dec = :default) = _rev_dispatch(acosh_rev, (c,), (), dec)
acosh_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(acosh_rev, (c, x), (), dec)

# `asin_rev`, `acos_rev`, `atan_rev` need to clip `c` to the range of the
# corresponding forward function before applying the (locally monotonic)
# inverse: outside that range, `sin`/`cos`/`tan` of `c` would compute
# values from a different period and over-report the preimage.

"""
    asin_rev(c)
    asin_rev(c, x)

Reverse function for `asin`. Returns an enclosure of
``\\{y ∈ x : \\mathrm{asin}(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.
"""
function asin_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    half_π = bareinterval(T, π) / bareinterval(T, 2)
    asin_range = _unsafe_bareinterval(T, -sup(half_π), sup(half_π))
    c_clipped = intersect_interval(c, asin_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return intersect_interval(sin(c_clipped), x)
end
asin_rev(c::BareInterval, x::BareInterval) = asin_rev(promote(c, x)...)
asin_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = asin_rev(float(c), float(x))
asin_rev(c::BareInterval{T}) where {T<:NumTypes} = asin_rev(c, entireinterval(BareInterval{T}))
asin_rev(c::Interval; dec = :default) = _rev_dispatch(asin_rev, (c,), (), dec)
asin_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(asin_rev, (c, x), (), dec)

"""
    acos_rev(c)
    acos_rev(c, x)

Reverse function for `acos`. Returns an enclosure of
``\\{y ∈ x : \\mathrm{acos}(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.
"""
function acos_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    π_int = bareinterval(T, π)
    acos_range = _unsafe_bareinterval(T, zero(T), sup(π_int))
    c_clipped = intersect_interval(c, acos_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return intersect_interval(cos(c_clipped), x)
end
acos_rev(c::BareInterval, x::BareInterval) = acos_rev(promote(c, x)...)
acos_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = acos_rev(float(c), float(x))
acos_rev(c::BareInterval{T}) where {T<:NumTypes} = acos_rev(c, entireinterval(BareInterval{T}))
acos_rev(c::Interval; dec = :default) = _rev_dispatch(acos_rev, (c,), (), dec)
acos_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(acos_rev, (c, x), (), dec)

"""
    atan_rev(c)
    atan_rev(c, x)

Reverse function for `atan`. Returns an enclosure of
``\\{y ∈ x : \\mathrm{atan}(y) ∈ c\\}``; the single-argument form takes
`x = entireinterval()`.
"""
function atan_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:AbstractFloat}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    half_π = bareinterval(T, π) / bareinterval(T, 2)
    atan_range = _unsafe_bareinterval(T, -sup(half_π), sup(half_π))
    c_clipped = intersect_interval(c, atan_range)
    isempty_interval(c_clipped) && return emptyinterval(BareInterval{T})
    return intersect_interval(tan(c_clipped), x)
end
atan_rev(c::BareInterval, x::BareInterval) = atan_rev(promote(c, x)...)
atan_rev(c::BareInterval{<:Rational}, x::BareInterval{<:Rational}) = atan_rev(float(c), float(x))
atan_rev(c::BareInterval{T}) where {T<:NumTypes} = atan_rev(c, entireinterval(BareInterval{T}))
atan_rev(c::Interval; dec = :default) = _rev_dispatch(atan_rev, (c,), (), dec)
atan_rev(c::Interval, x::Interval; dec = :default) = _rev_dispatch(atan_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# Additive and divisive reverses — not in IEEE 1788 but standard in
# constraint propagation (cf. Goualard, "Interval analysis for constraint
# solving").
# ------------------------------------------------------------------

"""
    add_rev(b, c)
    add_rev(b, c, x)

Reverse function for `+`. Returns an enclosure of
``\\{y ∈ x : ∃ b' ∈ b,\\ y + b' ∈ c\\} = (c - b) ∩ x``.
"""
add_rev(b::BareInterval, c::BareInterval) = c - b
add_rev(b::BareInterval, c::BareInterval, x::BareInterval) =
    intersect_interval(add_rev(b, c), x)

add_rev(b::Interval, c::Interval; dec = :default) =
    _rev_dispatch(add_rev, (b, c), (), dec)
add_rev(b::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(add_rev, (b, c, x), (), dec)

"""
    sub_rev1(b, c)
    sub_rev1(b, c, x)

Reverse function for `-`, recovering the minuend. Returns an enclosure of
``\\{y ∈ x : ∃ b' ∈ b,\\ y - b' ∈ c\\} = (c + b) ∩ x``.
"""
sub_rev1(b::BareInterval, c::BareInterval) = c + b
sub_rev1(b::BareInterval, c::BareInterval, x::BareInterval) =
    intersect_interval(sub_rev1(b, c), x)

sub_rev1(b::Interval, c::Interval; dec = :default) =
    _rev_dispatch(sub_rev1, (b, c), (), dec)
sub_rev1(b::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(sub_rev1, (b, c, x), (), dec)

"""
    sub_rev2(a, c)
    sub_rev2(a, c, x)

Reverse function for `-`, recovering the subtrahend. Returns an enclosure of
``\\{y ∈ x : ∃ a' ∈ a,\\ a' - y ∈ c\\} = (a - c) ∩ x``.
"""
sub_rev2(a::BareInterval, c::BareInterval) = a - c
sub_rev2(a::BareInterval, c::BareInterval, x::BareInterval) =
    intersect_interval(sub_rev2(a, c), x)

sub_rev2(a::Interval, c::Interval; dec = :default) =
    _rev_dispatch(sub_rev2, (a, c), (), dec)
sub_rev2(a::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(sub_rev2, (a, c, x), (), dec)

"""
    div_rev1(b, c)
    div_rev1(b, c, x)

Reverse function for `/`, recovering the numerator. Returns an enclosure of
``\\{y ∈ x : ∃ b' ∈ b,\\ y / b' ∈ c\\} = (c \\cdot b) ∩ x``.
"""
div_rev1(b::BareInterval, c::BareInterval) = c * b
div_rev1(b::BareInterval, c::BareInterval, x::BareInterval) =
    intersect_interval(div_rev1(b, c), x)

div_rev1(b::Interval, c::Interval; dec = :default) =
    _rev_dispatch(div_rev1, (b, c), (), dec)
div_rev1(b::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(div_rev1, (b, c, x), (), dec)

"""
    div_rev2(a, c)
    div_rev2(a, c, x)

Reverse function for `/`, recovering the denominator. Returns an enclosure of
``\\{y ∈ x : ∃ a' ∈ a,\\ a' / y ∈ c\\}``. Uses the two-output extended
division to handle ``0 \\in c``.
"""
function div_rev2(a::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(a) && return a
    isempty_interval(c) && return c
    r1, r2 = extended_div(a, c)
    return hull(r1, r2)
end
div_rev2(a::BareInterval, c::BareInterval) = div_rev2(promote(a, c)...)

div_rev2(a::BareInterval, c::BareInterval, x::BareInterval) =
    intersect_interval(div_rev2(a, c), x)

div_rev2(a::Interval, c::Interval; dec = :default) =
    _rev_dispatch(div_rev2, (a, c), (), dec)
div_rev2(a::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(div_rev2, (a, c, x), (), dec)

# ------------------------------------------------------------------
# `mul_rev_to_pair` — Section 10.5.5
# ------------------------------------------------------------------

"""
    mul_rev_to_pair(b, c)

Two-output reverse multiplication. Returns the pair `(x₁, x₂)` whose
union is an enclosure of ``\\{y : ∃ b' ∈ b,\\ b' \\cdot y ∈ c\\}``.

When `b` does not straddle zero this is the ordinary division `c / b`,
returned as `(c / b, ∅)`. When `0 ∈ b` and `0 ∉ c` the preimage splits
into two disjoint half-rays, both of which are returned.

Implements `mulRevToPair` of the IEEE Standard 1788-2015 (§10.5.5).
"""
mul_rev_to_pair(b::BareInterval, c::BareInterval) = extended_div(c, b)

function mul_rev_to_pair(b::Interval, c::Interval)
    if isnai(b) | isnai(c)
        T = promote_type(numtype(b), numtype(c))
        nai_iv = nai(Interval{T})
        return (nai_iv, nai_iv)
    end
    bb, bc = bareinterval(b), bareinterval(c)
    r1, r2 = extended_div(bc, bb)
    g = isguaranteed(b) & isguaranteed(c)
    # §11.7.1: when this is a true split (`0 ∈ b`) both outputs are `trv`;
    # otherwise the call reduces to a standard division and `r1` propagates
    # the usual `min(input_decorations, range_dec)`.
    if isempty_interval(bb) | isempty_interval(bc) | in_interval(0, bb)
        d1 = trv
    else
        d1 = min(decoration(b), decoration(c), decoration(r1))
    end
    return (_unsafe_interval(r1, d1, g), _unsafe_interval(r2, trv, g))
end

# ------------------------------------------------------------------
# `inv_rev`
# ------------------------------------------------------------------

"""
    inv_rev(c)
    inv_rev(c, x)

Reverse function for `inv`. Returns an enclosure of
``\\{y ∈ x : 1/y ∈ c\\} = \\mathrm{inv}(c) ∩ x``. Since `inv` is an
involution, `inv_rev(c)` is just `inv(c)` (intersected with `x`).
"""
inv_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes} =
    intersect_interval(inv(c), x)
inv_rev(c::BareInterval, x::BareInterval) = inv_rev(promote(c, x)...)
inv_rev(c::BareInterval{T}) where {T<:NumTypes} =
    inv_rev(c, entireinterval(BareInterval{T}))

inv_rev(c::Interval; dec = :default) = _rev_dispatch(inv_rev, (c,), (), dec)
inv_rev(c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(inv_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `sign_rev`
# ------------------------------------------------------------------

"""
    sign_rev(c)
    sign_rev(c, x)

Reverse function for `sign`. Since `sign` maps `ℝ` into `{-1, 0, 1}`, the
preimage of `c` is determined by which of those values lie in `c`:

- `1 ∈ c`  contributes `(0, ∞)` (enclosed as `[0, ∞)`);
- `0 ∈ c`  contributes `{0}`;
- `-1 ∈ c` contributes `(-∞, 0)` (enclosed as `(-∞, 0]`).

Returns the intersection of the resulting set with `x`; the single-argument
form takes `x = entireinterval()`.
"""
function sign_rev(c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes}
    isempty_interval(c) && return c
    isempty_interval(x) && return x
    has_neg = in_interval(-1, c)
    has_zer = in_interval( 0, c)
    has_pos = in_interval( 1, c)
    (has_neg | has_zer | has_pos) || return emptyinterval(BareInterval{T})
    lo = has_neg ? typemin(T) : zero(T)
    hi = has_pos ? typemax(T) : zero(T)
    return intersect_interval(_unsafe_bareinterval(T, lo, hi), x)
end
sign_rev(c::BareInterval, x::BareInterval) = sign_rev(promote(c, x)...)
sign_rev(c::BareInterval{T}) where {T<:NumTypes} =
    sign_rev(c, entireinterval(BareInterval{T}))

sign_rev(c::Interval; dec = :default) = _rev_dispatch(sign_rev, (c,), (), dec)
sign_rev(c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(sign_rev, (c, x), (), dec)

# ------------------------------------------------------------------
# `pow_rev1`, `pow_rev2`
# ------------------------------------------------------------------

"""
    pow_rev1(b, c)
    pow_rev1(b, c, x)

Reverse for the base of `^`: returns an enclosure of
``\\{y ∈ x : ∃ b' ∈ b,\\ y^{b'} ∈ c\\}``, computed as `c^(1/b) ∩ x`.
Use `pown_rev` instead when the exponent is integer.
"""
pow_rev1(b::BareInterval{T}, c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes} =
    intersect_interval(c^inv(b), x)
pow_rev1(b::BareInterval, c::BareInterval, x::BareInterval) =
    pow_rev1(promote(b, c, x)...)
pow_rev1(b::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes} =
    pow_rev1(b, c, entireinterval(BareInterval{T}))

pow_rev1(b::Interval, c::Interval; dec = :default) =
    _rev_dispatch(pow_rev1, (b, c), (), dec)
pow_rev1(b::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(pow_rev1, (b, c, x), (), dec)

"""
    pow_rev2(a, c)
    pow_rev2(a, c, x)

Reverse for the exponent of `^`: returns an enclosure of
``\\{y ∈ x : ∃ a' ∈ a,\\ (a')^{y} ∈ c\\}``, computed as
`(log(c) / log(a)) ∩ x`. Requires `a` and `c` to lie in the positive
reals; outside that the enclosure may be loose or empty.
"""
pow_rev2(a::BareInterval{T}, c::BareInterval{T}, x::BareInterval{T}) where {T<:NumTypes} =
    intersect_interval(log(c) / log(a), x)
pow_rev2(a::BareInterval, c::BareInterval, x::BareInterval) =
    pow_rev2(promote(a, c, x)...)
pow_rev2(a::BareInterval{T}, c::BareInterval{T}) where {T<:NumTypes} =
    pow_rev2(a, c, entireinterval(BareInterval{T}))

pow_rev2(a::Interval, c::Interval; dec = :default) =
    _rev_dispatch(pow_rev2, (a, c), (), dec)
pow_rev2(a::Interval, c::Interval, x::Interval; dec = :default) =
    _rev_dispatch(pow_rev2, (a, c, x), (), dec)
