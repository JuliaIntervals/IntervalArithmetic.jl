@testset "exceptions" begin

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[+infinity]") === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test bareinterval(+Inf,-Inf) === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test bareinterval(nai(Interval{Float64})) === emptyinterval(BareInterval{Float64})

    @test_logs (:warn,) @test parse(BareInterval{Float64}, "[1.0000000000000001, 1.0000000000000002]") === bareinterval(1.0, 0x1.0000000000001p+0)

end
