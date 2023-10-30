using Random

@testset "rand tests" begin

    X = interval(3, 4)
    for i in 1:100
        @test in_interval(rand(X), X)
    end

    X = interval(3, 4)
    for i in 1:100
        @test in_interval(rand(X, 4)[(i%4)+1], X)
    end

    for T in (Float32, Float64, BigFloat)
        X = interval(T, 3, 4)
        @test rand(X) isa T
    end

    for T in (Float32, Float64, BigFloat)
        X = interval(T, 3, 7)
        Y = rand(X, 7)
        @test Y isa Array{T, 1}
        for x in Y
            @test x isa T
        end
    end
end
