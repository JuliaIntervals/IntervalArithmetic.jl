@testset "cxsc.intervaladdsub" begin

    @test isequalinterval(+(interval(10.0, 20.0), interval(13.0, 17.0)), interval(23.0, 37.0))

    @test isequalinterval(+(interval(13.0, 17.0), interval(10.0, 20.0)), interval(23.0, 37.0))

    @test isequalinterval(-(interval(10.0, 20.0), interval(13.0, 16.0)), interval(-6.0, 7.0))

    @test isequalinterval(-(interval(13.0, 16.0), interval(10.0, 20.0)), interval(-7.0, 6.0))

    @test isequalinterval(-(interval(10.0, 20.0)), interval(-20.0, -10.0))

    @test isequalinterval(+(interval(10.0, 20.0)), interval(10.0, 20.0))

end

@testset "cxsc.intervalmuldiv" begin

    @test isequalinterval(*(interval(1.0, 2.0), interval(3.0, 4.0)), interval(3.0, 8.0))

    @test isequalinterval(*(interval(-1.0, 2.0), interval(3.0, 4.0)), interval(-4.0, 8.0))

    @test isequalinterval(*(interval(-2.0, 1.0), interval(3.0, 4.0)), interval(-8.0, 4.0))

    @test isequalinterval(*(interval(-2.0, -1.0), interval(3.0, 4.0)), interval(-8.0, -3.0))

    @test isequalinterval(*(interval(1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test isequalinterval(*(interval(-1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test isequalinterval(*(interval(-2.0, 1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test isequalinterval(*(interval(-2.0, -1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test isequalinterval(*(interval(1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test isequalinterval(*(interval(-1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test isequalinterval(*(interval(-2.0, 1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test isequalinterval(*(interval(-2.0, -1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test isequalinterval(*(interval(1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, -3.0))

    @test isequalinterval(*(interval(-1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, 4.0))

    @test isequalinterval(*(interval(-2.0, -1.0), interval(-4.0, -3.0)), interval(3.0, 8.0))

    @test isequalinterval(/(interval(1.0, 2.0), interval(4.0, 8.0)), interval(0.125, 0.5))

    @test isequalinterval(/(interval(-1.0, 2.0), interval(4.0, 8.0)), interval(-0.25, 0.5))

    @test isequalinterval(/(interval(-2.0, 1.0), interval(4.0, 8.0)), interval(-0.5, 0.25))

    @test isequalinterval(/(interval(-2.0, -1.0), interval(4.0, 8.0)), interval(-0.5, -0.125))

    @test isequalinterval(/(interval(1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test isequalinterval(/(interval(-1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test isequalinterval(/(interval(-2.0, 1.0), interval(-4.0, 8.0)), entireinterval())

    @test isequalinterval(/(interval(-2.0, -1.0), interval(-4.0, 8.0)), entireinterval())

    @test isequalinterval(/(interval(1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test isequalinterval(/(interval(-1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test isequalinterval(/(interval(-2.0, 1.0), interval(-8.0, 4.0)), entireinterval())

    @test isequalinterval(/(interval(-2.0, -1.0), interval(-8.0, 4.0)), entireinterval())

    @test isequalinterval(/(interval(1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, -0.125))

    @test isequalinterval(/(interval(-1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, 0.25))

    @test isequalinterval(/(interval(-2.0, 1.0), interval(-8.0, -4.0)), interval(-0.25, 0.5))

    @test isequalinterval(/(interval(-2.0, -1.0), interval(-8.0, -4.0)), interval(0.125, 0.5))

end

@testset "cxsc.intervalsetops" begin

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(-4.0, -3.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-4.0, 4.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-2.0, 2.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(-2.0, 4.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(3.0, 4.0)), interval(-2.0, 4.0))

    @test isequalinterval(hull(interval(-4.0, -3.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-4.0, 4.0))

    @test isequalinterval(hull(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequalinterval(hull(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequalinterval(hull(interval(3.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(-4.0, -3.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-2.0, -1.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-2.0, 2.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-1.0, 1.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(1.0, 2.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(3.0, 4.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(-4.0, -3.0), interval(-2.0, 2.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-2.0, -1.0))

    @test isequalinterval(intersectinterval(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequalinterval(intersectinterval(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-1.0, 1.0))

    @test isequalinterval(intersectinterval(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(1.0, 2.0))

    @test isequalinterval(intersectinterval(interval(3.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.intervalmixsetops" begin

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(-4.0, -4.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(-2.0, 2.0))

    @test isequalinterval(hull(interval(-2.0, 2.0), interval(4.0, 4.0)), interval(-2.0, 4.0))

    @test isequalinterval(hull(interval(-4.0, -4.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test isequalinterval(hull(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test isequalinterval(hull(interval(4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(-4.0, -4.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(1.0, 1.0))

    @test isequalinterval(intersectinterval(interval(-2.0, 2.0), interval(4.0, 4.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(-4.0, -4.0), interval(-2.0, 2.0)), emptyinterval())

    @test isequalinterval(intersectinterval(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(1.0, 1.0))

    @test isequalinterval(intersectinterval(interval(4.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.scalarmixsetops" begin

    @test isequalinterval(hull(interval(-2.0, -2.0), interval(-4.0, -4.0)), interval(-4.0, -2.0))

    @test isequalinterval(hull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test isequalinterval(hull(interval(-2.0, -2.0), interval(2.0, 2.0)), interval(-2.0, 2.0))

    @test isequalinterval(hull(interval(-4.0, -4.0), interval(-2.0, -2.0)), interval(-4.0, -2.0))

    @test isequalinterval(hull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test isequalinterval(hull(interval(2.0, 2.0), interval(-2.0, -2.0)), interval(-2.0, 2.0))

end

@testset "cxsc.intervalsetcompops" begin

    @test isinterior(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test isinterior(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test isinterior(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

    @test isinterior(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test isinterior(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test isinterior(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test isinterior(interval(-1.0, 2.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(-2.0, 1.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test isweaksubset(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test isweaksubset(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test isweaksubset(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(-2.0, 3.0)) == true

    @test isweaksubset(interval(-2.0, 2.0), interval(-3.0, 2.0)) == true

    @test isweaksubset(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test isweaksubset(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(-1.0, 2.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(-2.0, 1.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test isweaksubset(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test isequalinterval(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test isequalinterval(interval(-2.0, 1.0), interval(-3.0, 2.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test isinterior(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test isinterior(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test isinterior(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test isinterior(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test isinterior(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test isinterior(interval(-2.0, -2.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test isinterior(interval(2.0, 2.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test isinterior(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test isinterior(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test isweaksubset(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test isweaksubset(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test isweaksubset(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test isweaksubset(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test isweaksubset(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test isweaksubset(interval(-2.0, -2.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(2.0, 2.0), interval(-2.0, 2.0)) == true

    @test isweaksubset(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test isweaksubset(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test isweaksubset(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test isequalinterval(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test isequalinterval(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test isequalinterval(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test isequalinterval(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

end

@testset "cxsc.intervalstdfunc" begin

    @test isequalinterval(interval(11.0, 11.0)^2, interval(121.0, 121.0))

    @test isequalinterval(interval(0.0, 0.0)^2, interval(0.0, 0.0))

    @test isequalinterval(interval(-9.0, -9.0)^2, interval(81.0, 81.0))

    @test isequalinterval(sqrt(interval(121.0, 121.0)), interval(11.0, 11.0))

    @test isequalinterval(sqrt(interval(0.0, 0.0)), interval(0.0, 0.0))

    @test isequalinterval(sqrt(interval(81.0, 81.0)), interval(9.0, 9.0))

    @test isequalinterval(nthroot(interval(27.0, 27.0), 3), interval(3.0, 3.0))

    @test isequalinterval(nthroot(interval(0.0, 0.0), 4), interval(0.0, 0.0))

    @test isequalinterval(nthroot(interval(1024.0, 1024.0), 10), interval(2.0, 2.0))

    @test isequalinterval(^(interval(2.0, 2.0), interval(2.0, 2.0)), interval(4.0, 4.0))

    @test isequalinterval(^(interval(4.0, 4.0), interval(5.0, 5.0)), interval(1024.0, 1024.0))

    @test isequalinterval(^(interval(2.0, 2.0), interval(3.0, 3.0)), interval(8.0, 8.0))

end
