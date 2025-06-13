module IntervalArithmeticArblibExt

import IntervalArithmetic as IA
import Arblib

# Promotion rules

# These are needed for ambiguity reasons
Base.promote_rule(
    ::Type{IA.Interval{T}},
    ::Type{S},
) where {T<:IA.NumTypes,S<:Arblib.ArfOrRef} = IA.Interval{promote_type(T, S)}
Base.promote_rule(
    ::Type{T},
    ::Type{IA.Interval{S}},
) where {T<:Arblib.ArfOrRef,S<:IA.NumTypes} = IA.Interval{promote_type(T, S)}

Base.promote_rule(
    ::Type{IA.Interval{T}},
    ::Type{S},
) where {T<:IA.NumTypes,S<:Arblib.ArbOrRef} =
    throw(ArgumentError("promotion between Interval and Arb is purposely not supported"))
Base.promote_rule(
    ::Type{T},
    ::Type{IA.Interval{S}},
) where {T<:Arblib.ArbOrRef,S<:IA.NumTypes} =
    throw(ArgumentError("promotion between Interval and Arb is purposely not supported"))

# Construction of Arb from Interval
# Note that this automatically gives support for construction of Acb.

Arblib._precision(x::Union{IA.Interval,IA.BareInterval}) =
    Arblib._precision(IA.inf(x), IA.sup(x))

function Arblib.set!(
    res::Arblib.ArbLike,
    x::Union{IA.Interval,IA.BareInterval};
    prec::Integer = precision(res),
)
    if IA.isempty_interval(x)
        Arblib.indeterminate!(res)
    else
        Arblib.set!(res, (IA.inf(x), IA.sup(x)); prec)
    end
    return res
end

# Construction of Interval from Arb

# We essentially treat Arb as Interval{BigFloat} for the purposes of
# constructing Intervals. This means that we only have to change the
# behavior of _inf and _sup since these are called early on in the
# construction process to handle endpoints which are Intervals.

IA._inf(x::Arblib.ArbOrRef) = BigFloat(Arblib.lbound(x))
IA._sup(x::Arblib.ArbOrRef) = BigFloat(Arblib.ubound(x))

# Make promote_numtype for Arb behave like promotion with BigFloat
IA.promote_numtype(::Type{<:Arblib.ArbOrRef}, ::Type{<:Arblib.ArbOrRef}) = BigFloat
IA.promote_numtype(::Type{<:Arblib.ArbOrRef}, ::Type{S}) where {S} =
    IA.promote_numtype(BigFloat, S)
IA.promote_numtype(::Type{<:Arblib.ArbOrRef}, ::Type{S}) where {S<:IA.NumTypes} =
    IA.promote_numtype(BigFloat, S)
IA.promote_numtype(::Type{T}, ::Type{<:Arblib.ArbOrRef}) where {T} =
    IA.promote_numtype(T, BigFloat)
IA.promote_numtype(::Type{T}, ::Type{<:Arblib.ArbOrRef}) where {T<:IA.NumTypes} =
    IA.promote_numtype(T, BigFloat)

# Construction of Complex{Interval} from Acb
IA.numtype(::Type{<:Arblib.AcbOrRef}) = Arblib.Arb

# Handle Acb in the same way as Complex.
IA._interval_infsup(
    ::Type{T},
    a::Arblib.AcbOrRef,
    b::Arblib.AcbOrRef,
    d::IA.Decoration,
) where {T<:IA.NumTypes} = complex(
    IA._interval_infsup(T, real(a), real(b), d),
    IA._interval_infsup(T, imag(a), imag(b), d),
)
IA._interval_infsup(
    ::Type{T},
    a::Arblib.AcbOrRef,
    b,
    d::IA.Decoration,
) where {T<:IA.NumTypes} = complex(
    IA._interval_infsup(T, real(a), real(b), d),
    IA._interval_infsup(T, imag(a), imag(b), d),
)
IA._interval_infsup(
    ::Type{T},
    a,
    b::Arblib.AcbOrRef,
    d::IA.Decoration,
) where {T<:IA.NumTypes} = complex(
    IA._interval_infsup(T, real(a), real(b), d),
    IA._interval_infsup(T, imag(a), imag(b), d),
)

# Handle ambiguities
for S in [Union{IA.BareInterval,IA.Interval}, Complex]
    @eval IA._interval_infsup(
        ::Type{T},
        a::Arblib.AcbOrRef,
        b::$S,
        d::IA.Decoration,
    ) where {T<:IA.NumTypes} = complex(
        IA._interval_infsup(T, real(a), real(b), d),
        IA._interval_infsup(T, imag(a), imag(b), d),
    )
    @eval IA._interval_infsup(
        ::Type{T},
        a::$S,
        b::Arblib.AcbOrRef,
        d::IA.Decoration,
    ) where {T<:IA.NumTypes} = complex(
        IA._interval_infsup(T, real(a), real(b), d),
        IA._interval_infsup(T, imag(a), imag(b), d),
    )
end

# Make it so that implicit conversion from Arb to Interval doesn't set
# the NG flag.

Base.convert(::Type{IA.Interval{T}}, x::Arblib.ArbOrRef) where {T<:IA.NumTypes} =
    IA.interval(T, x)

function Base.convert(::Type{IA.Interval{T}}, x::Arblib.AcbOrRef) where {T<:IA.NumTypes}
    isreal(x) || return throw(DomainError(x, "imaginary part must be zero"))
    return convert(IA.Interval{T}, real(x))
end

Base.convert(::Type{Complex{IA.Interval{T}}}, x::Arblib.ArbOrRef) where {T<:IA.NumTypes} =
    complex(IA.interval(T, x))

# Handle ambiguities related to ExactReal

Arblib.Mag(x::IA.ExactReal) = convert(Arblib.Mag, x)
Arblib.Arf(x::IA.ExactReal) = convert(Arblib.Arf, x)
Arblib.Arb(x::IA.ExactReal) = convert(Arblib.Arb, x)

Base.promote_rule(::Type{T}, ::Type{IA.ExactReal{S}}) where {T<:Arblib.ArfOrRef,S<:Real} =
    promote_type(T, S)
Base.promote_rule(::Type{IA.ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Arblib.ArfOrRef} =
    promote_type(T, S)

Base.promote_rule(::Type{T}, ::Type{IA.ExactReal{S}}) where {T<:Arblib.ArbOrRef,S<:Real} =
    promote_type(T, S)
Base.promote_rule(::Type{IA.ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Arblib.ArbOrRef} =
    promote_type(T, S)

end
