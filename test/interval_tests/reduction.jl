using IntervalArithmetic
using Test

setprecision(Interval, Float64)

@testset "Reduction Test" begin
    @test mpfr_vector_sum(Base.vect(1.0, 2.0, 3.0), 0.5) == 6.0
    @test isnan(mpfr_vector_sum(Base.vect(1.0, 2.0, NaN, 3.0), 0.5))
    @test isnan(mpfr_vector_sum(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.5))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -2.0, 3.0), 0.5) == 6.0
    @test isnan(mpfr_vector_sumAbs(Base.vect(1.0, -2.0, NaN, 3.0), 0.5))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.5) == Inf
    @test mpfr_vector_sumSquare(Base.vect(1.0, 2.0, 3.0), 0.5) == 14.0
    @test isnan(mpfr_vector_sumSquare(Base.vect(1.0, 2.0, NaN, 3.0), 0.5))
    @test mpfr_vector_sumSquare(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.5) == Inf
    @test mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0), Base.vect(1.0, 2.0, 3.0), 0.5) == 14.0
    @test mpfr_vector_dot(Base.vect(0x10000000000001p0, 0x1p104), Base.vect(0x0fffffffffffffp0, -1.0), 0.5) == -1.0
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, NaN, 3.0), Base.vect(1.0, 2.0, 3.0, 4.0), 0.5))
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0, 4.0), Base.vect(1.0, 2.0, NaN, 3.0), 0.5))
    @test mpfr_vector_sum(Base.vect(1.0, 2.0, 3.0), 0.0) == 6.0
    @test isnan(mpfr_vector_sum(Base.vect(1.0, 2.0, NaN, 3.0), 0.0))
    @test isnan(mpfr_vector_sum(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.0))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -2.0, 3.0), 0.0) == 6.0
    @test isnan(mpfr_vector_sumAbs(Base.vect(1.0, -2.0, NaN, 3.0), 0.0))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.0) == Inf
    @test mpfr_vector_sumSquare(Base.vect(1.0, 2.0, 3.0), 0.0) == 14.0
    @test isnan(mpfr_vector_sumSquare(Base.vect(1.0, 2.0, NaN, 3.0), 0.0))
    @test mpfr_vector_sumSquare(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), 0.0) == Inf
    @test mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0), Base.vect(1.0, 2.0, 3.0), 0.0) == 14.0
    @test mpfr_vector_dot(Base.vect(0x10000000000001p0, 0x1p104), Base.vect(0x0fffffffffffffp0, -1.0), 0.0) == -1.0
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, NaN, 3.0), Base.vect(1.0, 2.0, 3.0, 4.0), 0.0))
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0, 4.0), Base.vect(1.0, 2.0, NaN, 3.0), 0.0))
    @test mpfr_vector_sum(Base.vect(1.0, 2.0, 3.0), Inf) == 6.0
    @test isnan(mpfr_vector_sum(Base.vect(1.0, 2.0, NaN, 3.0), Inf))
    @test isnan(mpfr_vector_sum(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), Inf))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -2.0, 3.0), Inf) == 6.0
    @test isnan(mpfr_vector_sumAbs(Base.vect(1.0, -2.0, NaN, 3.0), Inf))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), Inf) == Inf
    @test mpfr_vector_sumSquare(Base.vect(1.0, 2.0, 3.0), Inf) == 14.0
    @test isnan(mpfr_vector_sumSquare(Base.vect(1.0, 2.0, NaN, 3.0), Inf))
    @test mpfr_vector_sumSquare(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), Inf) == Inf
    @test mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0), Base.vect(1.0, 2.0, 3.0), Inf) == 14.0
    @test mpfr_vector_dot(Base.vect(0x10000000000001p0, 0x1p104), Base.vect(0x0fffffffffffffp0, -1.0), Inf) == -1.0
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, NaN, 3.0), Base.vect(1.0, 2.0, 3.0, 4.0), Inf))
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0, 4.0), Base.vect(1.0, 2.0, NaN, 3.0), Inf))
    @test mpfr_vector_sum(Base.vect(1.0, 2.0, 3.0), -Inf) == 6.0
    @test isnan(mpfr_vector_sum(Base.vect(1.0, 2.0, NaN, 3.0), -Inf))
    @test isnan(mpfr_vector_sum(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), -Inf))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -2.0, 3.0), -Inf) == 6.0
    @test isnan(mpfr_vector_sumAbs(Base.vect(1.0, -2.0, NaN, 3.0), -Inf))
    @test mpfr_vector_sumAbs(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), -Inf) == Inf
    @test mpfr_vector_sumSquare(Base.vect(1.0, 2.0, 3.0), -Inf) == 14.0
    @test isnan(mpfr_vector_sumSquare(Base.vect(1.0, 2.0, NaN, 3.0), -Inf))
    @test mpfr_vector_sumSquare(Base.vect(1.0, -Inf, 2.0, Inf, 3.0), -Inf) == Inf
    @test mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0), Base.vect(1.0, 2.0, 3.0), -Inf) == 14.0
    @test mpfr_vector_dot(Base.vect(0x10000000000001p0, 0x1p104), Base.vect(0x0fffffffffffffp0, -1.0), -Inf) == -1.0
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, NaN, 3.0), Base.vect(1.0, 2.0, 3.0, 4.0), -Inf))
    @test isnan(mpfr_vector_dot(Base.vect(1.0, 2.0, 3.0, 4.0), Base.vect(1.0, 2.0, NaN, 3.0), -Inf))
end
