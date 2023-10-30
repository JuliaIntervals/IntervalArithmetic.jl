@testset "minimal.powRev1_test" begin

    @test pow_rev1(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), bareinterval(-Inf,-1.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(-Inf,-1.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(-Inf,0.9), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(1.1,Inf), bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.1,Inf), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,0.9), bareinterval(1.0,Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,1.0), bareinterval(-Inf,0.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow_rev1(bareinterval(1.0,2.0), bareinterval(0.0,0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,0.0)

    @test pow_rev1(bareinterval(1.0,1.0), bareinterval(0.0,0.0), bareinterval(0.0,0.0)) === bareinterval(0.0,0.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), bareinterval(1.0,1.0)) === bareinterval(1.0,1.0)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,1.0), bareinterval(2.0,3.0)) === bareinterval(2.0,3.0)

    @test_broken pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0,Inf)

    @test_broken pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), bareinterval(20.0,30.0)) === bareinterval(20.0,30.0)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,1.0), bareinterval(1.0,1.0)) === bareinterval(1.0,1.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, 2.0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 2.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 2.0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 2.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 1.0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 1.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 1.0)

    @test pow_rev1(bareinterval(-4.0,-2.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,-2.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,0.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,0.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,0.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,0.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,0.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,0.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,0.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,0.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(bareinterval(-4.0,4.0), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(bareinterval(-Inf,4.0), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(-4.0,Inf), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(entireinterval(BareInterval{Float64}), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,0.5), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,0.5), bareinterval(1.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.25,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,1.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,1.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,2.0), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,Inf), bareinterval(0.0, 1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.0,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,2.0), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(-Inf,Inf), bareinterval(1.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(0.5,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,2.0), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,Inf), bareinterval(0.0,1.0)) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,4.0), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,Inf), bareinterval(0.0,1.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(0.0,4.0), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,4.0), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(0.0,Inf), bareinterval(2.0,Inf), bareinterval(1.0,Inf)) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.0,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(-Inf,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.25,0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 1.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 1.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 1.0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.25,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 1.0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(1.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 1.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.0,1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(-Inf,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(-Inf,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.5,2.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(0.5,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(1.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, 2.0)

    @test pow_rev1(bareinterval(2.0,4.0), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(2.0,4.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, 2.0)

    @test pow_rev1(bareinterval(2.0,Inf), bareinterval(2.0,Inf), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

end

@testset "minimal.powRev2_test" begin

    @test pow_rev2(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 0.0), bareinterval(0.1, Inf), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(-Inf, 0.9), bareinterval(0.0, 0.9), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.1, Inf), bareinterval(1.1, Inf), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(-Inf, 0.9), bareinterval(1.1, Inf), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.1, Inf), bareinterval(0.0, 0.9), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0), bareinterval(1.0, 2.0)) === bareinterval(1.0, 2.0)

    @test_broken pow_rev2(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0), bareinterval(1.0, 2.0)) === bareinterval(1.0, 2.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}), bareinterval(1.0, 2.0)) === bareinterval(1.0, 2.0)

    @test_broken pow_rev2(bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(1.0, 1.0), bareinterval(2.0, 3.0)) === bareinterval(2.0, 3.0)

    @test_broken pow_rev2(entireinterval(BareInterval{Float64}), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(entireinterval(BareInterval{Float64}), bareinterval(1.0, 1.0), bareinterval(2.0, 3.0)) === bareinterval(2.0, 3.0)

    @test pow_rev2(bareinterval(2.0, 3.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(2.0, 3.0), bareinterval(1.0, 1.0), bareinterval(2.0, 3.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 0.5), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 0.5), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 0.5), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 2.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.5)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-0.5, Inf)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-0.5, 0.5)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.5)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-0.5, 0.0)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 0.25), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 0.25), bareinterval(2.0, Inf), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, Inf)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 2.0)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev2(bareinterval(0.25, 0.5), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, 0.0)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, Inf)

    @test pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 1.0)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 1.0)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 0.0)

    @test pow_rev2(bareinterval(0.25, 0.5), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(-2.0, -0.5)

    @test_broken pow_rev2(bareinterval(0.25, 0.5), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, Inf)

    @test pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.5, Inf)

    @test pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.25, 1.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 1.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, -0.5)

    @test pow_rev2(bareinterval(1.0, 1.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.25, 1.0), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 1.0), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 1.0), bareinterval(2.0, Inf), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.0, 2.0), bareinterval(2.0, Inf), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.0, Inf), bareinterval(2.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(1.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(0.5, 2.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test_broken pow_rev2(bareinterval(0.5, 2.0), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(0.5, Inf), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test pow_rev2(bareinterval(0.5, Inf), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, -1.0)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, -1.0)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.25, 0.5), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 1.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.0, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, Inf), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(0.5, Inf), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, Inf), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(1.0, 2.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test pow_rev2(bareinterval(1.0, 2.0), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, Inf), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(1.0, 2.0), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(1.0, Inf)

    @test pow_rev2(bareinterval(1.0, Inf), bareinterval(2.0, 4.0), bareinterval(0.0, Inf)) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, -0.5)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(0.0, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.0, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-2.0, -0.5)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.25, 0.5), entireinterval(BareInterval{Float64})) === bareinterval(-2.0, 0.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.25, 0.5), bareinterval(0.0, Inf)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 0.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.5, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 0.0)

    @test pow_rev2(bareinterval(2.0, 4.0), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(1.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(0.0, 1.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 0.0)

    @test pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(0.0, 1.0), bareinterval(0.0, Inf)) === bareinterval(0.0, 0.0)

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 1.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-Inf, 1.0)

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 1.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(0.5, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 1.0)

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(1.0, 2.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test pow_rev2(bareinterval(2.0, 4.0), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, 0.0)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(1.0, 2.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, 0.0)

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.5, 2.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(2.0, 4.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 2.0)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(2.0, 4.0), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

    @test_broken pow_rev2(bareinterval(2.0, 4.0), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.5, Inf)

    @test pow_rev2(bareinterval(2.0, Inf), bareinterval(2.0, Inf), entireinterval(BareInterval{Float64})) === bareinterval(0.0, Inf)

    @test_broken pow_rev2(bareinterval(2.0, Inf), bareinterval(2.0, Inf), bareinterval(-Inf, 0.0)) === emptyinterval(BareInterval{Float64})

end
