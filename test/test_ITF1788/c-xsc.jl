@testset "cxsc.intervaladdsub" begin

    @test isequal_interval(+(bareinterval(10.0, 20.0), bareinterval(13.0, 17.0)), bareinterval(23.0, 37.0))

    @test isequal_interval(+(bareinterval(13.0, 17.0), bareinterval(10.0, 20.0)), bareinterval(23.0, 37.0))

    @test isequal_interval(-(bareinterval(10.0, 20.0), bareinterval(13.0, 16.0)), bareinterval(-6.0, 7.0))

    @test isequal_interval(-(bareinterval(13.0, 16.0), bareinterval(10.0, 20.0)), bareinterval(-7.0, 6.0))

    @test isequal_interval(-(bareinterval(10.0, 20.0)), bareinterval(-20.0, -10.0))

    @test isequal_interval(+(bareinterval(10.0, 20.0)), bareinterval(10.0, 20.0))

end

@testset "cxsc.intervalmuldiv" begin

    @test isequal_interval(*(bareinterval(1.0, 2.0), bareinterval(3.0, 4.0)), bareinterval(3.0, 8.0))

    @test isequal_interval(*(bareinterval(-1.0, 2.0), bareinterval(3.0, 4.0)), bareinterval(-4.0, 8.0))

    @test isequal_interval(*(bareinterval(-2.0, 1.0), bareinterval(3.0, 4.0)), bareinterval(-8.0, 4.0))

    @test isequal_interval(*(bareinterval(-2.0, -1.0), bareinterval(3.0, 4.0)), bareinterval(-8.0, -3.0))

    @test isequal_interval(*(bareinterval(1.0, 2.0), bareinterval(-3.0, 4.0)), bareinterval(-6.0, 8.0))

    @test isequal_interval(*(bareinterval(-1.0, 2.0), bareinterval(-3.0, 4.0)), bareinterval(-6.0, 8.0))

    @test isequal_interval(*(bareinterval(-2.0, 1.0), bareinterval(-3.0, 4.0)), bareinterval(-8.0, 6.0))

    @test isequal_interval(*(bareinterval(-2.0, -1.0), bareinterval(-3.0, 4.0)), bareinterval(-8.0, 6.0))

    @test isequal_interval(*(bareinterval(1.0, 2.0), bareinterval(-4.0, 3.0)), bareinterval(-8.0, 6.0))

    @test isequal_interval(*(bareinterval(-1.0, 2.0), bareinterval(-4.0, 3.0)), bareinterval(-8.0, 6.0))

    @test isequal_interval(*(bareinterval(-2.0, 1.0), bareinterval(-4.0, 3.0)), bareinterval(-6.0, 8.0))

    @test isequal_interval(*(bareinterval(-2.0, -1.0), bareinterval(-4.0, 3.0)), bareinterval(-6.0, 8.0))

    @test isequal_interval(*(bareinterval(1.0, 2.0), bareinterval(-4.0, -3.0)), bareinterval(-8.0, -3.0))

    @test isequal_interval(*(bareinterval(-1.0, 2.0), bareinterval(-4.0, -3.0)), bareinterval(-8.0, 4.0))

    @test isequal_interval(*(bareinterval(-2.0, -1.0), bareinterval(-4.0, -3.0)), bareinterval(3.0, 8.0))

    @test isequal_interval(/(bareinterval(1.0, 2.0), bareinterval(4.0, 8.0)), bareinterval(0.125, 0.5))

    @test isequal_interval(/(bareinterval(-1.0, 2.0), bareinterval(4.0, 8.0)), bareinterval(-0.25, 0.5))

    @test isequal_interval(/(bareinterval(-2.0, 1.0), bareinterval(4.0, 8.0)), bareinterval(-0.5, 0.25))

    @test isequal_interval(/(bareinterval(-2.0, -1.0), bareinterval(4.0, 8.0)), bareinterval(-0.5, -0.125))

    @test isequal_interval(/(bareinterval(1.0, 2.0), bareinterval(-4.0, 8.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-1.0, 2.0), bareinterval(-4.0, 8.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-2.0, 1.0), bareinterval(-4.0, 8.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-2.0, -1.0), bareinterval(-4.0, 8.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(1.0, 2.0), bareinterval(-8.0, 4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-1.0, 2.0), bareinterval(-8.0, 4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-2.0, 1.0), bareinterval(-8.0, 4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(-2.0, -1.0), bareinterval(-8.0, 4.0)), entireinterval(BareInterval{Float64}))

    @test isequal_interval(/(bareinterval(1.0, 2.0), bareinterval(-8.0, -4.0)), bareinterval(-0.5, -0.125))

    @test isequal_interval(/(bareinterval(-1.0, 2.0), bareinterval(-8.0, -4.0)), bareinterval(-0.5, 0.25))

    @test isequal_interval(/(bareinterval(-2.0, 1.0), bareinterval(-8.0, -4.0)), bareinterval(-0.25, 0.5))

    @test isequal_interval(/(bareinterval(-2.0, -1.0), bareinterval(-8.0, -4.0)), bareinterval(0.125, 0.5))

end

@testset "cxsc.intervalsetops" begin

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -3.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -1.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, 4.0)), bareinterval(-4.0, 4.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(1.0, 4.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(3.0, 4.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(hull(bareinterval(-4.0, -3.0), bareinterval(-2.0, 2.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(-4.0, -1.0), bareinterval(-2.0, 2.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(-4.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(-4.0, 4.0))

    @test isequal_interval(hull(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(hull(bareinterval(1.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(hull(bareinterval(3.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -3.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -1.0)), bareinterval(-2.0, -1.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, 4.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)), bareinterval(-1.0, 1.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(1.0, 4.0)), bareinterval(1.0, 2.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 4.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(-4.0, -3.0), bareinterval(-2.0, 2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(-4.0, -1.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, -1.0))

    @test isequal_interval(intersect_interval(bareinterval(-4.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(intersect_interval(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)), bareinterval(-1.0, 1.0))

    @test isequal_interval(intersect_interval(bareinterval(1.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(1.0, 2.0))

    @test isequal_interval(intersect_interval(bareinterval(3.0, 4.0), bareinterval(-2.0, 2.0)), emptyinterval(BareInterval{Float64}))

end

@testset "cxsc.intervalmixsetops" begin

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -4.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(1.0, 1.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(hull(bareinterval(-2.0, 2.0), bareinterval(4.0, 4.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(hull(bareinterval(-4.0, -4.0), bareinterval(-2.0, 2.0)), bareinterval(-4.0, 2.0))

    @test isequal_interval(hull(bareinterval(1.0, 1.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(hull(bareinterval(4.0, 4.0), bareinterval(-2.0, 2.0)), bareinterval(-2.0, 4.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -4.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(1.0, 1.0)), bareinterval(1.0, 1.0))

    @test isequal_interval(intersect_interval(bareinterval(-2.0, 2.0), bareinterval(4.0, 4.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(-4.0, -4.0), bareinterval(-2.0, 2.0)), emptyinterval(BareInterval{Float64}))

    @test isequal_interval(intersect_interval(bareinterval(1.0, 1.0), bareinterval(-2.0, 2.0)), bareinterval(1.0, 1.0))

    @test isequal_interval(intersect_interval(bareinterval(4.0, 4.0), bareinterval(-2.0, 2.0)), emptyinterval(BareInterval{Float64}))

end

@testset "cxsc.scalarmixsetops" begin

    @test isequal_interval(hull(bareinterval(-2.0, -2.0), bareinterval(-4.0, -4.0)), bareinterval(-4.0, -2.0))

    @test isequal_interval(hull(bareinterval(-2.0, -2.0), bareinterval(-2.0, -2.0)), bareinterval(-2.0, -2.0))

    @test isequal_interval(hull(bareinterval(-2.0, -2.0), bareinterval(2.0, 2.0)), bareinterval(-2.0, 2.0))

    @test isequal_interval(hull(bareinterval(-4.0, -4.0), bareinterval(-2.0, -2.0)), bareinterval(-4.0, -2.0))

    @test isequal_interval(hull(bareinterval(-2.0, -2.0), bareinterval(-2.0, -2.0)), bareinterval(-2.0, -2.0))

    @test isequal_interval(hull(bareinterval(2.0, 2.0), bareinterval(-2.0, -2.0)), bareinterval(-2.0, 2.0))

end

@testset "cxsc.intervalsetcompops" begin

    @test isstrictsubset_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) == true

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 1.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) == true

    @test isstrictsubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 1.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 3.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 2.0)) == false

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) == true

    @test issubset_interval(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) == true

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) == true

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) == true

    @test issubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 1.0)) == false

    @test issubset_interval(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(-2.0, 1.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(-2.0, 3.0), bareinterval(-2.0, 2.0)) == false

    @test issubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 2.0)) == false

    @test isequal_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) == true

    @test isequal_interval(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) == false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test isstrictsubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, -2.0), bareinterval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(-2.0, -2.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(0.0, 0.0), bareinterval(-2.0, 2.0)) == true

    @test isstrictsubset_interval(bareinterval(2.0, 2.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(3.0, 3.0), bareinterval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(bareinterval(1.0, 1.0), bareinterval(-1.0, -1.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) == false

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) == false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) == false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) == false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) == true

    @test issubset_interval(bareinterval(-2.0, -2.0), bareinterval(-1.0, 2.0)) == false

    @test issubset_interval(bareinterval(-2.0, -2.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(0.0, 0.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(2.0, 2.0), bareinterval(-2.0, 2.0)) == true

    @test issubset_interval(bareinterval(3.0, 3.0), bareinterval(-2.0, 2.0)) == false

    @test issubset_interval(bareinterval(1.0, 1.0), bareinterval(-1.0, -1.0)) == false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) == true

    @test isequal_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) == false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) == false

    @test isequal_interval(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) == false

    @test isequal_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) == true

end

@testset "cxsc.intervalstdfunc" begin

    @test isequal_interval(nthpow(bareinterval(11.0, 11.0), 2), bareinterval(121.0, 121.0))

    @test isequal_interval(nthpow(bareinterval(0.0, 0.0), 2), bareinterval(0.0, 0.0))

    @test isequal_interval(nthpow(bareinterval(-9.0, -9.0), 2), bareinterval(81.0, 81.0))

    @test isequal_interval(sqrt(bareinterval(121.0, 121.0)), bareinterval(11.0, 11.0))

    @test isequal_interval(sqrt(bareinterval(0.0, 0.0)), bareinterval(0.0, 0.0))

    @test isequal_interval(sqrt(bareinterval(81.0, 81.0)), bareinterval(9.0, 9.0))

    @test isequal_interval(nthroot(bareinterval(27.0, 27.0), 3), bareinterval(3.0, 3.0))

    @test isequal_interval(nthroot(bareinterval(0.0, 0.0), 4), bareinterval(0.0, 0.0))

    @test isequal_interval(nthroot(bareinterval(1024.0, 1024.0), 10), bareinterval(2.0, 2.0))

    @test isequal_interval(^(bareinterval(2.0, 2.0), bareinterval(2.0, 2.0)), bareinterval(4.0, 4.0))

    @test isequal_interval(^(bareinterval(4.0, 4.0), bareinterval(5.0, 5.0)), bareinterval(1024.0, 1024.0))

    @test isequal_interval(^(bareinterval(2.0, 2.0), bareinterval(3.0, 3.0)), bareinterval(8.0, 8.0))

end
