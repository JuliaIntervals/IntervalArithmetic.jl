import LinearAlgebra

@testset "Matrix inversion" begin
    IntervalArithmetic.configure(; matmul = :slow)
    A = [interval(2) interval(1, 2) ; interval(0) interval(1)]
    @test all(isequal_interval.(inv(A), [interval(0, 1) interval(-1.25, -0.25) ; interval(-0.5, 0.5) interval(0.5, 1.5)]))
    B = [interval(2) interval(1, 2) ; interval(0) interval(0, 1)]
    @test all(isnai, inv(B))
end

@testset "Eigendecomposition" begin
    exact_eigs = LinearAlgebra.eigvals(LinearAlgebra.Symmetric([1.0 0.5; 0.5 2.0]))

    # small radius: contraction mapping succeeds, tight individual bounds
    A_small = interval.([1.0 0.5; 0.5 2.0])
    r_small = LinearAlgebra.eigen(A_small)
    @test in_interval(exact_eigs[1], real(r_small.values[1]))
    @test in_interval(exact_eigs[2], real(r_small.values[2]))
    @test !any(isnai, r_small.vectors)

    # moderate radius: contraction mapping may fail, fallback provides valid enclosure
    A_mid = interval.([1.0 0.5; 0.5 2.0], 0.3; format = :midpoint)
    r_mid = LinearAlgebra.eigen(A_mid)
    @test in_interval(exact_eigs[1], real(r_mid.values[1]))
    @test in_interval(exact_eigs[2], real(r_mid.values[2]))

    # large radius: contraction mapping fails, eigenvalue enclosure fallback
    A_large = interval.([1.0 0.5; 0.5 2.0], 1.0; format = :midpoint)
    r_large = LinearAlgebra.eigen(A_large)
    @test in_interval(exact_eigs[1], real(r_large.values[1]))
    @test in_interval(exact_eigs[2], real(r_large.values[2]))
    @test all(isnai, r_large.vectors)

    # general (non-symmetric) matrix with large radius
    M = [0.0 -1.0; 2.0 -0.5]
    mid_eigs = LinearAlgebra.eigvals(M)
    A_gen = interval.(M, 0.5; format = :midpoint)
    r_gen = LinearAlgebra.eigen(A_gen)
    for λ in mid_eigs
        @test in_interval(real(λ), real(r_gen.values[1]))
        @test in_interval(imag(λ), imag(r_gen.values[1]))
    end

    # 3×3 symmetric with large radius
    S3_mid = [2.0 1.0 0.0; 1.0 3.0 1.0; 0.0 1.0 4.0]
    exact3 = LinearAlgebra.eigvals(LinearAlgebra.Symmetric(S3_mid))
    A3 = interval.(S3_mid, 0.5; format = :midpoint)
    r3 = LinearAlgebra.eigen(A3)
    for λ in exact3
        @test in_interval(λ, real(r3.values[1]))
    end

    # explicit algorithm selection: IntervalEigenContraction on small-radius matrix
    r_contraction = LinearAlgebra.eigen(A_small; alg = IntervalEigenContraction())
    @test in_interval(exact_eigs[1], real(r_contraction.values[1]))
    @test in_interval(exact_eigs[2], real(r_contraction.values[2]))
    @test !any(isnai, r_contraction.vectors)

    # explicit algorithm selection: IntervalEigenContraction on large-radius matrix → nai
    r_contraction_large = LinearAlgebra.eigen(A_large; alg = IntervalEigenContraction())
    @test all(isnai, r_contraction_large.values)
    @test all(isnai, r_contraction_large.vectors)

    # explicit algorithm selection: IntervalEigenRohn
    r_rohn = LinearAlgebra.eigen(A_large; alg = IntervalEigenRohn())
    @test in_interval(exact_eigs[1], real(r_rohn.values[1]))
    @test in_interval(exact_eigs[2], real(r_rohn.values[2]))
    @test all(isnai, r_rohn.vectors)

    # explicit algorithm selection: IntervalEigenHertz
    r_hertz = LinearAlgebra.eigen(A_large; alg = IntervalEigenHertz())
    @test in_interval(exact_eigs[1], real(r_hertz.values[1]))
    @test in_interval(exact_eigs[2], real(r_hertz.values[2]))
    @test all(isnai, r_hertz.vectors)
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
