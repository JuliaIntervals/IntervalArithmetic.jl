module IntervalArithmeticLinearAlgebraExt

using IntervalArithmetic, LinearAlgebra

IntervalArithmetic.interval(::Type{T}, J::UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) where {T} =
    UniformScaling(interval(T, J.λ, d; format = format))
IntervalArithmetic.interval(J::UniformScaling, d::IntervalArithmetic.Decoration = com; format::Symbol = :infsup) =
    UniformScaling(interval(J.λ, d; format = format))

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
                nrmj += norm(A[i,j])
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
                nrmi += norm(A[i,j])
            end
            nrm = max(nrm, nrmi)
        end
    end
    return convert(Tnorm, nrm)
end

end
