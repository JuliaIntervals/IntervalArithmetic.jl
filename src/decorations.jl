using ValidatedNumerics

import ValidatedNumerics.AbstractInterval

@enum DECORATION ill=0 trv=1 dev=2 dac=3 com=4
# < and min work automatically!

macro I_str(ex)
    @interval ex
end


type DecoratedInterval{T <: AbstractFloat} <: AbstractInterval
    interval::Interval{T}
    decoration::DECORATION
end

type Box{T <: AbstractInterval}
    components::Vector{T}
end

Box(a...) = Box([a...])

#Box(DecoratedInterval(I"1", com), DecoratedInterval(I"2", com))



# Define sin(::DecoratedInterval)
