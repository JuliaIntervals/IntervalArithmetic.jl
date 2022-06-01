@testset "exceptions" begin

    @test_broken @interval("[+infinity]") === emptyinterval()

    @test interval(+Inf,-Inf) === emptyinterval()

    @test_broken interval(nai()) === emptyinterval()

    @test_broken @interval("[1.0000000000000001, 1.0000000000000002]") === Interval(1.0, 0x1.0000000000001p+0)

end

