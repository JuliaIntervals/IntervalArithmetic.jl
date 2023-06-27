@testset "cxsc.intervaladdsub" begin

    @test +(interval(10.0, 20.0), interval(13.0, 17.0)) === interval(23.0, 37.0)

    @test +(interval(13.0, 17.0), interval(10.0, 20.0)) === interval(23.0, 37.0)

    @test -(interval(10.0, 20.0), interval(13.0, 16.0)) === interval(-6.0, 7.0)

    @test -(interval(13.0, 16.0), interval(10.0, 20.0)) === interval(-7.0, 6.0)

    @test -(interval(10.0, 20.0)) === interval(-20.0, -10.0)

    @test +(interval(10.0, 20.0)) === interval(10.0, 20.0)
end

@testset "cxsc.intervalmuldiv" begin

    @test *(interval(1.0, 2.0), interval(3.0, 4.0)) === interval(3.0, 8.0)

    @test *(interval(-1.0, 2.0), interval(3.0, 4.0)) === interval(-4.0, 8.0)

    @test *(interval(-2.0, 1.0), interval(3.0, 4.0)) === interval(-8.0, 4.0)

    @test *(interval(-2.0, -1.0), interval(3.0, 4.0)) === interval(-8.0, -3.0)

    @test *(interval(1.0, 2.0), interval(-3.0, 4.0)) === interval(-6.0, 8.0)

    @test *(interval(-1.0, 2.0), interval(-3.0, 4.0)) === interval(-6.0, 8.0)

    @test *(interval(-2.0, 1.0), interval(-3.0, 4.0)) === interval(-8.0, 6.0)

    @test *(interval(-2.0, -1.0), interval(-3.0, 4.0)) === interval(-8.0, 6.0)

    @test *(interval(1.0, 2.0), interval(-4.0, 3.0)) === interval(-8.0, 6.0)

    @test *(interval(-1.0, 2.0), interval(-4.0, 3.0)) === interval(-8.0, 6.0)

    @test *(interval(-2.0, 1.0), interval(-4.0, 3.0)) === interval(-6.0, 8.0)

    @test *(interval(-2.0, -1.0), interval(-4.0, 3.0)) === interval(-6.0, 8.0)

    @test *(interval(1.0, 2.0), interval(-4.0, -3.0)) === interval(-8.0, -3.0)

    @test *(interval(-1.0, 2.0), interval(-4.0, -3.0)) === interval(-8.0, 4.0)

    @test *(interval(-2.0, -1.0), interval(-4.0, -3.0)) === interval(3.0, 8.0)

    @test /(interval(1.0, 2.0), interval(4.0, 8.0)) === interval(0.125, 0.5)

    @test /(interval(-1.0, 2.0), interval(4.0, 8.0)) === interval(-0.25, 0.5)

    @test /(interval(-2.0, 1.0), interval(4.0, 8.0)) === interval(-0.5, 0.25)

    @test /(interval(-2.0, -1.0), interval(4.0, 8.0)) === interval(-0.5, -0.125)

    @test /(interval(1.0, 2.0), interval(-4.0, 8.0)) === entireinterval()

    @test /(interval(-1.0, 2.0), interval(-4.0, 8.0)) === entireinterval()

    @test /(interval(-2.0, 1.0), interval(-4.0, 8.0)) === entireinterval()

    @test /(interval(-2.0, -1.0), interval(-4.0, 8.0)) === entireinterval()

    @test /(interval(1.0, 2.0), interval(-8.0, 4.0)) === entireinterval()

    @test /(interval(-1.0, 2.0), interval(-8.0, 4.0)) === entireinterval()

    @test /(interval(-2.0, 1.0), interval(-8.0, 4.0)) === entireinterval()

    @test /(interval(-2.0, -1.0), interval(-8.0, 4.0)) === entireinterval()

    @test /(interval(1.0, 2.0), interval(-8.0, -4.0)) === interval(-0.5, -0.125)

    @test /(interval(-1.0, 2.0), interval(-8.0, -4.0)) === interval(-0.5, 0.25)

    @test /(interval(-2.0, 1.0), interval(-8.0, -4.0)) === interval(-0.25, 0.5)

    @test /(interval(-2.0, -1.0), interval(-8.0, -4.0)) === interval(0.125, 0.5)
end

