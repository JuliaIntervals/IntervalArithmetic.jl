# Decorated intervals, following the IEEE 1758-2015 standard


@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# < and min work automatically for enums


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

# Functions with restricted domains:
restricted_functions = Dict(
    :sqrt => [0, ∞],
    :log => [0, ∞],

    :asin => [-1, 1]
)

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

unrestricted_functions = [:exp, :sinh, :cosh]

for f in unrestricted_functions

    @eval function Base.$(f){T}(xx::DecoratedInterval{T})
        x = interval(xx)

        DecoratedInterval($f(x), decay(xx, com))
    end
end

binary_functions = [:+, :-, :*, :/]
for f in binary_functions

    @eval function Base.$(f){T}(xx::DecoratedInterval{T}, yy::DecoratedInterval{T})
        x = interval(xx)
        y = interval(yy)

        DecoratedInterval($f(x, y), decay(xx, com))
    end
end
