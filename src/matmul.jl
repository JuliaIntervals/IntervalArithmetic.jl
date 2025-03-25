interval(::Type{T}, J::LinearAlgebra.UniformScaling, d::Decoration = com; format::Symbol = :infsup) where {T} =
    LinearAlgebra.UniformScaling(interval(T, J.λ, d; format = format))
interval(J::LinearAlgebra.UniformScaling, d::Decoration = com; format::Symbol = :infsup) =
    LinearAlgebra.UniformScaling(interval(J.λ, d; format = format))



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



# matrix inversion
# note: use the contraction mapping theorem, only works when the entries of A have small radii

function Base.inv(A::Matrix{<:RealOrComplexI})
    mid_A = mid.(A)
    approx_A⁻¹ = interval(inv(mid_A))
    F = A * approx_A⁻¹ - interval(LinearAlgebra.I)
    Y = LinearAlgebra.opnorm(approx_A⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(F, Inf)
    if isbounded(Y) & strictprecedes(Z₁, one(Z₁))
        A⁻¹ = interval.(approx_A⁻¹, inf(interval(mag(Y)) / (one(Z₁) - interval(mag(Z₁)))); format = :midpoint)
    else
        A⁻¹ = fill(nai(eltype(approx_A⁻¹)), size(A))
    end
    _ensure_ng_flag!(A⁻¹, all(isguaranteed, A))
    return A⁻¹
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
            z = complex(setdecoration(real(z), min(decoration(real(vᵢ)), minimum(decoration ∘ real, w))), setdecoration(imag(z), min(decoration(imag(vᵢ)), minimum(decoration ∘ imag, w))))
            v[i] = z
        end
    end
    return v
end



# matrix determinant

LinearAlgebra.det(A::AbstractMatrix{<:Interval}) = real(reduce(*, LinearAlgebra.eigvals(A)))
LinearAlgebra.det(A::AbstractMatrix{<:Complex{<:Interval}}) = reduce(*, LinearAlgebra.eigvals(A))



# matrix multiplication

"""
    MatMulMode

Matrix multiplication type.

Available mode types:
- `:slow` (default): generic algorithm.
- `:fast` : Rump's algorithm.
"""
struct MatMulMode{T} end

matmul_mode() = MatMulMode{:slow}()

# by-pass `similar` methods defined in array.jl
# note: written in this form to avoid by-passing the default behaviour for `Union{}`
Base.similar(a::Array{Interval{T},1})          where {T<:NumTypes} = zeros(Interval{T}, size(a, 1))
Base.similar(a::Array{Complex{Interval{T}},1}) where {T<:NumTypes} = zeros(Complex{Interval{T}}, size(a, 1))

Base.similar(a::Array{<:Any,1}, S::Type{Interval{T}})          where {T<:NumTypes} = zeros(S, size(a, 1))
Base.similar(a::Array{<:Any,1}, S::Type{Complex{Interval{T}}}) where {T<:NumTypes} = zeros(S, size(a, 1))

Base.similar(a::Array{Interval{T},2})          where {T<:NumTypes} = zeros(Interval{T}, size(a, 1), size(a, 2))
Base.similar(a::Array{Complex{Interval{T}},2}) where {T<:NumTypes} = zeros(Complex{Interval{T}}, size(a, 1), size(a, 2))

Base.similar(a::Array{<:Any,2}, S::Type{Interval{T}})          where {T<:NumTypes} = zeros(S, size(a, 1), size(a, 2))
Base.similar(a::Array{<:Any,2}, S::Type{Complex{Interval{T}}}) where {T<:NumTypes} = zeros(S, size(a, 1), size(a, 2))

Base.similar(::Array{Interval{T}},          m::Int) where {T<:NumTypes} = zeros(Interval{T}, m)
Base.similar(::Array{Complex{Interval{T}}}, m::Int) where {T<:NumTypes} = zeros(Complex{Interval{T}}, m)

Base.similar(::Array{Interval{T}},          dims::Dims) where {T<:NumTypes} = zeros(Interval{T}, dims)
Base.similar(::Array{Complex{Interval{T}}}, dims::Dims) where {T<:NumTypes} = zeros(Complex{Interval{T}}, dims)

Base.similar(::Array, S::Type{Interval{T}},          dims::Dims) where {T<:NumTypes} = zeros(S, dims)
Base.similar(::Array, S::Type{Complex{Interval{T}}}, dims::Dims) where {T<:NumTypes} = zeros(S, dims)
#

function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVecOrMat{<:RealOrComplexI})
    return LinearAlgebra.mul!(C, A, B, interval(true), interval(false))
