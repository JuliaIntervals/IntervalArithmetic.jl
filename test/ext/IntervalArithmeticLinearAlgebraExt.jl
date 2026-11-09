using Test
using IntervalArithmetic
using IntervalArithmetic: IntervalEigen, IntervalEigenContraction, IntervalEigenRohn, IntervalEigenHertz
import LinearAlgebra
using LinearAlgebra: I, UniformScaling, opnorm, eigvals, eigvals!, eigen, det, mul!

@testset "UniformScaling" begin
    J = interval(I)
    @test J isa UniformScaling{Interval{Float64}}
    @test J.λ === interval(1, 1)
    @test interval(Float64, I, I).λ === interval(1, 1)
    @test interval(I, 2I).λ === interval(1, 2)
    @test IntervalArithmetic._infer_numtype(2 * I) === Int
    @test IntervalArithmetic._infer_numtype(2.0 * I) === Float64
    E = exact(2.0 * I)
    @test E isa UniformScaling{ExactReal{Float64}}
    @test E.λ === exact(2.0)
    A = interval.([1.0 2.0; 3.0 4.0])
    @test all(isequal_interval.(A - interval(I), interval.([0.0 2.0; 3.0 3.0])))
    @test all(isequal_interval.(A - UniformScaling(interval(1)), interval.([0.0 2.0; 3.0 3.0])))
end

@testset "opnorm" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    @test isequal_interval(opnorm(A, 1), interval(6))
    @test isguaranteed(opnorm(A, 1))
    @test isequal_interval(opnorm(A, Inf), interval(7))
    @test isguaranteed(opnorm(A, Inf))
    o2 = opnorm(A, 2)
    @test o2 isa Interval{Float64}
    @test in_interval(5.464985704219043, o2)

    Ac = complex.(A, A)
    @test opnorm(Ac, 1) isa Interval{Float64}
    @test isguaranteed(opnorm(Ac, 1))
    @test opnorm(Ac, Inf) isa Interval{Float64}

    A32 = interval.(Float32[1 2; 3 4])
    @test opnorm(A32, 1) isa Interval{Float32}
    @test isequal_interval(opnorm(A32, 1), interval(Float32, 6, 6))
    Abig = interval.(big.([1.0 2.0; 3.0 4.0]))
    @test opnorm(Abig, 1) isa Interval{BigFloat}

    @test isequal_interval(opnorm(Matrix{Interval{Float64}}(undef, 0, 0), 1), interval(0))
    @test isequal_interval(opnorm(interval.(fill(-2.0, 1, 1)), 1), interval(2))
    @test isequal_interval(opnorm(interval.([1.0 -2.0]), 1), interval(2))
    @test isequal_interval(opnorm(interval.([1.0 -2.0]), Inf), interval(3))
end

@testset "eigvals" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    λ = eigvals(A)
    @test λ isa Vector{Interval{Float64}}
    @test in_interval((5 - sqrt(33)) / 2, λ[1])
    @test in_interval((5 + sqrt(33)) / 2, λ[2])
    B = copy(A)
    eigvals!(B)
    @test all(B .=== A)
    @test eigvals(A; permute = false, scale = false, sortby = nothing) isa Vector{Interval{Float64}}

    R = interval.([0.0 -1.0; 1.0 0.0])
    μ = eigvals(R)
    @test μ isa Vector{Complex{Interval{Float64}}}
    @test isequal_interval(real(μ[1]), real(μ[2]))
    @test isequal_interval(imag(μ[1]), -imag(μ[2]))
    @test any(x -> in_interval(1, imag(x)), μ)

    D = [interval(1) interval(0); interval(0) interval(2)]
    ν = eigvals(D)
    @test ν isa Vector{Interval{Float64}}
    @test in_interval(1, ν[1]) & in_interval(2, ν[2])

    Cm = complex.(A, interval(1))
    @test eigvals(Cm) isa Vector{Complex{Interval{Float64}}}
end

@testset "det" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    d = det(A)
    @test d isa Interval{Float64}
    @test in_interval(-2, d)
    @test det(complex.(A, interval(1))) isa Complex{Interval{Float64}}
    @test in_interval(0, det(interval.([1.0 2.0; 2.0 4.0])))
end

