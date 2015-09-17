# This file is part of the ValidatedNumerics.jl package; MIT licensed

type IntervalParameters

    precision_type::Type
    precision::Int
    rounding::Symbol
    pi::Interval{BigFloat}

    IntervalParameters() = new(Float64, 256, :narrow)  # leave out pi
end


const interval_parameters = IntervalParameters()
