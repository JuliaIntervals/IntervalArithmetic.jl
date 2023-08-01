@testset "minimal.absRevBin_test" begin

    @test equal(abs_rev(emptyinterval(), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(0.0, 1.0), emptyinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(0.0, 1.0), interval(7.0, 9.0))[2], emptyinterval())

    @test equal(abs_rev(emptyinterval(), interval(0.0, 1.0))[2], emptyinterval())

    @test equal(abs_rev(interval(-2.0, -1.0), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(1.0, 1.0), entireinterval())[2], interval(-1.0, 1.0))

    @test equal(abs_rev(interval(0.0, 0.0), entireinterval())[2], interval(0.0, 0.0))

    @test equal(abs_rev(interval(-1.0, -1.0), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), entireinterval())[2], interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023))

    @test equal(abs_rev(interval(0x1p-1022, 0x1p-1022), entireinterval())[2], interval(-0x1p-1022, 0x1p-1022))

    @test equal(abs_rev(interval(-0x1p-1022, -0x1p-1022), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(-0x1.FFFFFFFFFFFFFp1023, -0x1.FFFFFFFFFFFFFp1023), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(1.0, 2.0), entireinterval())[2], interval(-2.0, 2.0))

    @test equal(abs_rev(interval(1.0, 2.0), interval(0.0, 2.0))[2], interval(1.0, 2.0))

    @test equal(abs_rev(interval(0.0, 1.0), interval(-0.5, 2.0))[2], interval(-0.5, 1.0))

    @test equal(abs_rev(interval(-1.0, 1.0), entireinterval())[2], interval(-1.0, 1.0))

    @test equal(abs_rev(interval(-1.0, 0.0), entireinterval())[2], interval(0.0, 0.0))

    @test equal(abs_rev(interval(0.0, Inf), entireinterval())[2], entireinterval())

    @test equal(abs_rev(entireinterval(), entireinterval())[2], entireinterval())

    @test equal(abs_rev(interval(-Inf, 0.0), entireinterval())[2], interval(0.0, 0.0))

    @test equal(abs_rev(interval(1.0, Inf), interval(-Inf, 0.0))[2], interval(-Inf, -1.0))

    @test equal(abs_rev(interval(-1.0, Inf), entireinterval())[2], entireinterval())

    @test equal(abs_rev(interval(-Inf, -1.0), entireinterval())[2], emptyinterval())

    @test equal(abs_rev(interval(-Inf, 1.0), entireinterval())[2], interval(-1.0, 1.0))

end
