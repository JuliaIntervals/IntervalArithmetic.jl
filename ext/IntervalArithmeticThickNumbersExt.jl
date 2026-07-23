module IntervalArithmeticThickNumbersExt

import ThickNumbers as TN
import IntervalArithmetic as IA

# `IA.Interval <: Real`, so it cannot subtype `TN.ThickNumber`; it opts into the
# ThickNumbers interface via the `isthick` trait instead.
TN.isthick(::Type{<:IA.Interval}) = true

# Required interface

TN.loval(x::IA.Interval) = IA.inf(x)
TN.hival(x::IA.Interval) = IA.sup(x)

TN.lohi(::Type{IA.Interval{T}}, lo, hi) where {T} = IA.interval(T, lo, hi)
TN.lohi(::Type{IA.Interval}, lo, hi) = IA.interval(lo, hi)

TN.basetype(::Type{<:IA.Interval}) = IA.Interval
TN.basetype(x::IA.Interval) = IA.Interval

TN.valuetype(::Type{IA.Interval{T}}) where {T} = T
TN.valuetype(x::IA.Interval{T}) where {T} = T

# Optional interface

TN.midrad(::Type{IA.Interval{T}}, m, r) where {T} = IA.interval(T, m, r; format = :midpoint)
TN.midrad(::Type{IA.Interval}, m, r) = IA.interval(m, r; format = :midpoint)

# `IA.emptyinterval` is used directly rather than the `ThickNumbers.emptyset`
# default (`lohi(TN, typemax(T), typemin(T))`), which would round-trip through
# `interval` and emit its "ill-formed interval" warning.
TN.emptyset(::Type{IA.Interval{T}}) where {T} = IA.emptyinterval(IA.Interval{T})
TN.emptyset(::Type{IA.Interval}) = IA.emptyinterval()
TN.emptyset(x::IA.Interval) = IA.emptyinterval(x)

TN.isempty_tn(x::IA.Interval) = IA.isempty_interval(x)

TN.mid(x::IA.Interval) = IA.mid(x)
TN.wid(x::IA.Interval) = IA.diam(x)
TN.rad(x::IA.Interval) = IA.radius(x)
TN.mag(x::IA.Interval) = IA.mag(x)
TN.mig(x::IA.Interval) = IA.mig(x)

TN.hull(a::IA.Interval, b::IA.Interval) = IA.hull(a, b)
TN.hull(a::IA.Interval, b::IA.Interval, c::IA.Interval...) = IA.hull(a, b, c...)

TN.isfinite_tn(x::IA.Interval) = IA.isbounded(x)
TN.isinf_tn(x::IA.Interval) = IA.isunbounded(x)
TN.isnan_tn(x::IA.Interval) = IA.isnai(x)

TN.isequal_tn(a::IA.Interval, b::IA.Interval) = IA.isequal_interval(a, b)

TN.issubset_tn(a::IA.Interval, b::IA.Interval) = IA.issubset_interval(a, b)
# `IA.isstrictsubset` is defined as `issubset_interval(x,y) & !isequal_interval(x,y)`,
# which is exactly ThickNumbers' loval/hival-based definition of a strict subset;
# it is unrelated to `IA.isinterior`, which is a topological (open-set) notion and
# uses `<` instead of `<=` at the endpoints (so, e.g., `interior([1,2],[1,3])` is
# false while `is_strict_subset_tn([1,2],[1,3])` is true).
TN.is_strict_subset_tn(a::IA.Interval, b::IA.Interval) = IA.isstrictsubset(a, b)
TN.issupset_tn(a::IA.Interval, b::IA.Interval) = IA.issubset_interval(b, a)
TN.is_strict_supset_tn(a::IA.Interval, b::IA.Interval) = IA.isstrictsubset(b, a)

# `ThickNumbers` derives `Base.in(x::Real, a::ThickNumber)` from `loval`/`hival` for every
# `ThickNumber` subtype, but a type that opts in via `isthick` (like `IA.Interval`) does not
# inherit that dispatch and must define it directly. Unlike `IA.Interval == IA.Interval` or
# `in_interval(::Interval, ::Interval)`, a real point's membership in an interval is always
# decidable, and `IA.in_interval` already computes exactly that (`Base.in(::Interval,
# ::Interval)` is the one IA purposely leaves unsupported, for `issubset_interval` instead).
Base.in(x::Real, a::IA.Interval) = IA.in_interval(x, a)

# `IA.strictprecedes` treats an empty interval as preceding (and being preceded
# by) everything, and NaI as never satisfying either; `isless_tn` has neither
# special case, so it is implemented directly from `inf`/`sup` rather than
# reused from `strictprecedes`.
TN.isless_tn(a::IA.Interval, b::IA.Interval) = isless(IA.sup(a), IA.inf(b))

# `≺`, `≻`, `⪯` and `⪰` are functions distinct from `isless_tn` (not aliases of
# it), each requiring its own method.
TN.:(≺)(a::IA.Interval, b::IA.Interval) = IA.sup(a) < IA.inf(b)
TN.:(≻)(a::IA.Interval, b::IA.Interval) = IA.inf(a) > IA.sup(b)
TN.:(⪯)(a::IA.Interval, b::IA.Interval) = IA.sup(a) <= IA.inf(b)
TN.:(⪰)(a::IA.Interval, b::IA.Interval) = IA.inf(a) >= IA.sup(b)

TN.iseq_tn(a::IA.Interval, b::IA.Interval) =
    (IA.isempty_interval(a) & IA.isempty_interval(b)) | ((IA.inf(a) == IA.inf(b)) & (IA.sup(a) == IA.sup(b)))

function TN.isapprox_tn(
    x::IA.Interval, y::IA.Interval;
    atol::Real = 0,
    rtol::Real = Base.rtoldefault(IA.numtype(x), IA.numtype(y), atol),
    nans::Bool = false,
)
    (IA.isempty_interval(x) & IA.isempty_interval(y)) && return true
    return TN.isequal_tn(x, y) ||
        (IA.isbounded(x) && IA.isbounded(y) &&
            max(abs(IA.sup(x) - IA.sup(y)), abs(IA.inf(x) - IA.inf(y))) <= max(atol, rtol * max(IA.mag(x), IA.mag(y)))) ||
        (nans && IA.isnai(x) && IA.isnai(y))
end

end # module