end

for T ∈ (:AbstractVector, :AbstractMatrix) # needed to resolve method ambiguities
    @eval begin
        function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::$T{<:RealOrComplexI}, α::Number, β::Number)
            size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
            return _mul!(matmul_mode(), C, A, B, α, β)
        end

        function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix, B::$T{<:RealOrComplexI}, α::Number, β::Number)
            size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
            return _mul!(matmul_mode(), C, A, B, α, β)
        end

        function LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::$T, α::Number, β::Number)
            size(A, 2) == size(B, 1) || return throw(DimensionMismatch("The number of columns of A must match the number of rows of B."))
            return _mul!(matmul_mode(), C, A, B, α, β)
        end
    end
end

function _mul!(::MatMulMode{:slow}, C, A::AbstractMatrix, B::AbstractVecOrMat, α, β)
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
    if m + n + p ≤ 256 # base case: naive matmult for sufficiently large matrices
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

_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:Interval{<:Rational}}, B::AbstractVecOrMat{<:Interval{<:Rational}}, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)
_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:Interval{<:Rational}}, B::AbstractVecOrMat, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)
_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix, B::AbstractVecOrMat{<:Interval{<:Rational}}, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)

_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:Complex{<:Interval{<:Rational}}}, B::AbstractVecOrMat{<:Complex{<:Interval{<:Rational}}}, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)
_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:Complex{<:Interval{<:Rational}}}, B::AbstractVecOrMat{<:Interval{<:Rational}}, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)
_mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:Interval{<:Rational}}, B::AbstractVecOrMat{<:Complex{<:Interval{<:Rational}}}, α, β) =
    LinearAlgebra._mul!(C, A, B, α, β)

function _mul!(::MatMulMode{:fast}, C, A, B, α, β)
    Int != Int32 && return _fastmul!(C, A, B, α, β)
    @info "Fast multiplication is not supported on 32-bit systems, using the slow version"
    return _mul!(MatMulMode{:slow}(), C, A, B, α, β)
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
            mC, rC = __mul(A, B)
            if isone(α)
                if iszero(β)
                    C .=  interval.(BoundType, mC, rC; format = :midpoint)
                elseif isone(β)
                    C .+= interval.(BoundType, mC, rC; format = :midpoint)
                else
                    C .=  interval.(BoundType, mC, rC; format = :midpoint) .+ C .* β
                end
            else
                if iszero(β)
                    C .=  interval.(BoundType, mC, rC; format = :midpoint) .* α
                elseif isone(β)
                    C .+= interval.(BoundType, mC, rC; format = :midpoint) .* α
                else
                    C .=  interval.(BoundType, mC, rC; format = :midpoint) .* α .+ C .* β
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
            mC_1, rC_1 = __mul(A_real, B_real)
            mC_2, rC_2 = __mul(A_imag, B_imag)
            mC_3, rC_3 = __mul(A_real, B_imag)
            mC_4, rC_4 = __mul(A_imag, B_real)
            if isone(α)
                if iszero(β)
                    C .=  complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint))
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint))
                else
                    C .=  complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint)) .+ C .* β
                end
            else
                if iszero(β)
                    C .=  complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint)) .* α
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint)) .* α
                else
                    C .=  complex.(interval.(BoundType, mC_1, rC_1; format = :midpoint) .- interval.(BoundType, mC_2, rC_2; format = :midpoint),
                                   interval.(BoundType, mC_3, rC_3; format = :midpoint) .+ interval.(BoundType, mC_4, rC_4; format = :midpoint)) .* α .+ C .* β
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
                mC_real, rC_real = __mul(A_real, B)
                mC_imag, rC_imag = __mul(A_imag, B)
                if isone(α)
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint))
                    else
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α
                    else
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α .+ C .* β
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
                mC_real, rC_real = __mul(A, B_real)
                mC_imag, rC_imag = __mul(A, B_imag)
                if isone(α)
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint))
                    else
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α
                    else
                        C .=  complex.(interval.(BoundType, mC_real, rC_real; format = :midpoint), interval.(BoundType, mC_imag, rC_imag; format = :midpoint)) .* α .+ C .* β
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
    NewType = promote_numtype(T, S)
    return __mul(interval.(NewType, A), interval.(NewType, B))
