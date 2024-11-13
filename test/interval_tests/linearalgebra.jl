import LinearAlgebra

@testset "Matrix inversion" begin
    A = [interval(2) interval(1, 2) ; interval(0) interval(1)]
    @test all(isequal_interval.(inv(A), [interval(0, 1) interval(-1.25, -0.25) ; interval(-0.5, 0.5) interval(0.5, 1.5)]))
    B = [interval(2) interval(1, 2) ; interval(0) interval(0, 1)]
    @test all(isnai, inv(B))
end

@testset "Matrix multiplication" begin
    IntervalArithmetic.matmul_mode() = IntervalArithmetic.MatMulMode{:fast}()
    A = [interval(2, 4) interval(-2, 1) ; interval(-1, 2) interval(2, 4)]
    imA = interval(im) * A

    @test all(isequal_interval.(A * A, [interval(-2, 19.5) interval(-16, 10) ; interval(-10, 16) interval(-2, 19.5)]))
    @test all(isequal_interval.(A * mid.(A), [interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)]))
    @test all(isequal_interval.(mid.(A) * A, [interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)]))

    @test all(isequal_interval.(imA * imA, -[interval(-2, 19.5) interval(-16, 10) ; interval(-10, 16) interval(-2, 19.5)]))
    @test all(isequal_interval.(mid.(A) * imA, interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)]))
    @test all(isequal_interval.(imA * mid.(A), interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)]))
    IntervalArithmetic.matmul_mode() = IntervalArithmetic.MatMulMode{:slow}()
end
