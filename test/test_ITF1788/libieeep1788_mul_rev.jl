@testset "minimal_mulRevToPair_test" begin

    @test equal(mul_rev_to_pair(emptyinterval(), interval(1.0, 2.0))[1], emptyinterval()) && equal(mul_rev_to_pair(emptyinterval(), interval(1.0, 2.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(1.0, 2.0), emptyinterval())[1], emptyinterval()) && equal(mul_rev_to_pair(interval(1.0, 2.0), emptyinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(emptyinterval(), emptyinterval())[1], emptyinterval()) && equal(mul_rev_to_pair(emptyinterval(), emptyinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, -0.4))[1], interval(0x1.999999999999AP-3, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, -0.4))[1], interval(0x1.999999999999AP-3, Inf)) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, -0.4))[1], interval(-Inf, -0x1.745D1745D1745P-2)) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, -0.4))[2], interval(0x1.999999999999AP-3, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, -0.4))[1], interval(-Inf, -0x1.745D1745D1745P-2)) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, -0.4))[1], interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, -0.4))[1], emptyinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, -0.4))[1], interval(0.0, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, -0.4))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, -0.4))[1], interval(-Inf, -0x1.745D1745D1745P-2)) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, -0.4))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, -0.4))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, -0.4))[2], interval(0x1.999999999999AP-3, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, -0.4))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, -0.4))[1], interval(-0x1.A400000000001P+7, 0.0)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, -0.4))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-2.1, -0.4))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(entireinterval(), interval(-2.1, -0.4))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.0))[1], interval(0.0, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.0))[1], interval(-0x1.A400000000001P+7, 0.0)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.0))[1], interval(0.0, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.0))[1], interval(-0x1.A400000000001P+7, 0.0)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-2.1, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(-2.1, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.12))[1], interval(-0x1.3333333333333P+0, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.12))[1], interval(-0x1.A400000000001P+7 , 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.12))[1], interval(-0x1.3333333333333P+0, 0x1.5P+4)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.12))[1], interval(-0x1.A400000000001P+7 , 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-2.1, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(-2.1, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.12))[1], interval(-0x1.3333333333333P+0, 0.0)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.12))[1], interval(0.0, 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.12))[1], interval(-0x1.3333333333333P+0, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.12))[1], interval(0.0, 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(0.0, 0.12))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(0.0, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.01, 0.12))[1], interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.01, 0.12))[1], interval(-Inf, -0x1.47AE147AE147BP-8)) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.01, 0.12))[1], interval(-Inf, -0x1.47AE147AE147BP-8)) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.01, 0.12))[2], interval(0x1.29E4129E4129DP-7, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.01, 0.12))[1], interval(0x1.29E4129E4129DP-7, Inf)) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.01, 0.12))[1], interval(0x1.29E4129E4129DP-7, 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.01, 0.12))[1], emptyinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.01, 0.12))[1], interval(-0x1.3333333333333P+0, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.01, 0.12))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.01, 0.12))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.01, 0.12))[2], interval(0x1.29E4129E4129DP-7, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.01, 0.12))[1], interval(-Inf, -0x1.47AE147AE147BP-8)) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.01, 0.12))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.01, 0.12))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.01, 0.12))[1], interval(0.0, 0x1.8P+3)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.01, 0.12))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(0.01, 0.12))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(entireinterval(), interval(0.01, 0.12))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.0))[1], interval(0.0, 0.0)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.0))[1], interval(0.0, 0.0)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.0))[1], interval(0.0, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.0))[1], interval(0.0, 0.0)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(0.0, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(0.0, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, -0.1))[1], interval(0x1.999999999999AP-5, Inf)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, -0.1))[1], interval(0x1.999999999999AP-5 , Inf)) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, -0.1))[1], interval(-Inf , -0x1.745D1745D1745P-4)) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, -0.1))[2], interval(0x1.999999999999AP-5 , Inf))

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, -0.1))[1], interval(-Inf, -0x1.745D1745D1745P-4)) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, -0.1))[1], interval(-Inf, -0x1.745D1745D1745P-4)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, -0.1))[1], emptyinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, -0.1))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, -0.1))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, -0.1))[1], interval(-Inf, -0x1.745D1745D1745P-4)) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, -0.1))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, -0.1))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, -0.1))[2], interval(0x1.999999999999AP-5 , Inf))

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, -0.1))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, -0.1))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, -0.1))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-Inf, -0.1))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(entireinterval(), interval(-Inf, -0.1))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.0))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.0))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.0))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.0))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-Inf, 0.0))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(-Inf, 0.0))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.3))[1], interval(-0x1.8P+1, Inf)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.3))[1], interval(-Inf, 0x1.EP+4)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.3))[1], interval(-0x1.8P+1, Inf)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.3))[1], interval(-Inf, 0x1.EP+4)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-Inf, 0.3))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(-Inf, 0.3))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-0.21, Inf))[1], interval(-Inf , 0x1.0CCCCCCCCCCCDP+1)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-0.21, Inf))[1], interval(-0x1.5P+4, Inf)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-0.21, Inf))[1], interval(-Inf, 0x1.0CCCCCCCCCCCDP+1)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(-0.21, Inf))[1], interval(-0x1.5P+4, Inf)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(-0.21, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(-0.21, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, Inf))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, Inf))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(0.0, Inf))[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), interval(0.0, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.04, Inf))[1], interval(-Inf, -0x1.47AE147AE147BP-6)) && equal(mul_rev_to_pair(interval(-2.0, -0.1), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.04, Inf))[1], interval(-Inf, -0x1.47AE147AE147BP-6)) && equal(mul_rev_to_pair(interval(-2.0, 0.0), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.04, Inf))[1], interval(-Inf, -0x1.47AE147AE147BP-6)) && equal(mul_rev_to_pair(interval(-2.0, 1.1), interval(0.04, Inf))[2], interval(0x1.29E4129E4129DP-5, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.04, Inf))[1], interval(0x1.29E4129E4129DP-5, Inf)) && equal(mul_rev_to_pair(interval(0.0, 1.1), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.04, Inf))[1], interval(0x1.29E4129E4129DP-5, Inf)) && equal(mul_rev_to_pair(interval(0.01, 1.1), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.04, Inf))[1], emptyinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.04, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, -0.1), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.04, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, 0.0), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.04, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(interval(-Inf, 1.1), interval(0.04, Inf))[2], interval(0x1.29E4129E4129DP-5, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.04, Inf))[1], interval(-Inf, -0x1.47AE147AE147BP-6)) && equal(mul_rev_to_pair(interval(-2.0, Inf), interval(0.04, Inf))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.04, Inf))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(0.0, Inf), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.04, Inf))[1], interval(0.0, Inf)) && equal(mul_rev_to_pair(interval(0.01, Inf), interval(0.04, Inf))[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), interval(0.04, Inf))[1], interval(-Inf, 0.0)) && equal(mul_rev_to_pair(entireinterval(), interval(0.04, Inf))[2], interval(0.0, Inf))

    @test equal(mul_rev_to_pair(interval(-2.0, -0.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, -0.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 0.0), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 0.0), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, 1.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, 1.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 1.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 1.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, 1.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.01, 1.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, 0.0), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, 0.0), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, -0.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, -0.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 0.0), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 0.0), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-Inf, 1.1), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-Inf, 1.1), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(-2.0, Inf), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(-2.0, Inf), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.0, Inf), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.0, Inf), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(interval(0.01, Inf), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(interval(0.01, Inf), entireinterval())[2], emptyinterval())

    @test equal(mul_rev_to_pair(entireinterval(), entireinterval())[1], entireinterval()) && equal(mul_rev_to_pair(entireinterval(), entireinterval())[2], emptyinterval())

