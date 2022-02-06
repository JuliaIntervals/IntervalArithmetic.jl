@testset "minimal_mulRevToPair_test" begin

    @test mul_rev_to_pair(emptyinterval(), interval(1.0, 2.0))[1] === emptyinterval() && mul_rev_to_pair(emptyinterval(), interval(1.0, 2.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(1.0, 2.0), emptyinterval())[1] === emptyinterval() && mul_rev_to_pair(interval(1.0, 2.0), emptyinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(emptyinterval(), emptyinterval())[1] === emptyinterval() && mul_rev_to_pair(emptyinterval(), emptyinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, -0.4))[1] === Interval(0x1.999999999999AP-3, 0x1.5P+4) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, -0.4))[1] === Interval(0x1.999999999999AP-3, Inf) && mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, -0.4))[1] === Interval(-Inf, -0x1.745D1745D1745P-2) && mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, -0.4))[2] === Interval(0x1.999999999999AP-3, Inf)

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, -0.4))[1] === Interval(-Inf, -0x1.745D1745D1745P-2) && mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, -0.4))[1] === Interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2) && mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, -0.4))[1] === emptyinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, -0.4))[1] === Interval(0.0, 0x1.5P+4) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, -0.4))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, -0.4))[1] === Interval(-Inf, -0x1.745D1745D1745P-2) && mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, -0.4))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, -0.4))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, -0.4))[2] === Interval(0x1.999999999999AP-3, Inf)

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, -0.4))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, -0.4))[1] === Interval(-0x1.A400000000001P+7, 0.0) && mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, -0.4))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-2.1, -0.4))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(entireinterval(), interval(-2.1, -0.4))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.0))[1] === Interval(0.0, 0x1.5P+4) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.0))[1] === Interval(-0x1.A400000000001P+7, 0.0) && mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.0))[1] === Interval(0.0, 0x1.5P+4) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.0))[1] === Interval(-0x1.A400000000001P+7, 0.0) && mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-2.1, 0.0))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(-2.1, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.12))[1] === Interval(-0x1.3333333333333P+0, 0x1.5P+4) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.12))[1] === Interval(-0x1.A400000000001P+7 , 0x1.8P+3) && mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.12))[1] === Interval(-0x1.3333333333333P+0, 0x1.5P+4) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.12))[1] === Interval(-0x1.A400000000001P+7 , 0x1.8P+3) && mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-2.1, 0.12))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(-2.1, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.12))[1] === Interval(-0x1.3333333333333P+0, 0.0) && mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.12))[1] === Interval(0.0, 0x1.8P+3) && mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.12))[1] === Interval(-0x1.3333333333333P+0, 0.0) && mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.12))[1] === Interval(0.0, 0x1.8P+3) && mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(0.0, 0.12))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(0.0, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(0.01, 0.12))[1] === Interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8) && mul_rev_to_pair(interval(-2.0, -0.1), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(0.01, 0.12))[1] === Interval(-Inf, -0x1.47AE147AE147BP-8) && mul_rev_to_pair(interval(-2.0, 0.0), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(0.01, 0.12))[1] === Interval(-Inf, -0x1.47AE147AE147BP-8) && mul_rev_to_pair(interval(-2.0, 1.1), interval(0.01, 0.12))[2] === Interval(0x1.29E4129E4129DP-7, Inf)

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(0.01, 0.12))[1] === Interval(0x1.29E4129E4129DP-7, Inf) && mul_rev_to_pair(interval(0.0, 1.1), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(0.01, 0.12))[1] === Interval(0x1.29E4129E4129DP-7, 0x1.8P+3) && mul_rev_to_pair(interval(0.01, 1.1), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(0.01, 0.12))[1] === emptyinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(0.01, 0.12))[1] === Interval(-0x1.3333333333333P+0, 0.0) && mul_rev_to_pair(interval(-Inf, -0.1), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(0.01, 0.12))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, 0.0), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(0.01, 0.12))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, 1.1), interval(0.01, 0.12))[2] === Interval(0x1.29E4129E4129DP-7, Inf)

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(0.01, 0.12))[1] === Interval(-Inf, -0x1.47AE147AE147BP-8) && mul_rev_to_pair(interval(-2.0, Inf), interval(0.01, 0.12))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(0.0, Inf), interval(0.01, 0.12))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(0.0, Inf), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(0.01, 0.12))[1] === Interval(0.0, 0x1.8P+3) && mul_rev_to_pair(interval(0.01, Inf), interval(0.01, 0.12))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(0.01, 0.12))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(entireinterval(), interval(0.01, 0.12))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.0))[1] === Interval(0.0, 0.0) && mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.0))[1] === Interval(0.0, 0.0) && mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.0))[1] === Interval(0.0, 0.0) && mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.0))[1] === Interval(0.0, 0.0) && mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(0.0, 0.0))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(0.0, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, -0.1))[1] === Interval(0x1.999999999999AP-5, Inf) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, -0.1))[1] === Interval(0x1.999999999999AP-5 , Inf) && mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, -0.1))[1] === Interval(-Inf , -0x1.745D1745D1745P-4) && mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, -0.1))[2] === Interval(0x1.999999999999AP-5 , Inf)

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, -0.1))[1] === Interval(-Inf, -0x1.745D1745D1745P-4) && mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, -0.1))[1] === Interval(-Inf, -0x1.745D1745D1745P-4) && mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, -0.1))[1] === emptyinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, -0.1))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, -0.1))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, -0.1))[1] === Interval(-Inf, -0x1.745D1745D1745P-4) && mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, -0.1))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, -0.1))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, -0.1))[2] === Interval(0x1.999999999999AP-5 , Inf)

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, -0.1))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, -0.1))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, -0.1))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-Inf, -0.1))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(entireinterval(), interval(-Inf, -0.1))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.0))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.0))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.0))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.0))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-Inf, 0.0))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(-Inf, 0.0))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.3))[1] === Interval(-0x1.8P+1, Inf) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.3))[1] === Interval(-Inf, 0x1.EP+4) && mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.3))[1] === Interval(-0x1.8P+1, Inf) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.3))[1] === Interval(-Inf, 0x1.EP+4) && mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-Inf, 0.3))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(-Inf, 0.3))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(-0.21, Inf))[1] === Interval(-Inf , 0x1.0CCCCCCCCCCCDP+1) && mul_rev_to_pair(interval(-2.0, -0.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(-0.21, Inf))[1] === Interval(-0x1.5P+4, Inf) && mul_rev_to_pair(interval(0.01, 1.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(-0.21, Inf))[1] === Interval(-Inf, 0x1.0CCCCCCCCCCCDP+1) && mul_rev_to_pair(interval(-Inf, -0.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(-0.21, Inf))[1] === Interval(-0x1.5P+4, Inf) && mul_rev_to_pair(interval(0.01, Inf), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(-0.21, Inf))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(-0.21, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, Inf))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(0.0, Inf))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(0.01, Inf), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(0.0, Inf))[1] === entireinterval() && mul_rev_to_pair(entireinterval(), interval(0.0, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, -0.1), interval(0.04, Inf))[1] === Interval(-Inf, -0x1.47AE147AE147BP-6) && mul_rev_to_pair(interval(-2.0, -0.1), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), interval(0.04, Inf))[1] === Interval(-Inf, -0x1.47AE147AE147BP-6) && mul_rev_to_pair(interval(-2.0, 0.0), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), interval(0.04, Inf))[1] === Interval(-Inf, -0x1.47AE147AE147BP-6) && mul_rev_to_pair(interval(-2.0, 1.1), interval(0.04, Inf))[2] === Interval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev_to_pair(interval(0.0, 1.1), interval(0.04, Inf))[1] === Interval(0x1.29E4129E4129DP-5, Inf) && mul_rev_to_pair(interval(0.0, 1.1), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), interval(0.04, Inf))[1] === Interval(0x1.29E4129E4129DP-5, Inf) && mul_rev_to_pair(interval(0.01, 1.1), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), interval(0.04, Inf))[1] === emptyinterval() && mul_rev_to_pair(interval(0.0, 0.0), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), interval(0.04, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, -0.1), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), interval(0.04, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, 0.0), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), interval(0.04, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(interval(-Inf, 1.1), interval(0.04, Inf))[2] === Interval(0x1.29E4129E4129DP-5, Inf)

    @test mul_rev_to_pair(interval(-2.0, Inf), interval(0.04, Inf))[1] === Interval(-Inf, -0x1.47AE147AE147BP-6) && mul_rev_to_pair(interval(-2.0, Inf), interval(0.04, Inf))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(0.0, Inf), interval(0.04, Inf))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(0.0, Inf), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), interval(0.04, Inf))[1] === Interval(0.0, Inf) && mul_rev_to_pair(interval(0.01, Inf), interval(0.04, Inf))[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), interval(0.04, Inf))[1] === Interval(-Inf, 0.0) && mul_rev_to_pair(entireinterval(), interval(0.04, Inf))[2] === Interval(0.0, Inf)

    @test mul_rev_to_pair(interval(-2.0, -0.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, -0.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 0.0), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 0.0), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, 1.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, 1.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 1.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 1.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, 1.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(0.01, 1.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, 0.0), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(0.0, 0.0), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, -0.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, -0.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 0.0), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 0.0), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-Inf, 1.1), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-Inf, 1.1), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(-2.0, Inf), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(-2.0, Inf), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.0, Inf), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(0.0, Inf), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(interval(0.01, Inf), entireinterval())[1] === entireinterval() && mul_rev_to_pair(interval(0.01, Inf), entireinterval())[2] === emptyinterval()

    @test mul_rev_to_pair(entireinterval(), entireinterval())[1] === entireinterval() && mul_rev_to_pair(entireinterval(), entireinterval())[2] === emptyinterval()