@testset "cxsc.intervalsetops" begin

    @test hull(interval(-2.0, 2.0), interval(-4.0, -3.0)) === interval(-4.0, 2.0)

    @test hull(interval(-2.0, 2.0), interval(-4.0, -1.0)) === interval(-4.0, 2.0)

    @test hull(interval(-2.0, 2.0), interval(-4.0, 4.0)) === interval(-4.0, 4.0)

    @test hull(interval(-2.0, 2.0), interval(-1.0, 1.0)) === interval(-2.0, 2.0)

    @test hull(interval(-2.0, 2.0), interval(1.0, 4.0)) === interval(-2.0, 4.0)

    @test hull(interval(-2.0, 2.0), interval(3.0, 4.0)) === interval(-2.0, 4.0)

    @test hull(interval(-4.0, -3.0), interval(-2.0, 2.0)) === interval(-4.0, 2.0)

    @test hull(interval(-4.0, -1.0), interval(-2.0, 2.0)) === interval(-4.0, 2.0)

    @test hull(interval(-4.0, 4.0), interval(-2.0, 2.0)) === interval(-4.0, 4.0)

    @test hull(interval(-1.0, 1.0), interval(-2.0, 2.0)) === interval(-2.0, 2.0)

    @test hull(interval(1.0, 4.0), interval(-2.0, 2.0)) === interval(-2.0, 4.0)

    @test hull(interval(3.0, 4.0), interval(-2.0, 2.0)) === interval(-2.0, 4.0)

    @test intersect(interval(-2.0, 2.0), interval(-4.0, -3.0)) === emptyinterval()

    @test intersect(interval(-2.0, 2.0), interval(-4.0, -1.0)) === interval(-2.0, -1.0)

    @test intersect(interval(-2.0, 2.0), interval(-4.0, 4.0)) === interval(-2.0, 2.0)

    @test intersect(interval(-2.0, 2.0), interval(-1.0, 1.0)) === interval(-1.0, 1.0)

    @test intersect(interval(-2.0, 2.0), interval(1.0, 4.0)) === interval(1.0, 2.0)

    @test intersect(interval(-2.0, 2.0), interval(3.0, 4.0)) === emptyinterval()

    @test intersect(interval(-4.0, -3.0), interval(-2.0, 2.0)) === emptyinterval()

    @test intersect(interval(-4.0, -1.0), interval(-2.0, 2.0)) === interval(-2.0, -1.0)

    @test intersect(interval(-4.0, 4.0), interval(-2.0, 2.0)) === interval(-2.0, 2.0)

    @test intersect(interval(-1.0, 1.0), interval(-2.0, 2.0)) === interval(-1.0, 1.0)

    @test intersect(interval(1.0, 4.0), interval(-2.0, 2.0)) === interval(1.0, 2.0)

    @test intersect(interval(3.0, 4.0), interval(-2.0, 2.0)) === emptyinterval()

end

@testset "cxsc.intervalmixsetops" begin

    @test hull(interval(-2.0, 2.0), interval(-4.0, -4.0)) === interval(-4.0, 2.0)

    @test hull(interval(-2.0, 2.0), interval(1.0, 1.0)) === interval(-2.0, 2.0)

    @test hull(interval(-2.0, 2.0), interval(4.0, 4.0)) === interval(-2.0, 4.0)

    @test hull(interval(-4.0, -4.0), interval(-2.0, 2.0)) === interval(-4.0, 2.0)

    @test hull(interval(1.0, 1.0), interval(-2.0, 2.0)) === interval(-2.0, 2.0)

    @test hull(interval(4.0, 4.0), interval(-2.0, 2.0)) === interval(-2.0, 4.0)

    @test intersect(interval(-2.0, 2.0), interval(-4.0, -4.0)) === emptyinterval()

    @test intersect(interval(-2.0, 2.0), interval(1.0, 1.0)) === interval(1.0, 1.0)

    @test intersect(interval(-2.0, 2.0), interval(4.0, 4.0)) === emptyinterval()

    @test intersect(interval(-4.0, -4.0), interval(-2.0, 2.0)) === emptyinterval()

    @test intersect(interval(1.0, 1.0), interval(-2.0, 2.0)) === interval(1.0, 1.0)

    @test intersect(interval(4.0, 4.0), interval(-2.0, 2.0)) === emptyinterval()

end

@testset "cxsc.scalarmixsetops" begin

    @test hull(interval(-2.0, -2.0), interval(-4.0, -4.0)) === interval(-4.0, -2.0)

    @test hull(interval(-2.0, -2.0), interval(-2.0, -2.0)) === interval(-2.0, -2.0)

    @test hull(interval(-2.0, -2.0), interval(2.0, 2.0)) === interval(-2.0, 2.0)

    @test hull(interval(-4.0, -4.0), interval(-2.0, -2.0)) === interval(-4.0, -2.0)

    @test hull(interval(-2.0, -2.0), interval(-2.0, -2.0)) === interval(-2.0, -2.0)

    @test hull(interval(2.0, 2.0), interval(-2.0, -2.0)) === interval(-2.0, 2.0)

end

