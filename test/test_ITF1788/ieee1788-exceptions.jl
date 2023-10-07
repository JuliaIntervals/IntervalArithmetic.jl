@testset "exceptions" begin

    @test isequal_interval(I"[+infinity]", emptyinterval())

    @test isequal_interval(interval(+Inf, -Inf), emptyinterval())

    @test_broken isequal_interval(interval(nai()), emptyinterval())

    @test isequal_interval(I"[1.0000000000000001, 1.0000000000000002]", interval(1.0, 0x1.0000000000001p+0))

end
