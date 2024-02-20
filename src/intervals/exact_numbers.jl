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
        if x isa Real
            e = ExactNumber(x)
            s = string(e)
            if s != string(x)
                @warn "$(typeof(x)) displayed as $x is equal to $s"
            end
            return e
        end

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

Base.string(x::ExactNumber{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.number, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactNumber) = string(x.number)

Base.show(io::IO, ::MIME"text/plain", x::ExactNumber{T}) where {T<:AbstractFloat} =
    print(io, "ExactNumber{$T}($(string(x)))")