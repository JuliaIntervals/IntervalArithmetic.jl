import LinearAlgebra



#

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
# Note: use the contraction mapping theorem, only works when the entries of A have small radii

function Base.inv(A::Matrix{<:RealOrComplexI})
    mid_A = mid.(A)
    approx_A⁻¹ = interval(inv(mid_A))
    F = A * approx_A⁻¹ - interval(LinearAlgebra.I)
    Y = LinearAlgebra.opnorm(approx_A⁻¹ * F, Inf)
    Z₁ = LinearAlgebra.opnorm(F, Inf)
    if isbounded(Y) & strictprecedes(Z₁, one(one(Z₁)))
        A⁻¹ = interval.(approx_A⁻¹, inf(interval(mag(Y)) / (one(Z₁) - interval(mag(Z₁)))); format = :midpoint)
    else
        A⁻¹ = fill(nai(eltype(approx_A⁻¹)), size(A))
    end
    _ensure_ng_flag!(A⁻¹, all(isguaranteed, A))
    return A⁻¹
end



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

#

function Base.:*(A::AbstractMatrix{<:RealOrComplexI}, B::AbstractMatrix{<:RealOrComplexI})
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1), size(B, 2))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end
function Base.:*(A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVector{<:RealOrComplexI})
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end

function Base.:*(A::AbstractMatrix{<:RealOrComplexI}, B::AbstractMatrix)
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1), size(B, 2))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end
function Base.:*(A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVector)
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end

function Base.:*(A::AbstractMatrix, B::AbstractMatrix{<:RealOrComplexI})
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1), size(B, 2))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end
function Base.:*(A::AbstractMatrix, B::AbstractVector{<:RealOrComplexI})
    T = promote_type(eltype(A), eltype(B))
    C = zeros(T, size(A, 1))
    return LinearAlgebra.mul!(C, A, B, one(T), zero(T))
end

LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVecOrMat{<:RealOrComplexI}, α::Number, β::Number) =
    _mul!(matmul_mode(), C, A, B, α, β)

LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix, B::AbstractVecOrMat{<:RealOrComplexI}, α::Number, β::Number) =
    _mul!(matmul_mode(), C, A, B, α, β)

LinearAlgebra.mul!(C::AbstractVecOrMat{<:RealOrComplexI}, A::AbstractMatrix{<:RealOrComplexI}, B::AbstractVecOrMat, α::Number, β::Number) =
    _mul!(matmul_mode(), C, A, B, α, β)

_mul!(::MatMulMode{:slow}, C, A, B, α, β) = LinearAlgebra._mul!(C, A, B, α, β)

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

