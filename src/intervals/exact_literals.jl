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
julia> setdisplay(:full);

julia> 0.5 * interval(1)
Interval{Float64}(0.5, 0.5, com, NG)

julia> ExactReal(0.5) * interval(1)
Interval{Float64}(0.5, 0.5, com)

julia> [1, interval(2)]
2-element Vector{Interval{Float64}}:
 Interval{Float64}(1.0, 1.0, com, NG)
 Interval{Float64}(2.0, 2.0, com)

julia> [ExactReal(1), interval(2)]
2-element Vector{Interval{Float64}}:
 Interval{Float64}(1.0, 1.0, com)
 Interval{Float64}(2.0, 2.0, com)
```

See also: [`@exact`](@ref).
"""
struct ExactReal{T<:Real} <: Real
    value :: T

    ExactReal{T}(value::T) where {T<:Real} = new{T}(value)
    ExactReal(value::T) where {T<:Real} = new{T}(value)
end

_value(x::ExactReal) = x.value # hook for interval constructor

# allow to index with ExactReal

Base.to_index(i::ExactReal{<:Integer}) = i.value

Base.zero(::Type{ExactReal{T}}) where {T<:Real} = ExactReal(zero(T))
Base.zero(::ExactReal{T}) where {T<:Real} = zero(ExactReal{T})

Base.zero(::Type{Complex{ExactReal{T}}}) where {T<:Real} = complex(zero(ExactReal{T}), zero(ExactReal{T}))
Base.zero(::Complex{ExactReal{T}}) where {T<:Real} = zero(Complex{ExactReal{T}})

Base.one(::Type{ExactReal{T}}) where {T<:Real} = ExactReal(one(T))
Base.one(::ExactReal{T}) where {T<:Real} = one(ExactReal{T})

Base.one(::Type{Complex{ExactReal{T}}}) where {T<:Real} = complex(one(ExactReal{T}), zero(ExactReal{T}))
Base.one(::Complex{ExactReal{T}}) where {T<:Real} = one(Complex{ExactReal{T}})

# conversion and promotion

Base.convert(::Type{ExactReal{T}}, x::ExactReal{T}) where {T<:Real} = x

Base.promote_rule(::Type{ExactReal{T}}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    throw(ArgumentError("promotion between `ExactReal` is not allowed"))

# to BareInterval

Base.convert(::Type{BareInterval{T}}, x::ExactReal) where {T<:NumTypes} = bareinterval(T, x.value)

Base.promote_rule(::Type{BareInterval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    BareInterval{promote_numtype(T, S)}
Base.promote_rule(::Type{ExactReal{T}}, ::Type{BareInterval{S}}) where {T<:Real,S<:NumTypes} =
    BareInterval{promote_numtype(T, S)}

# to Interval

Base.convert(::Type{Interval{T}}, x::ExactReal) where {T<:NumTypes} = interval(T, x.value)

Base.promote_rule(::Type{Interval{T}}, ::Type{ExactReal{S}}) where {T<:NumTypes,S<:Real} =
    Interval{promote_numtype(T, S)}
Base.promote_rule(::Type{ExactReal{T}}, ::Type{Interval{S}}) where {T<:Real,S<:NumTypes} =
    Interval{promote_numtype(T, S)}

# to Real

# allows Interval{<:NumTypes}(::ExactReal)
(::Type{T})(x::ExactReal) where {T<:Real} = convert(T, x)

Base.convert(::Type{T}, x::ExactReal) where {T<:Real} = convert(T, x.value)

Base.promote_rule(::Type{T}, ::Type{ExactReal{S}}) where {T<:Real,S<:Real} =
    promote_type(T, S)
Base.promote_rule(::Type{ExactReal{T}}, ::Type{S}) where {T<:Real,S<:Real} =
    promote_type(T, S)
# needed to resolve method ambiguities
Base.promote_rule(::Type{ExactReal{T}}, ::Type{Bool}) where {T<:Real} =
    promote_type(T, Bool)
Base.promote_rule(::Type{Bool}, ::Type{ExactReal{T}}) where {T<:Real} =
    promote_type(Bool, T)
Base.promote_rule(::Type{ExactReal{T}}, ::Type{BigFloat}) where {T<:Real} =
    promote_type(T, BigFloat)
Base.promote_rule(::Type{BigFloat}, ::Type{ExactReal{T}}) where {T<:Real} =
    promote_type(BigFloat, T)

# display

Base.show(io::IO, x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(_str_repr(x)))")

Base.show(io::IO, ::MIME"text/plain", x::ExactReal{T}) where {T<:AbstractFloat} =
    print(io, "ExactReal{$T}($(_str_repr(x)))")

_str_repr(x::ExactReal) = string(x.value)

_str_repr(x::ExactReal{T}) where {T<:AbstractFloat} =
    Base.Ryu.writefixed(x.value, 2000, false, false, false, UInt8('.'), true)

# always exact

Base.:-(x::ExactReal) = ExactReal(-x.value)

# by-pass default

Base.:^(x::ExactReal, p::Integer) = ^(promote(x, p)...)

# basic operations with `BareInterval` and `ExactReal`

for f ∈ (:+, :-, :*, :/, :\, :^)
    @eval Base.$f(x::BareInterval, y::ExactReal) = $f(promote(x, y)...)
    @eval Base.$f(x::ExactReal, y::BareInterval) = $f(promote(x, y)...)
end

"""
    has_exact_display(x::Real)

Determine if the display of `x` up to 2000 decimals is equal to the bitwise
value of `x`. This is famously not true for the float displayed as `0.1`.
"""
has_exact_display(x::Real) = string(x) == _str_repr(ExactReal(x))

#

"""
    @exact

Wrap every literal numbers of the expression in an [`ExactReal`](@ref). This
macro allows defining generic functions, seamlessly accepting both `Number` and
[`Interval`](@ref) arguments, without producing the "NG" flag.

!!! danger
    By using [`ExactReal`](@ref), users acknowledge the responsibility of
    ensuring that the number they input corresponds to their intended value.
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
julia> setdisplay(:full);

julia> f(x) = 1.2*x + 0.1
f (generic function with 1 method)

julia> f(interval(1, 2))
Interval{Float64}(1.2999999999999998, 2.5, com, NG)

julia> @exact g(x) = 1.2*x + 0.1
g (generic function with 1 method)

julia> g(interval(1, 2))
Interval{Float64}(1.2999999999999998, 2.5, com)

julia> g(1.4)
1.78
```

