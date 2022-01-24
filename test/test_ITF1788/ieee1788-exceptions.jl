@testset "exceptions" begin

    @test_logs (:warn, ) @test @interval("[+infinity]") === emptyinterval()

    @test_logs (:warn, ) @test interval(+Inf,-Inf) === emptyinterval()

    @test_logs (:warn, ) @test_skip interval_part(nai()) === emptyinterval()

    @test_logs (:warn, ) @test @interval("[1.0000000000000001, 1.0000000000000002]") === Interval(1.0, 0x1.0000000000001p+0)

end

