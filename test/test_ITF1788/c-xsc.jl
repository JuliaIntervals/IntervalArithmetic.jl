@testset "cxsc.intervaladdsub" begin

    @test equal(+(interval(10.0, 20.0), interval(13.0, 17.0)), interval(23.0, 37.0))

    @test equal(+(interval(13.0, 17.0), interval(10.0, 20.0)), interval(23.0, 37.0))

    @test equal(-(interval(10.0, 20.0), interval(13.0, 16.0)), interval(-6.0, 7.0))

    @test equal(-(interval(13.0, 16.0), interval(10.0, 20.0)), interval(-7.0, 6.0))

    @test equal(-(interval(10.0, 20.0)), interval(-20.0, -10.0))

    @test equal(+(interval(10.0, 20.0)), interval(10.0, 20.0))

end

@testset "cxsc.intervalmuldiv" begin

    @test equal(*(interval(1.0, 2.0), interval(3.0, 4.0)), interval(3.0, 8.0))

    @test equal(*(interval(-1.0, 2.0), interval(3.0, 4.0)), interval(-4.0, 8.0))

    @test equal(*(interval(-2.0, 1.0), interval(3.0, 4.0)), interval(-8.0, 4.0))

    @test equal(*(interval(-2.0, -1.0), interval(3.0, 4.0)), interval(-8.0, -3.0))

    @test equal(*(interval(1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test equal(*(interval(-1.0, 2.0), interval(-3.0, 4.0)), interval(-6.0, 8.0))

    @test equal(*(interval(-2.0, 1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test equal(*(interval(-2.0, -1.0), interval(-3.0, 4.0)), interval(-8.0, 6.0))

    @test equal(*(interval(1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test equal(*(interval(-1.0, 2.0), interval(-4.0, 3.0)), interval(-8.0, 6.0))

    @test equal(*(interval(-2.0, 1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test equal(*(interval(-2.0, -1.0), interval(-4.0, 3.0)), interval(-6.0, 8.0))

    @test equal(*(interval(1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, -3.0))

    @test equal(*(interval(-1.0, 2.0), interval(-4.0, -3.0)), interval(-8.0, 4.0))

    @test equal(*(interval(-2.0, -1.0), interval(-4.0, -3.0)), interval(3.0, 8.0))

    @test equal(/(interval(1.0, 2.0), interval(4.0, 8.0)), interval(0.125, 0.5))

    @test equal(/(interval(-1.0, 2.0), interval(4.0, 8.0)), interval(-0.25, 0.5))

    @test equal(/(interval(-2.0, 1.0), interval(4.0, 8.0)), interval(-0.5, 0.25))

    @test equal(/(interval(-2.0, -1.0), interval(4.0, 8.0)), interval(-0.5, -0.125))

    @test equal(/(interval(1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test equal(/(interval(-1.0, 2.0), interval(-4.0, 8.0)), entireinterval())

    @test equal(/(interval(-2.0, 1.0), interval(-4.0, 8.0)), entireinterval())

    @test equal(/(interval(-2.0, -1.0), interval(-4.0, 8.0)), entireinterval())

    @test equal(/(interval(1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test equal(/(interval(-1.0, 2.0), interval(-8.0, 4.0)), entireinterval())

    @test equal(/(interval(-2.0, 1.0), interval(-8.0, 4.0)), entireinterval())

    @test equal(/(interval(-2.0, -1.0), interval(-8.0, 4.0)), entireinterval())

    @test equal(/(interval(1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, -0.125))

    @test equal(/(interval(-1.0, 2.0), interval(-8.0, -4.0)), interval(-0.5, 0.25))

    @test equal(/(interval(-2.0, 1.0), interval(-8.0, -4.0)), interval(-0.25, 0.5))

    @test equal(/(interval(-2.0, -1.0), interval(-8.0, -4.0)), interval(0.125, 0.5))

end

@testset "cxsc.intervalsetops" begin

    @test equal(convexhull(interval(-2.0, 2.0), interval(-4.0, -3.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-4.0, 4.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-2.0, 2.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(-2.0, 4.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(3.0, 4.0)), interval(-2.0, 4.0))

    @test equal(convexhull(interval(-4.0, -3.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-4.0, 4.0))

    @test equal(convexhull(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test equal(convexhull(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test equal(convexhull(interval(3.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(-4.0, -3.0)), emptyinterval())

    @test equal(intersection(interval(-2.0, 2.0), interval(-4.0, -1.0)), interval(-2.0, -1.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(-4.0, 4.0)), interval(-2.0, 2.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(-1.0, 1.0)), interval(-1.0, 1.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(1.0, 4.0)), interval(1.0, 2.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(3.0, 4.0)), emptyinterval())

    @test equal(intersection(interval(-4.0, -3.0), interval(-2.0, 2.0)), emptyinterval())

    @test equal(intersection(interval(-4.0, -1.0), interval(-2.0, 2.0)), interval(-2.0, -1.0))

    @test equal(intersection(interval(-4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test equal(intersection(interval(-1.0, 1.0), interval(-2.0, 2.0)), interval(-1.0, 1.0))

    @test equal(intersection(interval(1.0, 4.0), interval(-2.0, 2.0)), interval(1.0, 2.0))

    @test equal(intersection(interval(3.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.intervalmixsetops" begin

    @test equal(convexhull(interval(-2.0, 2.0), interval(-4.0, -4.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(-2.0, 2.0))

    @test equal(convexhull(interval(-2.0, 2.0), interval(4.0, 4.0)), interval(-2.0, 4.0))

    @test equal(convexhull(interval(-4.0, -4.0), interval(-2.0, 2.0)), interval(-4.0, 2.0))

    @test equal(convexhull(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(-2.0, 2.0))

    @test equal(convexhull(interval(4.0, 4.0), interval(-2.0, 2.0)), interval(-2.0, 4.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(-4.0, -4.0)), emptyinterval())

    @test equal(intersection(interval(-2.0, 2.0), interval(1.0, 1.0)), interval(1.0, 1.0))

    @test equal(intersection(interval(-2.0, 2.0), interval(4.0, 4.0)), emptyinterval())

    @test equal(intersection(interval(-4.0, -4.0), interval(-2.0, 2.0)), emptyinterval())

    @test equal(intersection(interval(1.0, 1.0), interval(-2.0, 2.0)), interval(1.0, 1.0))

    @test equal(intersection(interval(4.0, 4.0), interval(-2.0, 2.0)), emptyinterval())

end

@testset "cxsc.scalarmixsetops" begin

    @test equal(convexhull(interval(-2.0, -2.0), interval(-4.0, -4.0)), interval(-4.0, -2.0))

    @test equal(convexhull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test equal(convexhull(interval(-2.0, -2.0), interval(2.0, 2.0)), interval(-2.0, 2.0))

    @test equal(convexhull(interval(-4.0, -4.0), interval(-2.0, -2.0)), interval(-4.0, -2.0))

    @test equal(convexhull(interval(-2.0, -2.0), interval(-2.0, -2.0)), interval(-2.0, -2.0))

    @test equal(convexhull(interval(2.0, 2.0), interval(-2.0, -2.0)), interval(-2.0, 2.0))

end

@testset "cxsc.intervalsetcompops" begin

    @test interior(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test interior(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test interior(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test interior(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test interior(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test interior(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test interior(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

    @test interior(interval(-1.0, 2.0), interval(-1.0, 2.0)) == false

    @test interior(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test interior(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test interior(interval(-1.0, 2.0), interval(-2.0, 2.0)) == false

    @test interior(interval(-2.0, 1.0), interval(-2.0, 2.0)) == false

    @test interior(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test interior(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test subset(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test subset(interval(-2.0, 1.0), interval(-3.0, 2.0)) == true

    @test subset(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test subset(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test subset(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test subset(interval(-2.0, 2.0), interval(-2.0, 3.0)) == true

    @test subset(interval(-2.0, 2.0), interval(-3.0, 2.0)) == true

    @test subset(interval(-3.0, 2.0), interval(-2.0, 1.0)) == false

    @test subset(interval(-1.0, 1.0), interval(-2.0, 2.0)) == true

    @test subset(interval(-1.0, 2.0), interval(-2.0, 2.0)) == true

    @test subset(interval(-2.0, 1.0), interval(-2.0, 2.0)) == true

    @test subset(interval(-2.0, 3.0), interval(-2.0, 2.0)) == false

    @test subset(interval(-3.0, 2.0), interval(-2.0, 2.0)) == false

    @test equal(interval(-1.0, 2.0), interval(-1.0, 2.0)) == true

    @test equal(interval(-2.0, 1.0), interval(-3.0, 2.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-1.0, 1.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-1.0, 2.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-2.0, 1.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-2.0, 3.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-3.0, 2.0)) == false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test interior(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test interior(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test interior(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test interior(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test interior(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test interior(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test interior(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test interior(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test interior(interval(-2.0, -2.0), interval(-2.0, 2.0)) == false

    @test interior(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test interior(interval(2.0, 2.0), interval(-2.0, 2.0)) == false

    @test interior(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test interior(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test interior(interval(-1.0, -1.0), interval(-1.0, -1.0)) == false

    @test subset(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test subset(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test subset(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test subset(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test subset(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test subset(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test subset(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test subset(interval(-2.0, -2.0), interval(-1.0, 2.0)) == false

    @test subset(interval(-2.0, -2.0), interval(-2.0, 2.0)) == true

    @test subset(interval(0.0, 0.0), interval(-2.0, 2.0)) == true

    @test subset(interval(2.0, 2.0), interval(-2.0, 2.0)) == true

    @test subset(interval(3.0, 3.0), interval(-2.0, 2.0)) == false

    @test subset(interval(1.0, 1.0), interval(-1.0, -1.0)) == false

    @test subset(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

    @test equal(interval(-1.0, 2.0), interval(-2.0, -2.0)) == false

    @test equal(interval(-2.0, 2.0), interval(-2.0, -2.0)) == false

    @test equal(interval(-2.0, 2.0), interval(0.0, 0.0)) == false

    @test equal(interval(-2.0, 2.0), interval(2.0, 2.0)) == false

    @test equal(interval(-2.0, 2.0), interval(3.0, 3.0)) == false

    @test equal(interval(-1.0, -1.0), interval(1.0, 1.0)) == false

    @test equal(interval(-1.0, -1.0), interval(-1.0, -1.0)) == true

end

@testset "cxsc.intervalstdfunc" begin

    @test equal(interval(11.0, 11.0)^2, interval(121.0, 121.0))

    @test equal(interval(0.0, 0.0)^2, interval(0.0, 0.0))

    @test equal(interval(-9.0, -9.0)^2, interval(81.0, 81.0))

    @test equal(sqrt(interval(121.0, 121.0)), interval(11.0, 11.0))

    @test equal(sqrt(interval(0.0, 0.0)), interval(0.0, 0.0))

    @test equal(sqrt(interval(81.0, 81.0)), interval(9.0, 9.0))

    @test equal(nthroot(interval(27.0, 27.0), 3), interval(3.0, 3.0))

    @test equal(nthroot(interval(0.0, 0.0), 4), interval(0.0, 0.0))

    @test equal(nthroot(interval(1024.0, 1024.0), 10), interval(2.0, 2.0))

    @test equal(^(interval(2.0, 2.0), interval(2.0, 2.0)), interval(4.0, 4.0))

    @test equal(^(interval(4.0, 4.0), interval(5.0, 5.0)), interval(1024.0, 1024.0))

    @test equal(^(interval(2.0, 2.0), interval(3.0, 3.0)), interval(8.0, 8.0))

end