for (T, S) ∈ ((:Interval, :Interval), (:Interval, :Any), (:Any, :Interval))
    @eval function _mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
        CoefType = eltype(C)
        if iszero(α)
            if iszero(β)
                C .= zero(CoefType)
            elseif !isone(β)
                C .*= β
            end
        else
            BoundType = numtype(CoefType)
            ABinf, ABsup = __mul(A, B)
            if isone(α)
                if iszero(β)
                    C .= interval.(BoundType, ABinf, ABsup)
                elseif isone(β)
                    C .+= interval.(BoundType, ABinf, ABsup)
                else
                    C .= interval.(BoundType, ABinf, ABsup) .+ C .* β
                end
            else
                if iszero(β)
                    C .= interval.(BoundType, ABinf, ABsup) .* α
                elseif isone(β)
                    C .+= interval.(BoundType, ABinf, ABsup) .* α
                else
                    C .= interval.(BoundType, ABinf, ABsup) .* α .+ C .* β
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
    @eval function _mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
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
            ABinf_1, ABsup_1 = __mul(A_real, B_real)
            ABinf_2, ABsup_2 = __mul(A_imag, B_imag)
            ABinf_3, ABsup_3 = __mul(A_real, B_imag)
            ABinf_4, ABsup_4 = __mul(A_imag, B_real)
            if isone(α)
                if iszero(β)
                    C .= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                  interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4))
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                   interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4))
                else
                    C .= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                  interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4)) .+ C .* β
                end
            else
                if iszero(β)
                    C .= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                  interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4)) .* α
                elseif isone(β)
                    C .+= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                   interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4)) .* α
                else
                    C .= complex.(interval.(BoundType, ABinf_1, ABsup_1) .- interval.(BoundType, ABinf_2, ABsup_2),
                                  interval.(BoundType, ABinf_3, ABsup_3) .+ interval.(BoundType, ABinf_4, ABsup_4)) .* α .+ C .* β
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
        function _mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:$T}, B::AbstractVecOrMat{<:$S}, α, β)
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
                ABinf_real, ABsup_real = __mul(A_real, B)
                ABinf_imag, ABsup_imag = __mul(A_imag, B)
                if isone(α)
                    if iszero(β)
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag))
                    else
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α
                    else
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α .+ C .* β
                    end
                end
            end
            t = all(isguaranteed, A) & all(isguaranteed, B) & isguaranteed(α) & isguaranteed(β)
            _ensure_ng_flag!(C, t)
            return C
        end

        function _mul!(::MatMulMode{:fast}, C, A::AbstractMatrix{<:$S}, B::AbstractVecOrMat{<:$T}, α, β)
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
                ABinf_real, ABsup_real = __mul(A, B_real)
                ABinf_imag, ABsup_imag = __mul(A, B_imag)
                if isone(α)
                    if iszero(β)
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag))
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag))
                    else
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .+ C .* β
                    end
                else
                    if iszero(β)
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α
                    elseif isone(β)
                        C .+= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α
                    else
                        C .= complex.(interval.(BoundType, ABinf_real, ABsup_real), interval.(BoundType, ABinf_imag, ABsup_imag)) .* α .+ C .* β
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

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractMatrix{Interval{T}}) where {T<:AbstractFloat}
    mA = _div_round.(_add_round.(inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp) # (inf.(A) .+ sup.(A)) ./ 2
    rA = _sub_round.(mA, inf.(A), RoundUp)
    mB = _div_round.(_add_round.(inf.(B), sup.(B), RoundUp), convert(T, 2), RoundUp) # (inf.(B) .+ sup.(B)) ./ 2
    rB = _sub_round.(mB, inf.(B), RoundUp)

    Cinf = zeros(T, size(A, 1), size(B, 2))
    Csup = zeros(T, size(A, 1), size(B, 2))

    Threads.@threads for j ∈ axes(B, 2)
        for l ∈ axes(A, 2)
            @inbounds for i ∈ axes(A, 1)
                U_ij         = _mul_round(abs(mA[i,l]), rB[l,j], RoundUp)
                V_ij         = _mul_round(rA[i,l], _add_round(abs(mB[l,j]), rB[l,j], RoundUp), RoundUp)
                rC_ij        = _add_round(U_ij, V_ij, RoundUp)
                mAmB_up_ij   = _mul_round(mA[i,l], mB[l,j], RoundUp)
                mAmB_down_ij = _mul_round(mA[i,l], mB[l,j], RoundDown)

                Cinf[i,j] = _add_round(_sub_round(mAmB_down_ij, rC_ij, RoundDown), Cinf[i,j], RoundDown)
                Csup[i,j] = _add_round(_add_round(mAmB_up_ij,   rC_ij, RoundUp),   Csup[i,j], RoundUp)
            end
        end
    end

    return Cinf, Csup
end

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractMatrix{T}) where {T<:AbstractFloat}
    mA = _div_round.(_add_round.(inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp) # (inf.(A) .+ sup.(A)) ./ 2
    rA = _sub_round.(mA, inf.(A), RoundUp)

    Cinf = zeros(T, size(A, 1), size(B, 2))
    Csup = zeros(T, size(A, 1), size(B, 2))

    Threads.@threads for j ∈ axes(B, 2)
        for l ∈ axes(A, 2)
            @inbounds for i ∈ axes(A, 1)
                rC_ij        = _mul_round(rA[i,l], abs(B[l,j]), RoundUp)
                mAmB_up_ij   = _mul_round(mA[i,l], B[l,j], RoundUp)
                mAmB_down_ij = _mul_round(mA[i,l], B[l,j], RoundDown)

                Cinf[i,j] = _add_round(_sub_round(mAmB_down_ij, rC_ij, RoundDown), Cinf[i,j], RoundDown)
                Csup[i,j] = _add_round(_add_round(mAmB_up_ij,   rC_ij, RoundUp),   Csup[i,j], RoundUp)
            end
        end
    end

    return Cinf, Csup
end

function __mul(A::AbstractMatrix{T}, B::AbstractMatrix{Interval{T}}) where {T<:AbstractFloat}
    mB = _div_round.(_add_round.(inf.(B), sup.(B), RoundUp), convert(T, 2), RoundUp) # (inf.(B) .+ sup.(B)) ./ 2
    rB = _sub_round.(mB, inf.(B), RoundUp)

    Cinf = zeros(T, size(A, 1), size(B, 2))
    Csup = zeros(T, size(A, 1), size(B, 2))

    Threads.@threads for j ∈ axes(B, 2)
        for l ∈ axes(A, 2)
            @inbounds for i ∈ axes(A, 1)
                rC_ij        = _mul_round(abs(A[i,l]), rB[l,j], RoundUp)
                mAmB_up_ij   = _mul_round(A[i,l], mB[l,j], RoundUp)
                mAmB_down_ij = _mul_round(A[i,l], mB[l,j], RoundDown)

                Cinf[i,j] = _add_round(_sub_round(mAmB_down_ij, rC_ij, RoundDown), Cinf[i,j], RoundDown)
                Csup[i,j] = _add_round(_add_round(mAmB_up_ij,   rC_ij, RoundUp),   Csup[i,j], RoundUp)
            end
        end
    end

    return Cinf, Csup
end

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractVector{Interval{T}}) where {T<:AbstractFloat}
    mA = _div_round.(_add_round.(inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp) # (inf.(A) .+ sup.(A)) ./ 2
    rA = _sub_round.(mA, inf.(A), RoundUp)
    mB = _div_round.(_add_round.(inf.(B), sup.(B), RoundUp), convert(T, 2), RoundUp) # (inf.(B) .+ sup.(B)) ./ 2
    rB = _sub_round.(mB, inf.(B), RoundUp)

    Cinf = zeros(T, size(A, 1))
    Csup = zeros(T, size(A, 1))

    Threads.@threads for i ∈ axes(A, 1)
        @inbounds for l ∈ axes(A, 2)
            U_il         = _mul_round(abs(mA[i,l]), rB[l], RoundUp)
            V_il         = _mul_round(rA[i,l], _add_round(abs(mB[l]), rB[l], RoundUp), RoundUp)
            rC_il        = _add_round(U_il, V_il, RoundUp)
            mAmB_up_il   = _mul_round(mA[i,l], mB[l], RoundUp)
            mAmB_down_il = _mul_round(mA[i,l], mB[l], RoundDown)

            Cinf[i] = _add_round(_sub_round(mAmB_down_il, rC_il, RoundDown), Cinf[i], RoundDown)
            Csup[i] = _add_round(_add_round(mAmB_up_il,   rC_il, RoundUp),   Csup[i], RoundUp)
        end
    end

    return Cinf, Csup
end

function __mul(A::AbstractMatrix{Interval{T}}, B::AbstractVector{T}) where {T<:AbstractFloat}
    mA = _div_round.(_add_round.(inf.(A), sup.(A), RoundUp), convert(T, 2), RoundUp) # (inf.(A) .+ sup.(A)) ./ 2
    rA = _sub_round.(mA, inf.(A), RoundUp)

    Cinf = zeros(T, size(A, 1))
    Csup = zeros(T, size(A, 1))

    Threads.@threads for i ∈ axes(A, 1)
        @inbounds for l ∈ axes(A, 2)
            rC_il       = _mul_round(rA[i,l], abs(B[l]), RoundUp)
            mAB_up_il   = _mul_round(mA[i,l], B[l], RoundUp)
            mAB_down_il = _mul_round(mA[i,l], B[l], RoundDown)

            Cinf[i] = _add_round(_sub_round(mAB_down_il, rC_il, RoundDown), Cinf[i], RoundDown)
            Csup[i] = _add_round(_add_round(mAB_up_il,   rC_il, RoundUp),   Csup[i], RoundUp)
        end
    end

    return Cinf, Csup
end

function __mul(A::AbstractMatrix{T}, B::AbstractVector{Interval{T}}) where {T<:AbstractFloat}
    mB = _div_round.(_add_round.(inf.(B), sup.(B), RoundUp), convert(T, 2), RoundUp) # (inf.(B) .+ sup.(B)) ./ 2
    rB = _sub_round.(mB, inf.(B), RoundUp)

    Cinf = zeros(T, size(A, 1))
    Csup = zeros(T, size(A, 1))

    Threads.@threads for i ∈ axes(A, 1)
        @inbounds for l ∈ axes(A, 2)
            rC_il       = _mul_round(abs(A[i,l]), rB[l], RoundUp)
            AmB_up_il   = _mul_round(A[i,l], mB[l], RoundUp)
            AmB_down_il = _mul_round(A[i,l], mB[l], RoundDown)

            Cinf[i] = _add_round(_sub_round(AmB_down_il, rC_il, RoundDown), Cinf[i], RoundDown)
            Csup[i] = _add_round(_add_round(AmB_up_il,   rC_il, RoundUp),   Csup[i], RoundUp)
        end
    end

    return Cinf, Csup
end

# convenient function to propagate NG flag

function _ensure_ng_flag!(C::AbstractVecOrMat{<:Interval}, ng_flag::Bool)
    C .= _unsafe_interval.(getfield.(C, :bareinterval), decoration.(C), ng_flag)
    return C
end

function _ensure_ng_flag!(C::AbstractVecOrMat{<:Complex{<:Interval}}, ng_flag::Bool)
    C .= complex.(
        _unsafe_interval.(getfield.(real.(C), :bareinterval), decoration.(C), ng_flag),
        _unsafe_interval.(getfield.(imag.(C), :bareinterval), decoration.(C), ng_flag)
        )
    return C
end
