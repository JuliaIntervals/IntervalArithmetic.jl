@testset "cxsc.intervaladdsub" begin

    @test isequal_interval(+(interval(10.0, 20.0), interval(13.0, 17.0)), interval(23.0, 37.0))

    @test isequal_interval(+(interval(13.0, 17.0), interval(10.0, 20.0)), interval(23.0, 37.0))

    @test isequal_interval(-(interval(10.0, 20.0), interval(13.0, 16.0)), interval(-6.0, 7.0))

    @test isequal_interval(-(interval(13.0, 16.0), interval(10.0, 20.0)), interval(-7.0, 6.0))

    @test isequal_interval(-(interval(10.0, 20.0)), interval(-20.0, -10.0))

    @test isequal_interval(+(interval(10.0, 20.0)), interval(10.0, 20.0))

end

@testset "cxsc.intervalmuldiv" begin

    @test isequal_interval(*(interval(1.0, 2.0), interval(3.0, 4.0)), interval(3.0, 8.0))

    @test isequal_interval(*(interval(-1.0, 2.0), interval(3.0, 4.0)), interval(-4.0, 8.0))

    @test isequal_interval(*(interval(-2.0, 1.0), interval(3.0, 4.0)), interval(-8.0, 4.0))

    @test isequal_interval(*(interval(-2.0, -1.0), interval(3.0, 4.0)), interval(-8.0, -3.0))

    @test isequal_interval(*(interval(1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test isequal_interval(*(interval(-1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test isequal_interval(*(interval(-2.0, 1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test isequal_interval(*(interval(-2.0, -1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test isequal_interval(*(interval(1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test isequal_interval(*(interval(-1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test isequal_interval(*(interval(-2.0, 1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test isequal_interval(*(interval(-2.0, -1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test isequal_interval(*(interval(1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, -3.0))

    @test isequal_interval(*(interval(-1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, 4.0))

    @test isequal_interval(*(interval(-2.0, -1.0), interval(-4.0, -3.0)), interval(3.0, 8.0))

    @test isequal_interval(/(interval(1.0, 2.0), interval(4.0, 8.0)), interval(0.125, 0.5))

    @test isequal_interval(/(interval(-1.0, 2.0), interval(4.0, 8.0)), interval(-0.25, 0.5))

    @test isequal_interval(/(interval(-2.0, 1.0), interval(4.0, 8.0)), interval(-0.5, 0.25))

    @test isequal_interval(/(interval(-2.0, -1.0), interval(4.0, 8.0)), interval(-0.5, -0.125))

    @test isequal_interval(/(interval(1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test isequal_interval(/(interval(-1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test isequal_interval(/(interval(-2.0, 1.0), interval(-4.0, 8.0)), entireinterval())

    @test isequal_interval(/(interval(-2.0, -1.0), interval(-4.0, 8.0)), entireinterval())

    @test isequal_interval(/(interval(1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test isequal_interval(/(interval(-1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test isequal_interval(/(interval(-2.0, 1.0), interval(-8.0, 4.0)), entireinterval())

    @test isequal_interval(/(interval(-2.0, -1.0), interval(-8.0, 4.0)), entireinterval())

    @test isequal_interval(/(interval(1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, -0.125))

    @test isequal_interval(/(interval(-1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, 0.25))

    @test isequal_interval(/(interval(-2.0, 1.0), interval(-8.0, -4.0)), interval(-0.25, 0.5))

    @test isequal_interval(/(interval(-2.0, -1.0), interval(-8.0, -4.0)), interval(0.125, 0.5))

end

@testset "cxsc.intervalsetops" begin

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(-4.0, -3.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-4.0, 4.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-2.0, 2.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(-2.0, 4.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(3.0, 4.0)), interval(-2.0, 4.0))

    @test isequal_interval(hull(interval(-4.0, -3.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-4.0, 4.0))

    @test isequal_interval(hull(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequal_interval(hull(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequal_interval(hull(interval(3.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(-4.0, -3.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-2.0, -1.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-2.0, 2.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-1.0, 1.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(1.0, 2.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(3.0, 4.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(-4.0, -3.0), interval(-2.0, 2.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-2.0, -1.0))

    @test isequal_interval(intersect_interval(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequal_interval(intersect_interval(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-1.0, 1.0))

    @test isequal_interval(intersect_interval(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(1.0, 2.0))

    @test isequal_interval(intersect_interval(interval(3.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.intervalmixsetops" begin

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(-4.0, -4.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(-2.0, 2.0))

    @test isequal_interval(hull(interval(-2.0, 2.0), interval(4.0, 4.0)), interval(-2.0, 4.0))

    @test isequal_interval(hull(interval(-4.0, -4.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequal_interval(hull(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequal_interval(hull(interval(4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(-4.0, -4.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(1.0, 1.0))

    @test isequal_interval(intersect_interval(interval(-2.0, 2.0), interval(4.0, 4.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(-4.0, -4.0), interval(-2.0, 2.0)), emptyinterval())

    @test isequal_interval(intersect_interval(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(1.0, 1.0))

    @test isequal_interval(intersect_interval(interval(4.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.scalarmixsetops" begin

    @test isequal_interval(hull(interval(-2.0, -2.0), interval(-4.0, -4.0)), interval(-4.0, -2.0))

    @test isequal_interval(hull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test isequal_interval(hull(interval(-2.0, -2.0), interval(2.0, 2.0)), interval(-2.0, 2.0))

    @test isequal_interval(hull(interval(-4.0, -4.0), interval(-2.0, -2.0)), interval(-4.0, -2.0))

    @test isequal_interval(hull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test isequal_interval(hull(interval(2.0, 2.0), interval(-2.0, -2.0)), interval(-2.0, 2.0))

end

@testset "cxsc.intervalsetcompops" begin

    @test isstrictsubset_interval(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test isstrictsubset_interval(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test isstrictsubset_interval(interval(-1.0, 2.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 1.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test issubset_interval(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test issubset_interval(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test issubset_interval(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(-2.0, 3.0)) == true

    @test issubset_interval(interval(-2.0, 2.0), interval(-3.0, 2.0)) == true

    @test issubset_interval(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test issubset_interval(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(-1.0, 2.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(-2.0, 1.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test issubset_interval(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test isequal_interval(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test isequal_interval(interval(-2.0, 1.0), interval(-3.0, 2.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test isstrictsubset_interval(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test isstrictsubset_interval(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test isstrictsubset_interval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test isstrictsubset_interval(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test isstrictsubset_interval(interval(-2.0, -2.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test isstrictsubset_interval(interval(2.0, 2.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test isstrictsubset_interval(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test isstrictsubset_interval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test issubset_interval(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test issubset_interval(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test issubset_interval(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test issubset_interval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test issubset_interval(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test issubset_interval(interval(-2.0, -2.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(2.0, 2.0), interval(-2.0, 2.0)) == true

    @test issubset_interval(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test issubset_interval(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test issubset_interval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test isequal_interval(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test isequal_interval(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test isequal_interval(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test isequal_interval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

end

@testset "cxsc.intervalstdfunc" begin

    @test isequal_interval(interval(11.0, 11.0)^2, interval(121.0, 121.0))

    @test isequal_interval(interval(0.0, 0.0)^2, interval(0.0, 0.0))

    @test isequal_interval(interval(-9.0, -9.0)^2, interval(81.0, 81.0))

    @test isequal_interval(sqrt(interval(121.0, 121.0)), interval(11.0, 11.0))

    @test isequal_interval(sqrt(interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequal_interval(sqrt(interval(81.0, 81.0)), interval(9.0, 9.0))

    @test isequal_interval(nthroot(interval(27.0, 27.0), 3), interval(3.0, 3.0))

    @test isequal_interval(nthroot(interval(0.0, 0.0), 4), interval(0.0, 0.0))

    @test isequal_interval(nthroot(interval(1024.0, 1024.0), 10), interval(2.0, 2.0))

    @test isequal_interval(^(interval(2.0, 2.0), interval(2.0, 2.0)), interval(4.0, 4.0))

    @test isequal_interval(^(interval(4.0, 4.0), interval(5.0, 5.0)), interval(1024.0, 1024.0))

    @test isequal_interval(^(interval(2.0, 2.0), interval(3.0, 3.0)), interval(8.0, 8.0))

end
