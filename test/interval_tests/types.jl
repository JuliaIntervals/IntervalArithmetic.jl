using IntervalArithmetic
using Test


@testset "types consistency" begin
    int_types = [Int8, Int16, Int32, Int64, Int128]
    float_types = [Float16, Float32, Float64]
    considered_types = vcat(int_types, float_types)
    interval_functions = [.., interval, Interval]
    for interval_constructors in interval_functions
        for T in considered_types
            for S in considered_types
                @test typeof(interval_constructors(T(0), S(1)) == promote_type(T, S)
            end
            for S in float_types
                @test typeof(interval_constructors(T(0), S(∞)) == promote_type(T, S)
                @test typeof(interval_constructors(S(-∞), T(0)) == promote_type(T, S)
                @test typeof(interval_constructors(T(0), S(0.1)) == promote_type(T, S)
                @test typeof(interval_constructors(S(-0.1), T(0)) == promote_type(T, S)
            end
        end
        for T in float_types
            for S in float_types
                @test typeof(interval_constructors(T(-0.1), S(0.2)) == promote_type(T, S)
            end
        end
    end
end
