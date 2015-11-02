using ValidatedNumerics
using FactCheck

facts("Misc tests") do
    @fact BigFloat(pi) == big(pi) --> true
    @fact pi < pi --> false
    @fact pi > pi --> false
end

facts("Rationalize tests") do
    for rounding_mode in (RoundNearest, RoundDown, RoundUp)
        a = with_rounding(Float64, rounding_mode) do
            # @compat a = parse(Float64, "0.1")
            1 / 10
        end

        #println("Rationalizing a=$a")
        @fact ValidatedNumerics.old_rationalize(a) == 1//10 --> true

    end
end
