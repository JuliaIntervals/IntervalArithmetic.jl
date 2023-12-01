@testset "minimal_intersection_test" begin

    @test isequal_interval(intersect_interval(bareinterval(1.0,3.0), bareinterval(2.1,4.0)), bareinterval(2.1,3.0))

    @test isequal_interval(intersect_interval(bareinterval(1.0,3.0), bareinterval(3.0,4.0)), bareinterval(3.0,3.0))

    @test isequal_interval(intersect_interval(bareinterval(1.0,3.0), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(entireinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(1.0,3.0), entireinterval(BareInterval{Float64})), bareinterval(1.0,3.0))

end

@testset "minimal_intersection_dec_test" begin

    @test isequal_interval(intersect_interval(Interval(bareinterval(1.0,3.0), IntervalArithmetic.com), Interval(bareinterval(2.1,4.0), IntervalArithmetic.com)), Interval(bareinterval(2.1,3.0), IntervalArithmetic.trv))

    @test isequal_interval(intersect_interval(Interval(bareinterval(1.0,3.0), IntervalArithmetic.dac), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)), Interval(bareinterval(3.0,3.0), IntervalArithmetic.trv))

    @test isequal_interval(intersect_interval(Interval(bareinterval(1.0,3.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(intersect_interval(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(intersect_interval(Interval(bareinterval(1.0,3.0), IntervalArithmetic.dac), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv))

end

@testset "minimal_convex_convexhull_test" begin

    @test isequal_interval(hull(bareinterval(1.0,3.0), bareinterval(2.1,4.0)), bareinterval(1.0,4.0))

    @test isequal_interval(hull(bareinterval(1.0,1.0), bareinterval(2.1,4.0)), bareinterval(1.0,4.0))

    @test isequal_interval(hull(bareinterval(1.0,3.0), emptyinterval(BareInterval{Float64})), bareinterval(1.0,3.0))

    @test isequal_interval(hull(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(hull(bareinterval(1.0,3.0), entireinterval(BareInterval{Float64})), entireinterval(BareInterval{Float64}))

end

@testset "minimal_convex_convexhull_dec_test" begin

    @test isequal_interval(hull(Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv), Interval(bareinterval(2.1,4.0), IntervalArithmetic.trv)), Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv))

    @test isequal_interval(hull(Interval(bareinterval(1.0,1.0), IntervalArithmetic.trv), Interval(bareinterval(2.1,4.0), IntervalArithmetic.trv)), Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv))

    @test isequal_interval(hull(Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv))

    @test isequal_interval(hull(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv))

    @test isequal_interval(hull(Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)), Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv))

end
