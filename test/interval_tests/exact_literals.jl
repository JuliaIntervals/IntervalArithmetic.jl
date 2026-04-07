@testset "Exact literals" begin
    @test_throws MethodError convert(ExactReal{Float64}, 2)

    @test has_exact_display(0.5)
    @test !has_exact_display(0.1)

    @test (@exact 2im) isa Complex{<:ExactReal}
    @test (@exact 1.2 + 3.4im) isa Complex{<:ExactReal}
    @test_throws ArgumentError (@exact 1.2 + 3im)

    @test exact(3).value == 3
    @test_throws MethodError ExactReal{Float64}(1//3)
    @test_throws MethodError ExactReal{Float64}(1.0)
    @test_throws MethodError ExactReal(1.0)

    #

    x = @exact 0.5

    @test (2 * x) isa Float64
    @test isone(2 * x)

    @test (bareinterval(2) * x) isa BareInterval
    @test isthinone(bareinterval(2) * x)

    @test (interval(2) * x) isa Interval
    @test isthinone(interval(2) * x)
    @test isguaranteed(interval(2) * x)

    #

    @exact function f(x)
       return x^2 - 2x + 1
    end

    @test f(1.0) isa Real
    @test iszero(f(1.0))

    @test f(bareinterval(1)) isa BareInterval
    @test isthinzero(f(bareinterval(1)))

    @test f(interval(1)) isa Interval
    @test isthinzero(f(interval(1)))
    @test isguaranteed(f(interval(1)))

    #

    @test isequal_interval(promote(bareinterval(1, 2), exact(3))[2], bareinterval(3))

    @test isequal_interval(promote(interval(1, 2), exact(3))[2], interval(3))

    # Extended exactness operations

    # Exact operations (Integers and Rationals)
    @test exact(1) + exact(2) === exact(3)
    @test exact(1) - exact(3) === exact(-2)
    @test exact(2) * exact(3) === exact(6)
    @test exact(4) / exact(2) === exact(2//1)
    @test exact(2) ^ exact(3) === exact(8)

    @test exact(1//2) + exact(1//4) === exact(3//4)
    @test exact(1//2) - exact(1//4) === exact(1//4)
    @test exact(1//2) * exact(1//2) === exact(1//4)

    # Checked Arithmetic Overflows
    @test_throws OverflowError exact(typemax(Int)) + exact(1)
    @test_throws OverflowError exact(typemin(Int)) - exact(1)
    @test_throws OverflowError exact(typemax(Int)) * exact(2)
    @test_throws OverflowError -exact(typemin(Int))

    # Bool operations
    let x = @exact 1.5
        @test (x * exact(true)) isa ExactReal
        @test (x * exact(true)) === exact(1.5)

        @test (x * exact(false)) isa ExactReal
        @test (x * exact(false)) === exact(0.0)

        @test (x / exact(true)) isa ExactReal
        @test (x / exact(true)) === exact(1.5)
    end

    # Loss of exactness
    let val = exact(1.5) + exact(2.0)
        @test val isa Float64
        @test val == 3.5
    end

    let val2 = exact(1.5) * exact(2.0)
        @test val2 isa Float64
        @test val2 == 3.0
    end
end
