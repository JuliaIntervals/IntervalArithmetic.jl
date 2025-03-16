import LinearAlgebra

@testset "Matrix inversion" begin
    IntervalArithmetic.configure(; matmul = :slow)
    A = [interval(2) interval(1, 2) ; interval(0) interval(1)]
    @test all(isequal_interval.(inv(A), [interval(0, 1) interval(-1.25, -0.25) ; interval(-0.5, 0.5) interval(0.5, 1.5)]))
    B = [interval(2) interval(1, 2) ; interval(0) interval(0, 1)]
    @test all(isnai, inv(B))
end

@testset "Matrix multiplication" begin
    IntervalArithmetic.configure(; matmul = :fast)
    A = [interval(2, 4) interval(-2, 1) ; interval(-1, 2) interval(2, 4)]
    imA = interval(im) * A

    @test all(issubset_interval.([interval(0, 18) interval(-16, 8) ; interval(-8, 16) interval(0, 18)], A * A))
    @test all(issubset_interval.([interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], A * mid.(A)))
    @test all(issubset_interval.([interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], mid.(A) * A))

    @test all(issubset_interval.([interval(-18, 0) interval(-8, 16) ; interval(-16, 8) interval(-18, 0)], imA * imA))
    @test all(issubset_interval.(interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], mid.(A) * imA))
    @test all(issubset_interval.(interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], imA * mid.(A)))
end
