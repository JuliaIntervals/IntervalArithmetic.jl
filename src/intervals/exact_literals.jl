struct ExactReal{T <: Real} <: Real
    value::T
end

# Promotion to Interval
Base.promote_rule(::Type{Interval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactReal{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

Base.convert(::Type{Interval{T}}, x::ExactReal) where {T<:NumTypes} =
    interval(T, x)

# Promotion to Real
Base.promote_rule(::Type{T}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.convert(::Type{T}, x::ExactReal) where {T<:Real} =
    convert(T, x.value)

# Remove the fallback for Real number that go to the constructor T(x) and
# would allow to create ExactReal from other sources than literals.
Base.convert(::Type{<:ExactReal}, x::Real) =
    throw(ArgumentError("converting to ExactReal is not allowed"))

interval(::Type{T}, x::ExactReal{T}) where {T<:NumTypes} = interval(T, x.value)
interval(x::ExactReal) = interval(x.value)

Base.string(x::ExactReal{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.value, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactReal) = string(x.value)

Base.show(io::IO, ::MIME"text/plain", x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(string(x)))")

"""
    has_exact_display(x::Real)

Determine if the display of `x` is equal to the bitwise value of `x`.

This is famously not true for the float displayed as `0.1`, which is equal to
`0.1000000000000000055511151231257827021181583404541015625` since `0.1`
can not be represented exactly as a binary number.
"""
has_exact_display(x::Real) = string(x) == string(ExactReal(x))

macro exact_input(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactReal(x)

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