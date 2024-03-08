struct ExactReal{T <: Real} <: Real
    number::T
end

# Promotion to Interval
Base.promote_rule(::Type{Interval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactReal{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

function Base.convert(::Type{Interval{T}}, x::ExactReal) where {T<:NumTypes}
    y = interval(T, x)
    return _unsafe_interval(bareinterval(y), decoration(y), true)
end

# Promotion to Real
Base.promote_rule(::Type{T}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.convert(::Type{T}, x::ExactReal) where {T<:Real} =
    convert(T, x.number)

interval(::Type{T}, x::ExactReal) where {T<:NumTypes} = interval(T, x.number)
interval(x::ExactReal) = interval(x.number)

Base.string(x::ExactReal{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.number, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactReal) = string(x.number)

Base.show(io::IO, ::MIME"text/plain", x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(string(x)))")

for unary in Symbol.((inv, sqrt, sin, cos, tan, asin, acos, atan, exp, log, sinh, cosh, tanh, asinh, acosh, atanh))
    @eval (Base.$unary)(x::ExactReal) = ($unary)(interval(x))
end

for binary in Symbol.((+, -, *, /, ^))
    @eval (Base.$binary)(x::ExactReal, y::ExactReal) = ($binary)(interval(x), interval(y))
end

macro exact_literals(expr)
    exact_expr = postwalk(expr) do x
        if x isa Real
            e = ExactReal(x)
            s = string(e)
            if s != string(x)
                @warn "$(typeof(x)) displayed as $x is equal to $s"
            end
            return e
        end

        # Unwrap literal powers to be sure the expression uses Base.literal_pow
        if @capture(x, y_ ^ N_)
            if N isa ExactReal{<:Integer}
                return :($y ^ $N)
            end
        end

        return x
    end

    return esc(exact_expr)
end
