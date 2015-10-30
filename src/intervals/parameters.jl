# This file is part of the ValidatedNumerics.jl package; MIT licensed

type IntervalParameters

    precision_type::Type
    precision::Int
    rounding::Symbol
    pi::Interval{BigFloat}

    IntervalParameters() = new(BigFloat, 256, :narrow)  # leave out pi
end


const parameters = IntervalParameters()