end

@testset "minimal_mulRevToPair_dec_test" begin

    @test isnai(mul_rev_to_pair(nai(), DecoratedInterval(interval(1.0,2.0), def))[1]) && isnai(mul_rev_to_pair(nai(), DecoratedInterval(interval(1.0,2.0), def))[2])

    @test isnai(mul_rev_to_pair(DecoratedInterval(interval(1.0,2.0), com), nai())[1]) && isnai(mul_rev_to_pair(DecoratedInterval(interval(1.0,2.0), com), nai())[2])

    @test isnai(mul_rev_to_pair(nai(), nai())[1]) && isnai(mul_rev_to_pair(nai(), nai())[2])

    @test mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, 2.0), def))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, 2.0), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(emptyinterval(), trv))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[1] === DecoratedInterval(Interval(0x1.999999999999AP-3, 0x1.5P+4), com) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), com))[1] === DecoratedInterval(Interval(0x1.999999999999AP-3, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-2), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), dac))[2] === DecoratedInterval(Interval(0x1.999999999999AP-3, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-2), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2), com) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), def))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1] === DecoratedInterval(Interval(0.0, 0x1.5P+4), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, -0.4), com))[1] === DecoratedInterval(Interval(0.0, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, -0.4), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-2), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2] === DecoratedInterval(Interval(0x1.999999999999AP-3, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, -0.4), com))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, -0.4), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, -0.4), def))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7, 0.0), def) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, -0.4), def))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0x1.5P+4), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0x1.5P+4), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, 0x1.5P+4), def) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7 , 0x1.8P+3), def) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, 0x1.5P+4), def) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.A400000000001P+7 , 0x1.8P+3), def) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, 0.0), com) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(Interval(0.0, 0x1.8P+3), com) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(Interval(0.0, 0x1.8P+3), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.12), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.12), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-8), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-8), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(Interval(0x1.29E4129E4129DP-7, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(0x1.29E4129E4129DP-7, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(0x1.29E4129E4129DP-7, 0x1.8P+3), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-0x1.3333333333333P+0, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(Interval(0x1.29E4129E4129DP-7, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-8), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(0.0, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(0.0, 0x1.8P+3), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0.0), com) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0.0), com) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(Interval(0.0, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(0x1.999999999999AP-5, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(0x1.999999999999AP-5 , Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf , -0x1.745D1745D1745P-4), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(Interval(0x1.999999999999AP-5 , Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-4), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-4), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(0.0, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.745D1745D1745P-4), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(Interval(0x1.999999999999AP-5 , Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(Interval(-0x1.8P+1, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(Interval(-Inf, 0x1.EP+4), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(Interval(-0x1.8P+1, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(Interval(-Inf, 0x1.EP+4), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(Interval(-Inf , 0x1.0CCCCCCCCCCCDP+1), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(Interval(-0x1.5P+4, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0x1.0CCCCCCCCCCCDP+1), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(Interval(-0x1.5P+4, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, Inf), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-6), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-6), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-6), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(Interval(0x1.29E4129E4129DP-5, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(0x1.29E4129E4129DP-5, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(0x1.29E4129E4129DP-5, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(emptyinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(Interval(0x1.29E4129E4129DP-5, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, -0x1.47AE147AE147BP-6), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(0.0, Inf), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(0.0, Inf), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.04, Inf), dac))[1] === DecoratedInterval(Interval(-Inf, 0.0), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.04, Inf), dac))[2] === DecoratedInterval(Interval(0.0, Inf), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), dac) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), dac) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), dac) && mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

    @test mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac))[1] === DecoratedInterval(entireinterval(), trv) && mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac))[2] === DecoratedInterval(emptyinterval(), trv)

end
