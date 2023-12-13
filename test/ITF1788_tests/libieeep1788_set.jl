@testset "minimal_intersection_test" begin

    @test intersect_interval(bareinterval(1.0,3.0), bareinterval(2.1,4.0)) === bareinterval(2.1,3.0)

    @test intersect_interval(bareinterval(1.0,3.0), bareinterval(3.0,4.0)) === bareinterval(3.0,3.0)

    @test intersect_interval(bareinterval(1.0,3.0), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(1.0,3.0), entireinterval(BareInterval{Float64})) === bareinterval(1.0,3.0)

end

@testset "minimal_intersection_dec_test" begin

    @test intersect_interval(interval(bareinterval(1.0,3.0), com), interval(bareinterval(2.1,4.0), com)) === interval(bareinterval(2.1,3.0), trv)

    @test intersect_interval(interval(bareinterval(1.0,3.0), dac), interval(bareinterval(3.0,4.0), def)) === interval(bareinterval(3.0,3.0), trv)

    @test intersect_interval(interval(bareinterval(1.0,3.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test intersect_interval(interval(entireinterval(BareInterval{Float64}), dac), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test intersect_interval(interval(bareinterval(1.0,3.0), dac), interval(entireinterval(BareInterval{Float64}), dac)) === interval(bareinterval(1.0,3.0), trv)

end

@testset "minimal_convex_hull_test" begin

    @test hull(bareinterval(1.0,3.0), bareinterval(2.1,4.0)) === bareinterval(1.0,4.0)

    @test hull(bareinterval(1.0,1.0), bareinterval(2.1,4.0)) === bareinterval(1.0,4.0)

    @test hull(bareinterval(1.0,3.0), emptyinterval(BareInterval{Float64})) === bareinterval(1.0,3.0)

    @test hull(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === emptyinterval(BareInterval{Float64})

    @test hull(bareinterval(1.0,3.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

end

@testset "minimal_convex_hull_dec_test" begin

    @test hull(interval(bareinterval(1.0,3.0), trv), interval(bareinterval(2.1,4.0), trv)) === interval(bareinterval(1.0,4.0), trv)

    @test hull(interval(bareinterval(1.0,1.0), trv), interval(bareinterval(2.1,4.0), trv)) === interval(bareinterval(1.0,4.0), trv)

    @test hull(interval(bareinterval(1.0,3.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(bareinterval(1.0,3.0), trv)

    @test hull(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === interval(emptyinterval(BareInterval{Float64}), trv)

    @test hull(interval(bareinterval(1.0,3.0), trv), interval(entireinterval(BareInterval{Float64}), dac)) === interval(entireinterval(BareInterval{Float64}), trv)

end