@testset "eigen" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    E = eigen(A)
    @test E isa LinearAlgebra.Eigen
    @test in_interval((5 - sqrt(33)) / 2, E.values[1])
    @test in_interval((5 + sqrt(33)) / 2, E.values[2])
    @test all(isguaranteed, E.vectors)
    B = copy(A)
    LinearAlgebra.eigen!(B)
    @test all(B .=== A)

    W = A .+ interval(-1, 1)
    EW = eigen(W; alg = IntervalEigenContraction())
    @test all(isnai, EW.values)
    @test all(isnai, EW.vectors)

    ANG = copy(A)
    ANG[1, 1] = interval(1) + 1
    ENG = eigen(ANG)
    @test all(x -> !isguaranteed(x), ENG.vectors)

    ext = Base.get_extension(IntervalArithmetic, :IntervalArithmeticLinearAlgebraExt)
    λ = [complex(interval(1), interval(2))]
    v = fill(complex(interval(1), interval(2)), 1, 1)
    λ2, v2 = ext._fold_conjugate!(Complex{Interval{Float64}}, copy(λ), copy(v))
    @test all(λ2 .=== λ) & all(v2 .=== v)
    λ3, v3 = ext._fold_conjugate!(Interval{Float64}, copy(λ), copy(v))
    @test isequal_interval(λ3[1], complex(interval(1), interval(0)))
    @test isequal_interval(v3[1, 1], complex(interval(1), interval(0)))
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
        @test any(μ -> in_interval(real(λ), real(μ)) && in_interval(imag(λ), imag(μ)), r_gen.values)
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

    # `eigvals` uses the algorithm
    λ_rohn = eigvals(LinearAlgebra.Symmetric(A_large); alg = IntervalEigenRohn())
    @test all(λ -> issubset_interval(interval(-1.2, 4.2), λ), λ_rohn)
    λ_hertz = eigvals(LinearAlgebra.Symmetric(A_large); alg = IntervalEigenHertz())
    @test all(λ -> issubset_interval(λ, λ_rohn[1]), λ_hertz)

    # default intersects Gershgorin with Rohn, which is tighter than both
    A_01 = interval.([1.0 0.5; 0.5 2.0], 0.1; format = :midpoint)
    λ_default = eigvals(LinearAlgebra.Symmetric(A_01))
    λ_box = eigvals(LinearAlgebra.Symmetric(A_01); alg = IntervalEigenRohn())
    @test all(λ -> issubset_interval(λ, λ_box[1]), λ_default)
    @test !isequal_interval(λ_default[1], λ_box[1])
    @test isdisjoint_interval(λ_default[1], λ_default[2])
    @test in_interval(exact_eigs[1], λ_default[1]) && in_interval(exact_eigs[2], λ_default[2])

    # a plain matrix with symmetric entries also contains non-symmetric matrices
    # e.g. `[0 1; -1 0]` with eigenvalues ±i
    K = [interval(0) interval(-1, 1); interval(-1, 1) interval(0)]
    for alg ∈ (IntervalEigen(), IntervalEigenRohn(), IntervalEigenHertz())
        @test all(λ -> in_interval(1, imag(λ)) && in_interval(-1, imag(λ)), eigvals(K; alg))
        @test all(λ -> isthinzero(imag(λ)), eigvals(LinearAlgebra.Symmetric(K); alg))
    end
    @test all(isnai, eigvals(A_large; alg = IntervalEigenContraction()))
    @test all(isguaranteed, eigvals(A_large))

    # Rohn bounds are rigorous
    D = interval.([1.0 0.0; 0.0 1.0], 0.1; format = :midpoint)
    @test all(λ -> in_interval(0.9, λ) && in_interval(1.1, λ), eigvals(D; alg = IntervalEigenRohn()))

    # NG flag
    @test !any(isguaranteed, eigen(A_large .+ 1; alg = IntervalEigenRohn()).values)
    @test !any(isguaranteed, eigvals(A_large .+ 1; alg = IntervalEigenRohn()))
    @test !any(isguaranteed, eigen(LinearAlgebra.Symmetric(A_large .+ 1)).values)
    @test all(isguaranteed, eigen(A_gen; alg = IntervalEigenRohn()).values)

    # `Symmetric` and `Hermitian` wrappers with non-thin diagonal
    r_sym = eigen(LinearAlgebra.Symmetric(A_mid))
    @test in_interval(exact_eigs[1], real(r_sym.values[1]))
    @test in_interval(exact_eigs[2], real(r_sym.values[2]))
    r_herm = eigen(LinearAlgebra.Hermitian(complex.(A_mid)))
    @test in_interval(exact_eigs[1], real(r_herm.values[1]))
    @test in_interval(exact_eigs[2], real(r_herm.values[2]))
    @test in_interval(exact_eigs[1], eigvals(LinearAlgebra.Symmetric(A_mid))[1])
    @test in_interval(exact_eigs[1], real(eigvals(LinearAlgebra.Hermitian(complex.(A_mid)))[1]))

    # eigenvalues of `Symmetric` and `Hermitian` matrices are real
    C = interval.([1.0 1e-8; 1e-8 1.0])
    for alg ∈ (IntervalEigen(), IntervalEigenContraction(), IntervalEigenRohn(), IntervalEigenHertz())
        @test eigvals(LinearAlgebra.Symmetric(C); alg) isa Vector{Interval{Float64}}
        @test eigvals(LinearAlgebra.Hermitian(C); alg) isa Vector{Interval{Float64}}
        @test eigvals(LinearAlgebra.Hermitian(complex.(C)); alg) isa Vector{Interval{Float64}}
        @test eigen(LinearAlgebra.Symmetric(C); alg).values isa Vector{Interval{Float64}}
        @test eigen(LinearAlgebra.Symmetric(C); alg).vectors isa Matrix{Interval{Float64}}
        @test eigen(LinearAlgebra.Hermitian(complex.(C)); alg).values isa Vector{Interval{Float64}}
        @test eigen(LinearAlgebra.Hermitian(complex.(C)); alg).vectors isa Matrix{Complex{Interval{Float64}}}
    end
    # but not those of complex symmetric matrices
    CS = interval.(complex.([1.0 1.0; 1.0 2.0], [1.0 0.0; 0.0 0.0]))
    @test all(λ -> !in_interval(0, imag(λ)), eigvals(LinearAlgebra.Symmetric(CS)))

    # repeated eigenvalues fall back to Rohn
    r_rep = eigen(interval.([1.0 0.0; 0.0 1.0]))
    @test all(λ -> isequal_interval(λ, interval(1)), r_rep.values)
    @test all(isnai, eigen(interval.([1.0 0.0; 0.0 1.0]); alg = IntervalEigenContraction()).values)

    # unbounded entries
    U = [interval(1) interval(0, Inf); interval(0) interval(1)]
    for alg ∈ (IntervalEigen(), IntervalEigenContraction(), IntervalEigenRohn(), IntervalEigenHertz())
        @test all(isnai, eigen(U; alg).values)
        @test all(isnai, eigvals(U; alg))
    end

    # LinearAlgebra matrix functions of `Symmetric` and `Hermitian` matrices are not rigorous
    S = interval.([2.0 1.0 0.0; 1.0 2.0 0.0; 0.0 0.0 -2.0^-50])
    @test_throws ArgumentError sqrt(S)
    @test_throws ArgumentError sqrt(LinearAlgebra.Symmetric(S))
    @test_throws ArgumentError LinearAlgebra.Symmetric(S)^0.5
    @test_throws ArgumentError LinearAlgebra.svd(LinearAlgebra.Symmetric(S))
    σ = LinearAlgebra.svdvals(LinearAlgebra.Symmetric(S))
    @test in_interval(3, σ[1]) && in_interval(1, σ[2]) && in_interval(2.0^-50, σ[3])
    @test all(isequal_interval.(LinearAlgebra.Symmetric(S)^2, S * S))
    @test all(isequal_interval.(LinearAlgebra.Symmetric(S)^2.0, S * S))
    @test all(isequal_interval.(exp(LinearAlgebra.Symmetric(A_small)), exp(A_small)))
    @test all(isequal_interval.(log(LinearAlgebra.Symmetric(A_small)), log(A_small)))
