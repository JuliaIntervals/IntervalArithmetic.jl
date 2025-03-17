module IntervalArithmeticLinearAlgebraExt

using IntervalArithmetic
import LinearAlgebra

# contructor for `UniformScaling`

IntervalArithmetic.interval(::Type{T}, J::LinearAlgebra.UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) where {T} =
    LinearAlgebra.UniformScaling(interval(T, J.λ, d; format = format))
IntervalArithmetic.interval(J::LinearAlgebra.UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) =
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

end
