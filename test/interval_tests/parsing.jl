@testset "BareInterval" begin
    for T ∈ (Float16, Float32, Float64, BigFloat)
        @test isequal_interval(parse(BareInterval{T}, "[1, 2]"), bareinterval(T, 1, 2))
        if T != BigFloat
            @test isequal_interval(parse(BareInterval{T}, "[1e-324, 1e400]"), bareinterval(T, 0, Inf))
        else
            @test isequal_interval(parse(BareInterval{BigFloat}, "[1e-324, 1e400]"), bareinterval(BigFloat("1e-324", RoundDown), BigFloat("1e400", RoundUp)))
        end
        @test isequal_interval(parse(BareInterval{T}, "[2,infinity]"), bareinterval(T, 2, Inf))
        @test isempty_interval(parse(BareInterval{T}, "[foobar]"))
    end

    @test isequal_interval(parse(BareInterval{Rational{Int64}}, "0.1"), bareinterval(Rational{Int64}, 1//10))
    @test isequal_interval(parse(BareInterval{Rational{Int64}}, "[0.1, 0.3]"), bareinterval(Rational{Int64}, 1//10, 3//10))
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
        @test isnai(parse(Interval{T}, "[foobar]"))

        x = parse(Interval{T}, "[1, 2]_com")
        y = parse(Interval{T}, "[1, 2]")
        z = interval(T, 1, 2)
        @test isequal_interval(x, y, z) & (decoration(x) == decoration(y) == decoration(z))
    end

    @test isequal_interval(parse(Interval{Rational{Int64}}, "0.1"), interval(Rational{Int64}, 1//10))
    @test isequal_interval(parse(Interval{Rational{Int64}}, "[0.1, 0.3]"), interval(Rational{Int64}, 1//10, 3//10))
end

@testset "String macro" begin
    @test typeof(I"0.1") == Interval{Float64}

    @test isequal_interval(I"[2/3, 1.1]", interval(0.6666666666666666, 1.1))
    @test isequal_interval(I"[1]", interval(1))
    @test isequal_interval(I"[-0x1.3p-1, 2/3]", interval(-0.59375, 0.6666666666666667))
    @test isequal_interval(I"123412341234123412341241234", interval(1.234123412341234e26, 1.2341234123412342e26))
    @test isequal_interval(interval(big"3"), interval(3))
    @test isequal_interval(interval(Float64, big"1e10000"), interval(Float64, big(10)^10000), interval(prevfloat(Inf), Inf))

    @test in_interval(1//10, I"[0.1, 0.2]") && in_interval(2//10, I"[0.1, 0.2]")
    @test issubset_interval(I"[0.1, 0.2]", interval(prevfloat(0.1), nextfloat(0.2)))

    @test nextfloat(inf(I"0.1")) == sup(I"0.1")

    @test isequal_interval(interval(0.5), interval(1//2), I"0.5")

    @test inf(I"1e300") == 9.999999999999999e299 && sup(I"1e300") == 1.0e300
    @test inf(I"-1e307") == -1.0000000000000001e307 && sup(I"-1e307") == -1.0e307
    # corner case for enclosure, `0.100000000000000006` rounds down to `0.1` for `Float64`
    @test in_interval(big"0.100000000000000006", I"0.100000000000000006")
end
