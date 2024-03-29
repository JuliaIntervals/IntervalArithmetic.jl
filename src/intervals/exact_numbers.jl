struct ExactNumber{T} <: Real
    number::T
end

# Promotion to Interval
Base.promote_rule(::Type{Interval{T}}, ::Type{ExactNumber{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactNumber{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

Base.convert(::Type{Interval{T}}, x::ExactNumber) where {T<:NumTypes} =
    interval(T, x)

# Promotion to Real
Base.promote_rule(::Type{T}, ::Type{ExactNumber{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactNumber{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.convert(::Type{T}, x::ExactNumber) where {T<:Real} =
    convert(T, x.number)

interval(::Type{T}, x::ExactNumber{T}) where {T<:NumTypes} = interval(T, x.number)
interval(x::ExactNumber) = interval(x.number)

"""
    has_exact_display(x::Real)

Determine if the display of `x` is equal to the bitwise value of `x`.

This is famously not true for the float displayed as `0.1`, which is equal to
`0.1000000000000000055511151231257827021181583404541015625` since `0.1`
can not be represented exactly as a binary number.
"""
has_exact_display(x::Real) = string(x) == string(ExactNumber(x))

Base.string(x::ExactNumber{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.number, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactNumber) = string(x.number)

Base.show(io::IO, ::MIME"text/plain", x::ExactNumber{T}) where {T<:AbstractFloat} =
    print(io, "ExactNumber{$T}($(string(x)))")

macro exact_input(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactNumber(x)

        # Unwrap literal powers to be sure the expression uses Base.literal_pow
        if @capture(x, y_ ^ N_)
            if N isa ExactNumber{<:Integer}
                return :($y ^ $N)
            end
        end

        return x
    end

    return esc(exact_expr)
end