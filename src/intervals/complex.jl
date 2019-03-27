
⊆(x::Complex{Interval{T}}, y::Complex{Interval{T}}) where T = real(x) ⊆ real(y) && imag(x) ⊆ imag(y)

function ^(x::Complex{Interval{T}}, n::Integer) where {T}
    if n < 0
        return inv(x)^n
    end

    return Base.power_by_squaring(x, n)
end

function ^(x::Complex{Interval{T}}, y::Real) where {T}
    return exp(y*log(x))
end

function ^(x::Complex{Interval{T}}, y::Complex) where {T}
    return exp(y*log(x))
end


function ssqs(x::T, y::T,RND::RoundingMode) where T<:AbstractFloat
    k::Int = 0
    ρ = +(*(x,x,RND),*(y,y,RND),RND)
    if !isfinite(ρ) && (isinf(x) || isinf(y))
        ρ = convert(T, Inf)
    elseif isinf(ρ) || (ρ==0 && (x!=0 || y!=0)) || ρ<nextfloat(zero(T))/(2*eps(T)^2)
        m::T = max(abs(x), abs(y))
        k = m==0 ? m : exponent(m)
        xk, yk = ldexp(x,-k), ldexp(y,-k)
        ρ = +(*(xk,xk,RND),*(yk,yk,RND),RND)
    end
    ρ, k
end

# function ssqs(x::Interval{T}, y::Interval{T}) where T<:AbstractFloat
#     x = abs(x); y = abs(y)
#     ρl,kl = ssqs(inf(x),inf(y),RoundDown)
#     ρu,ku = ssqs(sup(x),sup(y),RoundUp)
#     ρl, kl, ρu, ku
# end

function sqrt_realpart(x::T, y::T,RND::RoundingMode) where T<:AbstractFloat
    # @assert x ≥ 0
    ρ, k = ssqs(x,y,RND)
    if isfinite(x) ρ = +(ldexp(x,-k),sqrt(ρ,RND),RND) end

    if isodd(k)
        k = div(k-1,2)
    else
        k = div(k,2)-1
        ρ *= 2
    end
    ρ = ldexp(sqrt(ρ,RND),k) #sqrt((abs(z)+abs(x))/2) without over/underflow
end

function sqrt(z::Complex{Interval{T}}) where T<:AbstractFloat
    x, y = reim(z)

    (inf(x) < 0 && inf(y) < 0 && sup(y) >= 0) && error("Interval lies across branch cut")
    x == y == 0 && return Complex(zero(x),y)

    (inf(x) < 0 && sup(x) > 0) && return sqrt((inf(x)..0) + im*y) ∪ sqrt((0..sup(x)) + im*y)

    absx = abs(x)

    absy= abs(y)
    ρl = sqrt_realpart(inf(absx),inf(absy),RoundDown)
    ρu = sqrt_realpart(sup(absx),sup(absy),RoundUp)

    ηu = sup(y)
    if isfinite(ηu)
        if ηu >= 0
            ηu_re = sqrt_realpart(inf(absx),ηu,RoundDown)
        else
            ηu_re = sqrt_realpart(sup(absx),ηu,RoundUp)
        end
        ηu = ηu_re ≠ 0 ?  /(ηu,2ηu_re,RoundUp) : zero(T)
    end

    ηl = inf(y)
    if ηl >= 0
        ηl_re = sqrt_realpart(sup(absx),ηl,RoundUp)
    else
        ηl_re = sqrt_realpart(inf(absx),ηl,RoundDown)
    end
    ηl = ηl_re ≠ 0 ? /(ηl,2ηl_re,RoundDown) : zero(T)

    ξ = ρl..ρu
    η = ηl..ηu

    if mid(x)<0
        ξ = flipsign(η,mid(η))
        η = flipsign((ρl..ρu),mid(η))
    end

    Complex(ξ,η)
end


function log(z::Complex{T}) where T<:Interval
    ρ = abs(z)
    θ = angle(z)

    return log(ρ) + im * θ
end


function abs2(z::Complex{T}) where T<:Interval
    return real(z)^2 + imag(z)^2
end

function abs(z::Complex{T}) where T<:Interval
    return sqrt(abs2(z))
end
#
# # \left( |x|^p \right)^{1/p}.
# function norm(z::Complex{T}, p=2) where T<:Interval
#     return (abs(z)^(p))^(1 / p)
# end
