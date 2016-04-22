# This file is part of the ValidatedNumerics.jl package; MIT licensed


decay(a::DECORATION, b::DECORATION) = min(a, b)
decay(a::DECORATION, b::DECORATION, c::DECORATION) = min(a, b, c)
function decay(a::DECORATION)
    a == com && return dac
    a == dac && return def
    a == def && return trv
    ill
end
# decay(xx::DecoratedInterval, a::DECORATION) = min(decoration(xx), a)
# decay(xx::DecoratedInterval, yy::DecoratedInterval) = min(decoration(xx), decoration(yy))
export decay

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

for f in bool_functions
    @eval $(f)(xx::DecoratedInterval) = $(f)(interval(xx))
end

for f in bool_binary_functions
    @eval $(f)(xx::DecoratedInterval, yy::DecoratedInterval) =
        $(f)(interval(xx), interval(yy))
end

in{T<:Real}(x::T, a::DecoratedInterval) = in(x, interval(a))


## scalar functions: mig, mag and friends
scalar_functions = ( :mig, :mag, :infimum, :supremum, :mid, :diam, :radius )

for f in scalar_functions
    @eval $(f){T}(xx::DecoratedInterval{T}) = $f(interval(xx))
end

## Arithmetic function; / is treated separately
arithm_functions = ( :+, :-, :* )

+(xx::DecoratedInterval) =  xx
-(xx::DecoratedInterval) =  DecoratedInterval(-interval(xx), decoration(xx))
for f in arithm_functions
    @eval function $(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)
        r = $f(x, y)
        dec = decay(decoration(xx), decoration(yy), decoration(r))
        DecoratedInterval(r, dec)
    end
end

# Division
function inv{T}(xx::DecoratedInterval{T})
    x = interval(xx)
    dx = decoration(xx)
    dx = zero(T) ∈ x ? decay(dx,trv) : dx
    r = inv(x)
    dx = decay(decoration(r), dx)
    DecoratedInterval( r, dx )
end
function /{T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
    x = interval(xx)
    y = interval(yy)
    r = x / y
    dy = decoration(yy)
    dy = zero(T) ∈ y ? decay(dy, trv) : dy
    dy = decay(decoration(xx), dy, decoration(r))
    DecoratedInterval(r, dy)
end

## fma
function fma{T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T}, zz::DecoratedInterval{T})
    r = fma(interval(xx), interval(yy), interval(zz))
    d = decay(decoration(xx), decoration(yy), decoration(zz))
    d = decay(decoration(r), d)
    DecoratedInterval(r, d)
end





## Functions on unrestricted domains; tan and atan2 are treated separately
unrestricted_functions =(
    :exp, :exp2, :exp10,
    :sin, :cos,
    :atan,
    :sinh, :cosh, :tanh)

for f in unrestricted_functions
    @eval function $(f){T}(xx::DecoratedInterval{T})
        x = interval(xx)
        r = $f(x)
        d = decay(decoration(r), decoration(xx))
        DecoratedInterval(r, d)
    end
end

function tan{T}(xx::DecoratedInterval{T})
    x = interval(xx)
    r = tan(x)
    d = decay(decoration(r), decoration(xx))
    if isunbounded(r)
        d = decay(d, trv)
    end
    DecoratedInterval(r, d)
end

function atan2{T}(yy::DecoratedInterval{T}, xx::DecoratedInterval{T})
    x = interval(xx)
    y = interval(yy)
    r = atan2(y, x)
    d = decoration(r)
    d = decay(d, decoration(xx), decoration(yy))
    # Check cases when decoration is trv and decays (from com or dac)
    if zero(T) ∈ y
        zero(T) ∈ x && return DecoratedInterval(r, trv)
        if x.hi < zero(T) && y.lo != y.hi && signbit(y.lo) && Int(d) > 2
            return DecoratedInterval(r, decay(d))
        end
    end
    DecoratedInterval(r, d)
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

binary_functions = ( :min, :max )

for f in binary_functions

    @eval function Base.$(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)

        DecoratedInterval($f(x, y), decay(xx, com))
    end
end
