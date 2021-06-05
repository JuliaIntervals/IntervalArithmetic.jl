@testset "exceptions" begin

    @test_logs (:warn, ) @test interval(+Inf,-Inf) == emptyinterval()

    @test_logs (:warn, ) @test interval(nai()) == emptyinterval()

end