end

@testset "inv" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    iA = inv(A)
    @test in_interval(-2, iA[1, 1]) & in_interval(1, iA[1, 2]) & in_interval(1.5, iA[2, 1]) & in_interval(-0.5, iA[2, 2])
    P = iA * A
    @test in_interval(1, P[1, 1]) & in_interval(0, P[1, 2]) & in_interval(0, P[2, 1]) & in_interval(1, P[2, 2])
    @test all(isguaranteed, iA)
    ANG = copy(A)
    ANG[1, 1] = interval(1) + 1
    @test all(x -> !isguaranteed(x), inv(ANG))
    @test inv(complex.(A, interval(0))) isa Matrix{Complex{Interval{Float64}}}
    @test all(isnai, inv(A .+ interval(-1, 1)))
end

@testset "Matrix inversion" begin
    IntervalArithmetic.configure(; matmul = :slow)
    try
        @test IntervalArithmetic.configuration_options.matmul === :slow
        @test Base.invokelatest(IntervalArithmetic.default_matmul) === IntervalArithmetic.MatMulMode{:slow}()
        A = [interval(2) interval(1, 2) ; interval(0) interval(1)]
        @test all(isequal_interval.(Base.invokelatest(inv, A), [interval(0, 1) interval(-1.25, -0.25) ; interval(-0.5, 0.5) interval(0.5, 1.5)]))
        B = [interval(2) interval(1, 2) ; interval(0) interval(0, 1)]
        @test all(isnai, Base.invokelatest(inv, B))
    finally
        IntervalArithmetic.configure(; matmul = :fast)
    end
