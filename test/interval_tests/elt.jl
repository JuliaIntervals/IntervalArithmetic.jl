using IntervalArithmetic
using Test

@testset "brodcasting tests" begin
    x = 3..12
    y = 4..5
    a = 3
    b = 12
    
    @test sqrt(sum(x.^2 .+ y.^2)) == 5..13

    for i in 1:20
        @test x.-i == (a-i)..(b-i)
    end


    for i in 1:20
        @test x.*i == (a*i)..(b*i)
    end

    a = 4
    b = 5 
    for i in 1:20
        @test y.+i == (a+i)..(b+i)
    end

    for i in 1:20
        @test y./i == (a/i)..(b/i)
    end

    j = 6
    Y = IntervalBox(4..6, 4..5)
    for i in 1:20
        @test Y.*i == IntervalBox(a*i..j*i,a*i..b*i)
    end
end