@testset "minimal.atan2_test" begin

    @test atan(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === bareinterval(0x1.921FB54442D18p1, 0x1.921FB54442D19p1)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, Inf)) === bareinterval(0.0, 0.0)

    @test atan(bareinterval(0.0, Inf), bareinterval(0.0, 0.0)) === bareinterval(0x1.921FB54442D18p0, 0x1.921FB54442D19p0)

    @test atan(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === bareinterval(-0x1.921FB54442D19p0, -0x1.921FB54442D18p0)

    @test atan(bareinterval(-0x1p-1022, 0.0), bareinterval(-0x1p-1022, -0x1p-1022)) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(1.0, 1.0), bareinterval(-1.0, -1.0)) === bareinterval(0x1.2D97C7F3321D2p1, 0x1.2D97C7F3321D3p1)

    @test atan(bareinterval(1.0, 1.0), bareinterval(1.0, 1.0)) === bareinterval(0x1.921FB54442D18p-1, 0x1.921FB54442D19p-1)

    @test atan(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) === bareinterval(-0x1.921FB54442D19p-1, -0x1.921FB54442D18p-1)

    @test atan(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === bareinterval(-0x1.2D97C7F3321D3p1, -0x1.2D97C7F3321D2p1)

    @test atan(bareinterval(-0x1p-1022, 0x1p-1022), bareinterval(-0x1p-1022, -0x1p-1022)) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(-0x1p-1022, 0x1p-1022), bareinterval(0x1p-1022, 0x1p-1022)) === bareinterval(-0x1.921FB54442D19p-1, +0x1.921FB54442D19p-1)

    @test atan(bareinterval(-0x1p-1022, -0x1p-1022), bareinterval(-0x1p-1022, 0x1p-1022)) === bareinterval(-0x1.2D97C7F3321D3p1, -0x1.921FB54442D18p-1)

    @test atan(bareinterval(0x1p-1022, 0x1p-1022), bareinterval(-0x1p-1022, 0x1p-1022)) === bareinterval(0x1.921FB54442D18p-1, 0x1.2D97C7F3321D3p1)

    @test atan(bareinterval(-2.0, 2.0), bareinterval(-3.0, -1.0)) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(0.0, 2.0), bareinterval(-3.0, -1.0)) === bareinterval(0x1.0468A8ACE4DF6p1, 0x1.921FB54442D19p1)

    @test atan(bareinterval(1.0, 3.0), bareinterval(-3.0, -1.0)) === bareinterval(0x1.E47DF3D0DD4Dp0, 0x1.68F095FDF593Dp1)

    @test atan(bareinterval(1.0, 3.0), bareinterval(-2.0, 0.0)) === bareinterval(0x1.921FB54442D18p0, 0x1.56C6E7397F5AFp1)

    @test atan(bareinterval(1.0, 3.0), bareinterval(-2.0, 2.0)) === bareinterval(0x1.DAC670561BB4Fp-2, 0x1.56C6E7397F5AFp1)

    @test atan(bareinterval(1.0, 3.0), bareinterval(0.0, 2.0)) === bareinterval(0x1.DAC670561BB4Fp-2, 0x1.921FB54442D19p0)

    @test atan(bareinterval(1.0, 3.0), bareinterval(1.0, 3.0)) === bareinterval(0x1.4978FA3269EE1p-2, 0x1.3FC176B7A856p0)

    @test atan(bareinterval(0.0, 2.0), bareinterval(1.0, 3.0)) === bareinterval(0x0p0, 0x1.1B6E192EBBE45p0)

    @test atan(bareinterval(-2.0, 2.0), bareinterval(1.0, 3.0)) === bareinterval(-0x1.1B6E192EBBE45p0, +0x1.1B6E192EBBE45p0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(1.0, 3.0)) === bareinterval(-0x1.1B6E192EBBE45p0, 0x0p0)

    @test atan(bareinterval(-3.0, -1.0), bareinterval(1.0, 3.0)) === bareinterval(-0x1.3FC176B7A856p0, -0x1.4978FA3269EE1p-2)

    @test atan(bareinterval(-3.0, -1.0), bareinterval(0.0, 2.0)) === bareinterval(-0x1.921FB54442D19p0, -0x1.DAC670561BB4Fp-2)

    @test atan(bareinterval(-3.0, -1.0), bareinterval(-2.0, 2.0)) === bareinterval(-0x1.56C6E7397F5AFp1, -0x1.DAC670561BB4Fp-2)

    @test atan(bareinterval(-3.0, -1.0), bareinterval(-2.0, 0.0)) === bareinterval(-0x1.56C6E7397F5AFp1, -0x1.921FB54442D18p0)

    @test atan(bareinterval(-3.0, -1.0), bareinterval(-3.0, -1.0)) === bareinterval(-0x1.68F095FDF593Dp1, -0x1.E47DF3D0DD4Dp0)

    @test atan(bareinterval(-2.0, 0.0), bareinterval(-3.0, -1.0)) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(-5.0, 0.0), bareinterval(-5.0, 0.0)) === bareinterval(-0x1.921FB54442D19p1, +0x1.921FB54442D19p1)

    @test atan(bareinterval(0.0, 5.0), bareinterval(-5.0, 0.0)) === bareinterval(0x1.921FB54442D18p0, 0x1.921FB54442D19p1)

    @test atan(bareinterval(0.0, 5.0), bareinterval(0.0, 5.0)) === bareinterval(0x0p0, 0x1.921FB54442D19p0)

    @test atan(bareinterval(-5.0, 0.0), bareinterval(0.0, 5.0)) === bareinterval(-0x1.921FB54442D19p0, 0x0p0)

end