end

@testset "exp and log" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    eA = exp(A)
    @test eA isa Matrix{Interval{Float64}}
    @test all(in_interval.(exp([1.0 2.0; 3.0 4.0]), eA))
    B = copy(A)
    LinearAlgebra.exp!(B)
    @test all(B .=== A)
    @test exp(complex.(A, interval(0))) isa Matrix{Complex{Interval{Float64}}}

    L = interval.([2.0 0.0; 0.0 3.0])
    lg = log(L)
    @test lg isa Matrix{Interval{Float64}}
    @test in_interval(log(2), lg[1, 1]) & in_interval(log(3), lg[2, 2])
    @test all(isnai, log([interval(-0.1, 0.1) interval(0); interval(0) interval(2)]))
    lgn = log(interval.([-2.0 0.0; 0.0 3.0]))
    @test lgn isa Matrix{Complex{Interval{Float64}}}
    @test in_interval(log(2), real(lgn[1, 1])) & in_interval(π, imag(lgn[1, 1]))
    @test log(complex.(L, interval(0))) isa Matrix{Complex{Interval{Float64}}}
    Pw = interval.([2.0 0.1; 0.1 3.0])
    @test all(issubset_interval.(Pw, exp(log(Pw))))
end

@testset "Matrix multiplication :slow" begin
    IntervalArithmetic.configure(; matmul = :slow)
    try
        @test IntervalArithmetic.configuration_options.matmul === :slow
        @test Base.invokelatest(IntervalArithmetic.default_matmul) === IntervalArithmetic.MatMulMode{:slow}()

        A = [interval(2, 4)  interval(-2, 1)
             interval(-1, 2) interval(2, 4)]

        b = [interval(-2, 2)
             interval(-2, 2)]

        # exact for the generic algorithm; Rump's `:fast` algorithm widens the diagonal to [-2, 19.5]
        @test all(isequal_interval.(Base.invokelatest(*, A, A), [interval(0, 18) interval(-16, 8) ; interval(-8, 16) interval(0, 18)]))

        @test all(isequal_interval.(Base.invokelatest(*, A, b), [interval(-12, 12), interval(-12, 12)]))
        @test_throws IntervalArithmetic.InconclusiveBooleanOperation Base.invokelatest(\, A, b)

        @test all(isequal_interval.(interval.([1 2; 3 4]) * interval(-1, 1), [interval(-1, 1) interval(-2, 2) ; interval(-3, 3) interval(-4, 4)]))

        n = 100
        Aid = interval.(Matrix(1.0 * I, n, n))
        Bones = interval.(ones(n, n))
        @test all(isequal_interval.(Base.invokelatest(*, Aid, Bones), Bones))
        @test all(isequal_interval.(Base.invokelatest(*, Bones, Bones), interval.(fill(100.0, n, n))))

        e00 = Matrix{Interval{Float64}}(undef, 0, 0)
        @test size(Base.invokelatest(*, e00, e00)) == (0, 0)
        @test isequal_interval(Base.invokelatest(*, interval.(fill(2.0, 1, 1)), interval.(fill(3.0, 1, 1)))[1, 1], interval(6))
        @test isequal_interval(Base.invokelatest(*, interval.(reshape([1.0, 2.0], 1, 2)), interval.(reshape([3.0, 4.0], 2, 1)))[1, 1], interval(11))
        @test size(Base.invokelatest(*, interval.(reshape([1.0, 2.0], 2, 1)), interval.(fill(3.0, 1, 1)))) == (2, 1)
    finally
        IntervalArithmetic.configure(; matmul = :fast)
    end
