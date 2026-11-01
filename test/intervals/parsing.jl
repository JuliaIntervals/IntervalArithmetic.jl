using Test
using IntervalArithmetic
using IntervalArithmetic: _parse, _parse_num

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
    @test isnai(@test_logs (:warn, r"ill-formed interval") parse(Interval{Float64}, "[2,1]"))

    x = @test_logs (:warn, r"atomic") parse(Interval{Float64}, "[1, 1.0000000000000002]")
    @test bounds(x) == (1.0, 1.0000000000000002)
    x = @test_logs (:warn, r"atomic") parse(Interval{Float64}, "[1e400, 2e400]_com")
    @test (bounds(x) == (1.7976931348623157e308, Inf)) & (decoration(x) == dac)
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

    x = parse(Interval{Float64}, "0.03?3")
    @test inf(x) == 0

    x = parse(Interval{Float64}, "100.03?3")
    @test inf(x) == 100
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

@testset "_parse_num" begin
    @test _parse_num(Float64, "0.1", RoundDown) == 0.09999999999999999
    @test _parse_num(Float64, "0.1", RoundUp) == 0.1
    @test _parse_num(Float64, "0.1", RoundDown) < _parse_num(Float64, "0.1", RoundUp)
    @test _parse_num(Float64, "0.1", RoundDown) < 1//10 < _parse_num(Float64, "0.1", RoundUp)
    @test _parse_num(Float64, "1/3", RoundDown) == 0.3333333333333333

    @test _parse_num(Rational{Int64}, "1/3", RoundDown) == _parse_num(Rational{Int64}, "1/3", RoundUp) == 1//3
    @test _parse_num(Rational{Int64}, "0.1", RoundDown) ≤ 1//10 ≤ _parse_num(Rational{Int64}, "0.1", RoundUp)
    @test _parse_num(Rational{Int64}, "3.14159", RoundDown) ≤ 314159//100000 ≤ _parse_num(Rational{Int64}, "3.14159", RoundUp)
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
    @test isequal_interval(_parse("0.1"), parse(Interval{Float64}, "0.1"))

    _, flag, isexactnai, iserror = _parse(Float64, "[1, 1e400]")
    @test (flag == false) & (isexactnai == false) & (iserror == false)
    _, flag, isexactnai, iserror = _parse(Float64, "[1, inf]")
    @test (flag == true) & (isexactnai == false) & (iserror == false)
    _, flag, isexactnai, iserror = _parse(Float64, "[nai]")
    @test (flag == true) & (isexactnai == true) & (iserror == false)
    for str ∈ ("[empty]", "[entire]", "3??")
        _, flag, isexactnai, iserror = _parse(Float64, str)
        @test (flag == true) & (isexactnai == false) & (iserror == false)
    end
    x, flag, isexactnai, iserror = _parse(Float64, "[garbage]")
    @test (isexactnai == false) & (iserror == true)
    @test isnai(x)
end
