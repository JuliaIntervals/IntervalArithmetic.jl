import LinearAlgebra

@testset "Matrix inversion" begin
    IntervalArithmetic.configure(; matmul = :slow)
    A = [interval(2) interval(1, 2) ; interval(0) interval(1)]
    @test all(isequal_interval.(inv(A), [interval(0, 1) interval(-1.25, -0.25) ; interval(-0.5, 0.5) interval(0.5, 1.5)]))
    B = [interval(2) interval(1, 2) ; interval(0) interval(0, 1)]
    @test all(isnai, inv(B))
end

@testset "Eigenbox" begin
    # Rohn: symmetric matrix with zero radius
    A0 = LinearAlgebra.Symmetric(interval.([1.0 0.5; 0.5 2.0]))
    exact_eigs = LinearAlgebra.eigvals(LinearAlgebra.Symmetric([1.0 0.5; 0.5 2.0]))
    box0 = eigenbox(A0)
    @test in_interval(exact_eigs[1], box0)
    @test in_interval(exact_eigs[2], box0)

    # Rohn: symmetric matrix with nonzero radius
    A1 = LinearAlgebra.Symmetric(interval.([1.0 0.5; 0.5 2.0], 0.1; format = :midpoint))
    box1 = eigenbox(A1)
    @test in_interval(exact_eigs[1], box1)
    @test in_interval(exact_eigs[2], box1)

    # Hertz gives tighter bounds than Rohn
    box1h = eigenbox(A1, Hertz())
    @test in_interval(exact_eigs[1], box1h)
    @test in_interval(exact_eigs[2], box1h)
    @test inf(box1) ≤ inf(box1h)
    @test sup(box1h) ≤ sup(box1)

    # wider intervals
    A2 = LinearAlgebra.Symmetric(interval.([1.0 0.5; 0.5 2.0], 0.3; format = :midpoint))
    box2 = eigenbox(A2)
    box2h = eigenbox(A2, Hertz())
    @test in_interval(exact_eigs[1], box2)
    @test in_interval(exact_eigs[2], box2)
    @test inf(box2) ≤ inf(box2h)
    @test sup(box2h) ≤ sup(box2)

    # general (non-symmetric) matrix
    M = [0.0 -1.0; 2.0 -0.5]
    A3 = interval.(M, 0.5; format = :midpoint)
    box3 = eigenbox(A3)
    mid_eigs = LinearAlgebra.eigvals(M)
    for λ in mid_eigs
        @test in_interval(real(λ), real(box3))
        @test in_interval(imag(λ), imag(box3))
    end

    # 3×3 symmetric
    S3 = LinearAlgebra.Symmetric(interval.([2.0 1.0 0.0; 1.0 3.0 1.0; 0.0 1.0 4.0], 0.1; format = :midpoint))
    exact3 = LinearAlgebra.eigvals(LinearAlgebra.Symmetric(mid.(S3)))
    box3s = eigenbox(S3)
    for λ in exact3
        @test in_interval(λ, box3s)
    end
end

@testset "Eigen fallback to eigenbox" begin
    # small radius: contraction mapping succeeds, tight individual bounds
    A_small = interval.([1.0 0.5; 0.5 2.0])
    r_small = LinearAlgebra.eigen(A_small)
    exact_eigs = LinearAlgebra.eigvals(LinearAlgebra.Symmetric([1.0 0.5; 0.5 2.0]))
    @test in_interval(exact_eigs[1], real(r_small.values[1]))
    @test in_interval(exact_eigs[2], real(r_small.values[2]))
    @test !any(isnai, r_small.vectors)

    # large radius: contraction mapping fails, eigenbox fallback
    A_large = interval.([1.0 0.5; 0.5 2.0], 1.0; format = :midpoint)
    r_large = LinearAlgebra.eigen(A_large)
    @test in_interval(exact_eigs[1], real(r_large.values[1]))
    @test in_interval(exact_eigs[2], real(r_large.values[2]))
    @test all(isnai, r_large.vectors)
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
