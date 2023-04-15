@testset "exceptions" begin

    @test @interval("[+infinity]") === emptyinterval()

    @test interval(+Inf,-Inf) === emptyinterval()

    @test_broken interval(nai()) === emptyinterval()

    @test @interval("[1.0000000000000001, 1.0000000000000002]") === interval(1.0, 0x1.0000000000001p+0)

end