end

@testset "Matrix multiplication :fast" begin
    IntervalArithmetic.configure(; matmul = :fast)
    try
        @test IntervalArithmetic.configuration_options.matmul === :fast
        @test Base.invokelatest(IntervalArithmetic.default_matmul) === IntervalArithmetic.MatMulMode{:fast}()

        A = [interval(2, 4) interval(-2, 1) ; interval(-1, 2) interval(2, 4)]
        imA = interval(im) * A

        @test all(issubset_interval.([interval(0, 18) interval(-16, 8) ; interval(-8, 16) interval(0, 18)], Base.invokelatest(*, A, A)))
        @test all(issubset_interval.([interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], Base.invokelatest(*, A, mid.(A))))
        @test all(issubset_interval.([interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], Base.invokelatest(*, mid.(A), A)))

        @test all(issubset_interval.([interval(-18, 0) interval(-8, 16) ; interval(-16, 8) interval(-18, 0)], Base.invokelatest(*, imA, imA)))
        @test all(issubset_interval.(interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], Base.invokelatest(*, mid.(A), imA)))
        @test all(issubset_interval.(interval(im)*[interval(5, 12.5) interval(-8, 2) ; interval(-2, 8) interval(5, 12.5)], Base.invokelatest(*, imA, mid.(A))))

        e00 = Matrix{Interval{Float64}}(undef, 0, 0)
        @test size(Base.invokelatest(*, e00, e00)) == (0, 0)
        @test isequal_interval(Base.invokelatest(*, interval.(fill(2.0, 1, 1)), interval.(fill(3.0, 1, 1)))[1, 1], interval(6))
        @test isequal_interval(Base.invokelatest(*, interval.(reshape([1.0, 2.0], 1, 2)), interval.(reshape([3.0, 4.0], 2, 1)))[1, 1], interval(11))
        @test size(Base.invokelatest(*, interval.(reshape([1.0, 2.0], 2, 1)), interval.(fill(3.0, 1, 1)))) == (2, 1)
    finally
        IntervalArithmetic.configure(; matmul = :fast)
    end
end

@testset "mul!" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    B = [interval(2, 4) interval(-2, 1); interval(-1, 2) interval(2, 4)]
    C = A * B
    C2 = similar(C)
    @test mul!(C2, A, B) === C2
    @test all(C2 .=== C)

    C3 = copy(B); mul!(C3, A, B, 0, 0)
    @test all(x -> isequal_interval(x, interval(0)), C3)
    C3 = copy(B); mul!(C3, A, B, interval(0), interval(1))
    @test all(C3 .=== B)
    C3 = copy(B); mul!(C3, A, B, 0, 2)
    @test all(isequal_interval.(C3, B .* 2))
    C3 = copy(B); mul!(C3, A, B, 1, 1)
    @test all(isequal_interval.(C3, C .+ B))
    C3 = copy(B); mul!(C3, A, B, 2, 0)
    @test all(isequal_interval.(C3, C .* 2))
    C3 = copy(B); mul!(C3, A, B, 2, 3)
    @test all(isequal_interval.(C3, C .* 2 .+ B .* 3))

    v = [interval(1), interval(2)]
    @test all(isequal_interval.(A * v, [interval(5), interval(11)]))
    cv = copy(v); mul!(cv, A, v, 2, 3)
    @test all(isequal_interval.(cv, (A * v) .* 2 .+ v .* 3))

    @test_throws DimensionMismatch mul!(similar(C), A, interval.(ones(3, 3)), 1, 0)
    @test_throws DimensionMismatch mul!(similar(v), A, interval.(ones(3)), 1, 0)
end

