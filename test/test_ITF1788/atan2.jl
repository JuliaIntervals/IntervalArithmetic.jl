@testset "minimal.atan2_test" begin

    @test atan(emptyinterval(), emptyinterval()) ≛ emptyinterval()

    @test atan(emptyinterval(), entireinterval()) ≛ emptyinterval()

    @test atan(entireinterval(), emptyinterval()) ≛ emptyinterval()

    @test atan(interval(0.0, 0.0), interval(0.0, 0.0)) ≛ emptyinterval()

    @test atan(entireinterval(), entireinterval()) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(0.0, 0.0), interval(-Inf, 0.0)) ≛ interval(0x1.921FB54442D18p1, 0x1.921FB54442D19p1)

    @test atan(interval(0.0, 0.0), interval(0.0, Inf)) ≛ interval(0.0, 0.0)

    @test atan(interval(0.0, Inf), interval(0.0, 0.0)) ≛ interval(0x1.921FB54442D18p0, 0x1.921FB54442D19p0)

    @test atan(interval(-Inf, 0.0), interval(0.0, 0.0)) ≛ interval(-0x1.921FB54442D19p0, -0x1.921FB54442D18p0)

    @test atan(interval(-0x1p-1022, 0.0), interval(-0x1p-1022, -0x1p-1022)) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(1.0, 1.0), interval(-1.0, -1.0)) ≛ interval(0x1.2D97C7F3321D2p1, 0x1.2D97C7F3321D3p1)

    @test atan(interval(1.0, 1.0), interval(1.0, 1.0)) ≛ interval(0x1.921FB54442D18p-1, 0x1.921FB54442D19p-1)

    @test atan(interval(-1.0, -1.0), interval(1.0, 1.0)) ≛ interval(-0x1.921FB54442D19p-1, -0x1.921FB54442D18p-1)

    @test atan(interval(-1.0, -1.0), interval(-1.0, -1.0)) ≛ interval(-0x1.2D97C7F3321D3p1, -0x1.2D97C7F3321D2p1)

    @test atan(interval(-0x1p-1022, 0x1p-1022), interval(-0x1p-1022, -0x1p-1022)) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(-0x1p-1022, 0x1p-1022), interval(0x1p-1022, 0x1p-1022)) ≛ interval(-0x1.921FB54442D19p-1, +0x1.921FB54442D19p-1)

    @test atan(interval(-0x1p-1022, -0x1p-1022), interval(-0x1p-1022, 0x1p-1022)) ≛ interval(-0x1.2D97C7F3321D3p1, -0x1.921FB54442D18p-1)

    @test atan(interval(0x1p-1022, 0x1p-1022), interval(-0x1p-1022, 0x1p-1022)) ≛ interval(0x1.921FB54442D18p-1, 0x1.2D97C7F3321D3p1)

    @test atan(interval(-2.0, 2.0), interval(-3.0, -1.0)) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(0.0, 2.0), interval(-3.0, -1.0)) ≛ interval(0x1.0468A8ACE4DF6p1, 0x1.921FB54442D19p1)

    @test atan(interval(1.0, 3.0), interval(-3.0, -1.0)) ≛ interval(0x1.E47DF3D0DD4Dp0, 0x1.68F095FDF593Dp1)

    @test atan(interval(1.0, 3.0), interval(-2.0, 0.0)) ≛ interval(0x1.921FB54442D18p0, 0x1.56C6E7397F5AFp1)

    @test atan(interval(1.0, 3.0), interval(-2.0, 2.0)) ≛ interval(0x1.DAC670561BB4Fp-2, 0x1.56C6E7397F5AFp1)

    @test atan(interval(1.0, 3.0), interval(0.0, 2.0)) ≛ interval(0x1.DAC670561BB4Fp-2, 0x1.921FB54442D19p0)

    @test atan(interval(1.0, 3.0), interval(1.0, 3.0)) ≛ interval(0x1.4978FA3269EE1p-2, 0x1.3FC176B7A856p0)

    @test atan(interval(0.0, 2.0), interval(1.0, 3.0)) ≛ interval(0x0p0, 0x1.1B6E192EBBE45p0)

    @test atan(interval(-2.0, 2.0), interval(1.0, 3.0)) ≛ interval(-0x1.1B6E192EBBE45p0, +0x1.1B6E192EBBE45p0)

    @test atan(interval(-2.0, 0.0), interval(1.0, 3.0)) ≛ interval(-0x1.1B6E192EBBE45p0, 0x0p0)

    @test atan(interval(-3.0, -1.0), interval(1.0, 3.0)) ≛ interval(-0x1.3FC176B7A856p0, -0x1.4978FA3269EE1p-2)

    @test atan(interval(-3.0, -1.0), interval(0.0, 2.0)) ≛ interval(-0x1.921FB54442D19p0, -0x1.DAC670561BB4Fp-2)

    @test atan(interval(-3.0, -1.0), interval(-2.0, 2.0)) ≛ interval(-0x1.56C6E7397F5AFp1, -0x1.DAC670561BB4Fp-2)

    @test atan(interval(-3.0, -1.0), interval(-2.0, 0.0)) ≛ interval(-0x1.56C6E7397F5AFp1, -0x1.921FB54442D18p0)

    @test atan(interval(-3.0, -1.0), interval(-3.0, -1.0)) ≛ interval(-0x1.68F095FDF593Dp1, -0x1.E47DF3D0DD4Dp0)

    @test atan(interval(-2.0, 0.0), interval(-3.0, -1.0)) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(-5.0, 0.0), interval(-5.0, 0.0)) ≛ interval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(interval(0.0, 5.0), interval(-5.0, 0.0)) ≛ interval(0x1.921FB54442D18p0, 0x1.921FB54442D19p1)

    @test atan(interval(0.0, 5.0), interval(0.0, 5.0)) ≛ interval(0x0p0, 0x1.921FB54442D19p0)

    @test atan(interval(-5.0, 0.0), interval(0.0, 5.0)) ≛ interval(-0x1.921FB54442D19p0, 0x0p0)

end
