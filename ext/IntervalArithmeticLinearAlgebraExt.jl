module IntervalArithmeticLinearAlgebraExt

using IntervalArithmetic
import LinearAlgebra
import OpenBLASConsistentFPCSR_jll # 32-bit systems are not supported

if Int != Int32
    # use the same number of threads as the default BLAS library
    ccall((:openblas_set_num_threads64_, OpenBLASConsistentFPCSR_jll.libopenblas),
        Cint, (Cint,),
        LinearAlgebra.BLAS.get_num_threads())
end

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

function LinearAlgebra.eigvals!(A::AbstractMatrix{<:Interval}; permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    v = _eigvals(A, permute, scale, sortby)
    isreal(v) && return v
    _fold_conjugate!(v)
    isreal(v) && return real(v)
    return v
end

LinearAlgebra.eigvals!(A::AbstractMatrix{<:Complex{<:Interval}}; permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby) =
    # note: this function does not overwrite `A`
    _eigvals(A, permute, scale, sortby)

function _eigvals(A, permute, scale, sortby)
    # Gershgorin circle theorem
    B = _similarity_transform(A, permute, scale, sortby)
    v = LinearAlgebra.diag(B)
    T = eltype(v)
    for j ∈ axes(B, 1)
        r = zero(T)
        for i ∈ axes(B, 2)
            if i ≠ j
                r += abs(B[i,j])
            end
        end
        v[j] = interval(v[j], r; format = :midpoint)
    end
    return v
end

function _similarity_transform(A, permute, scale, sortby)
    mA = mid.(A)
    mλ, mV = LinearAlgebra.eigen(mA; permute = permute, scale = scale, sortby = sortby)
    mλ .+= LinearAlgebra.diag(mV \ (mA * mV - mV * LinearAlgebra.Diagonal(mλ)))
    Λ = LinearAlgebra.Diagonal(interval(mλ))
    V = interval(mV)
    V .= Λ .+ inv(V) * (A * V - V * Λ)
    return V
end

function _fold_conjugate!(v)
    for i ∈ eachindex(v)
        vᵢ = v[i]
        idxs = findall(j -> (j ≠ i) & !isdisjoint_interval(conj(vᵢ), v[j]), eachindex(v))
        if isempty(idxs)
            v[i] = real(vᵢ)
        else
            w = view(v, idxs)
            z = conj(intersect_interval(conj(vᵢ), reduce(intersect_interval, w)))
            z = complex(IntervalArithmetic.setdecoration(real(z), min(decoration(real(vᵢ)), minimum(decoration ∘ real, w))), IntervalArithmetic.setdecoration(imag(z), min(decoration(imag(vᵢ)), minimum(decoration ∘ imag, w))))
            v[i] = z
        end
    end
    return v
end

# matrix determinant

LinearAlgebra.det(A::AbstractMatrix{<:Interval}) = real(reduce(*, LinearAlgebra.eigvals(A)))
LinearAlgebra.det(A::AbstractMatrix{<:Complex{<:Interval}}) = reduce(*, LinearAlgebra.eigvals(A))

# matrix eigendecomposition
# note: use the contraction mapping theorem, only works when the entries of A have small radii, and A has simple eigenvalues

function LinearAlgebra.eigen!(A::AbstractMatrix{<:RealOrComplexI}; permute::Bool=true, scale::Bool=true, sortby::Union{Function,Nothing}=LinearAlgebra.eigsortby)
    # note: this function does not overwrite `A`
    true_vls = _eigvals(A, permute, scale, sortby)
    vcs = LinearAlgebra.eigvecs(mid.(A); permute, scale, sortby)
    n = length(true_vls)
    inds = [argmax(i -> abs(vcs[i,j]), 1:n) for j ∈ 1:n]
    ref_scale = [vcs[inds[j],j] for j ∈ 1:n]
    foreach(j -> vcs[:,j] ./= ref_scale[j], 1:n)
    vcs_ = interval(vcs)

    F = [[vcs_[inds[j],j] - interval(1) for j ∈ 1:n] ; vec(A * vcs_ - vcs_ * LinearAlgebra.Diagonal(true_vls))]
    DF = zeros(eltype(F), n+n^2, n+n^2)
    for j ∈ 1:n
        DF[j,n+inds[j]+(j-1)*n] = interval(1)
        DF[n+(j-1)*n+1:n+j*n,j] .= .- vcs_[:,j]
        DF[n+(j-1)*n+1:n+j*n,n+(j-1)*n+1:n+j*n] .= A - LinearAlgebra.UniformScaling(true_vls[j])
    end

    approx_DF⁻¹ = interval(inv(mid.(DF)))
    Y = LinearAlgebra.norm(approx_DF⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(approx_DF⁻¹ * DF - interval(LinearAlgebra.I), Inf)

    true_vcs = Matrix{eltype(vcs_)}(undef, size(vcs))
    if isbounded(Y) & strictprecedes(Z₁, one(Z₁))
        r = sup(Y / (one(Z₁) - Z₁))
        true_vcs .= interval.(vcs, r; format = :midpoint)
        foreach(j -> true_vcs[:,j] .*= interval(ref_scale[j]), 1:n)
    else
        true_vcs .= nai(eltype(vcs))
    end
    _ensure_ng_flag!(true_vcs, all(isguaranteed, A))
    return LinearAlgebra.Eigen(true_vls, true_vcs)
end

# matrix inversion
# note: use the contraction mapping theorem, only works when the entries of A have small radii

function Base.inv(A::Matrix{<:RealOrComplexI})
    mid_A = mid.(A)
    approx_A⁻¹ = interval(inv(mid_A))
    F = A * approx_A⁻¹ - interval(LinearAlgebra.I)
    Y = LinearAlgebra.norm(approx_A⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(F, Inf)
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

function LinearAlgebra.exp!(A::AbstractMatrix{<:RealOrComplexI})
    # note: this function does not overwrite `A`
    Λ, V = LinearAlgebra.eigen(A)
    V⁻¹ = inv(V)
    return V * LinearAlgebra.Diagonal(exp.(Λ)) * V⁻¹
end

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
