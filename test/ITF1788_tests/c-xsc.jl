@testset "cxsc.intervaladdsub" begin

    @test +(bareinterval(10.0, 20.0), bareinterval(13.0, 17.0)) === bareinterval(23.0, 37.0)

    @test +(bareinterval(13.0, 17.0), bareinterval(10.0, 20.0)) === bareinterval(23.0, 37.0)

    @test -(bareinterval(10.0, 20.0), bareinterval(13.0, 16.0)) === bareinterval(-6.0, 7.0)

    @test -(bareinterval(13.0, 16.0), bareinterval(10.0, 20.0)) === bareinterval(-7.0, 6.0)

    @test -(bareinterval(10.0, 20.0)) === bareinterval(-20.0, -10.0)

    @test +(bareinterval(10.0, 20.0)) === bareinterval(10.0, 20.0)

end

@testset "cxsc.intervalmuldiv" begin

    @test *(bareinterval(1.0, 2.0), bareinterval(3.0, 4.0)) === bareinterval(3.0, 8.0)

    @test *(bareinterval(-1.0, 2.0), bareinterval(3.0, 4.0)) === bareinterval(-4.0, 8.0)

    @test *(bareinterval(-2.0, 1.0), bareinterval(3.0, 4.0)) === bareinterval(-8.0, 4.0)

    @test *(bareinterval(-2.0, -1.0), bareinterval(3.0, 4.0)) === bareinterval(-8.0, -3.0)

    @test *(bareinterval(1.0, 2.0), bareinterval(-3.0, 4.0)) === bareinterval(-6.0, 8.0)

    @test *(bareinterval(-1.0, 2.0), bareinterval(-3.0, 4.0)) === bareinterval(-6.0, 8.0)

    @test *(bareinterval(-2.0, 1.0), bareinterval(-3.0, 4.0)) === bareinterval(-8.0, 6.0)

    @test *(bareinterval(-2.0, -1.0), bareinterval(-3.0, 4.0)) === bareinterval(-8.0, 6.0)

    @test *(bareinterval(1.0, 2.0), bareinterval(-4.0, 3.0)) === bareinterval(-8.0, 6.0)

    @test *(bareinterval(-1.0, 2.0), bareinterval(-4.0, 3.0)) === bareinterval(-8.0, 6.0)

    @test *(bareinterval(-2.0, 1.0), bareinterval(-4.0, 3.0)) === bareinterval(-6.0, 8.0)

    @test *(bareinterval(-2.0, -1.0), bareinterval(-4.0, 3.0)) === bareinterval(-6.0, 8.0)

    @test *(bareinterval(1.0, 2.0), bareinterval(-4.0, -3.0)) === bareinterval(-8.0, -3.0)

    @test *(bareinterval(-1.0, 2.0), bareinterval(-4.0, -3.0)) === bareinterval(-8.0, 4.0)

    @test *(bareinterval(-2.0, -1.0), bareinterval(-4.0, -3.0)) === bareinterval(3.0, 8.0)

    @test /(bareinterval(1.0, 2.0), bareinterval(4.0, 8.0)) === bareinterval(0.125, 0.5)

    @test /(bareinterval(-1.0, 2.0), bareinterval(4.0, 8.0)) === bareinterval(-0.25, 0.5)

    @test /(bareinterval(-2.0, 1.0), bareinterval(4.0, 8.0)) === bareinterval(-0.5, 0.25)

    @test /(bareinterval(-2.0, -1.0), bareinterval(4.0, 8.0)) === bareinterval(-0.5, -0.125)

    @test /(bareinterval(1.0, 2.0), bareinterval(-4.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-1.0, 2.0), bareinterval(-4.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.0, 1.0), bareinterval(-4.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.0, -1.0), bareinterval(-4.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(1.0, 2.0), bareinterval(-8.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-1.0, 2.0), bareinterval(-8.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.0, 1.0), bareinterval(-8.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.0, -1.0), bareinterval(-8.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(1.0, 2.0), bareinterval(-8.0, -4.0)) === bareinterval(-0.5, -0.125)

    @test /(bareinterval(-1.0, 2.0), bareinterval(-8.0, -4.0)) === bareinterval(-0.5, 0.25)

    @test /(bareinterval(-2.0, 1.0), bareinterval(-8.0, -4.0)) === bareinterval(-0.25, 0.5)

    @test /(bareinterval(-2.0, -1.0), bareinterval(-8.0, -4.0)) === bareinterval(0.125, 0.5)

end

@testset "cxsc.intervalsetops" begin

    @test hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -3.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -1.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, 4.0)) === bareinterval(-4.0, 4.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) === bareinterval(-2.0, 2.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(1.0, 4.0)) === bareinterval(-2.0, 4.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(3.0, 4.0)) === bareinterval(-2.0, 4.0)

    @test hull(bareinterval(-4.0, -3.0), bareinterval(-2.0, 2.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(-4.0, -1.0), bareinterval(-2.0, 2.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(-4.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(-4.0, 4.0)

    @test hull(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 2.0)

    @test hull(bareinterval(1.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 4.0)

    @test hull(bareinterval(3.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 4.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -3.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -1.0)) === bareinterval(-2.0, -1.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, 4.0)) === bareinterval(-2.0, 2.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(1.0, 4.0)) === bareinterval(1.0, 2.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 4.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-4.0, -3.0), bareinterval(-2.0, 2.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-4.0, -1.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, -1.0)

    @test intersect_interval(bareinterval(-4.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 2.0)

    @test intersect_interval(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test intersect_interval(bareinterval(1.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(1.0, 2.0)

    @test intersect_interval(bareinterval(3.0, 4.0), bareinterval(-2.0, 2.0)) === emptyinterval(BareInterval{Float64})

end

@testset "cxsc.intervalmixsetops" begin

    @test hull(bareinterval(-2.0, 2.0), bareinterval(-4.0, -4.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(1.0, 1.0)) === bareinterval(-2.0, 2.0)

    @test hull(bareinterval(-2.0, 2.0), bareinterval(4.0, 4.0)) === bareinterval(-2.0, 4.0)

    @test hull(bareinterval(-4.0, -4.0), bareinterval(-2.0, 2.0)) === bareinterval(-4.0, 2.0)

    @test hull(bareinterval(1.0, 1.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 2.0)

    @test hull(bareinterval(4.0, 4.0), bareinterval(-2.0, 2.0)) === bareinterval(-2.0, 4.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(-4.0, -4.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(1.0, 1.0)) === bareinterval(1.0, 1.0)

    @test intersect_interval(bareinterval(-2.0, 2.0), bareinterval(4.0, 4.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-4.0, -4.0), bareinterval(-2.0, 2.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(1.0, 1.0), bareinterval(-2.0, 2.0)) === bareinterval(1.0, 1.0)

    @test intersect_interval(bareinterval(4.0, 4.0), bareinterval(-2.0, 2.0)) === emptyinterval(BareInterval{Float64})

end

@testset "cxsc.scalarmixsetops" begin

    @test hull(bareinterval(-2.0, -2.0), bareinterval(-4.0, -4.0)) === bareinterval(-4.0, -2.0)

    @test hull(bareinterval(-2.0, -2.0), bareinterval(-2.0, -2.0)) === bareinterval(-2.0, -2.0)

    @test hull(bareinterval(-2.0, -2.0), bareinterval(2.0, 2.0)) === bareinterval(-2.0, 2.0)

    @test hull(bareinterval(-4.0, -4.0), bareinterval(-2.0, -2.0)) === bareinterval(-4.0, -2.0)

    @test hull(bareinterval(-2.0, -2.0), bareinterval(-2.0, -2.0)) === bareinterval(-2.0, -2.0)

    @test hull(bareinterval(2.0, 2.0), bareinterval(-2.0, -2.0)) === bareinterval(-2.0, 2.0)

end

@testset "cxsc.intervalsetcompops" begin

    @test isinterior(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) === true

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) === false

    @test isinterior(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) === false

    @test isinterior(bareinterval(-3.0, 2.0), bareinterval(-2.0, 1.0)) === false

    @test isinterior(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) === true

    @test isinterior(bareinterval(-1.0, 2.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, 1.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, 3.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(-3.0, 2.0), bareinterval(-2.0, 2.0)) === false

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) === true

    @test issubset_interval(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) === true

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) === true

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) === true

    @test issubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 1.0)) === false

    @test issubset_interval(bareinterval(-1.0, 1.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(-2.0, 1.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(-2.0, 3.0), bareinterval(-2.0, 2.0)) === false

    @test issubset_interval(bareinterval(-3.0, 2.0), bareinterval(-2.0, 2.0)) === false

    @test isequal_interval(bareinterval(-1.0, 2.0), bareinterval(-1.0, 2.0)) === true

    @test isequal_interval(bareinterval(-2.0, 1.0), bareinterval(-3.0, 2.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 1.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-1.0, 2.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 1.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, 3.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-3.0, 2.0)) === false

end

@testset "cxsc.intervalscalarsetcompops" begin

    @test isinterior(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) === false

    @test isinterior(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) === false

    @test isinterior(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === false

    @test isinterior(bareinterval(-2.0, -2.0), bareinterval(-1.0, 2.0)) === false

    @test isinterior(bareinterval(-2.0, -2.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(0.0, 0.0), bareinterval(-2.0, 2.0)) === true

    @test isinterior(bareinterval(2.0, 2.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(3.0, 3.0), bareinterval(-2.0, 2.0)) === false

    @test isinterior(bareinterval(1.0, 1.0), bareinterval(-1.0, -1.0)) === false

    @test isinterior(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === false

    @test issubset_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) === false

    @test issubset_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) === false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) === false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === true

    @test issubset_interval(bareinterval(-2.0, -2.0), bareinterval(-1.0, 2.0)) === false

    @test issubset_interval(bareinterval(-2.0, -2.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(0.0, 0.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(2.0, 2.0), bareinterval(-2.0, 2.0)) === true

    @test issubset_interval(bareinterval(3.0, 3.0), bareinterval(-2.0, 2.0)) === false

    @test issubset_interval(bareinterval(1.0, 1.0), bareinterval(-1.0, -1.0)) === false

    @test issubset_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === true

    @test isequal_interval(bareinterval(-1.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(-2.0, -2.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(0.0, 0.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(2.0, 2.0)) === false

    @test isequal_interval(bareinterval(-2.0, 2.0), bareinterval(3.0, 3.0)) === false

    @test isequal_interval(bareinterval(-1.0, -1.0), bareinterval(1.0, 1.0)) === false

    @test isequal_interval(bareinterval(-1.0, -1.0), bareinterval(-1.0, -1.0)) === true

end

@testset "cxsc.intervalstdfunc" begin

    @test pown(bareinterval(11.0, 11.0), 2) === bareinterval(121.0, 121.0)

    @test pown(bareinterval(0.0, 0.0), 2) === bareinterval(0.0, 0.0)

    @test pown(bareinterval(-9.0, -9.0), 2) === bareinterval(81.0, 81.0)

    @test sqrt(bareinterval(121.0, 121.0)) === bareinterval(11.0, 11.0)

    @test sqrt(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test sqrt(bareinterval(81.0, 81.0)) === bareinterval(9.0, 9.0)

    @test rootn(bareinterval(27.0, 27.0), 3) === bareinterval(3.0, 3.0)

    @test rootn(bareinterval(0.0, 0.0), 4) === bareinterval(0.0, 0.0)

    @test rootn(bareinterval(1024.0, 1024.0), 10) === bareinterval(2.0, 2.0)

    @test pow(bareinterval(2.0, 2.0), bareinterval(2.0, 2.0)) === bareinterval(4.0, 4.0)

    @test pow(bareinterval(4.0, 4.0), bareinterval(5.0, 5.0)) === bareinterval(1024.0, 1024.0)

    @test pow(bareinterval(2.0, 2.0), bareinterval(3.0, 3.0)) === bareinterval(8.0, 8.0)

end