See also: [`ExactReal`](@ref).
"""
macro exact(expr)
    exact_expr = postwalk(expr) do x
        x isa Real && return ExactReal(x)
        return x
    end

    exact_expr = prewalk(exact_expr) do x
        if @capture(x, im)
            return :(complex(ExactReal(false), ExactReal(true)))
        end

        if @capture(x, a_ + im) || @capture(x, im + a_)
            if a isa ExactReal
                return :(complex($a, ExactReal(one($a.value))))
            end
        end
        if @capture(x, a_ - im) || @capture(x, -im + a_)
            if a isa ExactReal
                return :(complex($a, ExactReal(-one($a.value))))
            end
        end

        if @capture(x, b_ * im) || @capture(x, im * b_)
            if b isa ExactReal
                return :(complex(ExactReal(zero($b.value)), $b))
            end
        end

        if @capture(x, a_ + b_ * im) || @capture(x, a_ + im * b_) || @capture(x, b_ * im + a_) || @capture(x, im * b_ + a_)
            if a isa ExactReal && b isa ExactReal
                return :(complex($a, $b))
            end
        end
        if @capture(x, a_ - b_ * im) || @capture(x, a_ - im * b_) || @capture(x, b_ * im - a_) || @capture(x, im * b_ - a_)
            if a isa ExactReal && b isa ExactReal
                return :(complex($a, -$b))
            end
        end

        return x
    end

    return esc(exact_expr)
end


Base.hash(x::ExactReal, h::UInt) = hash(x.value, h)

Base.isfinite(x::ExactReal) = isfinite(x.value)

Base.zero(x::ExactReal{T}) where {T} = ExactReal(zero(T))
Base.one(x::ExactReal{T}) where {T} = ExactReal(one(T))
