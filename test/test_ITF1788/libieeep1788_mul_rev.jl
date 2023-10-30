@testset "minimal_mulRevToPair_test" begin

    @test isequal_interval(mul_rev_to_pair(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 2.0))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(emptyinterval(BareInterval{Float64}), bareinterval(1.0, 2.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64}))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(1.0, 2.0), emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4))[1], bareinterval(0x1.999999999999AP-3, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, -0.4))[1], bareinterval(0x1.999999999999AP-3, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, -0x1.745D1745D1745P-2)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, -0.4))[2], bareinterval(0x1.999999999999AP-3, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, -0x1.745D1745D1745P-2)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, -0.4))[1], bareinterval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, -0.4))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, -0.4))[1], bareinterval(0.0, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, -0.4))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, -0x1.745D1745D1745P-2)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, -0.4))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, -0.4))[2], bareinterval(0x1.999999999999AP-3, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, -0.4))[1], bareinterval(-0x1.A400000000001P+7, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, -0.4))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, -0.4))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, -0.4))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.0))[1], bareinterval(0.0, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0))[1], bareinterval(-0x1.A400000000001P+7, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.0))[1], bareinterval(0.0, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.0))[1], bareinterval(-0x1.A400000000001P+7, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.12))[1], bareinterval(-0x1.3333333333333P+0, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.12))[1], bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.12))[1], bareinterval(-0x1.3333333333333P+0, 0x1.5P+4)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.12))[1], bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-2.1, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.12))[1], bareinterval(-0x1.3333333333333P+0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.12))[1], bareinterval(0.0, 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12))[1], bareinterval(-0x1.3333333333333P+0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.12))[1], bareinterval(0.0, 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.12))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.01, 0.12))[1], bareinterval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-8)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-8)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.01, 0.12))[2], bareinterval(0x1.29E4129E4129DP-7, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.01, 0.12))[1], bareinterval(0x1.29E4129E4129DP-7, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.01, 0.12))[1], bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.01, 0.12))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.01, 0.12))[1], bareinterval(-0x1.3333333333333P+0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.01, 0.12))[2], bareinterval(0x1.29E4129E4129DP-7, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-8)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.01, 0.12))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.01, 0.12))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.01, 0.12))[1], bareinterval(0.0, 0x1.8P+3)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.01, 0.12))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.01, 0.12))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.01, 0.12))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0))[1], bareinterval(0.0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.0))[1], bareinterval(0.0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.0))[1], bareinterval(0.0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.0))[1], bareinterval(0.0, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, -0.1))[1], bareinterval(0x1.999999999999AP-5, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, -0.1))[1], bareinterval(0x1.999999999999AP-5 , Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf , -0x1.745D1745D1745P-4)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, -0.1))[2], bareinterval(0x1.999999999999AP-5 , Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, -0x1.745D1745D1745P-4)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, -0x1.745D1745D1745P-4)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, -0.1))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, -0.1))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, -0x1.745D1745D1745P-4)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, -0.1))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, -0.1))[2], bareinterval(0x1.999999999999AP-5 , Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, -0.1))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.1))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, -0.1))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.0))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.0))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.0))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.0))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.0))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.3))[1], bareinterval(-0x1.8P+1, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.3))[1], bareinterval(-Inf, 0x1.EP+4)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.3))[1], bareinterval(-0x1.8P+1, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.3))[1], bareinterval(-Inf, 0x1.EP+4)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.3))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-Inf, 0.3))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-0.21, Inf))[1], bareinterval(-Inf , 0x1.0CCCCCCCCCCCDP+1)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-0.21, Inf))[1], bareinterval(-0x1.5P+4, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-0.21, Inf))[1], bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-0.21, Inf))[1], bareinterval(-0x1.5P+4, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-0.21, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(-0.21, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, Inf))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, Inf))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.0, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.04, Inf))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-6)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.04, Inf))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-6)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-6)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), bareinterval(0.04, Inf))[2], bareinterval(0x1.29E4129E4129DP-5, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.04, Inf))[1], bareinterval(0x1.29E4129E4129DP-5, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.04, Inf))[1], bareinterval(0x1.29E4129E4129DP-5, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.04, Inf))[1], emptyinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.04, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.04, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.04, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), bareinterval(0.04, Inf))[2], bareinterval(0x1.29E4129E4129DP-5, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.04, Inf))[1], bareinterval(-Inf, -0x1.47AE147AE147BP-6)) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), bareinterval(0.04, Inf))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.04, Inf))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.04, Inf))[1], bareinterval(0.0, Inf)) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), bareinterval(0.04, Inf))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.04, Inf))[1], bareinterval(-Inf, 0.0)) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), bareinterval(0.04, Inf))[2], bareinterval(0.0, Inf))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, -0.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 0.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, 1.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 1.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, 1.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, -0.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 0.0), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-Inf, 1.1), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(-2.0, Inf), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.0, Inf), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(bareinterval(0.01, Inf), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

    @test isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[1], entireinterval(BareInterval{Float64})) && isequal_interval(mul_rev_to_pair(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64}))[2], emptyinterval(BareInterval{Float64}))

