using IntervalArithmetic

import Base.mod2pi

function standard_map(X::IntervalBox, k = 1.0)
    p, θ = X

    p′ = p + k*sin(θ)
    @show p′
    θ′ = mod2pi( θ + p′ )
    p′ = mod2pi(p′)

    @show p′, θ′
    @show typeof(p′), typeof(θ′)

    IntervalBox(p′, θ′)
end

function IntervalBox(X::Vector{Interval{T}}, Y::Vector{Interval{T}}) where T
    vec([IntervalBox(x, y) for x in X, y in Y])
end

function iterate(f, n, x)
    for i in 1:n
        x = f(x)
    end
    x
end


import Base.mod
function mod(X::Interval, width::Real)


    @show X, width

    X /= width

    if diam(X) >= 1.

        return [Interval(0, 1) * width]
    end

    a = X.lo - floor(X.lo)
    b = X.hi - floor(X.hi)

    if a < b
        return [Interval(a, b)*width]

    end

    return [Interval(0, b)*width, Interval(a, 1)*width]

end


function mod(X::IntervalBox, width::Real)
    x, y = X

    xx = mod(x, width)
    yy = mod(y, width)

    vec([IntervalBox(x, y) for x in xx, y in yy])
end


mod2pi(x::Interval{T}) where {T} = mod(x, IntervalArithmetic.two_pi(T))

mod2pi(X::Vector{Interval{T}}) where {T} = vcat(map(mod2pi, X)...)
