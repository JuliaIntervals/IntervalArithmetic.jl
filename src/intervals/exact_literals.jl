"""
    ExactReal{T<:Real} <: Real

Real numbers with the assurance that they precisely correspond to the number
described by their binary form. The purpose is to guarantee that a non interval
number is exact, so that `ExactReal` can be used with `Interval` without
producing the "NG" flag.

!!! danger
    By using `ExactReal`, users acknowledge the responsibility of ensuring that
    the number they input corresponds to their intended value.
    For example, `ExactReal(0.1)` implies that the user knows that ``0.1`` can
    not be represented exactly as a binary number, and that they are using a
    slightly different number than ``0.1``.
    To help identify the binary number, `ExactReal` is displayed without any
    rounding.

    ```julia
    julia> ExactReal(0.1)
    ExactReal{Float64}(0.1000000000000000055511151231257827021181583404541015625)
    ```

    In case of doubt, [`has_exact_display`](@ref) can be use to check if the
    string representation of a `Real` is equal to its binary value.

# Examples

```jldoctest
julia> 0.5 * interval(1)
[0.5, 0.5]_com_NG

julia> ExactReal(0.5) * interval(1)
[0.5, 0.5]_com

julia> [1, interval(2)]
2-element Vector{Interval{Float64}}:
 [1.0, 1.0]_com_NG
 [2.0, 2.0]_com

julia> [ExactReal(1), interval(2)]
2-element Vector{Interval{Float64}}:
 [1.0, 1.0]_com
 [2.0, 2.0]_com
```

See also: [`@exact`](@ref).
"""
struct ExactReal{T<:Real} <: Real
    value :: T

    ExactReal(value::T) where {T<:Real} = new{T}(value)
end

interval(::Type{T}, x::ExactReal{T}) where {T<:NumTypes} = interval(T, x.value)
interval(::Type{T}, x::ExactReal{<:Integer}) where {T<:NumTypes} = interval(T, x.value)
interval(x::ExactReal) = interval(x.value)

Base.convert(::Type{ExactReal{T}}, x::ExactReal{T}) where {T<:Real} = x

# promotion to Interval

Base.promote_rule(::Type{Interval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}

Base.promote_rule(::Type{ExactReal{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

Base.convert(::Type{Interval{T}}, x::ExactReal) where {T<:NumTypes} =
    interval(T, x.value)

# promotion to Real

Base.promote_rule(::Type{T}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)

Base.promote_rule(::Type{ExactReal{T}}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    throw(ArgumentError("promotion between `ExactReal` is not allowed"))

Base.convert(::Type{T}, x::ExactReal) where {T<:Real} =
    convert(T, x.value)

# display

Base.string(x::ExactReal{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.value, 2000, false, false, false, UInt8('.'), true)

Base.string(x::ExactReal) = string(x.value)

Base.show(io::IO, ::MIME"text/plain", x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(string(x)))")

# this is always exact
Base.:(-)(x::ExactReal) = ExactReal(-x.value)
Base.:(*)(x::ExactReal, y::Bool) = ExactReal(x.value * y)
Base.:(*)(x::Bool, y::ExactReal) = ExactReal(x * y.value)

Base.complex(x::ExactReal{T}, y::ExactReal{T}) where {T} = Complex(x, y)  

function Base.complex(::ExactReal{T}, ::ExactReal{S}) where {T, S}
    throw(ArgumentError(
        "both the real and imaginary part of an exact complex " *
        "number must have the same type, since promotion " *
        "between ExactReal is not allowed"))
end

"""
    has_exact_display(x::Real)

Determine if the display of `x` is equal to the bitwise value of `x`. This is
famously not true for the float displayed as `0.1`.
"""
has_exact_display(x::Real) = string(x) == string(ExactReal(x))

"""
    @exact

Wrap every literal numbers of the expression in an `ExactReal`. This macro
allows defining generic functions, seamlessly accepting both `Number` and
`Interval` arguments, without producing the "NG" flag.

!!! danger
    By using `ExactReal`, users acknowledge the responsibility of ensuring that
    the number they input corresponds to their intended value.
    For example, `ExactReal(0.1)` implies that the user knows that ``0.1`` can
    not be represented exactly as a binary number, and that they are using a
    slightly different number than ``0.1``.
    To help identify the binary number, `ExactReal` is displayed without any
    rounding.

    ```julia
    julia> ExactReal(0.1)
    ExactReal{Float64}(0.1000000000000000055511151231257827021181583404541015625)
    ```

    In case of doubt, [`has_exact_display`](@ref) can be use to check if the
    string representation of a `Real` is equal to its binary value.

# Examples

```jldoctest
julia> f(x) = 1.2*x + 0.1
f (generic function with 1 method)

julia> f(interval(1, 2))
[1.29999, 2.50001]_com_NG

julia> @exact g(x) = 1.2*x + 0.1
g (generic function with 1 method)

julia> g(interval(1, 2))
[1.29999, 2.50001]_com

julia> g(1.4)
1.78
```

See also: [`ExactReal`](@ref).
"""
macro exact_input(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactReal(x)

        # unwrap literal powers to ensure that the expression uses Base.literal_pow
        if @capture(x, y_ ^ N_)
            if N isa ExactReal{<:Integer}
                return :($y ^ $N)
            end
        end

        # intercept the definition of complex for convenience
        if @capture(x, a_ + b_ * im)
            if a isa ExactReal && b isa ExactReal
                return :(complex($a, $b))
            end
        end

        return x
    end

    return esc(exact_expr)
end
