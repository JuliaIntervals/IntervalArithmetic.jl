using ValidatedNumerics

import ValidatedNumerics.AbstractInterval

@enum DECORATION com dac def trv ill

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




# Define sin(::DecoratedInterval)
