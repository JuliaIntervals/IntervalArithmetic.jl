@testset "minimal.absRevBin_test" begin

    @test isequal_interval(abs_rev(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(0.0, 1.0), emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(0.0, 1.0), bareinterval(7.0, 9.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(emptyinterval(BareInterval{Float64}), bareinterval(0.0, 1.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-2.0, -1.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64}))[2], bareinterval(-1.0, 1.0))

    @test isequal_interval(abs_rev(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}))[2], bareinterval(0.0, 0.0))

    @test isequal_interval(abs_rev(bareinterval(-1.0, -1.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), entireinterval(BareInterval{Float64}))[2], bareinterval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023))

    @test isequal_interval(abs_rev(bareinterval(0x1p-1022, 0x1p-1022), entireinterval(BareInterval{Float64}))[2], bareinterval(-0x1p-1022, 0x1p-1022))

    @test isequal_interval(abs_rev(bareinterval(-0x1p-1022, -0x1p-1022), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-0x1.FFFFFFFFFFFFFp1023, -0x1.FFFFFFFFFFFFFp1023), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64}))[2], bareinterval(-2.0, 2.0))

    @test isequal_interval(abs_rev(bareinterval(1.0, 2.0), bareinterval(0.0, 2.0))[2], bareinterval(1.0, 2.0))

    @test isequal_interval(abs_rev(bareinterval(0.0, 1.0), bareinterval(-0.5, 2.0))[2], bareinterval(-0.5, 1.0))

    @test isequal_interval(abs_rev(bareinterval(-1.0, 1.0), entireinterval(BareInterval{Float64}))[2], bareinterval(-1.0, 1.0))

    @test isequal_interval(abs_rev(bareinterval(-1.0, 0.0), entireinterval(BareInterval{Float64}))[2], bareinterval(0.0, 0.0))

    @test isequal_interval(abs_rev(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64}))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}))[2], bareinterval(0.0, 0.0))

    @test isequal_interval(abs_rev(bareinterval(1.0, Inf), bareinterval(-Inf, 0.0))[2], bareinterval(-Inf, -1.0))

    @test isequal_interval(abs_rev(bareinterval(-1.0, Inf), entireinterval(BareInterval{Float64}))[2], entireinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-Inf, -1.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(abs_rev(bareinterval(-Inf, 1.0), entireinterval(BareInterval{Float64}))[2], bareinterval(-1.0, 1.0))

end
