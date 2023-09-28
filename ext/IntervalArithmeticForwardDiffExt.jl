module IntervalArithmeticForwardDiffExt

using IntervalArithmetic, ForwardDiff
using ForwardDiff: Dual

function Base.:(*)(x::Dual{Tx,Vx,N}, y::Interval{Vy}) where {Tx,Vx<:Real,Vy<:Union{AbstractFloat, Rational},N}
    v = x.value * y
    V = typeof(v)
    Dual{Tx,V,N}(v, ForwardDiff.Partials{N,V}(x.partials.values .* y))
end

@generated function _iszero_tuple(::Type{<:Interval}, tup::NTuple{N,V}) where {N,V}
    ex = Expr(:&&, [:(z ≛ tup[$i]) for i=1:N]...)
    return quote
        z = zero(V)
        $(Expr(:meta, :inline))
        @inbounds return $ex
    end
end

end