end

@testset "minimal_mulRevToPair_dec_test" begin

    @test isnai(mul_rev_to_pair(nai(), DecoratedInterval(interval(1.0,2.0), def))[1]) && isnai(mul_rev_to_pair(nai(), DecoratedInterval(interval(1.0,2.0), def))[2])

    @test isnai(mul_rev_to_pair(DecoratedInterval(interval(1.0,2.0), com), nai())[1]) && isnai(mul_rev_to_pair(DecoratedInterval(interval(1.0,2.0), com), nai())[2])

    @test isnai(mul_rev_to_pair(nai(), nai())[1]) && isnai(mul_rev_to_pair(nai(), nai())[2])

    @test equal(mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, 2.0), def))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0, 2.0), def))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(emptyinterval(), trv))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(1.0, 2.0), com), DecoratedInterval(emptyinterval(), trv))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[1], DecoratedInterval(interval(0x1.999999999999AP-3, 0x1.5P+4), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), com))[1], DecoratedInterval(interval(0x1.999999999999AP-3, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), dac))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-2), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), dac))[2], DecoratedInterval(interval(0x1.999999999999AP-3, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-2), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[1], DecoratedInterval(interval(-0x1.A400000000001P+7, -0x1.745D1745D1745P-2), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(-2.1, -0.4), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), def))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, -0.4), def))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1], DecoratedInterval(interval(0.0, 0x1.5P+4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, -0.4), com))[1], DecoratedInterval(interval(0.0, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, -0.4), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-2), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), trv), DecoratedInterval(interval(-2.1, -0.4), def))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2], DecoratedInterval(interval(0x1.999999999999AP-3, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, -0.4), com))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, -0.4), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, -0.4), def))[1], DecoratedInterval(interval(-0x1.A400000000001P+7, 0.0), def)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, -0.4), def))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, -0.4), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(interval(0.0, 0x1.5P+4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(interval(-0x1.A400000000001P+7, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(interval(0.0, 0x1.5P+4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(interval(-0x1.A400000000001P+7, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-2.1, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, 0x1.5P+4), def)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(interval(-0x1.A400000000001P+7 , 0x1.8P+3), def)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, 0x1.5P+4), def)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(interval(-0x1.A400000000001P+7 , 0x1.8P+3), def)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-2.1, 0.12), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), def), DecoratedInterval(interval(-2.1, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, 0.0), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(interval(0.0, 0x1.8P+3), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(interval(0.0, 0x1.8P+3), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.12), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.12), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, -0x1.47AE147AE147BP-8), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-8), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-8), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(interval(0x1.29E4129E4129DP-7, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(0x1.29E4129E4129DP-7, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(0x1.29E4129E4129DP-7, 0x1.8P+3), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-0x1.3333333333333P+0, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(interval(0x1.29E4129E4129DP-7, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-8), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(0.0, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(0.0, 0x1.8P+3), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.01, 0.12), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.01, 0.12), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(interval(0.0, 0.0), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(interval(0.0, 0.0), com)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), com), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(interval(0.0, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(interval(0.0, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, 0.0), com))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(0x1.999999999999AP-5, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(0x1.999999999999AP-5 , Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf , -0x1.745D1745D1745P-4), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(interval(0x1.999999999999AP-5 , Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-4), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(0.0, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, -0x1.745D1745D1745P-4), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(interval(0x1.999999999999AP-5 , Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, -0.1), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.0), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(interval(-0x1.8P+1, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(interval(-Inf, 0x1.EP+4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(interval(-0x1.8P+1, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(interval(-Inf, 0x1.EP+4), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-Inf, 0.3), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(interval(-Inf , 0x1.0CCCCCCCCCCCDP+1), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(interval(-0x1.5P+4, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0x1.0CCCCCCCCCCCDP+1), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(interval(-0x1.5P+4, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.21, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(-0.21, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, Inf), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.0, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-6), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-6), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-6), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(interval(0x1.29E4129E4129DP-5, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(0x1.29E4129E4129DP-5, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(0x1.29E4129E4129DP-5, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(emptyinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(interval(0x1.29E4129E4129DP-5, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, -0x1.47AE147AE147BP-6), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(0.0, Inf), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(0.0, Inf), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.04, Inf), dac))[1], DecoratedInterval(interval(-Inf, 0.0), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(interval(0.04, Inf), dac))[2], DecoratedInterval(interval(0.0, Inf), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, -0.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, -0.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 0.0), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-Inf, 1.1), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(-2.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.0, Inf), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), dac)) && equal(mul_rev_to_pair(DecoratedInterval(interval(0.01, Inf), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

    @test equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac))[1], DecoratedInterval(entireinterval(), trv)) && equal(mul_rev_to_pair(DecoratedInterval(entireinterval(), dac), DecoratedInterval(entireinterval(), dac))[2], DecoratedInterval(emptyinterval(), trv))

end
