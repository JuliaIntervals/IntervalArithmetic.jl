@testset "minimal.powRev1_test" begin

    @test pow_rev1(emptyinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev1(emptyinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev1(entireinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev1(entireinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev1(emptyinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test pow_rev1(emptyinterval(), entireinterval(), entireinterval()) === emptyinterval()

    @test pow_rev1(entireinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test pow_rev1(entireinterval(), entireinterval(), entireinterval()) === interval(0.0, Inf)


    @test pow_rev1(entireinterval(), entireinterval(), interval(-Inf,-1.0)) === emptyinterval()

    @test_broken pow_rev1(interval(-Inf,-1.0), entireinterval(), interval(-Inf,0.0)) === emptyinterval()

    @test_broken pow_rev1(interval(-Inf,0.0), entireinterval(), interval(-Inf,0.0)) === emptyinterval()

    @test pow_rev1(interval(-Inf,0.0), interval(-Inf,0.0), entireinterval()) === emptyinterval()

    @test_broken pow_rev1(interval(-Inf,0.0), interval(-Inf,0.9), interval(0.0,1.0)) === emptyinterval()

    @test_broken pow_rev1(interval(-Inf,0.0), interval(1.1,Inf), interval(1.0,Inf)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.1,Inf), interval(0.0,1.0)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(-Inf,0.9), interval(1.0,Inf)) === emptyinterval()

    @test pow_rev1(interval(0.0,0.0), interval(1.0,1.0), interval(-Inf,0.0)) === emptyinterval()

    @test pow_rev1(entireinterval(), interval(0.0,0.0), entireinterval()) === interval(0.0,0.0)

    @test pow_rev1(entireinterval(), interval(-Inf,0.0), entireinterval()) === interval(0.0,0.0)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,0.0), entireinterval()) === interval(0.0,0.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,0.0), entireinterval()) === interval(0.0,0.0)

    @test pow_rev1(interval(1.0,2.0), interval(0.0,0.0), entireinterval()) === interval(0.0,0.0)

    @test pow_rev1(interval(1.0,1.0), interval(0.0,0.0), interval(0.0,0.0)) === interval(0.0,0.0)

    @test pow_rev1(entireinterval(), interval(1.0,1.0), interval(1.0,1.0)) === interval(1.0,1.0)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,1.0), entireinterval()) === interval(0.0,Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,1.0), interval(2.0,3.0)) === interval(2.0,3.0)

    @test_broken pow_rev1(entireinterval(), interval(1.0,1.0), entireinterval()) === interval(0.0,Inf)

    @test_broken pow_rev1(entireinterval(), interval(1.0,1.0), interval(20.0,30.0)) === interval(20.0,30.0)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,1.0), interval(1.0,1.0)) === interval(1.0,1.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.0,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.0,0.5), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(-Inf,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(-Inf,0.5), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.25,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, 2.0)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.25,0.5), entireinterval()) === interval(1.0, 2.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.25,1.0), entireinterval()) === interval(1.0, 2.0)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.25,1.0), entireinterval()) === interval(1.0, 2.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(1.0,1.0), entireinterval()) === interval(1.0, 1.0)

    @test pow_rev1(interval(-Inf,-2.0), interval(1.0,1.0), entireinterval()) === interval(1.0, 1.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.0,1.0), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.0,1.0), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.0,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.0,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(-Inf,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(-Inf,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,-2.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.5,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.5,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(-4.0,-2.0), interval(0.5,Inf), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(-Inf,-2.0), interval(0.5,Inf), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(-4.0,-2.0), interval(1.0,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 1.0)

    @test pow_rev1(interval(-Inf,-2.0), interval(1.0,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 1.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(1.0,Inf), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,-2.0), interval(1.0,Inf), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(2.0,4.0), entireinterval()) === interval(0.5, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,-2.0), interval(2.0,4.0), entireinterval()) === interval(0.5, 1.0)

    @test pow_rev1(interval(-4.0,-2.0), interval(2.0,Inf), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,-2.0), interval(2.0,Inf), entireinterval()) === interval(0.0, 1.0)


    @test pow_rev1(interval(0.0,0.0), interval(0.0,0.5), entireinterval()) === emptyinterval()

    @test pow_rev1(interval(0.0,0.0), interval(-Inf,0.5), entireinterval()) === emptyinterval()

    @test pow_rev1(interval(0.0,0.0), interval(0.25,0.5), entireinterval()) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,0.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)


    @test pow_rev1(interval(0.0,0.0), interval(2.0,4.0), entireinterval()) === emptyinterval()

    @test pow_rev1(interval(0.0,0.0), interval(2.0,Inf), entireinterval()) === emptyinterval()

    @test pow_rev1(interval(-4.0,0.0), interval(0.0,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.0,0.5), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(-Inf,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(-Inf,0.5), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(0.25,0.5), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.25,0.5), entireinterval()) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,0.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,0.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,0.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,0.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,0.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,0.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,0.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,0.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,0.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,0.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,0.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,0.0), interval(2.0,4.0), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,0.0), interval(2.0,4.0), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,0.0), interval(2.0,Inf), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,0.0), interval(2.0,Inf), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,0.5), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(0.0,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(-Inf,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(0.0,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(-Inf,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.25,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.25,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.25,0.5), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.25,0.5), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-4.0,Inf), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(0.25,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.25,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(0.25,0.5), interval(1.0, Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(entireinterval(), interval(0.25,0.5), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(entireinterval(), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(entireinterval(), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(entireinterval(), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(entireinterval(), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(2.0,4.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(2.0,4.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,4.0), interval(2.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-Inf,4.0), interval(2.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(2.0,4.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(2.0,4.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(2.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(entireinterval(), interval(2.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(2.0,4.0), interval(0.0,1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,4.0), interval(2.0,4.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(2.0,Inf), interval(0.0,1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(-Inf,4.0), interval(2.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(2.0,4.0), interval(0.0,1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(entireinterval(), interval(2.0,4.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,Inf), interval(2.0,Inf), interval(0.0,1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(entireinterval(), interval(2.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(2.0,4.0), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(2.0,4.0), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(interval(-4.0,4.0), interval(2.0,Inf), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test_broken pow_rev1(interval(-Inf,4.0), interval(2.0,Inf), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(2.0,4.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(2.0,4.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(-4.0,Inf), interval(2.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(entireinterval(), interval(2.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,0.5), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,0.5), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,0.5), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,0.5), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)


    @test pow_rev1(interval(0.0,4.0), interval(0.0,0.5), interval(1.0, Inf)) === emptyinterval()

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,0.5), interval(1.0, Inf)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.0,0.5), interval(1.0, Inf)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(-Inf,0.5), interval(1.0, Inf)) === emptyinterval()

    @test pow_rev1(interval(0.0,4.0), interval(0.25,0.5), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,Inf), interval(0.25,0.5), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(0.0,Inf), interval(0.25,0.5), interval(0.0, 1.0)) === interval(0.0, 1.0)


    @test pow_rev1(interval(0.0,4.0), interval(0.25,0.5), interval(1.0, Inf)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.25,0.5), interval(1.0, Inf)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,4.0), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.25,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.25,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,4.0), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.25,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.0,1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,1.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,4.0), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(0.0,1.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,2.0), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,Inf), interval(0.0, 1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.0,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,2.0), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(-Inf,Inf), interval(1.0, Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,2.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(0.5,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,2.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,4.0), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,2.0), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test_broken pow_rev1(interval(0.0,Inf), interval(1.0,Inf), interval(0.0,1.0)) === interval(0.0, 1.0)

    @test pow_rev1(interval(0.0,4.0), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(1.0,2.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(1.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(2.0,4.0), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(2.0,Inf), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(2.0,4.0), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(2.0,Inf), entireinterval()) === interval(1.0, Inf)


    @test pow_rev1(interval(0.0,4.0), interval(2.0,4.0), interval(0.0,1.0)) === emptyinterval()

    @test pow_rev1(interval(0.0,4.0), interval(2.0,Inf), interval(0.0,1.0)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(2.0,4.0), interval(0.0,1.0)) === emptyinterval()

    @test_broken pow_rev1(interval(0.0,Inf), interval(2.0,Inf), interval(0.0,1.0)) === emptyinterval()

    @test pow_rev1(interval(0.0,4.0), interval(2.0,4.0), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(0.0,4.0), interval(2.0,Inf), interval(1.0,Inf)) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(2.0,4.0), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(0.0,Inf), interval(2.0,Inf), interval(1.0,Inf)) === interval(1.0, Inf)

    @test pow_rev1(interval(2.0,4.0), interval(0.0,0.5), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(2.0,4.0), interval(-Inf,0.5), entireinterval()) === interval(0.0, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(2.0,Inf), interval(0.0,0.5), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(2.0,Inf), interval(-Inf,0.5), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(2.0,4.0), interval(0.25,0.5), entireinterval()) === interval(0.5, 0x1.AE89F995AD3AEp-1)

    @test pow_rev1(interval(2.0,Inf), interval(0.25,0.5), entireinterval()) === interval(0.5, 1.0)

    @test pow_rev1(interval(2.0,4.0), interval(0.25,1.0), entireinterval()) === interval(0.5, 1.0)

    @test pow_rev1(interval(2.0,4.0), interval(1.0,1.0), entireinterval()) === interval(1.0, 1.0)

    @test pow_rev1(interval(2.0,Inf), interval(0.25,1.0), entireinterval()) === interval(0.5, 1.0)

    @test pow_rev1(interval(2.0,Inf), interval(1.0,1.0), entireinterval()) === interval(1.0, 1.0)

    @test pow_rev1(interval(2.0,4.0), interval(0.0,1.0), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(2.0,Inf), interval(0.0,1.0), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev1(interval(2.0,4.0), interval(0.0,2.0), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,4.0), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(2.0,4.0), interval(-Inf,2.0), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,4.0), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(2.0,Inf), interval(0.0,2.0), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,Inf), interval(0.0,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(2.0,Inf), interval(-Inf,2.0), entireinterval()) === interval(0.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,Inf), interval(-Inf,Inf), entireinterval()) === interval(0.0, Inf)

    @test pow_rev1(interval(2.0,4.0), interval(0.5,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,4.0), interval(0.5,Inf), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(2.0,Inf), interval(0.5,2.0), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,Inf), interval(0.5,Inf), entireinterval()) === interval(0x1.6A09E667F3BCCp-1, Inf)

    @test pow_rev1(interval(2.0,4.0), interval(1.0,2.0), entireinterval()) === interval(1.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,4.0), interval(1.0,Inf), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(2.0,Inf), interval(1.0,2.0), entireinterval()) === interval(1.0, 0x1.6A09E667F3BCDp0)

    @test pow_rev1(interval(2.0,Inf), interval(1.0,Inf), entireinterval()) === interval(1.0, Inf)

    @test pow_rev1(interval(2.0,4.0), interval(2.0,4.0), entireinterval()) === interval(0x1.306FE0A31B715p0, 2.0)

    @test pow_rev1(interval(2.0,4.0), interval(2.0,Inf), entireinterval()) === interval(0x1.306FE0A31B715p0, Inf)

    @test pow_rev1(interval(2.0,Inf), interval(2.0,4.0), entireinterval()) === interval(1.0, 2.0)

    @test pow_rev1(interval(2.0,Inf), interval(2.0,Inf), entireinterval()) === interval(1.0, Inf)


end

@testset "minimal.powRev2_test" begin

    @test pow_rev2(emptyinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev2(emptyinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev2(entireinterval(), emptyinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev2(entireinterval(), entireinterval(), emptyinterval()) === emptyinterval()

    @test pow_rev2(emptyinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test pow_rev2(emptyinterval(), entireinterval(), entireinterval()) === emptyinterval()

    @test pow_rev2(entireinterval(), emptyinterval(), entireinterval()) === emptyinterval()

    @test pow_rev2(entireinterval(), entireinterval(), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 0.0), interval(-Inf, -0.1), entireinterval()) === emptyinterval()

    @test pow_rev2(interval(0.0, 0.0), interval(0.1, Inf), entireinterval()) === emptyinterval()

    @test pow_rev2(interval(0.0, 0.0), interval(0.0, 0.0), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(-Inf, 0.9), interval(0.0, 0.9), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(1.1, Inf), interval(1.1, Inf), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(-Inf, 0.9), interval(1.1, Inf), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(1.1, Inf), interval(0.0, 0.9), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(0.0, 0.0), interval(0.0, 0.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(-Inf, 0.0), interval(-Inf, 0.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(-Inf, 0.0), interval(-Inf, 0.0), interval(1.0, 2.0)) === interval(1.0, 2.0)

    @test_broken pow_rev2(entireinterval(), interval(0.0, 0.0), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(entireinterval(), interval(-Inf, 0.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(entireinterval(), interval(-Inf, 0.0), interval(1.0, 2.0)) === interval(1.0, 2.0)

    @test_broken pow_rev2(interval(0.0, 0.0), entireinterval(), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(-Inf, 0.0), entireinterval(), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(-Inf, 0.0), entireinterval(), interval(1.0, 2.0)) === interval(1.0, 2.0)


    @test_broken pow_rev2(interval(1.0, 1.0), entireinterval(), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(1.0, 1.0), interval(2.0, 3.0)) === interval(2.0, 3.0)

    @test_broken pow_rev2(entireinterval(), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(entireinterval(), interval(1.0, 1.0), interval(2.0, 3.0)) === interval(2.0, 3.0)

    @test pow_rev2(interval(2.0, 3.0), interval(1.0, 1.0), entireinterval()) === interval(0.0, 0.0)

    @test pow_rev2(interval(2.0, 3.0), interval(1.0, 1.0), interval(2.0, 3.0)) === emptyinterval()

    @test pow_rev2(interval(0.0, 0.5), interval(0.0, 0.5), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 0.5), interval(0.0, 0.5), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(0.0, 0.5), interval(0.25, 0.5), entireinterval()) === interval(0.0, 2.0)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(0.5, 1.0), entireinterval()) === interval(0.0, 0.5)

    @test pow_rev2(interval(0.0, 0.25), interval(1.0, 1.0), entireinterval()) === interval(0.0, 0.0)

    @test pow_rev2(interval(0.0, 0.25), interval(0.0, 1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 0.25), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(0.0, 0.0)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(0.0, 2.0), entireinterval()) === interval(-0.5, Inf)

    @test pow_rev2(interval(0.0, 0.25), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 0.25), interval(0.5, 2.0), entireinterval()) === interval(-0.5, 0.5)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(0.5, Inf), entireinterval()) === interval(-Inf, 0.5)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(1.0, 2.0), entireinterval()) === interval(-0.5, 0.0)

    @test pow_rev2(interval(0.0, 0.25), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, 0.0)

    @test pow_rev2(interval(0.0, 0.25), interval(1.0, Inf), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 0.25), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, 0.0)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(2.0, 4.0), entireinterval()) === interval(-1.0, 0.0)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(2.0, 4.0), interval(0.0, Inf)) === emptyinterval()

    @test pow_rev2(interval(0.0, 0.25), interval(2.0, Inf), entireinterval()) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 0.25), interval(2.0, Inf), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.0, 0.5), entireinterval()) === interval(0.5, Inf)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.25, 0.5), entireinterval()) === interval(0.5, 2.0)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.5, 1.0), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev2(interval(0.25, 0.5), interval(1.0, 1.0), entireinterval()) === interval(0.0, 0.0)

    @test pow_rev2(interval(0.25, 0.5), interval(0.0, 1.0), entireinterval()) === interval(0.0, Inf)

    @test pow_rev2(interval(0.25, 0.5), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(0.0, 0.0)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.0, 2.0), entireinterval()) === interval(-1.0, Inf)

    @test pow_rev2(interval(0.25, 0.5), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.5, 2.0), entireinterval()) === interval(-1.0, 1.0)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(0.5, Inf), entireinterval()) === interval(-Inf, 1.0)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(1.0, 2.0), entireinterval()) === interval(-1.0, 0.0)

    @test pow_rev2(interval(0.25, 0.5), interval(1.0, Inf), entireinterval()) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(2.0, 4.0), entireinterval()) === interval(-2.0, -0.5)

    @test_broken pow_rev2(interval(0.25, 0.5), interval(2.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(0.0, 0.5), entireinterval()) === interval(0.5, Inf)

    @test pow_rev2(interval(1.0, 1.0), interval(0.0, 0.5), entireinterval()) === emptyinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(0.25, 0.5), entireinterval()) === interval(0.5, Inf)


    @test pow_rev2(interval(1.0, 1.0), interval(0.25, 0.5), entireinterval()) === emptyinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.25, 1.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.25, 1.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.25, 1.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.25, 1.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 1.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(2.0, 4.0), entireinterval()) === interval(-Inf, -0.5)

    @test pow_rev2(interval(1.0, 1.0), interval(2.0, 4.0), entireinterval()) === emptyinterval()

    @test_broken pow_rev2(interval(0.25, 1.0), interval(2.0, Inf), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 1.0), interval(2.0, Inf), entireinterval()) === emptyinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 0.5), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.0, 0.5), interval(-Inf, 0.0)) === emptyinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(0.25, 0.5), entireinterval()) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.25, 0.5), interval(-Inf, 0.0)) === emptyinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.25, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)


    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 1.0), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(1.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 1.0), interval(2.0, 4.0), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(2.0, 4.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 1.0), interval(2.0, 4.0), interval(0.0, Inf)) === emptyinterval()

    @test pow_rev2(interval(0.0, 1.0), interval(2.0, Inf), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 1.0), interval(2.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)


    @test_broken pow_rev2(interval(0.0, 1.0), interval(2.0, Inf), interval(0.0, Inf)) === emptyinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 0.5), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 2.0), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 0.5), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.25, 0.5), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 2.0), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.25, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.25, 0.5), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.25, 0.5), interval(0.0, Inf)) === interval(0.0, Inf)


    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, 2.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 2.0), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, 2.0), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)


    @test pow_rev2(interval(0.0, Inf), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.0, Inf), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, Inf), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.0, Inf), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, 2.0), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(1.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(2.0, 4.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(2.0, 4.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 2.0), interval(2.0, 4.0), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(2.0, 4.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(2.0, 4.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(2.0, 4.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.0, 2.0), interval(2.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, 2.0), interval(2.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.0, 2.0), interval(2.0, Inf), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.0, Inf), interval(2.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.0, Inf), interval(2.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.0, Inf), interval(2.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 0.5), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, 2.0), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test_broken pow_rev2(interval(0.5, 2.0), interval(0.0, 0.5), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 0.5), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.5, Inf), interval(0.0, 0.5), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.25, 0.5), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, 2.0), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test_broken pow_rev2(interval(0.5, 2.0), interval(0.25, 0.5), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.25, 0.5), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.5, Inf), interval(0.25, 0.5), interval(0.0, Inf)) === interval(1.0, Inf)


    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, 2.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.5, 2.0), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.5, 2.0), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)


    @test pow_rev2(interval(0.5, Inf), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, Inf), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(0.5, Inf), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(0.5, Inf), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, 2.0), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(0.5, Inf), interval(1.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(0.5, Inf), interval(1.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(0.5, 2.0), interval(2.0, 4.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, 2.0), interval(2.0, 4.0), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test_broken pow_rev2(interval(0.5, 2.0), interval(2.0, 4.0), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(0.5, Inf), interval(2.0, 4.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(0.5, Inf), interval(2.0, 4.0), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test pow_rev2(interval(0.5, Inf), interval(2.0, 4.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.0, 0.5), entireinterval()) === interval(-Inf, -1.0)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 0.5), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 0.5), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, Inf), interval(0.0, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.25, 0.5), entireinterval()) === interval(-Inf, -1.0)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, -1.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.25, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.25, 0.5), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.25, 0.5), interval(-Inf, 0.0)) === interval(-Inf, 0.0)


    @test_broken pow_rev2(interval(1.0, Inf), interval(0.25, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)


    @test_broken pow_rev2(interval(1.0, Inf), interval(0.5, 1.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.5, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, Inf), interval(0.5, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, Inf), interval(0.0, 1.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 1.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, Inf), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(0.0, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.0, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.0, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(0.5, 2.0), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.5, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.5, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 2.0), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(0.5, Inf), entireinterval()) === entireinterval()

    @test pow_rev2(interval(1.0, Inf), interval(0.5, Inf), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, Inf), interval(0.5, Inf), interval(0.0, Inf)) === interval(0.0, Inf)


    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, Inf), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, 2.0), entireinterval()) === entireinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(1.0, Inf), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(-Inf, 0.0)

    @test pow_rev2(interval(1.0, 2.0), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(1.0, 2.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(1.0, 2.0), interval(2.0, 4.0), entireinterval()) === interval(1.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(2.0, 4.0), entireinterval()) === interval(0.0, Inf)


    @test pow_rev2(interval(1.0, 2.0), interval(2.0, 4.0), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(1.0, Inf), interval(2.0, 4.0), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(1.0, 2.0), interval(2.0, 4.0), interval(0.0, Inf)) === interval(1.0, Inf)

    @test pow_rev2(interval(1.0, Inf), interval(2.0, 4.0), interval(0.0, Inf)) === interval(0.0, Inf)

    @test_broken pow_rev2(interval(2.0, 4.0), interval(0.0, 0.5), entireinterval()) === interval(-Inf, -0.5)

    @test pow_rev2(interval(2.0, Inf), interval(0.0, 0.5), entireinterval()) === interval(-Inf, 0.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.0, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(2.0, 4.0), interval(0.25, 0.5), entireinterval()) === interval(-2.0, -0.5)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.25, 0.5), entireinterval()) === interval(-2.0, 0.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.25, 0.5), interval(0.0, Inf)) === emptyinterval()

    @test_broken pow_rev2(interval(2.0, 4.0), interval(0.5, 1.0), entireinterval()) === interval(-1.0, 0.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.5, 1.0), entireinterval()) === interval(-1.0, 0.0)

    @test pow_rev2(interval(2.0, 4.0), interval(1.0, 1.0), entireinterval()) === interval(0.0, 0.0)

    @test pow_rev2(interval(2.0, Inf), interval(1.0, 1.0), entireinterval()) === interval(0.0, 0.0)

    @test pow_rev2(interval(2.0, 4.0), interval(0.0, 1.0), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(2.0, Inf), interval(0.0, 1.0), entireinterval()) === interval(-Inf, 0.0)

    @test pow_rev2(interval(2.0, 4.0), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, 0.0)

    @test pow_rev2(interval(2.0, Inf), interval(0.0, 1.0), interval(0.0, Inf)) === interval(0.0, 0.0)

    @test_broken pow_rev2(interval(2.0, 4.0), interval(0.0, 2.0), entireinterval()) === interval(-Inf, 1.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.0, 2.0), entireinterval()) === interval(-Inf, 1.0)

    @test_broken pow_rev2(interval(2.0, 4.0), interval(0.5, 2.0), entireinterval()) === interval(-1.0, 1.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(0.5, 2.0), entireinterval()) === interval(-1.0, 1.0)

    @test_broken pow_rev2(interval(2.0, 4.0), interval(1.0, 2.0), entireinterval()) === interval(0.0, 1.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(1.0, 2.0), entireinterval()) === interval(0.0, 1.0)

    @test pow_rev2(interval(2.0, 4.0), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(0.0, 0.0)

    @test pow_rev2(interval(2.0, Inf), interval(1.0, 2.0), interval(-Inf, 0.0)) === interval(0.0, 0.0)

    @test_broken pow_rev2(interval(2.0, 4.0), interval(2.0, 4.0), entireinterval()) === interval(0.5, 2.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(2.0, 4.0), entireinterval()) === interval(0.0, 2.0)

    @test_broken pow_rev2(interval(2.0, Inf), interval(2.0, 4.0), interval(-Inf, 0.0)) === emptyinterval()

    @test_broken pow_rev2(interval(2.0, 4.0), interval(2.0, Inf), entireinterval()) === interval(0.5, Inf)

    @test pow_rev2(interval(2.0, Inf), interval(2.0, Inf), entireinterval()) === interval(0.0, Inf)


    @test_broken pow_rev2(interval(2.0, Inf), interval(2.0, Inf), interval(-Inf, 0.0)) === emptyinterval()

end