@testset "cxsc.intervalsetcompops" begin

    @test isinterior(interval(-1.0, 2.0), interval(-1.0, 2.0)) === false

    @test isinterior(interval(-2.0, 1.0), interval(-3.0, 2.0)) === true

    @test isinterior(interval(-2.0, 2.0), interval(-1.0, 1.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(-1.0, 2.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, 1.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, 3.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(-3.0, 2.0)) === false

    @test isinterior(interval(-1.0, 2.0), interval(-1.0, 2.0)) === false

    @test isinterior(interval(-3.0, 2.0), interval(-2.0, 1.0)) === false

    @test isinterior(interval(-1.0, 1.0), interval(-2.0, 2.0)) === true

    @test isinterior(interval(-1.0, 2.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(-2.0, 1.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(-2.0, 3.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(-3.0, 2.0), interval(-2.0, 2.0)) === false

    @test issubset(interval(-1.0, 2.0), interval(-1.0, 2.0)) === true

    @test issubset(interval(-2.0, 1.0), interval(-3.0, 2.0)) === true

    @test issubset(interval(-2.0, 2.0), interval(-1.0, 1.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(-1.0, 2.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(-2.0, 1.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(-2.0, 3.0)) === true

    @test issubset(interval(-2.0, 2.0), interval(-3.0, 2.0)) === true

    @test issubset(interval(-3.0, 2.0), interval(-2.0, 1.0)) === false

    @test issubset(interval(-1.0, 1.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(-1.0, 2.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(-2.0, 1.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(-2.0, 3.0), interval(-2.0, 2.0)) === false

    @test issubset(interval(-3.0, 2.0), interval(-2.0, 2.0)) === false

    @test ==(interval(-1.0, 2.0), interval(-1.0, 2.0)) === true

    @test ==(interval(-2.0, 1.0), interval(-3.0, 2.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-1.0, 1.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-1.0, 2.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-2.0, 1.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-2.0, 3.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-3.0, 2.0)) === false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test isinterior(interval(-1.0, 2.0), interval(-2.0, -2.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(-2.0, -2.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(0.0, 0.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(2.0, 2.0)) === false

    @test isinterior(interval(-2.0, 2.0), interval(3.0, 3.0)) === false

    @test isinterior(interval(-1.0, -1.0), interval(1.0, 1.0)) === false

    @test isinterior(interval(-1.0, -1.0), interval(-1.0, -1.0)) === false

    @test isinterior(interval(-2.0, -2.0), interval(-1.0, 2.0)) === false

    @test isinterior(interval(-2.0, -2.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(0.0, 0.0), interval(-2.0, 2.0)) === true

    @test isinterior(interval(2.0, 2.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(3.0, 3.0), interval(-2.0, 2.0)) === false

    @test isinterior(interval(1.0, 1.0), interval(-1.0, -1.0)) === false

    @test isinterior(interval(-1.0, -1.0), interval(-1.0, -1.0)) === false

    @test issubset(interval(-1.0, 2.0), interval(-2.0, -2.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(-2.0, -2.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(0.0, 0.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(2.0, 2.0)) === false

    @test issubset(interval(-2.0, 2.0), interval(3.0, 3.0)) === false

    @test issubset(interval(-1.0, -1.0), interval(1.0, 1.0)) === false

    @test issubset(interval(-1.0, -1.0), interval(-1.0, -1.0)) === true

    @test issubset(interval(-2.0, -2.0), interval(-1.0, 2.0)) === false

    @test issubset(interval(-2.0, -2.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(0.0, 0.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(2.0, 2.0), interval(-2.0, 2.0)) === true

    @test issubset(interval(3.0, 3.0), interval(-2.0, 2.0)) === false

    @test issubset(interval(1.0, 1.0), interval(-1.0, -1.0)) === false

    @test issubset(interval(-1.0, -1.0), interval(-1.0, -1.0)) === true

    @test ==(interval(-1.0, 2.0), interval(-2.0, -2.0)) === false

    @test ==(interval(-2.0, 2.0), interval(-2.0, -2.0)) === false

    @test ==(interval(-2.0, 2.0), interval(0.0, 0.0)) === false

    @test ==(interval(-2.0, 2.0), interval(2.0, 2.0)) === false

    @test ==(interval(-2.0, 2.0), interval(3.0, 3.0)) === false

    @test ==(interval(-1.0, -1.0), interval(1.0, 1.0)) === false

    @test ==(interval(-1.0, -1.0), interval(-1.0, -1.0)) === true

end

@testset "cxsc.intervalstdfunc" begin

    @test interval(11.0, 11.0)^2 === interval(121.0, 121.0)

    @test interval(0.0, 0.0)^2 === interval(0.0, 0.0)

    @test interval(-9.0, -9.0)^2 === interval(81.0, 81.0)

    @test sqrt(interval(121.0, 121.0)) === interval(11.0, 11.0)

    @test sqrt(interval(0.0, 0.0)) === interval(0.0, 0.0)

    @test sqrt(interval(81.0, 81.0)) === interval(9.0, 9.0)

    @test nthroot(interval(27.0, 27.0), 3) === interval(3.0, 3.0)

    @test nthroot(interval(0.0, 0.0), 4) === interval(0.0, 0.0)

    @test nthroot(interval(1024.0, 1024.0), 10) === interval(2.0, 2.0)

    @test ^(interval(2.0, 2.0), interval(2.0, 2.0)) === interval(4.0, 4.0)

    @test ^(interval(4.0, 4.0), interval(5.0, 5.0)) === interval(1024.0, 1024.0)

    @test ^(interval(2.0, 2.0), interval(3.0, 3.0)) === interval(8.0, 8.0)

end
