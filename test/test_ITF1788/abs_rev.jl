@testset "minimal.absRevBin_test" begin

    @test abs_rev(emptyinterval(), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(0.0, 1.0), emptyinterval())[2] === emptyinterval()

    @test abs_rev(interval(0.0, 1.0), interval(7.0, 9.0))[2] === emptyinterval()

    @test abs_rev(emptyinterval(), interval(0.0, 1.0))[2] === emptyinterval()

    @test abs_rev(interval(-2.0, -1.0), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(1.0, 1.0), entireinterval())[2] === Interval(-1.0, 1.0)

    @test abs_rev(interval(0.0, 0.0), entireinterval())[2] === Interval(0.0, 0.0)

    @test abs_rev(interval(-1.0, -1.0), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), entireinterval())[2] === Interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023)

    @test abs_rev(interval(0x1p-1022, 0x1p-1022), entireinterval())[2] === Interval(-0x1p-1022, 0x1p-1022)

    @test abs_rev(interval(-0x1p-1022, -0x1p-1022), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(-0x1.FFFFFFFFFFFFFp1023, -0x1.FFFFFFFFFFFFFp1023), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(1.0, 2.0), entireinterval())[2] === Interval(-2.0, 2.0)

    @test abs_rev(interval(1.0, 2.0), interval(0.0, 2.0))[2] === Interval(1.0, 2.0)

    @test abs_rev(interval(0.0, 1.0), interval(-0.5, 2.0))[2] === Interval(-0.5, 1.0)

    @test abs_rev(interval(-1.0, 1.0), entireinterval())[2] === Interval(-1.0, 1.0)

    @test abs_rev(interval(-1.0, 0.0), entireinterval())[2] === Interval(0.0, 0.0)

    @test abs_rev(interval(0.0, Inf), entireinterval())[2] === entireinterval()

    @test abs_rev(entireinterval(), entireinterval())[2] === entireinterval()

    @test abs_rev(interval(-Inf, 0.0), entireinterval())[2] === Interval(0.0, 0.0)

    @test abs_rev(interval(1.0, Inf), interval(-Inf, 0.0))[2] === Interval(-Inf, -1.0)

    @test abs_rev(interval(-1.0, Inf), entireinterval())[2] === entireinterval()

    @test abs_rev(interval(-Inf, -1.0), entireinterval())[2] === emptyinterval()

    @test abs_rev(interval(-Inf, 1.0), entireinterval())[2] === Interval(-1.0, 1.0)

end