end

@testset "minimal_mulRevToPair_dec_test" begin

    @test isnai(mul_rev_to_pair(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))[1]) && isnai(mul_rev_to_pair(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def))[2])

    @test isnai(mul_rev_to_pair(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), nai())[1]) && isnai(mul_rev_to_pair(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), nai())[2])

    @test isnai(mul_rev_to_pair(nai(), nai())[1]) && isnai(mul_rev_to_pair(nai(), nai())[2])

    @test isequal_interval(mul_rev_to_pair(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0, 2.0), IntervalArithmetic.def))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0, 2.0), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(1.0, 2.0), IntervalArithmetic.com), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[1], Interval(bareinterval(0x1.999999999999AP-3, 0x1.5P+4), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[1], Interval(bareinterval(0x1.999999999999AP-3, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.999999999999AP-3, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.trv), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.trv), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[1], Interval(bareinterval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, 0x1.5P+4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.trv), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-2), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.trv), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.999999999999AP-3, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[1], Interval(bareinterval(-0x1.A400000000001P+7, 0.0), IntervalArithmetic.def)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.def))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.1, -0.4), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0x1.5P+4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(-0x1.A400000000001P+7, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0x1.5P+4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(-0x1.A400000000001P+7, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-2.1, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.3333333333333P+0, 0x1.5P+4), IntervalArithmetic.def)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3), IntervalArithmetic.def)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.3333333333333P+0, 0x1.5P+4), IntervalArithmetic.def)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.A400000000001P+7 , 0x1.8P+3), IntervalArithmetic.def)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def), Interval(bareinterval(-2.1, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(bareinterval(-0x1.3333333333333P+0, 0.0), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0x1.8P+3), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(bareinterval(-0x1.3333333333333P+0, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0x1.8P+3), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.12), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.29E4129E4129DP-7, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.29E4129E4129DP-7, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.29E4129E4129DP-7, 0x1.8P+3), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.3333333333333P+0, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.29E4129E4129DP-7, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-8), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, 0x1.8P+3), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.01, 0.12), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, 0.0), IntervalArithmetic.com))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.999999999999AP-5, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.999999999999AP-5 , Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf , -0x1.745D1745D1745P-4), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.999999999999AP-5 , Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.745D1745D1745P-4), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.999999999999AP-5 , Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.8P+1, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0x1.EP+4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.8P+1, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0x1.EP+4), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-Inf, 0.3), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf , 0x1.0CCCCCCCCCCCDP+1), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.5P+4, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0x1.0CCCCCCCCCCCDP+1), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-0x1.5P+4, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(-0.21, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.29E4129E4129DP-5, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.29E4129E4129DP-5, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0x1.29E4129E4129DP-5, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(0x1.29E4129E4129DP-5, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, -0x1.47AE147AE147BP-6), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[1], Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(bareinterval(0.04, Inf), IntervalArithmetic.dac))[2], Interval(bareinterval(0.0, Inf), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, -0.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, -0.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 0.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-Inf, 1.1), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(-2.0, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.0, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) && isequal_interval(mul_rev_to_pair(Interval(bareinterval(0.01, Inf), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[1], Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) && isequal_interval(mul_rev_to_pair(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac))[2], Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end
