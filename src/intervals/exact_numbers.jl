struct ExactNumber{T} <: Real
    number::T
end

# Promotion to Interval
Base.promote_rule(::Type{Interval{T}}, ::Type{ExactNumber{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactNumber{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

function Base.convert(::Type{Interval{T}}, x::ExactNumber) where {T<:NumTypes}
    y = interval(T, x.number)
    return _unsafe_interval(bareinterval(y), decoration(y), true)
end

# Promotion to Real
Base.promote_rule(::Type{T}, ::Type{ExactNumber{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactNumber{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.convert(::Type{T}, x::ExactNumber) where {T<:Real} =
    convert(T, x.number)

macro exact(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactNumber(x)
        return x
    end
    return esc(exact_expr)
end