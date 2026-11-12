using Test
using IntervalArithmetic
using IntervalArithmetic: _parse, _bounds, _number

@testset "BareInterval" begin
    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test isequal_interval(parse(BareInterval{T}, "[1, 2]"), bareinterval(T, 1, 2))
        if T != BigFloat
            @test isequal_interval(parse(BareInterval{T}, "[1e-324, 1e400]"), bareinterval(T, 0, Inf))
        else
            @test isequal_interval(parse(BareInterval{BigFloat}, "[1e-324, 1e400]"), bareinterval(BigFloat("1e-324", RoundDown), BigFloat("1e400", RoundUp)))
        end
        @test isequal_interval(parse(BareInterval{T}, "[2,infinity]"), bareinterval(T, 2, Inf))
        @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{T}, "[foobar]"))
    end

    @test isequal_interval(parse(BareInterval{Rational{Int64}}, "0.1"), bareinterval(Rational{Int64}, 1//10))
    @test isequal_interval(parse(BareInterval{Rational{Int64}}, "[0.1, 0.3]"), bareinterval(Rational{Int64}, 1//10, 3//10))

    @test bounds(parse(BareInterval{Float64}, "[1, 2]")) == (1.0, 2.0)
    @test bounds(parse(BareInterval{Float64}, "[1,]")) == (1.0, Inf)
    @test bounds(parse(BareInterval{Float64}, "[,]")) == (-Inf, Inf)
    @test bounds(parse(BareInterval{Float64}, "6.42?2e2")) == (640.0, 644.0)

    @test isempty_interval(@test_logs (:warn, r"failed to parse a decorated interval") parse(BareInterval{Float64}, "[1, 2]_com"))
    @test isempty_interval(@test_logs (:warn, r"parsed NaI") parse(BareInterval{Float64}, "[nai]"))
    for str ∈ ("[garbage]", "garbage", "", "[1, garbage]")
        @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{Float64}, str))
    end
end

@testset "Interval" begin
    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test isequal_interval(parse(Interval{T}, "[1, 2]"), interval(T, 1, 2))
        if T != BigFloat
            @test isequal_interval(parse(Interval{T}, "[1e-324, 1e400]"), interval(T, 0, Inf))
        else
            @test isequal_interval(parse(Interval{BigFloat}, "[1e-324, 1e400]"), interval(BigFloat("1e-324", RoundDown), BigFloat("1e400", RoundUp)))
        end
        @test isequal_interval(parse(Interval{T}, "[2,infinity]"), interval(T, 2, Inf))
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{T}, "[foobar]"))

        x = parse(Interval{T}, "[1, 2]_com")
        y = parse(Interval{T}, "[1, 2]")
        z = interval(T, 1, 2)
        @test isequal_interval(x, y, z) & (decoration(x) == decoration(y) == decoration(z))
    end

    @test isequal_interval(parse(Interval{Rational{Int64}}, "0.1"), interval(Rational{Int64}, 1//10))
    @test isequal_interval(parse(Interval{Rational{Int64}}, "[0.1, 0.3]"), interval(Rational{Int64}, 1//10, 3//10))
    @test bounds(parse(Interval{Rational{Int64}}, "1/3")) == (1//3, 1//3)

    x = parse(Interval{Float64}, "[1, 2]")
    @test bounds(x) == (1.0, 2.0)
    @test (decoration(x) == com) & isguaranteed(x)

    for str ∈ ("[1.33]", "1.33")
        @test bounds(parse(Interval{Float64}, str)) == (1.3299999999999998, 1.33)
    end

    for str ∈ ("[empty]", "[]")
        e = @test_logs parse(Interval{Float64}, str)
        @test isempty_interval(e) & (decoration(e) == trv)
    end
    for str ∈ ("[entire]", "[,]")
        e = @test_logs parse(Interval{Float64}, str)
        @test (bounds(e) == (-Inf, Inf)) & (decoration(e) == dac)
    end

    x = parse(Interval{Float64}, "[3,]")
    @test (bounds(x) == (3.0, Inf)) & (decoration(x) == dac)
    x = parse(Interval{Float64}, "[,3]")
    @test (bounds(x) == (-Inf, 3.0)) & (decoration(x) == dac)

    @test isequal_interval(parse(Interval{Float64}, "  [1, 2]  "), parse(Interval{Float64}, "[1,2]"))
    @test decoration(parse(Interval{Float64}, "[1, 2]_DEF")) == def
    for (str, d) ∈ (("[1, 2]_trv", trv), ("[1, 2]_def", def), ("[1, 2]_dac", dac), ("[1, 2]_com", com))
        @test decoration(parse(Interval{Float64}, str)) == d
    end
    @test isnai(@test_logs (:warn, r"invalid interval") parse(Interval{Float64}, "[1, 2]_ill"))

    @test isnai(@test_logs (:warn, r"incompatible") parse(Interval{Float64}, "[1, inf]_com"))
    x = parse(Interval{Float64}, "[1, 1e400]_com")
    @test (bounds(x) == (1.0, Inf)) & (decoration(x) == dac) & isguaranteed(x)
    @test isnai(@test_logs (:warn, r"incompatible") parse(Interval{Float64}, "[empty]_com"))
    x = parse(Interval{Float64}, "[empty]_trv")
    @test isempty_interval(x) & (decoration(x) == trv)
    @test isnai(@test_logs (:warn, r"failed to parse the decoration") parse(Interval{Float64}, "[1,2]_foo"))

    x = @test_logs parse(Interval{Float64}, "[nai]")
    @test isnai(x)
    for str ∈ ("[garbage]", "garbage", "", "[1, garbage]")
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, str))
    end
    @test isnai(@test_logs (:warn, r"wrong order") parse(Interval{Float64}, "[2,1]"))

    # the order of the bounds is known exactly, however close they are
    x = @test_logs parse(Interval{Float64}, "[1, 1.0000000000000002]")
    @test bounds(x) == (1.0, 1.0000000000000002)
    x = @test_logs parse(Interval{Float64}, "[1.0000000000000001, 1.0000000000000002]")
    @test bounds(x) == (1.0, 1.0000000000000002)
    x = @test_logs parse(Interval{Float64}, "[1e400, 2e400]_com")
    @test (bounds(x) == (1.7976931348623157e308, Inf)) & (decoration(x) == dac)
    for str ∈ ("[1.0000000000000002,1.0000000000000001]", "[0x1.00000000000002p0,0x1.00000000000001p0]", "[2e400, 1e400]",
               "[10000000000000001/10000000000000000,10000000000000002/10000000000000001]", "[1.00000000000000001, 1]")
        @test isnai(@test_logs (:warn, r"wrong order") parse(Interval{Float64}, str))
        @test isempty_interval(@test_logs (:warn, r"wrong order") parse(BareInterval{Float64}, str))
    end
    for str ∈ ("[inf, inf]", "[-inf, -inf]", "[inf]", "-inf", "[inf, 1]")
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, str))
    end
    @test_logs parse(Interval{Float64}, "[1, 1]")
    @test_logs parse(Interval{Float64}, "[1,2]")
end

@testset "Uncertainty forms" begin
    @test isequal_interval(parse(Interval{Float64}, "3?"), interval(2.5, 3.5))
    @test isequal_interval(parse(Interval{Float64}, "3?1"), interval(2.0, 4.0))
    @test isequal_interval(parse(Interval{Float64}, "3.0?1"), interval(2.9, 3.1))
    @test bounds(parse(Interval{Float64}, "6.42?2")) == (6.3999999999999995, 6.44)
    @test isequal_interval(parse(Interval{Float64}, "6.42?2e2"), interval(640, 644))
    @test isequal_interval(parse(Interval{Float64}, "4.5?5u"), interval(4.5, 5.0))
    @test bounds(parse(Interval{Float64}, "6.42?2d")) == (6.3999999999999995, 6.420000000000001)

    x = parse(Interval{Float64}, "3??u")
    @test (bounds(x) == (3.0, Inf)) & (decoration(x) == dac)
    x = parse(Interval{Float64}, "3??d")
    @test (bounds(x) == (-Inf, 3.0)) & (decoration(x) == dac)
    @test isequal_interval(parse(Interval{Float64}, "3??"), entireinterval(Interval{Float64}))
end

@testset "Decimal string enclosures" begin
    x = parse(Interval{Float64}, "0.1")
    @test bounds(x) == (0.09999999999999999, 0.1)
    @test (decoration(x) == com) & isguaranteed(x)
    @test in_interval(1//10, x)

    @test bounds(parse(Interval{Float64}, "1/3")) == (0.3333333333333333, 0.33333333333333337)

    @test bounds(parse(Interval{Float32}, "0.1")) === (0.099999994f0, 0.1f0)
    @test in_interval(1//10, parse(Interval{BigFloat}, "0.1"))
end

@testset "Exact values" begin
    @test _number("0.1") == 1//10
    @test _number("-1.5e3") == -1500
    @test _number(".5") == _number("0.5") == _number("5.e-1") == _number("0.50") == _number("0.000005e5") == 1//2
    @test _number("1200") == _number("1.2e3") == 1200
    @test _number("0x1.8p1") == 3
    @test _number("0") == _number("-0.00e5") == _number("+.0e128") == _number("-0x.0p600") == 0
    @test _number("-4/6") == _number("-4//6") == -2//3
    @test _number("inf") == _number("+infinity") == 1//0
    @test _number("-inf") == -1//0
    for str ∈ ("", ".", "1e", "e1", "1.2.3", "+-1", "1 e2", "nan", "0x1", "0x1.8", "0b1", "1/0", "1/-2", "1.5/2", "1//0", "1///2", "@inf@", "1_000", "infinit")
        @test_throws ArgumentError _number(str)
    end
    # a written exponent larger than `10^6` in absolute value is not supported
    @test _number("1e1000000") == big(10)^1000000
    @test _number("1.000000e-999995") == 1 // big(10)^999995
    @test _number("1" * "0"^1000001) == big(10)^1000001
    @test _number("0." * "0"^1000001 * "1") == 1 // big(10)^1000002
    for str ∈ ("1e1000001", "-1e-1000001", "0x1p-1000001", "1e99999999999999999999", "0e99999999999999999999", "1000e-1000002")
        @test_throws ArgumentError _number(str)
    end
    @test_throws ArgumentError _bounds("1?e1000002")
    @test_throws ArgumentError _bounds("0?0e2000000")
    @test _bounds("1.000000?e-999995") == (1999999 // (2 * big(10)^1000001), 2000001 // (2 * big(10)^1000001))

    @test isnothing(_bounds("[]")) && isnothing(_bounds("[ empty ]"))
    @test _bounds("[entire]") == _bounds("[,]") == _bounds("3??") == (-1//0, 1//0)
    @test _bounds("[1/3, 0.5]") == (1//3, 1//2)
    @test _bounds("0.03?3") == (0, 3//50)
    @test _bounds("-0.03?3e1") == (-3//5, 0)
    @test _bounds("2.5?") == (49//20, 51//20)
    @test _bounds("2.5?d") == (49//20, 5//2)
    @test _bounds("2.5??u") == (5//2, 1//0)
end

@testset "Rounding" begin
    # uncertain forms are exact up to the final rounding
    @test bounds(parse(Interval{Float64}, "0.03?3")) == (0.0, 0.060000000000000005)
    @test bounds(parse(Interval{Float64}, "-0.03?3")) == (-0.060000000000000005, 0.0)
    @test bounds(parse(Interval{Float64}, "100.03?3")) == (100.0, 100.06)
    @test bounds(parse(Interval{Rational{Int64}}, "0.03?3")) == (0//1, 3//50)

    # negative value whose denominator does not fit in the precision
    x = parse(Interval{BigFloat}, "-1?e-120")
    @test inf(x) < -3 // (2 * big(10)^120) < nextfloat(inf(x))
    @test prevfloat(sup(x)) < -1 // (2 * big(10)^120) < sup(x)

    # the global `BigFloat` precision does not affect the other bound types
    setprecision(BigFloat, 32) do
        @test bounds(parse(Interval{Float64}, "0.001")) == (0.0009999999999999998, 0.001)
        @test bounds(parse(Interval{Float64}, "0.001?0")) == (0.0009999999999999998, 0.001)
        @test bounds(parse(Interval{Float64}, "[1/1000, 1/1000]")) == (0.0009999999999999998, 0.001)
        @test precision(inf(parse(Interval{BigFloat}, "0.1"))) == 32
    end

    # `Rational` bound types: exact if the value fits, otherwise the closest rationals around it
    @test bounds(parse(BareInterval{Rational{BigInt}}, "1e-30")) == (1 // big(10)^30, 1 // big(10)^30)
    @test bounds(parse(BareInterval{Rational{Int8}}, "0.33")) == (33//100, 33//100)
    @test bounds(parse(BareInterval{Rational{Int8}}, "3.14159265358979323846")) == (113//36, 22//7)
    @test bounds(parse(BareInterval{Rational{Int8}}, "-3.14159265358979323846")) == (-22//7, -113//36)
    @test bounds(parse(BareInterval{Rational{Int64}}, "1e-30")) == (0//1, 1//typemax(Int64))
    @test bounds(parse(BareInterval{Rational{Int64}}, "-1e30")) == (-1//0, typemin(Int64)//1)
    x = parse(BareInterval{Rational{Int64}}, "3.14159265358979323846")
    @test inf(x) < 314159265358979323846 // big(10)^20 < sup(x)
    @test big(sup(x)) - big(inf(x)) < 1 // big(10)^36

    # an exponent larger than `10^6` in absolute value is not supported
    for T ∈ (Float64, BigFloat, Rational{Int64}, Rational{BigInt})
        for str ∈ ("1e1000001", "[1, 1e1000001]_com", "[1e-2000000, 0x1p0]", "1?e1000002", "1?e-99999999999999999999",
                   "[1e2000000, 0x1p6000000]", "[1/3, 1e2000000]", "0?0e2000000", "[0e2000000, 1]")
            @test isnai(@test_logs (:warn, r"exponent larger than 10\^6") parse(Interval{T}, str))
        end
        @test isempty_interval(@test_logs (:warn, r"exponent larger than 10\^6") parse(BareInterval{T}, "-0x1p5000000"))
    end
    # the limit is on the written exponent, so it does not depend on how the mantissa is written
    @test bounds(parse(Interval{Float64}, "0." * "0"^1000001 * "1")) == (0.0, 5.0e-324)
    @test bounds(parse(Interval{Float64}, "1.000000?e-999995")) == (0.0, 5.0e-324)
    # large exponents up to `10^6` are exact
    @test bounds(parse(Interval{Float64}, "[1, 1e1000000]_com")) == (1.0, Inf)
    @test decoration(parse(Interval{Float64}, "[1, 1e1000000]_com")) == dac
    @test bounds(parse(Interval{Float64}, "1e-1000000")) == (0.0, 5.0e-324)
    x = parse(Interval{BigFloat}, "1.5e999999")
    @test (sup(x) == nextfloat(inf(x))) & (inf(x) < big(10)^999999 * 3 // 2 < sup(x))
    @test isthin(parse(Interval{Rational{BigInt}}, "1" * "0"^1000001))
    @test bounds(parse(BareInterval{Rational{Int64}}, "1e1000000")) == (typemax(Int64)//1, 1//0)
    @test bounds(parse(BareInterval{Rational{Int64}}, "-1e-1000000")) == (-1//typemax(Int64), 0//1)
    # the order of the bounds is exact
    z = "0"^100
    for str ∈ ("[10.$(z)1e999999, 1e1000000]", "[1e1000000, 1e999999]", "[1e-1000000, 0]", "[0x1p1000000, 1e300000]")
        @test isnai(@test_logs (:warn, r"wrong order") parse(Interval{Float64}, str))
    end
    @test_logs parse(Interval{Float64}, "[10e999999, 1e1000000]")
    # a negative value has no lower bound in an unsigned `Rational` bound type
    @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{Rational{UInt8}}, "-3"))
    @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{Rational{UInt8}}, "[-1/2, 1]"))
end

@testset "Invalid literals" begin
    for str ∈ ("[1,2", "1,2]", "[1,2,3]", "[1;2]", "[1 2]", "[nan]", "[1, nan]", "[0b1, 0b11]", "[0x10, 0x20]", "[1/0, 2]", "[1///3, 1]", "[1/ 3, 1]",
               "1 .5", "1.2.3", "1.2.3?5", "abc?5", "?5", "3?-1", "3?1.5", "3?ud", "3 ?", "1e2?3", "3???", "[1,\n2]", "[1\n,2]", "[1\u00a0, 2]",
               "7"^5000 * "x", "[1/" * "7"^5000 * "x, 2]", "0x." * "f"^5000 * "p0x")
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, str))
        @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{Float64}, str))
    end
    # invalid UTF-8
    for str ∈ ("[1,\xff]", "[1,2]_\xff", "\xff")
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, str))
        @test isempty_interval(@test_logs (:warn, r"parsing error") parse(BareInterval{Float64}, str))
    end
    # no space is allowed around the underscore
    for str ∈ ("1.5\n_com", "3?\n_def", "1/3\n_com", "[1, 2]\n_com")
        @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, str))
    end
    @test isnai(@test_logs (:warn, r"parsing error") parse(Interval{Float64}, "[1,2] _com"))
    @test isnai(@test_logs (:warn, r"failed to parse the decoration") parse(Interval{Float64}, "[1,2]_ com"))
    # the space characters of the standard are the space and the TAB
    @test bounds(parse(Interval{Float64}, "[\t1 ,\t 2\t]")) == (1.0, 2.0)
    @test isempty_interval(parse(BareInterval{Float64}, "[ \t]"))
    # long strings
    @test bounds(parse(Interval{Float64}, "[" * "7"^5000 * "/3]")) == (floatmax(Float64), Inf)
    @test bounds(parse(Interval{Float64}, "0." * "3"^5000)) == (0.3333333333333333, 0.33333333333333337)
end

@testset "String macro" begin
    @test typeof(I"0.1") == Interval{Float64}
    x = I"[3, 4]"
    @test (bounds(x) == (3.0, 4.0)) & (decoration(x) == com) & isguaranteed(x)
    @test bounds(I"0.1") == (0.09999999999999999, 0.1)
    @test in_interval(1//10, I"0.1")

    @test isequal_interval(I"[2/3, 1.1]", interval(0.6666666666666666, 1.1))
    @test isequal_interval(I"[1]", interval(1))
    @test isequal_interval(I"[-0x1.3p-1, 2/3]", interval(-0.59375, 0.6666666666666667))
    @test isequal_interval(I"123412341234123412341241234", interval(1.234123412341234e26, 1.2341234123412342e26))

    @test in_interval(1//10, I"[0.1, 0.2]") && in_interval(2//10, I"[0.1, 0.2]")
    @test issubset_interval(I"[0.1, 0.2]", interval(prevfloat(0.1), nextfloat(0.2)))

    @test nextfloat(inf(I"0.1")) == sup(I"0.1")

    @test isequal_interval(interval(0.5), interval(1//2), I"0.5")

    @test inf(I"1e300") == 9.999999999999999e299 && sup(I"1e300") == 1.0e300
    @test inf(I"-1e307") == -1.0000000000000001e307 && sup(I"-1e307") == -1.0e307
    # corner case for enclosure, `0.100000000000000006` rounds down to `0.1` for `Float64`
    @test in_interval(big"0.100000000000000006", I"0.100000000000000006")
end

IntervalArithmetic.configure(numtype = Float32)
try
    @testset "@I_str uses the default numtype" begin
        @test typeof(I"0.1") == Interval{Float32}
        @test typeof(I"[1, 2]") == Interval{Float32}
    end
finally
    IntervalArithmetic.configure(numtype = Float64)
end

@testset "@I_str default numtype restored" begin
    @test typeof(I"0.1") == Interval{Float64}
end

@testset "_parse internals" begin
    x, overflow = _parse(Float64, "[1, 1e400]")
    @test (bounds(x) == (1.0, Inf)) & overflow
    x, overflow = _parse(Float64, "[1, inf]")
    @test (bounds(x) == (1.0, Inf)) & !overflow
    for str ∈ ("[empty]", "[entire]", "3??")
        _, overflow = _parse(Float64, str)
        @test !overflow
    end
    @test_throws ArgumentError _parse(Float64, "[garbage]")
    @test_throws ArgumentError _parse(Float64, "[nai]")
    @test_throws ArgumentError _parse(Float64, "[2, 1]")
end
