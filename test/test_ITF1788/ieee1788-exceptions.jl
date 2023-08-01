@testset "exceptions" begin

    @test equal(I"[+infinity]", emptyinterval())

    @test equal(interval(+Inf, -Inf), emptyinterval())

    @test_broken equal(interval(nai()), emptyinterval())

    @test equal(I"[1.0000000000000001, 1.0000000000000002]", interval(1.0, 0x1.0000000000001p+0))

end
