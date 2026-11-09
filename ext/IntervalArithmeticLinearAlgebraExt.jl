module IntervalArithmeticLinearAlgebraExt

using IntervalArithmetic
import LinearAlgebra
import OpenBLASConsistentFPCSR_jll # 32-bit systems are not supported

# contructor for `UniformScaling`

IntervalArithmetic._interval_infsup(::Type{T}, J::LinearAlgebra.UniformScaling, H::LinearAlgebra.UniformScaling, d::IntervalArithmetic.Decoration) where {T<:IntervalArithmetic.NumTypes} =
    LinearAlgebra.UniformScaling(IntervalArithmetic._interval_infsup(T, J.λ, H.λ, d))

IntervalArithmetic._infer_numtype(J::LinearAlgebra.UniformScaling) = numtype(eltype(J))

IntervalArithmetic.exact(J::LinearAlgebra.UniformScaling) = LinearAlgebra.UniformScaling(exact(J.λ))

# by-pass generic `opnorm` from LinearAlgebra to prevent NG flag

function LinearAlgebra.opnorm1(A::AbstractMatrix{T}) where {T<:RealOrComplexI}
    LinearAlgebra.require_one_based_indexing(A)
    m, n = size(A)
    Tnorm = typeof(float(real(zero(T))))
    Tsum = promote_type(Float64, Tnorm)
    nrm = zero(Tsum)
    @inbounds begin
        for j = 1:n
            nrmj = zero(Tsum)
            for i = 1:m
                nrmj += LinearAlgebra.norm(A[i,j])
            end
            nrm = max(nrm, nrmj)
        end
    end
    return convert(Tnorm, nrm)
end

LinearAlgebra.opnorm2(A::AbstractMatrix{T}) where {T<:RealOrComplexI} = sqrt(maximum(abs, LinearAlgebra.eigvals(adjoint(A)*A)))

function LinearAlgebra.opnormInf(A::AbstractMatrix{T}) where {T<:RealOrComplexI}
    LinearAlgebra.require_one_based_indexing(A)
    m, n = size(A)
    Tnorm = typeof(float(real(zero(T))))
    Tsum = promote_type(Float64, Tnorm)
    nrm = zero(Tsum)
    @inbounds begin
        for i = 1:m
            nrmi = zero(Tsum)
            for j = 1:n
                nrmi += LinearAlgebra.norm(A[i,j])
            end
            nrm = max(nrm, nrmi)
        end
    end
    return convert(Tnorm, nrm)
end

# matrix eigenvalues

const _EigenAlg = IntervalArithmetic.AbstractIntervalEigenAlg

