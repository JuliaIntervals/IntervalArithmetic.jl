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

    # Exact operations (Integers and Rationals)
    @test exact(1) + exact(2) === exact(3)
    @test exact(1) - exact(3) === exact(-2)
    @test exact(2) * exact(3) === exact(6)
    @test exact(4) / exact(2) === exact(2.0)
    @test exact(1) / exact(3) === 1/3
    @test exact(1) / exact(Int64(2)^Int64(60) + Int64(1)) === 1/Int64(2)^Int64(60)
    @test exact(-Int64(1)) / exact(typemin(Int32)) === exact(-Int64(1)/typemin(Int32))
    @test exact(-1) / exact(typemin(Int)) === -1/typemin(Int)
    @test exact(2) ^ exact(3) === exact(8)
    @test_throws DomainError exact(2) ^ (-2)

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

@testset "Exact literals with bare intervals" begin
    # `+`, `-`, `*`, `/` and `\` on a matching number type bypass the promotion to
    # a thin interval, so they must be more specific than the generic methods and
    # must return exactly what those return.
    specialized(f, S, R) = which(f, Tuple{S,R}).sig isa UnionAll
    @test all(f -> specialized(f, BareInterval{Float64}, ExactReal{Float64}), (+, -, *, /))
    @test all(f -> specialized(f, ExactReal{Float64}, BareInterval{Float64}), (+, -, *, \))

    # ... and the mixed number types must not, since the promotion is where the
    # `ExactReal` gets rounded to the interval's number type.
    @test !specialized(*, BareInterval{Float64}, ExactReal{Int})

    viapromotion(f, x, y) = f(promote(x, y)...)
    samebits(x::BareInterval, y::BareInterval) = (inf(x) === inf(y)) & (sup(x) === sup(y))

    for T ∈ (Float64, Float32, Rational{Int})
        vals = T <: Rational ?
            (zero(T), one(T), -one(T), T(1//2), T(-5//3)) :
            (zero(T), -zero(T), one(T), -one(T), T(0.5), T(-2.5), T(0.1), T(-0.1),
             floatmax(T), floatmin(T))
        ivs = (bareinterval(T, 1, 2), bareinterval(T, -2, -1), bareinterval(T, -1, 2),
               bareinterval(T, 0, 1), bareinterval(T, -1, 0), bareinterval(T, 0, 0),
               bareinterval(T(1//10), T(1//10)), bareinterval(T, -Inf, 2),
               bareinterval(T, 3, Inf), entireinterval(BareInterval{T}),
               emptyinterval(BareInterval{T}))
        for v ∈ vals, x ∈ ivs
            k = exact(v)
            @test samebits(x + k, viapromotion(+, x, k))
            @test samebits(k + x, viapromotion(+, k, x))
            @test samebits(x - k, viapromotion(-, x, k))
            @test samebits(k - x, viapromotion(-, k, x))
            @test samebits(x * k, viapromotion(*, x, k))
            @test samebits(k * x, viapromotion(*, k, x))
            @test samebits(x / k, viapromotion(/, x, k))
            @test samebits(k \ x, viapromotion(\, k, x))
        end
    end

    # A non-finite `ExactReal` has no thin interval; both routes warn and return
    # the empty interval.
    let x = bareinterval(1.0, 2.0)
        for v ∈ (Inf, -Inf, NaN)
            @test isempty_interval(@test_logs (:warn,) x + exact(v))
            @test isempty_interval(@test_logs (:warn,) x - exact(v))
            @test isempty_interval(@test_logs (:warn,) exact(v) - x)
            @test isempty_interval(@test_logs (:warn,) x * exact(v))
            @test isempty_interval(@test_logs (:warn,) x / exact(v))
        end
    end

    # Mixed number types still round through the promotion.
    @test isequal_interval(bareinterval(1.0, 2.0) * exact(2), bareinterval(2.0, 4.0))
    @test isequal_interval(bareinterval(1.0, 2.0) + exact(1//3),
                           bareinterval(1.0, 2.0) + bareinterval(Float64, 1//3))
end
