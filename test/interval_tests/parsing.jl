@testset "parse to Interval{Float32}" begin
    I32 = Interval{Float32}
    DI32 = DecoratedInterval{Float32}
    @test parse(I32, "[1, 2]") ≛ interval(1f0, 2f0)
    @test parse(I32, "[1e-324, 1e400]") ≛ interval(0f0, Float32(Inf))
    @test parse(I32, "[2,infinity]") ≛ interval(2f0, Float32(Inf))
    @test parse(I32, "[foobar]") ≛ emptyinterval(Float32)

    @test parse(DI32, "[1, 2]_com") ≛ DecoratedInterval(interval(1f0, 2f0), com)
    @test isnai(parse(DI32, "[foobar]"))
end


@testset "parse to Interval{BigFloat}" begin
    BI = Interval{BigFloat}
    DBI = DecoratedInterval{BigFloat}

    @test parse(BI, "[1, 2]") ≛ interval(big(1), big(2))
    @test parse(BI, "[1e-400, 2e400]") ≛ interval(big"1e-400", big"2e400")

    x = parse(DBI, "[1e-400, 1e400]")
    _x = DecoratedInterval(big"1e-400", big"1e400", com)
    @test x ≛ _x && decoration(x) == decoration(_x) && x isa DecoratedInterval{BigFloat}

end
