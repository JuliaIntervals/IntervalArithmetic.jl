# Initially adapted from NumberIntervals.jl
# https://github.com/gwater/NumberIntervals.jl

function istrue(policy, bool)
    if policy == :ternary || policy == :certainly
        return bool
    end

    return true in bool && !(false in bool)
end

isfalse(policy, bool) = !istrue(policy, bool)

function isunkown(policy, bool)
    policy == :ternary && return ismissing(bool)
    policy == :certainly && return !bool

    return true in bool && false in bool
end

@testset "BooleanInterval" begin
    @test true in BooleanInterval(true)
    @test !(false in BooleanInterval(true))
    @test false in BooleanInterval(false)
    @test !(true in BooleanInterval(false))
    @test true in BooleanInterval(true, false)
    @test false in BooleanInterval(true, false)
    @test true in BooleanInterval(missing)
    @test false in BooleanInterval(missing)
    @test_throws ArgumentError BooleanInterval(true, true)
    @test_throws ArgumentError BooleanInterval(false, false)
end

a = interval(-1, 0)
b = interval(-0.5, 0.5)
c = interval(0.5, 2)
d = interval(0.25, 0.8)
f = interval(1)
z = zero(Interval{Float64})

for policy in (:certainly, :interval, :ternary)
    @eval istrue(bool) = istrue($(QuoteNode(policy)), bool)
    @eval isfalse(bool) = isfalse($(QuoteNode(policy)), bool)
    @eval isunkown(bool) = isunkown($(QuoteNode(policy)), bool)

    @eval IntervalArithmetic.pointwise_policy() = PointwisePolicy{$(QuoteNode(policy))}()

    @testset ":$policy pointwise policy" begin
        @testset "Number comparison" begin
            @test istrue(a < c)
            @test istrue(c > a)
            @test isunkown(a < b)
            @test isunkown(c > b)
            @test isfalse(c < a)
            @test isfalse(a > c)
            @test istrue(z == z)
            @test istrue(z != c)
            @test isunkown(a == b)
            @test isunkown(b != c)
            @test istrue(b <= c)
            @test isfalse(f < f)
        end

        @testset "Testing for zero" begin
            @test isfalse(iszero(c))
            @test istrue(iszero(z))
            @test isunkown(iszero(a))
            @test isunkown(iszero(b))
        end

        @testset "isinteger" begin
            @test istrue(isinteger(z))
            @test istrue(isinteger(interval(4)))
            @test isfalse(isinteger(interval(4.5)))
            @test isunkown(isinteger(c))
            @test isfalse(isinteger(d))
        end

        @testset "isfinite" begin
            @test istrue(isfinite(a))
            @test istrue(isfinite(b))
            @test istrue(isfinite(c))
            @test istrue(isfinite(z))
            # NOTE This depends on the flavor. We test it here for the
            # :set_based flavor only
            @test istrue(isfinite(interval(0., Inf)))
        end
    end
end

let policy = :ieee
    @eval istrue(bool) = istrue($(QuoteNode(policy)), bool)
    @eval isfalse(bool) = isfalse($(QuoteNode(policy)), bool)

    @eval IntervalArithmetic.pointwise_policy() = PointwisePolicy{$(QuoteNode(policy))}()
    @show(IntervalArithmetic.pointwise_policy())
    @testset ":$policy pointwise policy" begin
        @testset "Number comparison" begin
            @test istrue(a < c)
            @test istrue(c > a)
            @test istrue(a < b)
            @test istrue(c > b)
            @test isfalse(c < a)
            @test isfalse(a > c)
            @test istrue(z == z)
            @test istrue(z != c)
            @test isfalse(a == b)
            @test istrue(b != c)
            @test istrue(b <= c)
            @test isfalse(f < f)
        end

        @testset "Testing for zero" begin
            @test isfalse(iszero(c))
            @test istrue(iszero(z))
            @test isfalse(iszero(a))
            @test isfalse(iszero(b))
        end

        @testset "isinteger" begin
            @test istrue(isinteger(z))
            @test istrue(isinteger(interval(4)))
            @test isfalse(isinteger(interval(4.5)))
            @test isfalse(isinteger(c))
            @test isfalse(isinteger(d))
        end

        @testset "isfinite" begin
            @test istrue(isfinite(a))
            @test istrue(isfinite(b))
            @test istrue(isfinite(c))
            @test istrue(isfinite(z))
            # NOTE This depends on the flavor. We test it here for the
            # :set_based flavor only
            @test istrue(isfinite(interval(0., Inf)))
        end
    end
end