@testset "NG flag propagation" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    B = [interval(2, 4) interval(-2, 1); interval(-1, 2) interval(2, 4)]
    @test all(isguaranteed, A * B)
    ANG = copy(A)
    ANG[1, 1] = interval(1) + 1
    @test all(x -> !isguaranteed(x), ANG * B)
    @test all(x -> !isguaranteed(x), A * (interval(1) + 1))
    BNG = copy(B)
    BNG[2, 2] = interval(1) + 1
    @test all(x -> !isguaranteed(x), A * BNG)
    Cng = similar(A)
    mul!(Cng, A, B, interval(1) + 1, interval(0))
    @test all(x -> !isguaranteed(x), Cng)
    mul!(Cng, A, B, interval(1), interval(0) + 0)
    @test all(x -> !isguaranteed(x), Cng)
    @test all(x -> !isguaranteed(x), complex.(ANG, interval(0)) * complex.(B, B))

    ext = Base.get_extension(IntervalArithmetic, :IntervalArithmeticLinearAlgebraExt)
    r = [interval(1), interval(2)]
    ext._ensure_ng_flag!(r, false)
    @test all(x -> !isguaranteed(x), r)
    z = [complex(interval(1), interval(2))]
    ext._ensure_ng_flag!(z, false)
    @test !isguaranteed(real(z[1])) & !isguaranteed(imag(z[1]))
    ext._ensure_ng_flag!(z, true)
    @test isguaranteed(z[1])
end

@testset "Fast multiplication coverage" begin
    A = interval.([1.0 2.0; 3.0 4.0])
    B = [interval(2, 4) interval(-2, 1); interval(-1, 2) interval(2, 4)]
    iA = complex.(A, A)
    iB = complex.(B, B)
    cf = [complex(1.0, 2.0) complex(0.0, 0.0); complex(0.0, 0.0) complex(3.0, 4.0)]
    rf = [1.0 2.0; 3.0 4.0]
    mAB = [3.0 -0.5; 0.5 3.0]

    @test all(in_interval.(rf * mAB, A * B))
    @test all(in_interval.(rf * rf, A * rf))
    @test all(in_interval.(rf * rf, rf * A))
    @test all(in_interval.(complex.(rf, rf) * complex.(mAB, mAB), iA * iB))
    @test all(in_interval.(complex.(rf, rf) * cf, iA * cf))
    @test all(in_interval.(cf * complex.(mAB, mAB), cf * iB))
    @test all(in_interval.(complex.(rf, rf) * mAB, iA * B))
    @test all(in_interval.(complex.(rf, rf) * rf, iA * rf))
    @test all(in_interval.(cf * mAB, cf * B))
    @test all(in_interval.(rf * complex.(mAB, mAB), A * iB))
    @test all(in_interval.(rf * complex.(mAB, mAB), rf * iB))
    @test all(in_interval.(mAB * cf, B * cf))

    A32 = interval.(Float32[1 2; 3 4])
    @test A32 * A32 isa Matrix{Interval{Float32}}
    @test all(in_interval.(Float32[7 10; 15 22], A32 * A32))
    @test all(isequal_interval.(view(A, 1:2, 1:2) * B, A * B))
    @test all(in_interval.(rf' * mAB, A' * B))
    @test all(in_interval.(rf * mAB, [1.0 2.0; 3.0 4.0] * B))
    @test all(in_interval.(mAB * rf, B * [1.0 2.0; 3.0 4.0]))
end

@testset "Fast multiplication fallbacks" begin
    Abig = interval.(big.([1.0 2.0; 3.0 4.0]))
    Cbig = @test_logs (:info,) Abig * Abig
    @test all(isequal_interval.(Cbig, interval.(big.([7.0 10.0; 15.0 22.0]))))
    Arat = [interval(1//2) interval(1//3); interval(1//4) interval(1//5)]
    @test_logs (:info,) Arat * Arat
end

@testset "Fast multiplication internals" begin
    ext = Base.get_extension(IntervalArithmetic, :IntervalArithmeticLinearAlgebraExt)
    B = [interval(2, 4) interval(-2, 1); interval(-1, 2) interval(2, 4)]
    mB, rB = ext._vec_or_mat_midradius(B)
    @test all(rB .>= 0)
    @test all(big.(mB) .- big.(rB) .<= inf.(B))
    @test all(big.(mB) .+ big.(rB) .>= sup.(B))

    before = ext._getrounding()
    _ = interval.([1.0 2.0; 3.0 4.0]) * B
    @test ext._getrounding() == before

    @test ext._to_stride_64([1.0 2.0; 3.0 4.0]) == [1.0 2.0; 3.0 4.0]
    @test ext._to_stride_64(Float32[1 2; 3 4]) isa Matrix{Float64}
end
