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
