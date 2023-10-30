@testset "exceptions" begin

    @test isequal_interval(parse(BareInterval{Float64}, "[+infinity]"), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(bareinterval(+Inf, -Inf), emptyinterval(BareInterval{Float64}))

    @test_broken isequal_interval(bareinterval(nai()), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(parse(BareInterval{Float64}, "[1.0000000000000001, 1.0000000000000002]"), bareinterval(1.0, 0x1.0000000000001p+0))

end
