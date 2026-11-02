using Test
using IntervalArithmetic
import DiffRules
import ForwardDiff

@testset "Extension loading" begin
    @test Base.get_extension(IntervalArithmetic, :IntervalArithmeticDiffRulesExt) !== nothing
end

@testset "_abs_deriv values" begin
    @test DiffRules._abs_deriv(interval(1, 2)) === interval(1, 1, com)
    @test DiffRules._abs_deriv(interval(-2, -1)) === interval(-1, -1, com)
    @test DiffRules._abs_deriv(interval(-1, 1)) === interval(-1, 1, trv)
    @test DiffRules._abs_deriv(interval(0, 0)) === interval(-1, 1, trv)
    @test DiffRules._abs_deriv(interval(0, 2)) === interval(0, 1, trv)
    @test DiffRules._abs_deriv(interval(-2, 0)) === interval(-1, 0, trv)
    @test DiffRules._abs_deriv(entireinterval()) === interval(-1, 1, trv)
    @test isempty_interval(DiffRules._abs_deriv(emptyinterval()))
    @test decoration(DiffRules._abs_deriv(emptyinterval())) === trv
    @test DiffRules._abs_deriv(interval(1, 2)) isa Interval{Float64}
end

@testset "_abs_deriv decoration and guarantee" begin
    @test DiffRules._abs_deriv(interval(1, 2, def)) === interval(1, 1, def)
    @test isnai(@test_logs (:warn,) DiffRules._abs_deriv(nai()))
    @test isguaranteed(DiffRules._abs_deriv(interval(1, 2)))
    x = DiffRules._abs_deriv(interval(1, 2) + 1)
    @test !isguaranteed(x)
    @test isequal_interval(x, interval(1, 1))
end

@testset "_abs_deriv bound types" begin
    @test DiffRules._abs_deriv(interval(Float32, 1, 2)) === interval(Float32, 1, 1, com)
    @test DiffRules._abs_deriv(interval(Float16, -2, -1)) === interval(Float16, -1, -1, com)
    @test DiffRules._abs_deriv(interval(1//2, 3//4)) === interval(1//1, 1//1, com)
    y = DiffRules._abs_deriv(interval(BigFloat, 1, 2))
    @test y isa Interval{BigFloat}
    @test isequal_interval(y, interval(BigFloat, 1, 1))
    @test decoration(y) === com
end

@testset "BareInterval" begin
    @test DiffRules._abs_deriv(bareinterval(-2, -1)) === bareinterval(-1.0, -1.0)
    @test DiffRules._abs_deriv(bareinterval(0)) === bareinterval(-1.0, 1.0)
    @test DiffRules._abs_deriv(bareinterval(BigFloat, 1, 2)) isa BareInterval{BigFloat}

    @test ForwardDiff.derivative(abs, bareinterval(-2, -1)) === bareinterval(-1.0, -1.0)
    @test ForwardDiff.derivative(abs, bareinterval(1, 2)) === bareinterval(1.0, 1.0)
    @test ForwardDiff.derivative(abs, bareinterval(0)) === bareinterval(-1.0, 1.0)
    @test ForwardDiff.derivative(abs, bareinterval(-1, 0)) === bareinterval(-1.0, 0.0)
    @test ForwardDiff.derivative(abs, bareinterval(-2, 2)) === bareinterval(-1.0, 1.0)
end

@testset "ForwardDiff abs" begin
    @test ForwardDiff.derivative(abs, interval(-2, -1)) === interval(-1, -1, com)
    @test ForwardDiff.derivative(abs, interval(1, 2)) === interval(1, 1, com)
    @test ForwardDiff.derivative(abs, interval(0)) === interval(-1, 1, trv)
    @test ForwardDiff.derivative(abs, interval(-1, 0)) === interval(-1, 0, trv)
    @test ForwardDiff.derivative(abs, interval(0, 1)) === interval(0, 1, trv)
    @test ForwardDiff.derivative(abs, interval(-2, 2)) === interval(-1, 1, trv)

    f(x) = abs(x)^interval(2)
    @test ForwardDiff.derivative(f, interval(-1, 1)) === interval(-2, 2, trv)

    g(x) = abs(x)^2
    ng = interval(convert(Interval{Float64}, -2), convert(Interval{Float64}, 2), trv)
    @test ForwardDiff.derivative(g, interval(-1, 1)) === ng
    @test only(ForwardDiff.gradient(v -> g(v[1]), [interval(-1, 1)])) === ng
    @test only(ForwardDiff.hessian(v -> g(v[1]), [interval(0)])) === ng
    @test only(ForwardDiff.hessian(v -> g(v[1]), [interval(-1, 1)])) === ng

    h(x) = abs(x) * x
    @test issubset_interval(interval(0, 2), ForwardDiff.derivative(h, interval(-1, 1)))
end
