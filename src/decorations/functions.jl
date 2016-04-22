# This file is part of the ValidatedNumerics.jl package; MIT licensed


decay(a::DECORATION, b::DECORATION) = min(a, b)
function decay(a::DECORATION)
    a == com && return dac
    a == dac && return def
    a == def && return trv
    ill
end
decay(xx::DecoratedInterval, a::DECORATION) = min(decoration(xx), a)
decay(xx::DecoratedInterval, yy::DecoratedInterval) = min(decoration(xx), decoration(yy))


# zero, one
zero{T<:Real}(a::DecoratedInterval{T}) = DecoratedInterval(zero(T))
zero{T<:Real}(::Type{DecoratedInterval{T}}) = DecoratedInterval(zero(T))
one{T<:Real}(a::DecoratedInterval{T}) = DecoratedInterval(one(T))
one{T<:Real}(::Type{DecoratedInterval{T}}) = DecoratedInterval(one(T))


## Bool functions
bool_functions = (
    :isempty, :isentire, :isunbounded,
    :isfinite, :isnai, :isnan,
    :isthin, :iscommon
)

bool_binary_functions = (
    :<, :>, :(==), :!=, :⊆, :^, :<=,
    :interior, :isdisjoint, :precedes, :strictprecedes
)

in{T<:Real}(x::T, a::DecoratedInterval) = in(interval(a))

for f in bool_functions
    @eval $(f)(xx::DecoratedInterval) = $(f)(interval(xx))
end

for f in bool_binary_functions
    @eval $(f)(xx::DecoratedInterval, yy::DecoratedInterval) =
        $(f)(interval(xx), interval(yy))
end

## Arithmetic function
arithm_functions = ( :+, :-, :* )

# unary + and -
+(xx::DecoratedInterval) =  xx
-(xx::DecoratedInterval) =  DecoratedInterval(-interval(xx), decoration(xx))

for f in arithm_functions
    @eval function $(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)
        r = $f(x, y)
        dec = decay(xx, yy)
        dec = decay(decoration(r), dec)
        DecoratedInterval(r, dec)
    end
end

# Division
function inv{T}(xx::DecoratedInterval{T})
    x = interval(xx)
    dx = zero(T) ∈ x ? decay(xx,trv) : decoration(xx)
    r = inv(x)
    dx = decay(decoration(r), dx)
    DecoratedInterval( r, dx )
end

function /{T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
    y = interval(yy)
    dy = zero(T) ∈ y ? decay(yy, trv) : decoration(yy)
    x = interval(xx)
    dx = decoration(xx)
    #
    r = x / y
    dx = decay(dx, dy)
    dx = decay(decoration(r), dx)
    DecoratedInterval(r, dx)
end


#### HASTA AQUI

# Define functions on decorated intervals
function sign{T}(xx::DecoratedInterval{T})
    x = interval(xx)

    if zero(T) ∉ x
        return DecoratedInterval(sign(x), decay(xx, com))
    end

    return DecoratedInterval(sign(x), decay(xx, def))

end


# For domains, cf. table 9.1 on page 28 of the standard

# Functions with restricted domains:
restricted_functions = Dict(
    :sqrt => [0, ∞],

    :log => [0, ∞],
    :log2 => [0, ∞],
    :log10 => [0, ∞],

    :asin => [-1, 1],
    :acos => [-1, 1],

    :acosh => [1, ∞],
    :atanh => [-1, 1]
)

binary_functions = ( :min, :max )

# three_argument = [:fma]
# power function must be defined separately and carefully

# Discontinuous like sign:  floor, ceil, trunc, RoundTiesToEven, RoundTiesToAway


# Define functions with restricted domains on DecoratedInterval's:
for (f, domain) in restricted_functions

    domain = Interval(domain...)

    @eval function Base.$(f){T}(xx::DecoratedInterval{T})
        x = interval(xx)

        if x ⊆ $(domain)

            if isunbounded(x)  # unnecessary if domain is bounded
                return DecoratedInterval($(f)(x), decay(xx, dac))
            else
                return DecoratedInterval($(f)(x), decay(xx, com))
            end

        end

        DecoratedInterval($f(x ∩ $(domain)), decay(xx, trv))
    end
end


# Define unary functions with no domain restrictions



for f in unrestricted_functions
    @eval function $(f){T}(xx::DecoratedInterval{T})
        x = interval(xx)

        DecoratedInterval(r, decay(xx,com))
    end
end

for f in binary_functions

    @eval function Base.$(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)

        DecoratedInterval($f(x, y), decay(xx, com))
    end
end
