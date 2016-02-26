using ValidatedNumerics

import ValidatedNumerics.AbstractInterval

@enum DECORATION ill=0 trv=1 def=2 dac=3 com=4
# < and min work automatically!

macro I_str(ex)
    @interval ex
end


type DecoratedInterval{T <: AbstractFloat} <: AbstractInterval
    interval::Interval{T}
    decoration::DECORATION
end

interval(x::DecoratedInterval) = x.interval
decoration(x::DecoratedInterval) = x.decoration

Base.show(io::IO, x::DecoratedInterval) = print(io, x.interval, "_", x.decoration)



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

function Base.sign{T}(xx::DecoratedInterval{T})
    x = interval(xx)

    if zero(T) ∉ x
        return DecoratedInterval(sign(x), decay(xx, com))
    end

    return DecoratedInterval(sign(x), decay(xx, def))

end


restricted_functions = Dict(   # those with restricted domains
    :sqrt => [0, ∞],
    :asin => [-1, 1]
)

for (f, domain) in restricted_functions

    domain = Interval(domain...)

    #code = quote
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
    #end
end



a = DecoratedInterval(@interval(1, 2), com)
@show a, sqrt(a)

a = DecoratedInterval(@interval(-1, 1), com)
@show a, sqrt(a)
@show a, asin(a)
