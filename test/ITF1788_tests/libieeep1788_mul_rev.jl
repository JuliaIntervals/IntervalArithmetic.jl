@testset "minimal_mulRevToPair_test" begin

    @test _mul_rev_to_pair(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 2.0))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 2.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64}))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4))[1] === bareinterval(0x1.999999999999AP-3, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, -0.4))[1] === bareinterval(0x1.999999999999AP-3, Inf) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-2) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4))[2] === bareinterval(0x1.999999999999AP-3, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-2) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, -0.4))[1] === bareinterval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, -0.4))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, -0.4))[1] === bareinterval(0.0, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, -0.4))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-2) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, -0.4))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, -0.4))[2] === bareinterval(0x1.999999999999AP-3, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, -0.4))[1] === bareinterval(-0x1.A400000000001P+7, 0.0) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, -0.4))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, -0.4))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, -0.4))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.0))[1] === bareinterval(0.0, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0))[1] === bareinterval(-0x1.A400000000001P+7, 0.0) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.0))[1] === bareinterval(0.0, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.0))[1] === bareinterval(-0x1.A400000000001P+7, 0.0) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.12))[1] === bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, 0x1.5P+4) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.12))[1] === bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, 0.0) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.12))[1] === bareinterval(0.0, 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.12))[1] === bareinterval(0.0, 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.12))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.01, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-8) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-8) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.01, 0.12))[2] === bareinterval(0x1.29E4129E4129DP-7, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.01, 0.12))[1] === bareinterval(0x1.29E4129E4129DP-7, Inf) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.01, 0.12))[1] === bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.01, 0.12))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.01, 0.12))[1] === bareinterval(-0x1.3333333333333P+0, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.01, 0.12))[2] === bareinterval(0x1.29E4129E4129DP-7, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-8) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.01, 0.12))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.01, 0.12))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.01, 0.12))[1] === bareinterval(0.0, 0x1.8P+3) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.01, 0.12))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.01, 0.12))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.01, 0.12))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0))[1] === bareinterval(0.0, 0.0) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.0))[1] === bareinterval(0.0, 0.0) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.0))[1] === bareinterval(0.0, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.0))[1] === bareinterval(0.0, 0.0) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, -0.1))[1] === bareinterval(0x1.999999999999AP-5, Inf) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, -0.1))[1] === bareinterval(0x1.999999999999AP-5 , Inf) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf , -0x1.745D1745D1745P-4) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, -0.1))[2] === bareinterval(0x1.999999999999AP-5 , Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-4) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-4) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, -0.1))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, -0.1))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, -0x1.745D1745D1745P-4) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, -0.1))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, -0.1))[2] === bareinterval(0x1.999999999999AP-5 , Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, -0.1))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.1))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.1))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.0))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.0))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.0))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.0))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.3))[1] === bareinterval(-0x1.8P+1, Inf) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.3))[1] === bareinterval(-Inf, 0x1.EP+4) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.3))[1] === bareinterval(-0x1.8P+1, Inf) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.3))[1] === bareinterval(-Inf, 0x1.EP+4) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.3))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.3))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-0.21, Inf))[1] === bareinterval(-Inf , 0x1.0CCCCCCCCCCCDP+1) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-0.21, Inf))[1] === bareinterval(-0x1.5P+4, Inf) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-0.21, Inf))[1] === bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-0.21, Inf))[1] === bareinterval(-0x1.5P+4, Inf) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-0.21, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-0.21, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, Inf))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, Inf))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-6) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-6) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-6) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf))[2] === bareinterval(0x1.29E4129E4129DP-5, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.04, Inf))[1] === bareinterval(0x1.29E4129E4129DP-5, Inf) && _mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.04, Inf))[1] === bareinterval(0x1.29E4129E4129DP-5, Inf) && _mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.04, Inf))[1] === emptyinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.04, Inf))[2] === bareinterval(0x1.29E4129E4129DP-5, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, -0x1.47AE147AE147BP-6) && _mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.04, Inf))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.04, Inf))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.04, Inf))[1] === bareinterval(0.0, Inf) && _mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.04, Inf))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.04, Inf))[1] === bareinterval(-Inf, 0.0) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.04, Inf))[2] === bareinterval(0.0, Inf)

    @test _mul_rev_to_pair(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, 1.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, 1.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 1.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 1.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, 1.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.01, 1.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-Inf, 1.1), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-Inf, 1.1), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(-2.0, Inf), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(-2.0, Inf), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(bareinterval(0.01, Inf), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(bareinterval(0.01, Inf), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

    @test _mul_rev_to_pair(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[1] === entireinterval(BareInterval{Float64}) && _mul_rev_to_pair(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[2] === emptyinterval(BareInterval{Float64})

end

@testset "minimal_mulRevToPair_dec_test" begin

    @test _mul_rev_to_pair(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), def))[1] === nai(Interval{Float64}) && _mul_rev_to_pair(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), def))[2] === nai(Interval{Float64})

    @test _mul_rev_to_pair(interval(bareinterval(1.0,2.0), com), nai(Interval{Float64}))[1] === nai(Interval{Float64}) && _mul_rev_to_pair(interval(bareinterval(1.0,2.0), com), nai(Interval{Float64}))[2] === nai(Interval{Float64})

    @test _mul_rev_to_pair(nai(Interval{Float64}), nai(Interval{Float64}))[1] === nai(Interval{Float64}) && _mul_rev_to_pair(nai(Interval{Float64}), nai(Interval{Float64}))[2] === nai(Interval{Float64})

    @test _mul_rev_to_pair(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0, 2.0), def))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0, 2.0), def))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(1.0, 2.0), com), interval(emptyinterval(BareInterval{Float64}), trv))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(1.0, 2.0), com), interval(emptyinterval(BareInterval{Float64}), trv))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(-2.1, -0.4), com))[1] === interval(bareinterval(0x1.999999999999AP-3, 0x1.5P+4), com) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(-2.1, -0.4), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-2.1, -0.4), com))[1] === interval(bareinterval(0x1.999999999999AP-3, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-2.1, -0.4), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(-2.1, -0.4), dac))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(-2.1, -0.4), dac))[2] === interval(bareinterval(0x1.999999999999AP-3, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), trv), interval(bareinterval(-2.1, -0.4), def))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), trv), interval(bareinterval(-2.1, -0.4), def))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(-2.1, -0.4), com))[1] === interval(bareinterval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2), com) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(-2.1, -0.4), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-2.1, -0.4), def))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-2.1, -0.4), def))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-2.1, -0.4), dac))[1] === interval(bareinterval(0.0, 0x1.5P+4), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-2.1, -0.4), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), def), interval(bareinterval(-2.1, -0.4), com))[1] === interval(bareinterval(0.0, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), def), interval(bareinterval(-2.1, -0.4), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), trv), interval(bareinterval(-2.1, -0.4), def))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), trv), interval(bareinterval(-2.1, -0.4), def))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-2.1, -0.4), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-2.1, -0.4), dac))[2] === interval(bareinterval(0x1.999999999999AP-3, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), def), interval(bareinterval(-2.1, -0.4), com))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), def), interval(bareinterval(-2.1, -0.4), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), def), interval(bareinterval(-2.1, -0.4), def))[1] === interval(bareinterval(-0x1.A400000000001P+7, 0.0), def) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), def), interval(bareinterval(-2.1, -0.4), def))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.1, -0.4), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.1, -0.4), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(bareinterval(0.0, 0x1.5P+4), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(bareinterval(-0x1.A400000000001P+7, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(bareinterval(0.0, 0x1.5P+4), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(bareinterval(-0x1.A400000000001P+7, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.1, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-2.1, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(bareinterval(-0x1.3333333333333P+0, 0x1.5P+4), def) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3), def) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(bareinterval(-0x1.3333333333333P+0, 0x1.5P+4), def) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3), def) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-2.1, 0.12), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), def), interval(bareinterval(-2.1, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(bareinterval(-0x1.3333333333333P+0, 0.0), com) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(bareinterval(0.0, 0x1.8P+3), com) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(bareinterval(-0x1.3333333333333P+0, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(bareinterval(0.0, 0x1.8P+3), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 0.12), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 0.12), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(bareinterval(0x1.29E4129E4129DP-7, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(0x1.29E4129E4129DP-7, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-0x1.3333333333333P+0, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(bareinterval(0x1.29E4129E4129DP-7, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(0.0, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(0.0, 0x1.8P+3), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.01, 0.12), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.01, 0.12), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(bareinterval(0.0, 0.0), com) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(bareinterval(0.0, 0.0), com) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), com), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(bareinterval(0.0, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(bareinterval(0.0, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 0.0), com))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, 0.0), com))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(0x1.999999999999AP-5, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(0x1.999999999999AP-5 , Inf), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf , -0x1.745D1745D1745P-4), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(bareinterval(0x1.999999999999AP-5 , Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(0.0, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(bareinterval(0x1.999999999999AP-5 , Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, -0.1), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, -0.1), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, 0.0), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, 0.0), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(bareinterval(-0x1.8P+1, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(bareinterval(-Inf, 0x1.EP+4), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(bareinterval(-0x1.8P+1, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(bareinterval(-Inf, 0x1.EP+4), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, 0.3), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-Inf, 0.3), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(bareinterval(-Inf , 0x1.0CCCCCCCCCCCDP+1), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(bareinterval(-0x1.5P+4, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(bareinterval(-0x1.5P+4, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-0.21, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(-0.21, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, Inf), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.0, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(bareinterval(0x1.29E4129E4129DP-5, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(0x1.29E4129E4129DP-5, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(0x1.29E4129E4129DP-5, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(emptyinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(bareinterval(0x1.29E4129E4129DP-5, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(0.0, Inf), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(0.0, Inf), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.04, Inf), dac))[1] === interval(bareinterval(-Inf, 0.0), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(bareinterval(0.04, Inf), dac))[2] === interval(bareinterval(0.0, Inf), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), dac) && _mul_rev_to_pair(interval(bareinterval(-2.0, -0.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), dac) && _mul_rev_to_pair(interval(bareinterval(-Inf, -0.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 0.0), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-Inf, 1.1), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(-2.0, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(bareinterval(0.0, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), dac) && _mul_rev_to_pair(interval(bareinterval(0.01, Inf), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

    @test _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(entireinterval(BareInterval{Float64}), dac))[1] === interval(entireinterval(BareInterval{Float64}), trv) && _mul_rev_to_pair(interval(entireinterval(BareInterval{Float64}), dac), interval(entireinterval(BareInterval{Float64}), dac))[2] === interval(emptyinterval(BareInterval{Float64}), trv)

end
