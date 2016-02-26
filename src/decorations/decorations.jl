# Decorated intervals, following the IEEE 1758-2015 standard


@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# < and min work automatically for enums

doc"""
A `DecoratedInterval` is an interval, together with a *decoration*, i.e.
a flag that records the status of the interval when thought of as the result
of a previously executed sequence of functions acting on an initial interval.
"""
type DecoratedInterval{T <: AbstractFloat} <: AbstractInterval
    interval::Interval{T}
    decoration::DECORATION
end

interval(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

Base.show(io::IO, x::DecoratedInterval) = print(io, x.interval, "_", x.decoration)


# Automatic decorations for an interval
function DecoratedInterval(I::Interval)
    decoration = com

    if isempty(I)
        decoration = trv
    end

    if isinf(diam(I))  # unbounded
        decoration = dac
    end

    DecoratedInterval(I, decoration)

end


decay(a::DECORATION, b::DECORATION) = min(a, b)
decay(xx::DecoratedInterval, a::DECORATION) = min(decoration(xx), a)

# Define functions on decorated intervals
function Base.sign{T}(xx::DecoratedInterval{T})
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

unrestricted_functions =
    [
    :-,
    :exp, :exp2, :exp10,
    :sin, :cos, :tan,
    :atan, :atan2,
    :sinh, :cosh, :tanh,
    :asinh
    ]

binary_functions =
    [
    :+, :-, :*, :/,
    :min, :max
    ]

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

    @eval function Base.$(f){T}(xx::DecoratedInterval{T})
        x = interval(xx)

        DecoratedInterval($f(x), decay(xx, com))
    end
end

for f in binary_functions

    @eval function Base.$(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)

        DecoratedInterval($f(x, y), decay(xx, com))
    end
end
