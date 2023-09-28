using Test
using IntervalArithmetic
using ForwardDiff

@testset "ForwardDiff" begin
    x, w = 2.0, interval(-0.5, 0.5)
    ϕ(t) = sin(x + (1+t)*w)
    ϕ′(t) = cos(x + (1+t)*w) * w
    ϕ′′(t) = -sin(x + (1+t)*w) * w^2
    ϕ′′′(t) = -cos(x + (1+t)*w) * w^3
    dϕ(t) = ForwardDiff.derivative(ϕ, t)
    ddϕ(t) = ForwardDiff.derivative(dϕ, t)
    dddϕ(t) = ForwardDiff.derivative(ddϕ, t)
    @test ϕ′(0) ⊆ dϕ(0)
    @test ϕ′′(0) ⊆ ddϕ(0)
    @test ϕ′′′(0) ⊆ dddϕ(0)
end