function LinearAlgebra.eigvals!(A::AbstractMatrix{<:RealOrComplexI}; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    λ = _eigvals(alg, A, permute, scale, sortby)
    _ensure_ng_flag!(λ, all(isguaranteed, A))
    return λ
end

# more specific methods for `Symmetric` and `Hermitian` wrappers to take priority over
# the LinearAlgebra methods, which require `alg::LinearAlgebra.Algorithm` on Julia ≥ 1.12
const _SymHermInterval = Union{
    LinearAlgebra.Symmetric{<:Interval},
    LinearAlgebra.Symmetric{<:Complex{<:Interval}},
    LinearAlgebra.Hermitian{<:Interval},
    LinearAlgebra.Hermitian{<:Complex{<:Interval}}}

# the eigenvalues of Hermitian matrices are real, and so are the eigenvectors of real
# symmetric matrices
const _RealSymInterval = Union{LinearAlgebra.Symmetric{<:Interval},LinearAlgebra.Hermitian{<:Interval}}

_eigenvalues(::Union{_RealSymInterval,LinearAlgebra.Hermitian{<:Complex{<:Interval}}}, λ) = real.(λ)
_eigenvalues(::_SymHermInterval, λ) = λ

_eigenvectors(::_RealSymInterval, v) = real.(v)
_eigenvectors(::_SymHermInterval, v) = v

LinearAlgebra.eigvals(A::_SymHermInterval; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby) =
    LinearAlgebra.eigvals!(A; alg, sortby)

function LinearAlgebra.eigvals!(A::_SymHermInterval; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    λ = _eigenvalues(A, _eigvals(alg, A, true, true, sortby))
    _ensure_ng_flag!(λ, all(isguaranteed, A))
    return λ
end

# the Gershgorin circle theorem and the contraction mapping theorem are applied to the
# dense matrix, as the LinearAlgebra methods for the wrappers may throw for intervals
_dense(A) = A
_dense(A::_SymHermInterval) = Matrix(A)

# IntervalEigen (default): Gershgorin circle theorem intersected with Rohn, as neither of
# the two is always tighter than the other
function _eigvals(::IntervalArithmetic.IntervalEigen, A, permute, scale, sortby)
    box = _eigvals(IntervalArithmetic.IntervalEigenRohn(), A, permute, scale, sortby)
    λ = _eigvals_gershgorin(_dense(A), permute, scale, sortby)
    all(isbounded, λ) || return box
    return _intersect_eigbox.(λ, box)
end

_intersect_eigbox(λ::Interval, box::Interval) = _intersect_decorated(λ, box)
_intersect_eigbox(λ::Interval, box::Complex{<:Interval}) = _intersect_decorated(λ, real(box))
# `box` is real only if the matrix is real symmetric or Hermitian
_intersect_eigbox(λ::Complex{<:Interval}, box::Interval) = complex(_intersect_decorated(real(λ), box))
_intersect_eigbox(λ::Complex{<:Interval}, box::Complex{<:Interval}) =
    complex(_intersect_decorated(real(λ), real(box)), _intersect_decorated(imag(λ), imag(box)))

_intersect_decorated(x::Interval, y::Interval) =
    IntervalArithmetic.setdecoration(intersect_interval(x, y), min(decoration(x), decoration(y)))

_eigvals(alg::IntervalArithmetic.IntervalEigenContraction, A, permute, scale, sortby) =
    first(_eigen(alg, A, permute, scale, sortby))

function _eigvals(alg::Union{IntervalArithmetic.IntervalEigenRohn,IntervalArithmetic.IntervalEigenHertz}, A, permute, scale, sortby)
    n = LinearAlgebra.checksquare(A)
    _isbounded_matrix(A) || return fill(nai(complex(eltype(A))), n)
    return fill(_eigbox(A, alg), n)
end

function _eigvals_gershgorin(A::AbstractMatrix{<:Interval}, permute, scale, sortby)
    _isbounded_matrix(A) || return fill(nai(eltype(A)), LinearAlgebra.checksquare(A))
    λ, component = _gershgorin(A, permute, scale, sortby)
    _fold_conjugate!(λ, component)
    all(isthinzero ∘ imag, λ) && return real(λ)
    return λ
end

function _eigvals_gershgorin(A::AbstractMatrix{<:Complex{<:Interval}}, permute, scale, sortby)
    _isbounded_matrix(A) || return fill(nai(eltype(A)), LinearAlgebra.checksquare(A))
    return first(_gershgorin(A, permute, scale, sortby))
end

_isbounded_matrix(A) = all(x -> isbounded(real(x)) & isbounded(imag(x)), A)

function _gershgorin(A, permute, scale, sortby)
    # Gershgorin circle theorem: a connected component of `k` discs contains exactly `k`
    # eigenvalues, so each disc is replaced by the hull of its connected component
    B = _similarity_transform(A, permute, scale, sortby)
    c = LinearAlgebra.diag(B)
    T = real(eltype(c))
    v = Vector{Complex{T}}(undef, length(c))
    for j ∈ axes(B, 1)
        r = zero(T)
        for i ∈ axes(B, 2)
            if i ≠ j
                r += abs(B[i,j])
            end
        end
        # the disc is in the complex plane even if the matrix is real
        v[j] = complex(interval(real(c[j]), r; format = :midpoint), interval(imag(c[j]), r; format = :midpoint))
    end
    component = collect(eachindex(v))
    for i ∈ eachindex(v), j ∈ eachindex(v)
        if (component[i] ≠ component[j]) & !isdisjoint_interval(v[i], v[j])
            replace!(component, component[j] => component[i])
        end
    end
    for k ∈ unique(component)
        idxs = findall(==(k), component)
        v[idxs] .= Ref(reduce(_hull_decorated, view(v, idxs)))
    end
    return v, component
end

_hull_decorated(x::Interval, y::Interval) =
    IntervalArithmetic.setdecoration(hull(x, y), min(decoration(x), decoration(y)))
_hull_decorated(x::Complex{<:Interval}, y::Complex{<:Interval}) =
    complex(_hull_decorated(real(x), real(y)), _hull_decorated(imag(x), imag(y)))

function _similarity_transform(A, permute, scale, sortby)
    mA = mid.(A)
    mλ, mV = LinearAlgebra.eigen(mA; permute = permute, scale = scale, sortby = sortby)
    # note: `mλ` is real for Hermitian `mA`, while the correction may be complex
    mλ = mλ + LinearAlgebra.diag(mV \ (mA * mV - mV * LinearAlgebra.Diagonal(mλ)))
    Λ = LinearAlgebra.Diagonal(interval(mλ))
    V = interval(mV)
    V .= Λ .+ inv(V) * (A * V - V * Λ)
    return V
end

# the eigenvalues of a real matrix come in conjugate pairs: the conjugate of an eigenvalue
# in the component of `λ[i]` lies in one of the components intersecting `conj(λ[i])`
function _fold_conjugate!(λ, component)
    μ = copy(λ)
    for i ∈ eachindex(λ)
        idxs = findall(j -> !isdisjoint_interval(conj(μ[i]), μ[j]), eachindex(μ))
        if idxs == [i]
            # the only eigenvalue of the component is its own conjugate
            λ[i] = complex(real(μ[i]))
        elseif !isempty(idxs)
            z = conj(reduce(_hull_decorated, view(μ, idxs)))
            λ[i] = complex(_intersect_decorated(real(μ[i]), real(z)), _intersect_decorated(imag(μ[i]), imag(z)))
        end
    end
    return λ
end

# matrix determinant

LinearAlgebra.det(A::AbstractMatrix{<:Interval}) = real(reduce(*, LinearAlgebra.eigvals(A)))
LinearAlgebra.det(A::AbstractMatrix{<:Complex{<:Interval}}) = reduce(*, LinearAlgebra.eigvals(A))

# matrix eigendecomposition

LinearAlgebra.eigen(A::AbstractMatrix{<:RealOrComplexI}; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby) =
    LinearAlgebra.eigen!(A; alg, permute, scale, sortby)

LinearAlgebra.eigen(A::_SymHermInterval; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby) =
    LinearAlgebra.eigen!(A; alg, sortby)

function LinearAlgebra.eigen!(A::_SymHermInterval; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    true_λ, true_v = _eigen(alg, A, true, true, sortby)
    ng_flag = all(isguaranteed, A)
    true_λ = _ensure_ng_flag!(_eigenvalues(A, true_λ), ng_flag)
    true_v = _ensure_ng_flag!(_eigenvectors(A, true_v), ng_flag)
    return LinearAlgebra.Eigen(true_λ, true_v)
end

function LinearAlgebra.eigen!(A::AbstractMatrix{<:RealOrComplexI}; alg::_EigenAlg=IntervalArithmetic.IntervalEigen(), permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    true_λ, true_v = _eigen(alg, A, permute, scale, sortby)
    ng_flag = all(isguaranteed, A)
    _ensure_ng_flag!(true_λ, ng_flag)
    _ensure_ng_flag!(true_v, ng_flag)
    return LinearAlgebra.Eigen(true_λ, true_v)
end

# IntervalEigen (default): contraction mapping theorem, falls back to the eigenvalues of
# `IntervalEigen` and NaI eigenvectors on failure
function _eigen(alg::IntervalArithmetic.IntervalEigen, A, permute, scale, sortby)
    _isbounded_matrix(A) || return _eigen_nai(A)
    contraction_ok, true_λ, true_v = _eigen_contraction(_dense(A), permute, scale, sortby)
    contraction_ok && return true_λ, true_v
    λ = _eigvals(alg, A, permute, scale, sortby)
    return λ, fill(nai(complex(eltype(A))), length(λ), length(λ))
end

# IntervalEigenContraction: contraction mapping theorem only (NaI if it fails)
function _eigen(::IntervalArithmetic.IntervalEigenContraction, A, permute, scale, sortby)
    _isbounded_matrix(A) || return _eigen_nai(A)
    contraction_ok, true_λ, true_v = _eigen_contraction(_dense(A), permute, scale, sortby)
    contraction_ok && return true_λ, true_v
    return _eigen_nai(A)
end

function _eigen_nai(A)
    n = LinearAlgebra.checksquare(A)
    T = complex(eltype(A))
    return fill(nai(T), n), fill(nai(T), n, n)
end

# contraction mapping theorem: tight bounds when the entries of A have small radii, and
# A has simple eigenvalues

function _eigen_contraction(A, permute, scale, sortby)
    λ, v = LinearAlgebra.eigen!(mid.(A); permute, scale, sortby)
    n = length(λ)
    inds = [argmax(i -> abs(v[i,j]), 1:n) for j ∈ 1:n]
    ref_scale = [v[inds[j],j] for j ∈ 1:n]
    foreach(j -> v[:,j] ./= ref_scale[j], 1:n)
    λ_bar, v_bar = interval(λ), interval(v)

    F = [[v_bar[inds[j],j] - interval(1) for j ∈ 1:n] ; vec(A * v_bar - v_bar * LinearAlgebra.Diagonal(λ_bar))]
    DF = zeros(eltype(F), n+n^2, n+n^2)
    for j ∈ 1:n
        DF[j,n+inds[j]+(j-1)*n] = interval(1)
        DF[n+(j-1)*n+1:n+j*n,j] .= .- v_bar[:,j]
        DF[n+(j-1)*n+1:n+j*n,n+(j-1)*n+1:n+j*n] .= A - LinearAlgebra.UniformScaling(λ_bar[j])
    end

    # `mid.(DF)` is singular when `mid.(A)` has repeated eigenvalues
    lu_mid_DF = LinearAlgebra.lu(mid.(DF); check = false)
    LinearAlgebra.issuccess(lu_mid_DF) || return false, nothing, nothing
    approx_DF⁻¹ = interval(inv(lu_mid_DF))
    Y = LinearAlgebra.norm(approx_DF⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(approx_DF⁻¹ * DF - interval(LinearAlgebra.I), Inf)
    Z₂ = interval(2) * LinearAlgebra.opnorm(approx_DF⁻¹, Inf)

    if strictprecedes(Z₁, one(Z₁)) & precedes(interval(2) * Y * Z₂, (interval(1) - Z₁)^2)
        r = sup(( interval(1) - Z₁ - sqrt( (interval(1) - Z₁)^2 - interval(2) * Y * Z₂ ) ) / Z₂)
        true_λ = interval.(λ, r; format = :midpoint)
        true_v = interval.(v, r; format = :midpoint)
        _fold_conjugate!(eltype(A), true_λ, true_v)
        foreach(j -> true_v[:,j] .*= interval(ref_scale[j]), 1:n)
        return true, true_λ, true_v
    else
        return false, nothing, nothing
    end
end

_fold_conjugate!(::Type{<:ComplexI}, λ, v) = (λ, v)

function _fold_conjugate!(::Type{<:Interval}, λ, v)
    for i ∈ eachindex(λ)
        λᵢ = λ[i]
        idxs = findall(j -> (j ≠ i) & !isdisjoint_interval(conj(λᵢ), λ[j]), eachindex(λ))
        if isempty(idxs)
            λ[i] = real(λᵢ)
            v[:,i] .= real.(view(v, :, i))
        else
            w = view(λ, idxs)
            z = conj(intersect_interval(conj(λᵢ), reduce(intersect_interval, w)))
            z = complex(IntervalArithmetic.setdecoration(real(z), min(decoration(real(λᵢ)), minimum(decoration ∘ real, w))), IntervalArithmetic.setdecoration(imag(z), min(decoration(imag(λᵢ)), minimum(decoration ∘ imag, w))))
            λ[i] = z
        end
    end
    return λ, v
end

# eigenvalue enclosure: a single interval enclosing all the eigenvalues, NaI eigenvectors

function _eigen(alg::Union{IntervalArithmetic.IntervalEigenRohn,IntervalArithmetic.IntervalEigenHertz}, A, permute, scale, sortby)
    λ = _eigvals(alg, A, permute, scale, sortby)
    n = length(λ)
    return λ, fill(nai(complex(eltype(A))), n, n)
end

# The Rohn method, Hertz method, Orthants iterator, and the reduction of
# general/complex/Hermitian matrices to the symmetric case are derived from
# IntervalLinearAlgebra.jl (https://github.com/JuliaIntervals/IntervalLinearAlgebra.jl)
# Copyright (c) 2021 Luca Ferranti, MIT License.
# See: Hladík, Daney, Tsigaridas, "Bounds on real eigenvalues and singular values
# of interval matrices", APNUM 2013 (https://doi.org/10.1016/j.apnum.2012.09.003).

struct _Orthants
    n::Int
end

Base.length(O::_Orthants) = 2^(O.n)

function Base.iterate(O::_Orthants, state=1)
    state > 2 ^ O.n && return nothing
    vec = -2*digits(state-1, base=2, pad=O.n) .+ 1
    return (vec, state+1)
end

# rigorous bounds on the extreme eigenvalues of a symmetric matrix of floats
# note: call the Gershgorin enclosure directly to avoid the intersection with Rohn

function _eigrange(A::AbstractMatrix{<:AbstractFloat})
    λ = _eigvals_gershgorin(interval(A), true, true, LinearAlgebra.eigsortby)
    return minimum(x -> inf(real(x)), λ), maximum(x -> sup(real(x)), λ)
end

# Rohn: fast eigenvalue enclosure for symmetric interval matrices

function _eigbox(A::LinearAlgebra.Symmetric{Interval{T}}, ::IntervalArithmetic.IntervalEigenRohn) where {T}
    λmin, λmax = _eigrange(mid.(Matrix(A)))
    ρ = last(_eigrange(radius.(Matrix(A))))
    return interval(λmin, λmax) + interval(-ρ, ρ)
end

# Hertz: exact hull for symmetric interval matrices (exponential complexity)

function _eigbox(A::LinearAlgebra.Symmetric{Interval{T}}, ::IntervalArithmetic.IntervalEigenHertz) where {T}
    n = LinearAlgebra.checksquare(A)
    Amax = Matrix{T}(undef, n, n)
    Amin = Matrix{T}(undef, n, n)

    λmin = T(Inf)
    λmax = T(-Inf)
    @inbounds for z in _Orthants(n)
        first(z) < 0 && continue
        for j in 1:n
            for i in 1:n
                if z[i] == z[j]
                    Amax[i, j] = sup(A[i, j])
                    Amin[i, j] = inf(A[i, j])
                else
                    Amax[i, j] = inf(A[i, j])
                    Amin[i, j] = sup(A[i, j])
                end
            end
        end

        λmin = min(λmin, first(_eigrange(Amin)))
        λmax = max(λmax, last(_eigrange(Amax)))
    end
    return interval(λmin, λmax)
end

# eigenvalue enclosure for general and complex interval matrices (reduced to symmetric case)
# note: a plain matrix contains non-symmetric matrices even if its entries are symmetric,
# only the `Symmetric` and `Hermitian` wrappers restrict to the symmetric ones

_eigbox(A::LinearAlgebra.Hermitian{<:Interval}, alg) = _eigbox(LinearAlgebra.Symmetric(Matrix(A)), alg)

function _eigbox(M::LinearAlgebra.Hermitian{<:Complex{<:Interval}}, alg)
    # the eigenvalues of `M` are those of the real symmetric matrix `[A B'; B A]`
    A = real.(Matrix(M))
    B = imag.(Matrix(M))
    return _eigbox(LinearAlgebra.Symmetric([A B'; B A]), alg)
end

_eigbox(A::LinearAlgebra.Symmetric{<:Complex{<:Interval}}, alg) = _eigbox(Matrix(A), alg)

function _eigbox(A::AbstractMatrix{Interval{T}}, alg) where {T}
    half = interval(T, 1//2)
    λ = _eigbox(LinearAlgebra.Symmetric(half * (A + A')), alg)

    n = size(A, 1)
    S = half * (A - A')
    Z = zeros(Interval{T}, n, n)
    μ = _eigbox(LinearAlgebra.Symmetric([Z S'; S Z]), alg)

    return complex(λ, μ)
end

function _eigbox(M::AbstractMatrix{Complex{Interval{T}}}, alg) where {T}
    A = real.(M)
    B = imag.(M)
    half = interval(T, 1//2)
    λ = _eigbox(LinearAlgebra.Symmetric(half * [A+A' B'-B; B-B' A+A']), alg)
    μ = _eigbox(LinearAlgebra.Symmetric(half * [B+B' A-A'; A'-A B+B']), alg)
    return complex(λ, μ)
end

# matrix functions of `Symmetric` and `Hermitian` interval matrices
# note: the LinearAlgebra methods rely on `eigen`, but assume that the eigenvectors are
# orthonormal and that the eigenvalues are accurate up to roundoff errors (e.g. `sqrt`
# rounds slightly negative eigenvalues to zero), which is not rigorous

Base.exp(A::_SymHermInterval) = exp(Matrix(A))
Base.log(A::_SymHermInterval) = log(Matrix(A))

for f ∈ (:sqrt, :cbrt, :cis, :cos, :sin, :tan, :cosh, :sinh, :tanh, :acos, :asin, :atan, :acosh, :asinh, :atanh, :sincos)
    @eval Base.$f(::_SymHermInterval; kwargs...) = _throw_matrix_function($f)
end

Base.:^(A::_SymHermInterval, p::Integer) = Matrix(A)^p
Base.:^(A::_SymHermInterval, p::Real) = isinteger(p) ? Matrix(A)^Integer(p) : _throw_matrix_function(^)

# note: `svdvals` is rigorous as it only relies on `eigvals`
LinearAlgebra.svd(::_SymHermInterval; full::Bool=false) = _throw_matrix_function(LinearAlgebra.svd)

_throw_matrix_function(f) = throw(ArgumentError("`$f` is not supported for `Symmetric` or `Hermitian` interval matrices"))

# matrix inversion
# note: use the contraction mapping theorem, only works when the entries of A have small radii

function Base.inv(A::Matrix{<:RealOrComplexI})
    mid_A = mid.(A)
    approx_A⁻¹ = interval(inv(mid_A))
    F = A * approx_A⁻¹ - interval(LinearAlgebra.I)
    Y = LinearAlgebra.norm(approx_A⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(F, 1)
    A⁻¹ = Matrix{eltype(A)}(undef, size(A))
    if isbounded(Y) & strictprecedes(Z₁, one(Z₁))
        r = sup(Y / (one(Z₁) - Z₁))
        A⁻¹ .= interval.(approx_A⁻¹, r; format = :midpoint)
    else
        A⁻¹ .= nai(eltype(approx_A⁻¹))
    end
    _ensure_ng_flag!(A⁻¹, all(isguaranteed, A))
    return A⁻¹
end

# matrix exponential and logarithm

function LinearAlgebra.exp!(A::AbstractMatrix{T}) where {T<:RealOrComplexI}
    # note: this function does not overwrite `A`
    Λ, V = LinearAlgebra.eigen(A)
    V⁻¹ = inv(V)
    return _output_exp(T, V * LinearAlgebra.Diagonal(exp.(Λ)) * V⁻¹)
end
_output_exp(::Type{<:Interval}, A) = real(A) # exponential of a real matrix is always real
_output_exp(::Type{<:Complex{<:Interval}}, A) = A

function LinearAlgebra.log(A::AbstractMatrix{<:Interval})
    Λ, V = LinearAlgebra.eigen(A)
    any(x -> in_interval(0, x), Λ) && return fill(nai(eltype(A)), size(A))
    V⁻¹ = inv(V)
    any(x -> isreal(x) & precedes(real(x), interval(0)), Λ) && return V * LinearAlgebra.Diagonal(log.(complex.(Λ))) * V⁻¹
    return real(V * LinearAlgebra.Diagonal(log.(Λ)) * V⁻¹)
end

function LinearAlgebra.log(A::AbstractMatrix{<:ComplexI})
    Λ, V = LinearAlgebra.eigen(A)
    any(x -> in_interval(0, x), Λ) && return fill(nai(eltype(A)), size(A))
    V⁻¹ = inv(V)
    return V * LinearAlgebra.Diagonal(log.(Λ)) * V⁻¹
end

# matrix multiplication

function LinearAlgebra.mul!(C::AbstractVector{<:RealOrComplexI}, A::AbstractVecOrMat, B::AbstractVector, α::Number, β::Number)
    size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
    return _mul!(IntervalArithmetic.default_matmul(), C, A, B, α, β)
end

function LinearAlgebra.mul!(C::AbstractMatrix{<:RealOrComplexI}, A::AbstractVecOrMat, B::AbstractVecOrMat, α::Number, β::Number)
    size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
    return _mul!(IntervalArithmetic.default_matmul(), C, A, B, α, β)
end

# disambiguate from the LinearAlgebra methods for structured matrices of Julia v1.10
if VERSION < v"1.11"
    const _StructuredMatrix = Union{LinearAlgebra.Bidiagonal,LinearAlgebra.Diagonal,LinearAlgebra.SymTridiagonal,LinearAlgebra.Tridiagonal}

    for (CT, AT, BT) ∈ (
            (:(AbstractMatrix{<:RealOrComplexI}), :AbstractMatrix,    :_StructuredMatrix),
            (:(AbstractMatrix{<:RealOrComplexI}), :_StructuredMatrix, :AbstractMatrix),
            (:(AbstractMatrix{<:RealOrComplexI}), :_StructuredMatrix, :_StructuredMatrix),
            (:(AbstractVector{<:RealOrComplexI}), :_StructuredMatrix, :AbstractVector))
        @eval function LinearAlgebra.mul!(C::$CT, A::$AT, B::$BT, α::Number, β::Number)
            size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
            return _mul!(IntervalArithmetic.default_matmul(), C, A, B, α, β)
        end
    end
end

#

LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVecOrMat{<:RealOrComplexI}) =
    LinearAlgebra.mul!(C, A, B, interval(true), interval(false))

function _mul!(::IntervalArithmetic.MatMulMode{:slow}, C, A::AbstractMatrix, B::AbstractVecOrMat, α, β)
    if iszero(α)
        if iszero(β)
            C .= zero(eltype(C))
        elseif !isone(β)
            C .*= β
        end
    else
        if iszero(β)
            _matmul_rec!(C, A, B)
            C .*= α
        else
            AB = Matrix{eltype(C)}(undef, size(A, 1), size(B, 2))
            C .= _matmul_rec!(AB, A, B) .* α .+ C .* β
        end
    end
    t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
    _ensure_ng_flag!(C, t)
    return C
end

function _matmul_rec!(C, A, B)
    m, n = size(A)
    p = size(B, 2)
    fill!(C, zero(eltype(C)))
    return _add_matmul_rec!(m, n, p, 0, 0, 0, C, A, B)
end

function _add_matmul_rec!(m, n, p, i0, j0, k0, C, A, B)
    if m + n + p ≤ 256 # naive matmul for sufficiently small matrices
        for i ∈ 1:m, k ∈ 1:p
            c = zero(eltype(C))
            for j ∈ 1:n
                @inbounds c += A[i0+i,j0+j] * B[j0+j,k0+k]
            end
            @inbounds C[i0+i,k0+k] += c
        end
    else
        m2 = m ÷ 2; n2 = n ÷ 2; p2 = p ÷ 2
        _add_matmul_rec!(m2, n2, p2, i0, j0, k0, C, A, B)

        _add_matmul_rec!(m-m2, n2, p2, i0+m2, j0, k0, C, A, B)
        _add_matmul_rec!(m2, n-n2, p2, i0, j0+n2, k0, C, A, B)
        _add_matmul_rec!(m2, n2, p-p2, i0, j0, k0+p2, C, A, B)

        _add_matmul_rec!(m-m2, n-n2, p2, i0+m2, j0+n2, k0, C, A, B)
        _add_matmul_rec!(m2, n-n2, p-p2, i0, j0+n2, k0+p2, C, A, B)
        _add_matmul_rec!(m-m2, n2, p-p2, i0+m2, j0, k0+p2, C, A, B)

        _add_matmul_rec!(m-m2, n-n2, p-p2, i0+m2, j0+n2, k0+p2, C, A, B)
    end
    return C
end

# fast matrix multiplication
# Note: Rump's algorithm

function _mul!(::IntervalArithmetic.MatMulMode{:fast}, C, A, B, α, β)
    if Int == Int32
        @info "Fast multiplication is not supported on 32-bit systems, using the slow version"
        return _mul!(IntervalArithmetic.MatMulMode{:slow}(), C, A, B, α, β)
    else
        numtype(eltype(C)) <: Union{Float16,Float32,Float64} && return _fastmul!(C, A, B, α, β)
        @info "Fast multiplication is only supported for `Union{Float16,Float32,Float64}`, using the slow version"
        return _mul!(IntervalArithmetic.MatMulMode{:slow}(), C, A, B, α, β)
    end
end

for (T, S) ∈ ((:Interval, :Interval), (:Interval, :Any), (:Any, :Interval))
    @eval function _fastmul!(C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
        CoefType = eltype(C)
        if iszero(α)
            if iszero(β)
                C .= zero(CoefType)
            elseif !isone(β)
                C .*= β
            end
        else
            BoundType = numtype(CoefType)
            C_inf, C_sup = __mul(A, B)
            if isone(α)
                if iszero(β)
                    C .=  interval.(BoundType, C_inf, C_sup)
                elseif isone(β)
                    C .+= interval.(BoundType, C_inf, C_sup)
                else
                    C .=  interval.(BoundType, C_inf, C_sup) .+ C .* β
                end
            else
                if iszero(β)
                    C .=  interval.(BoundType, C_inf, C_sup) .* α
                elseif isone(β)
                    C .+= interval.(BoundType, C_inf, C_sup) .* α
                else
                    C .=  interval.(BoundType, C_inf, C_sup) .* α .+ C .* β
                end
            end
        end
        t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
        _ensure_ng_flag!(C, t)
        return C
    end
end

for (T, S) ∈ ((:(Complex{<:Interval}), :(Complex{<:Interval})),
        (:(Complex{<:Interval}), :Complex), (:Complex, :(Complex{<:Interval})))
    @eval function _fastmul!(C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
        CoefType = eltype(C)
        if iszero(α)
            if iszero(β)
                C .= zero(CoefType)
            elseif !isone(β)
                C .*= β
            end
        else
            BoundType = numtype(CoefType)
            A_real, A_imag = reim(A)
            B_real, B_imag = reim(B)
            C₁_inf, C₁_sup = __mul(A_real, B_real)
            C₂_inf, C₂_sup = __mul(A_imag, B_imag)
            C₃_inf, C₃_sup = __mul(A_real, B_imag)
            C₄_inf, C₄_sup = __mul(A_imag, B_real)
            if isone(α)
                if iszero(β)
                    C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup))
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup))
                else
                    C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup)) .+ C .* β
                end
            else
                if iszero(β)
                    C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup)) .* α
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup)) .* α
                else
                    C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup) .- interval.(BoundType, C₂_inf, C₂_sup),
                                   interval.(BoundType, C₃_inf, C₃_sup) .+ interval.(BoundType, C₄_inf, C₄_sup)) .* α .+ C .* β
                end
            end
        end
        t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
        _ensure_ng_flag!(C, t)
        return C
    end
end

for (T, S) ∈ ((:(Complex{<:Interval}), :Interval), (:(Complex{<:Interval}), :Any), (:Complex, :Interval))
    @eval begin
        function _fastmul!(C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
            CoefType = eltype(C)
            if iszero(α)
                if iszero(β)
                    C .= zero(CoefType)
                elseif !isone(β)
                    C .*= β
                end
            else
                BoundType = numtype(CoefType)
                A_real, A_imag = reim(A)
                C₁_inf, C₁_sup = __mul(A_real, B)
                C₂_inf, C₂_sup = __mul(A_imag, B)
                if isone(α)
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup))
                    else
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α
                    else
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α .+ C .* β
                    end
                end
            end
            t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
            _ensure_ng_flag!(C, t)
            return C
        end

        function _fastmul!(C, A::AbstractMatrix{<:$S}, B::AbstractVecOrMat{<:$T}, α, β)
            CoefType = eltype(C)
            if iszero(α)
                if iszero(β)
                    C .= zero(CoefType)
                elseif !isone(β)
                    C .*= β
                end
            else
                BoundType = numtype(CoefType)
                B_real, B_imag = reim(B)
                C₁_inf, C₁_sup = __mul(A, B_real)
                C₂_inf, C₂_sup = __mul(A, B_imag)
                if isone(α)
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup))
                    else
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α
                    else
                        C .=  complex.(interval.(BoundType, C₁_inf, C₁_sup), interval.(BoundType, C₂_inf, C₂_sup)) .* α .+ C .* β
                    end
                end
            end
            t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
            _ensure_ng_flag!(C, t)
            return C
        end
    end
end

function __mul(A::AbstractMatrix{T}, B::AbstractVecOrMat{S}) where {T,S}
    NewType = float(IntervalArithmetic.promote_numtype(T, S))
    return __mul(interval.(NewType, A), interval.(NewType, B))
end

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    all(x -> iszero(radius(x)), A) && return ___mul(sup.(A), B)
    all(x -> iszero(radius(x)), B) && return ___mul(A, sup.(B))
    return ___mul(A, B)
end

function ___mul(A::AbstractMatrix{T}, B::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    mB, rB = _vec_or_mat_midradius(B)

    cache_1 = zeros(Float64, size(A, 1), size(B, 2))
    cache_2 = zeros(Float64, size(A, 1), size(B, 2))

    rC = _call_gem_openblas!(cache_1, _to_stride_64(abs.(A)), _to_stride_64(rB), RoundUp)

    stride_A  = _to_stride_64(A)
    stride_mB = _to_stride_64(mB)
    C₁ = IntervalArithmetic._fround.(-,
        T.(_call_gem_openblas!(cache_2, stride_A, stride_mB, RoundDown), RoundDown),
        T.(rC, RoundUp),
        RoundDown)
    C₂ = cache_2; C₂ .= IntervalArithmetic._fround.(+,
        T.(_call_gem_openblas!(cache_2, stride_A, stride_mB, RoundUp), RoundUp),
        T.(rC, RoundUp),
        RoundUp)

    return C₁, C₂
end

function ___mul(A::AbstractMatrix{Interval{T}}, B::AbstractVecOrMat{T}) where {T<:AbstractFloat}
    mA, rA = _vec_or_mat_midradius(A)

    cache_1 = zeros(Float64, size(A, 1), size(B, 2))
    cache_2 = zeros(Float64, size(A, 1), size(B, 2))

    rC = _call_gem_openblas!(cache_1, _to_stride_64(rA), _to_stride_64(abs.(B)), RoundUp)

    stride_mA = _to_stride_64(mA)
    stride_B  = _to_stride_64(B)
    C₁ = IntervalArithmetic._fround.(-,
        T.(_call_gem_openblas!(cache_2, stride_mA, stride_B, RoundDown), RoundDown),
        T.(rC, RoundUp),
        RoundDown)
    C₂ = cache_2; C₂ .= IntervalArithmetic._fround.(+,
        T.(_call_gem_openblas!(cache_2, stride_mA, stride_B, RoundUp), RoundUp),
        T.(rC, RoundUp),
        RoundUp)

    return C₁, C₂
end

function ___mul(A::AbstractMatrix{Interval{T}}, B::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    mA, rA = _vec_or_mat_midradius(A)
    mB, rB = _vec_or_mat_midradius(B)

    cache_1 = zeros(Float64, size(A, 1), size(B, 2))
    cache_2 = zeros(Float64, size(A, 1), size(B, 2))

    absmA_rB = _call_gem_openblas!(cache_1, _to_stride_64(abs.(mA)), _to_stride_64(rB), RoundUp)
    U = rB; U .= IntervalArithmetic._fround.(+, abs.(mB), rB, RoundUp)
    rA_U = _call_gem_openblas!(cache_2, _to_stride_64(rA), _to_stride_64(U), RoundUp)

    cache_3 = zeros(Float64, size(A, 1), size(B, 2))

    stride_mA = _to_stride_64(mA)
    stride_mB = _to_stride_64(mB)
    C₁ = IntervalArithmetic._fround.(-,
        T.(_call_gem_openblas!(cache_3, stride_mA, stride_mB, RoundDown), RoundDown),
        IntervalArithmetic._fround.(+, T.(absmA_rB, RoundUp), T.(rA_U, RoundUp), RoundUp),
        RoundDown)
    C₂ = cache_3; C₂ .= IntervalArithmetic._fround.(+,
        T.(_call_gem_openblas!(cache_3, stride_mA, stride_mB, RoundUp), RoundUp),
        IntervalArithmetic._fround.(+, T.(absmA_rB, RoundUp), T.(rA_U, RoundUp), RoundUp),
        RoundUp)

    return C₁, C₂
end

_to_stride_64(A::StridedArray{Float64}) = A
_to_stride_64(A::StridedArray{<:AbstractFloat}) = Float64.(A, RoundUp)
_to_stride_64(A::AbstractVector) = _to_stride_64(Vector(A))
_to_stride_64(A::AbstractMatrix) = _to_stride_64(Matrix(A))

function _vec_or_mat_midradius(A::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    mA = IntervalArithmetic._fround.(/, IntervalArithmetic._fround.(+, inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp)
    rA = IntervalArithmetic._fround.(-, mA, inf.(A), RoundUp)
    return mA, rA
end

#-

let fenv_consts = Vector{Cint}(undef, 9)
    ccall(:jl_get_fenv_consts, Cvoid, (Ptr{Cint},), fenv_consts)
    global const JL_FE_INEXACT   = fenv_consts[1]
    global const JL_FE_UNDERFLOW = fenv_consts[2]
    global const JL_FE_OVERFLOW  = fenv_consts[3]
    global const JL_FE_DIVBYZERO = fenv_consts[4]
    global const JL_FE_INVALID   = fenv_consts[5]

    global const JL_FE_TONEAREST  = fenv_consts[6]
    global const JL_FE_UPWARD     = fenv_consts[7]
    global const JL_FE_DOWNWARD   = fenv_consts[8]
    global const JL_FE_TOWARDZERO = fenv_consts[9]
end

if Sys.iswindows()
    _setrounding(i::Integer) = ccall((:fesetround, Base.libm_name), Cint, (Cint,), i)
    _getrounding() = ccall((:fegetround, Base.libm_name), Cint, ())
else
    _setrounding(i::Integer) = ccall(:fesetround, Cint, (Cint,), i)
    _getrounding() = ccall(:fegetround, Cint, ())
end

_to_rounding_mode(::RoundingMode{:Down}) = JL_FE_DOWNWARD
_to_rounding_mode(::RoundingMode{:Up})   = JL_FE_UPWARD

function _call_gem_openblas!(C, A::AbstractMatrix, B::AbstractMatrix, r::RoundingMode)
    m, k = size(A)
    n = size(B, 2)

    α = 1.0
    β = 0.0

    transA = 'N'
    transB = 'N'

    prev_rounding = _getrounding() # save current rounding mode
    _setrounding(_to_rounding_mode(r)) # set rounding mode to upward
    try
        ccall((:dgemm_64_, OpenBLASConsistentFPCSR_jll.libopenblas), Cvoid,
            (Ref{UInt8}, Ref{UInt8}, Ref{LinearAlgebra.BLAS.BlasInt}, Ref{LinearAlgebra.BLAS.BlasInt}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ref{Float64}, Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ref{Float64}, Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt}),
            transA, transB, m, n, k,
            α, A, max(1, stride(A, 2)),
            B, max(1, stride(B, 2)),
            β, C, max(1, stride(C, 2))
            )
        return C
    finally
        _setrounding(prev_rounding) # restore previous rounding mode
    end
end

function _call_gem_openblas!(C, A::AbstractMatrix, B::AbstractVector, r::RoundingMode)
    m, k = size(A)

    α = 1.0
    β = 0.0

    transA = 'N'

    prev_rounding = _getrounding() # save current rounding mode
    _setrounding(_to_rounding_mode(r)) # set rounding mode to upward
    try
        ccall((:dgemv_64_, OpenBLASConsistentFPCSR_jll.libopenblas), Cvoid,
            (Ref{UInt8}, Ref{LinearAlgebra.BLAS.BlasInt}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ref{Float64}, Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt},
                Ref{Float64}, Ptr{Float64}, Ref{LinearAlgebra.BLAS.BlasInt}),
            transA, m, k,
            α, A, max(1, stride(A, 2)),
            B, max(1, stride(B, 1)),
            β, C, max(1, stride(C, 1))
            )
        return C
    finally
        _setrounding(prev_rounding) # restore previous rounding mode
    end
end

# convenient function to propagate NG flag

function _ensure_ng_flag!(C::AbstractVecOrMat{<:Interval}, ng_flag::Bool)
    @inbounds @simd for i ∈ eachindex(C)
        C[i] = IntervalArithmetic._unsafe_interval(C[i].bareinterval, C[i].decoration, ng_flag)
    end
    return C
end

function _ensure_ng_flag!(C::AbstractVecOrMat{<:Complex{<:Interval}}, ng_flag::Bool)
    @inbounds @simd for i ∈ eachindex(C)
        C[i] = complex(
            IntervalArithmetic._unsafe_interval(real(C[i]).bareinterval, real(C[i]).decoration, ng_flag),
            IntervalArithmetic._unsafe_interval(imag(C[i]).bareinterval, imag(C[i]).decoration, ng_flag)
            )
    end
    return C
end

end
