using Test
using IntervalArithmetic
import IntervalArithmetic: unsafe_interval

@testset "Constructing intervals" begin
    # Naive constructors, with no conversion involved
    @test interval(Float64, 1.0, 1.0) ≛ interval(1) ≛ interval(interval(1.0)) ≛
        interval(Float64, interval(1.0))
    @test size(interval(1)) == ()  # Match the `size` behaviour of `Number`
    @test interval(big(1)) ≛ interval(Float64, 1.0, 1.0)
    @test interval(Rational{Int}, 1//10) ≛ interval(Rational{Int}, 1//10, 1//10)
    @test interval(Rational{BigInt}, BigInt(1)//10) ≛ interval(Rational{BigInt}, 1//10, 1//10)
    @test interval( (1.0, 2.0) ) ≛ interval(Float64, 1.0, 2.0)
    @test interval(BigFloat, 1) ≛ interval(BigFloat, big(1.0), big(1.0))

    # constructing interval with `Interval` fails
    @test_throws MethodError Interval(1, 2)
    @test_throws MethodError Interval{Float64}(1.0, 2.0)

    # Irrational
    for irr in (π, ℯ)
        @test interval(0, irr) ≛ hull(interval(0), interval(irr))
        @test interval(irr) ≛ interval(irr, irr) ≛ interval(Float64, irr)
        @test interval(Float32, irr, irr) ≛ interval(Float32, irr)
    end

    @test interval(ℯ, big(4)) ≛ hull(interval(BigFloat, ℯ), interval(4))
    @test interval(π, big(4)) ≛ hull(interval(BigFloat, π), interval(4))

    @test interval(ℯ, π) ≛ hull(interval(ℯ), interval(Float64, π))
    @test big(ℯ) in interval(ℯ, π)
    @test big(π) in interval(ℯ, π)
    @test big(ℯ) in interval(0, ℯ)
    @test big(π) in interval(π, 4)

    @test big(ℯ) in interval(Float32, ℯ, π)
    @test big(π) in interval(Float32, ℯ, π)
    @test big(ℯ) in interval(Float32, 0, ℯ)
    @test big(π) in interval(Float32, π, 4)

    @test interval(interval(π)) ≛ interval(π)
    @test interval(unsafe_interval(Float64, NaN, -Inf)) ≛ emptyinterval()

    # with rational
    @test interval(1//2) ≛ I"0.5" ≛ interval(0.5)
    @test parse(Interval{Rational{Int64}}, "0.1") ≛ interval(Rational{Int64}, 1//10, 1//10)
    @test parse(Interval{Rational{Int64}}, "[0.1, 0.3]") ≛ interval(Rational{Int64}, 1//10, 3//10)

    # a < Inf and b > -Inf
    @test I"1e300" ≛ unsafe_interval(Float64, 9.999999999999999e299, 1.0e300)
    @test I"-1e307" ≛ unsafe_interval(Float64, -1.0000000000000001e307, -1.0e307)

    # Disallowed construction with a > b
    @test_logs (:warn,) @test isempty(interval(2, 1))
    @test_logs (:warn,) @test isempty(interval(big(2), big(1)))
    @test_logs (:warn,) @test isempty(interval(big(1), 1//10))
    @test_logs (:warn,) @test isempty(interval(1, 0.1))
    @test_logs (:warn,) @test isempty(interval(big(1), big(0.1)))
    @test_logs (:warn,) @test isempty(interval(Inf))
    @test_logs (:warn,) @test isempty(interval(-Inf, -Inf))
    @test_logs (:warn,) @test isempty(interval(Inf, Inf))

    # Conversion to Interval without type
    @test_throws MethodError convert(Interval, 1)
    @test_throws MethodError convert(Interval, π)
    @test_throws MethodError convert(Interval, ℯ)
    @test_throws MethodError convert(Interval, BigInt(1))
    @test_throws MethodError convert(Interval, 1//10)
    @test convert(Interval, interval(Float64, 0.1, 0.2)) ≛ interval(Float64, 0.1, 0.2)

    a = I"0.1"
    b = interval(π)

    @test typeof(a) == Interval{Float64}
    @test nextfloat(a.lo) == a.hi
    @test b ≛ interval(π)
    @test nextfloat(b.lo) == b.hi
    x = typemax(Int64)
    @test !isthin(interval(x))

    a = I"[0.1, 0.2]"
    b = interval(0.1, 0.2)

    @test b ⊆ a

    # TODO Actually use the rounding mode here
    for rounding in (:wide, :narrow)
        a = interval(0.1, 0.2)
        @test a ⊆ interval(0.09999999999999999, 0.20000000000000004)

        b = interval(0.1)
        @test b ⊆ interval(0.09999999999999999, 0.10000000000000002)
        @test b ⊆ interval(0.09999999999999999, 0.20000000000000004)
        @test float(b) ⊆ a

        c = I"[0.1, 0.2]"
        @test a ⊆ c   # a is narrower than c
        @test interval(1//2) ≛ interval(0.5)
        @test interval(1//10).lo == rationalize(0.1)
    end

    @test string(emptyinterval()) == "∅"
end

# Issue 502
@testset "Corner case for enclosure" begin
    # 0.100000000000000006 Round down to 0.1 for Float64
    @test BigFloat("0.100000000000000006") ∈ I"0.100000000000000006"
end

@testset "Big intervals" begin
    a = interval(3)
    @test typeof(a)== Interval{Float64}
    @test typeof(big(a)) == Interval{BigFloat}

    @test I"123412341234123412341241234" ≛ interval(1.234123412341234e26, 1.2341234123412342e26)
    @test interval(big"3") ≛ interval(3)

    @test interval(Float64, big"1e10000") ≛ interval(prevfloat(Inf), Inf)

    a = big(10)^10000
    @test interval(Float64, a) ≛ interval(prevfloat(Inf), Inf)
end

#=
@testset "Complex intervals" begin
    a = @floatinterval(3 + 4im)
    @test typeof(a) == Complex{Interval{Float64}}
    @test a ≛ Interval(3) + im*Interval(4)

    # b = exp(a)
    # @test real(b) == Interval(-13.12878308146216, -13.128783081462153)
    # @test imag(b) == Interval(-15.200784463067956, -15.20078446306795)
end
=#

@testset ".. tests" begin
    a = IntervalArithmetic.Symbols.:(..)(big(0.1), 2)
    @test typeof(a) == Interval{BigFloat}

    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(2, 1))
    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(π, 1))
    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(π, ℯ))
    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(4, π))
    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(NaN, 3))
    @test_logs (:warn, ) @test isempty(IntervalArithmetic.Symbols.:(..)(3, NaN))
    @test IntervalArithmetic.Symbols.:(..)(1, π) ≛ interval(Float64, 1, π)
end

@testset "± tests" begin
    @test 3 ± 1 ≛ interval(Float64, 2.0, 4.0)
    @test 3 ± 0.5 ≛ interval(2.5, 3.5)
    @test 3 ± 0.1 ≛ interval(2.9, 3.1)
    @test 0.5 ± 1 ≛ interval(-0.5, 1.5)

    # issue 172:
    @test interval(1, 1) ± 1 ≛ interval(0, 2)
end

@testset "Conversion to interval of same type" begin
    x = interval(3, 4)
    @test convert(Interval{Float64}, x) ≛ x

    x = interval(big(3), big(4))
    @test convert(Interval{BigFloat}, x) ≛ x
end

@testset "Promotion between intervals" begin
    x = interval(Float64, π)
    y = interval(BigFloat, π)
    x_, y_ = promote(x, y)

    @test promote_type(typeof(x), typeof(y)) == Interval{BigFloat}
    @test bounds(x_) == (BigFloat(inf(x), RoundDown), BigFloat(sup(x), RoundUp))
    @test y_ ≛ y
end

@testset "Typed intervals" begin
    @test typeof(interval(1, 2)) == Interval{Float64}
    @test typeof(interval(Float64, 1, 2)) == Interval{Float64}
    @test typeof(interval(Float32, 1, 2)) == Interval{Float32}
    @test typeof(interval(Float16, 1, 2)) == Interval{Float16}

    # PR 496
    @test eltype(interval(1, 2)) == Interval{Float64}
    @test IntervalArithmetic.numtype(interval(1, 2)) == Float64
    @test all([1 2; 3 4] * interval(-1, 1) .≛ [interval(-1, 1) interval(-2, 2) ; interval(-3, 3) interval(-4, 4)])

    @test eltype(IntervalBox(interval(1, 2), interval(2, 3))) == Interval{Float64}
    @test IntervalArithmetic.numtype(IntervalBox(interval(1, 2), interval(2, 3))) == Float64
end

@testset "Conversions between different types of interval" begin
    a = convert(Interval{BigFloat}, interval(3, 4))
    @test typeof(a) == Interval{BigFloat}

    a = convert(Interval{Float64}, interval(BigFloat, 3, 4))
    @test typeof(a) == Interval{Float64}

    pi64, pi32 = interval(Float64, pi), interval(Float32, pi)
    x, y = promote(pi64, pi32)
    @test x ≛ pi64
    @test y ≛ Interval{Float64}(pi32)
end

@testset "Interval{T} constructor" begin
    @test interval(Float64, 1, 1) ≛ interval(1)
    # no rounding
    @test bounds(interval(Float64, 1.1, 1.1)) == (1.1, 1.1)

    @test bounds(interval(BigFloat, big"1.1", big"1.1")) == (big"1.1", big"1.1")
end

# issue 206:
@testset "Interval strings" begin
    a = I"[2/3, 1.1]"
    b = interval(0.6666666666666666, 1.1)
    @test a ≛ b

    a = I"[1]"
    b = interval(1.0, 1.0)
    @test a ≛ b

    a = I"[-0x1.3p-1, 2/3]"
    b = interval(-0.59375, 0.6666666666666667)
    @test a ≛ b
end

@testset "setdiff tests" begin
    x = interval(1, 3)
    y = interval(2, 4)
    @test all(setdiff(x, y) .≛ [interval(1, 2)])
    @test all(setdiff(y, x) .≛ [interval(3, 4)])

    @test setdiff(x, x) == Interval{Float64}[]

    @test all(setdiff(x, emptyinterval(x)) .≛ [x])

    z = interval(0, 5)
    @test setdiff(x, z) == Interval{Float64}[]
    @test all(setdiff(z, x) .≛ [interval(0, 1), interval(3, 5)])
end

@testset "Interval{T}(x::Interval)" begin
    @test Interval{Float64}(interval(3, 4)) ≛ interval(Float64, 3.0, 4.0)
    @test Interval{BigFloat}(interval(3, 4)) ≛ interval(BigFloat, 3, 4)
end


@testset "@interval with user-defined function" begin
    f(x) = x.lo == Inf ? one(x) : x/(1+x)  # monotonic

    x = interval(3, 4)
    @test interval(0.75, 0.8) ⊆ interval(f(interval(x.lo)), f(interval(x.hi)))
end

# issue 192:
@testset "Disallow NaN in an interval" begin
    @test_logs (:warn, ) @test isempty(interval(NaN, 2))
    @test_logs (:warn, ) @test isempty(interval(Inf, NaN))
    @test_logs (:warn, ) @test isempty(interval(NaN, NaN))
end

@testset "Hashing of Intervals" begin
    x = interval(Float64, 1, 2)
    y = interval(BigFloat, 1, 2)
    @test x ≛ y
    @test hash(x) == hash(y)

    x = I"0.1"
    y = IntervalArithmetic.bigequiv(x)
    @test x ≛ y
    @test hash(x) == hash(y)

    x = interval(1, 2)
    y = interval(1, 3)
    @test !(x ≛ y)
    @test hash(x) != hash(y)
end

@testset "a..b with a > b" begin
    @test_logs (:warn,) @test isempty(interval(3, 2))
end

@testset "Zero interval" begin
    @test zero(Interval{Float64}) ≛ interval(Float64, 0, 0)
    @test zero(interval(0, 1)) ≛ interval(Float64, 0, 0)
end
