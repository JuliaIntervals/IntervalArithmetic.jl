@testset "Complex interval operations" begin
    a = interval(1im)
    b = interval(4im + 3)
    c = complex(interval(-1, 4), interval(0, 2))

    @test typeof(a) == Complex{Interval{Float64}}

    @test issubset_interval(a, c)
    @test isinterior(a, c)
    @test !issubset_interval(b, c)

    @test isequal_interval(a, complex(interval(0), interval(1)))
    @test isequal_interval(a * a, interval(-1))
    @test isequal_interval(a + a, interval(2)*interval(im))
    @test isthin(a - a, 0)
    @test isthin(a / a, 1)

    @test in_interval(3+2im, c)
    @test isequal_interval(hull(a, b), complex(interval(0, 3), interval(1, 4)))
    @test isequal_interval(intersect_interval(c, hull(a, b)), complex(interval(0, 3), interval(1, 2)))
    @test isempty_interval(intersect_interval(a, b))
    @test isdisjoint_interval(a, b)

    @test isequal_interval(interval(-1 - im, 0), interval(-1 - im, 0 + 0im))
    @test isequal_interval(interval(0, 1 + im), interval(0 + 0im, 1 + im))
end

@testset "Inverse roots of unity" begin
    for i ∈ 0:99
        if Int == Int32 && VERSION < v"1.10"
            @test issubset_interval(cispi( -interval(i)/interval(50) ), inv(cispi( interval(i)/interval(50) ))) &&
                radius( inv(cispi( interval(i)/interval(50) )) ) < 100eps()
        else
            @test issubset_interval(cispi( -interval(i)/interval(50) ), inv(cispi( interval(i)/interval(50) ))) &&
                radius( inv(cispi( interval(i)/interval(50) )) ) < 10eps()
        end
    end
end

# @testset "Complex functions" begin
#     Z = interval(3, 1e-7; format = :midpoint) + interval(4, 1e-7; format = :midpoint)*interval(im)
#     @test sin(Z) == complex(sin(real(Z)) * cosh(imag(Z)), sinh(imag(Z)) * cos(real(Z)))

#     z = exp(- interval(im) * interval(π))
#     @test in_interval(-1, real(z))
#     @test in_interval(0, imag(z))

#     sZ = sqrt(Z)
#     @test isequal_interval(sZ, complex(interval(1.99999996999999951619, 2.00000003000000070585), interval(0.99999996999999984926, 1.00000003000000048381)))
#     @test isequal_interval(sqrt(-Z), complex(imag(sZ), - real(sZ)))

#     @test isequal_interval(sqrt(interval(-1, 0) + interval(0)*interval(im)), interval(0im, im))
#     @test isequal_interval(sqrt(interval(-1, 1) + interval(0)*interval(im)), interval(0, 1) + interval(0im, 1im))
#     @test isequal_interval(sqrt(interval(-9//32, Inf)*interval(im)), complex(interval(0, Inf), interval(-3//8, Inf)))
# end

@testset "abs2 and abs" begin
    x = complex(interval(0, 3), interval(0, 4))
    @test isequal_interval(abs2(x), interval(0, 25))
    @test isequal_interval(abs(x), interval(0, 5))

    y = complex(interval(-1, 1), interval(-2, 2))
    @test inf(abs(y)) == 0
    @test inf(abs2(y)) == 0
end

@testset "real functions" begin
    x = complex(interval(0, 3), interval(0, 4))
    @test mag(x) == 5
    @test mig(x) == 0
    @test mid(x) == 1.5 + 2im
end
