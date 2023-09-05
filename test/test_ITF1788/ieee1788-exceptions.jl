@testset "exceptions" begin

    @test isequalinterval(I"[+infinity]", emptyinterval())

    @test isequalinterval(interval(+Inf, -Inf), emptyinterval())

    @test_broken isequalinterval(interval(nai()), emptyinterval())

    @test isequalinterval(I"[1.0000000000000001, 1.0000000000000002]", interval(1.0, 0x1.0000000000001p+0))

end