end

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    k = size(A, 2)
    u2 = eps(T) # twice the unit roundoff
    @assert (2k + 2) * u2 ≤ 1

    mA, rA = _vec_or_mat_midradius(A)
    mB, rB = _vec_or_mat_midradius(B)

    cache_1 = zeros(T, size(A, 1), size(B, 2))
    cache_2 = zeros(T, size(A, 1), size(B, 2))
    mC, μ = _fused_matmul!(cache_1, cache_2, mA, rA, mB, rB)

    γ = _add_round.(_mul_round.(convert(T, k + 1), eps.(μ), RoundUp), IntervalArithmetic._mul_round(IntervalArithmetic._inv_round(u2, RoundUp), floatmin(T), RoundUp), RoundUp)

    U = mA; U .= _add_round.(abs.(mA), rA, RoundUp)
    V = mB; V .= _add_round.(abs.(mB), rB, RoundUp)

    cache_3 = zeros(T, size(A, 1), size(B, 2))
    rC = _call_gem_openblas_upward!(cache_3, U, V)
    rC .= _add_round.(_sub_round.(rC, μ, RoundUp), 2 .* γ, RoundUp)

    return mC, rC
end

function _vec_or_mat_midradius(A::AbstractVecOrMat{Interval{T}}) where {T<:AbstractFloat}
    mA = _div_round.(_add_round.(inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp)
    rA = _sub_round.(mA, inf.(A), RoundUp)
    return mA, rA
end

function _fused_matmul!(mC, μ, mA, rA, mB, rB)
    Threads.@threads for j ∈ axes(mB, 2)
        for l ∈ axes(mA, 2)
            @inbounds for i ∈ axes(mA, 1)
                a, c = mA[i,l], rA[i,l]
                b, d = mB[l,j], rB[l,j]
                e = sign(a) * min(abs(a), c)
                f = sign(b) * min(abs(b), d)
                p = a*b + e*f
                mC[i,j] += p
                μ[i,j] += abs(p)
            end
        end
    end
    return mC, μ
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

_2mat(A::LinearAlgebra.Diagonal) = Matrix(A)

_2mat(A) = A

function _call_gem_openblas_upward!(C, A_::AbstractMatrix{Float64}, B_::AbstractMatrix{Float64})
    A = _2mat(A_)
    B = _2mat(B_)

    m, k = size(A)
    n = size(B, 2)

    α = 1.0
    β = 0.0

    transA = 'N'
    transB = 'N'

    prev_rounding = _getrounding() # save current rounding mode
    _setrounding(JL_FE_UPWARD) # set rounding mode to upward
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

function _call_gem_openblas_upward!(C, A_::AbstractMatrix{Float64}, B_::AbstractVector{Float64})
    A = _2mat(A_)
    B = _2mat(B_)

    m, k = size(A)

    α = 1.0
    β = 0.0

    transA = 'N'

    prev_rounding = _getrounding() # save current rounding mode
    _setrounding(JL_FE_UPWARD) # set rounding mode to upward
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
        C[i] = _unsafe_interval(C[i].bareinterval, C[i].decoration, ng_flag)
    end
    return C
end

function _ensure_ng_flag!(C::AbstractVecOrMat{<:Complex{<:Interval}}, ng_flag::Bool)
    @inbounds @simd for i ∈ eachindex(C)
        C[i] = complex(
            _unsafe_interval(real(C[i]).bareinterval, real(C[i]).decoration, ng_flag),
            _unsafe_interval(imag(C[i]).bareinterval, imag(C[i]).decoration, ng_flag)
            )
    end
    return C
end
