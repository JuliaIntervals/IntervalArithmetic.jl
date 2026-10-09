using Test
using IntervalArithmetic
using IntervalArithmetic: InconclusiveBooleanOperation, _unsafe_interval

@testset "numtype" begin
    @test numtype(interval(1, 2)) == Float64
    @test numtype(interval(Float32, 1, 2)) == Float32
    @test numtype(BareInterval{Float32}) == Float32
    @test numtype(Interval{Float32}) == Float32
    @test numtype(Complex{Interval{Float32}}) == Float32
    @test numtype(Complex{Float32}) == Float32
    @test numtype(bareinterval(1, 2)) == Float64
    @test numtype(Int) == Int
    @test numtype(1.0f0) == Float32
    @test numtype(π) == Irrational{:π}
end

@testset "float and big" begin
    @test float(bareinterval(1//2, 3//4)) === bareinterval(Float64, 1//2, 3//4)
    @test bounds(float(bareinterval(1//3, 1//2))) == (0.3333333333333333, 0.5)
    @test typeof(float(bareinterval(1//3, 1//2))) == BareInterval{Float64}

    x = float(interval(1//2, 3//4, def))
    @test typeof(x) == Interval{Float64}
    @test decoration(x) == def
    @test !isguaranteed(float(convert(Interval{Float64}, 1)))
    @test isguaranteed(float(interval(1)))

    @test typeof(big(bareinterval(1, 2))) == BareInterval{BigFloat}
    y = big(bareinterval(1//3, 1//2))
    @test typeof(y) == BareInterval{Rational{BigInt}}
    @test bounds(y) == (1//3, 1//2)
    @test decoration(big(interval(1, 2, def))) == def

    @test isnai(@test_logs (:warn, r"interval part of NaI") float(nai(Interval{Float64})))
    @test isnai(@test_logs (:warn,) big(nai(Interval{Float64})))
end

@testset "zero, one, floatmin, floatmax" begin
    a = interval(0.1, 1.1)
    b = interval(0.9, 2.0)

    @test isa(zero(b), Interval)
    @test isthin(zero(b), 0.0)
    @test isequal_interval(zero(b), zero(typeof(b)))
    @test isthin(one(a), 1.0)
    @test isequal_interval(one(a), one(typeof(a)))
    @test isthin(one(a), big(1.0))
    @test !isequal_interval(a, b)

    @test bounds(zero(BareInterval{Float64})) == (0.0, 0.0)
    @test bounds(one(BareInterval{Float64})) == (1.0, 1.0)
    @test bounds(floatmin(BareInterval{Float64})) == (floatmin(Float64), floatmin(Float64))
    @test bounds(floatmax(BareInterval{Float64})) == (floatmax(Float64), floatmax(Float64))
    @test zero(bareinterval(1, 2)) === zero(BareInterval{Float64})
    @test one(bareinterval(1, 2)) === one(BareInterval{Float64})
    @test floatmin(bareinterval(1, 2)) === floatmin(BareInterval{Float64})
    @test floatmax(bareinterval(1, 2)) === floatmax(BareInterval{Float64})

    @test (decoration(zero(Interval{Float64})) == com) & isguaranteed(zero(Interval{Float64}))
    @test (decoration(one(Interval{Float64})) == com) & isguaranteed(one(Interval{Float64}))
    @test !isguaranteed(zero(convert(Interval{Float64}, 1)))
    @test !isguaranteed(one(convert(Interval{Float64}, 1)))

    @test isequal_interval(floatmin(typeof(a)), interval(floatmin(Float64)))
    @test isequal_interval(floatmax(typeof(a)), interval(floatmax(Float64)))
    @test isequal_interval(floatmin(a), floatmin(typeof(a)))
    @test isequal_interval(floatmax(a), floatmax(typeof(a)))

    @test isthinzero(zero(Interval{Float64}))
    @test isthinzero(zero(Complex{Interval{Float64}}))
    @test isthinone(one(Interval{Float64}))
    @test isthinone(one(Complex{Interval{Float64}}))
    @test isequal_interval(zero(Complex{Interval{Float64}}), complex(zero(Interval{Float64}), zero(Interval{Float64})))
    @test isequal_interval(one(Complex{Interval{Float64}}), complex(one(Interval{Float64}), zero(Interval{Float64})))
    @test isequal_interval(zero(complex(interval(1), interval(2))), zero(Complex{Interval{Float64}}))
    @test isequal_interval(one(complex(interval(1), interval(2))), one(Complex{Interval{Float64}}))

    @test bounds(zero(BareInterval{Rational{Int64}})) == (0//1, 0//1)
    @test bounds(one(Interval{Rational{Int64}})) == (1//1, 1//1)
    @test_throws MethodError floatmin(BareInterval{Rational{Int64}})
    @test_throws MethodError floatmax(BareInterval{Rational{Int64}})

    @test isequal_interval(zero(Interval{Float64}), interval(0))
    @test isequal_interval(zero(interval(0, 1)), interval(0))
end

@testset "typemin and typemax" begin
    a = interval(0.1, 1.1)

    @test bounds(typemin(BareInterval{Float64})) == (-Inf, -floatmax(Float64))
    @test bounds(typemax(BareInterval{Float64})) == (floatmax(Float64), Inf)
    @test isequal_interval(typemin(typeof(a)), interval(-Inf, nextfloat(-Inf)))
    @test isequal_interval(typemax(typeof(a)), interval(prevfloat(Inf), Inf))
    @test isequal_interval(typemin(a), typemin(typeof(a)))
    @test isequal_interval(typemax(a), typemax(typeof(a)))
    @test (decoration(typemin(Interval{Float64})) == dac) & isguaranteed(typemin(Interval{Float64}))
    @test (decoration(typemax(Interval{Float64})) == dac) & isguaranteed(typemax(Interval{Float64}))
    @test bounds(typemin(Interval{Float32})) == (-Inf32, -floatmax(Float32))
    @test_throws MethodError typemin(BareInterval{Rational{Int64}})
    @test_throws MethodError typemax(BareInterval{Rational{Int64}})
end

@testset "eps" begin
    a = interval(0.1, 1.1)

    @test bounds(eps(BareInterval{Float64})) == (eps(Float64), eps(Float64))
    @test decoration(eps(Interval{Float64})) == com
    @test isequal_interval(eps(typeof(a)), eps(one(typeof(a))))

    @test bounds(eps(bareinterval(1.0))) == (2.220446049250313e-16, 2.220446049250313e-16)
    @test bounds(eps(bareinterval(1.0, 2.0))) == (2.220446049250313e-16, 4.440892098500626e-16)
    @test bounds(eps(bareinterval(-1.0, 1.0))) == (5.0e-324, 2.220446049250313e-16)
    @test bounds(eps(bareinterval(-Inf, Inf))) == (5.0e-324, Inf)
    @test bounds(eps(interval(0.0))) == (5.0e-324, 5.0e-324)
    @test isequal_interval(eps(emptyinterval(BareInterval{Float64})), emptyinterval(BareInterval{Float64}))
    @test isequal_interval(eps(bareinterval(-3.0, 1.0)), bareinterval(eps(0.0), eps(3.0)))

    @test isequal_interval(eps(interval(1e-12, 1.0)), interval(eps(1e-12), eps(1.0)))
    @test decoration(eps(interval(1e-12, 1.0))) == def
    @test isequal_interval(eps(interval(1.0, 1.5)), interval(eps(1.0)))
    @test decoration(eps(interval(1.0, 1.5))) == com
    @test isequal_interval(eps(interval(-3.0, 1.0)), interval(eps(0.0), eps(3.0)))
    @test isequal_interval(eps(interval(-1.0, 2.0)), interval(eps(0.0), eps(2.0)))
    @test isequal_interval(eps(interval(1.0, Inf)), interval(eps(1.0), Inf))
    @test decoration(eps(interval(1.0, Inf))) == def
    @test decoration(eps(interval(-Inf, Inf))) == def
    @test decoration(eps(interval(1.0, 1.0, def))) == def
    @test isequal_interval(eps(emptyinterval()), emptyinterval())
    @test decoration(eps(emptyinterval())) == trv
    @test isnai(@test_logs eps(nai()))
    @test !isguaranteed(eps(convert(Interval{Float64}, 1)))

    @test_throws MethodError eps(BareInterval{Rational{Int64}})
    @test_throws MethodError eps(interval(1//2))
end

@testset "hash" begin
    @test hash(bareinterval(1, 2)) == hash(bareinterval(1, 2))
    @test hash(interval(1, 2)) == hash(interval(1, 2))
    @test hash(interval(1, 2)) == hash(interval(1, 2, def))
    @test hash(interval(1, 2)) == hash(convert(Interval{Float64}, interval(1, 2)))
    @test hash(bareinterval(-0.0)) == hash(bareinterval(0.0))

    x = interval(Float64, 1, 2)
    y = interval(BigFloat, 1, 2)
    @test isequal_interval(x, y)
    @test hash(x) == hash(y)

    x = I"0.1"
    y = interval(BigFloat, x)
    @test isequal_interval(x, y)
    @test hash(x) == hash(y)

    x = interval(1, 2)
    y = interval(1, 3)
    @test !isequal_interval(x, y)
    @test hash(x) != hash(y)

    @test Dict(interval(1, 2) => 1)[interval(1, 2)] == 1
end

@testset "== and <" begin
    x, y = interval(1), interval(2)

    @test x == x
    @test x == 1
    @test x != y
    @test interval(1, 2) != interval(3, 4)
    @test_throws InconclusiveBooleanOperation interval(1, 2) != 2
    @test_throws InconclusiveBooleanOperation interval(1, 2) != y
    @test_throws InconclusiveBooleanOperation y != interval(1, 2)
    @test_throws InconclusiveBooleanOperation interval(1, 2) == interval(1, 2)
    @test isequal(x, interval(1))

    @test isone(x)
    @test !iszero(x)
    @test_throws InconclusiveBooleanOperation iszero(interval(0, 1))

    @test x < y
    @test x < 2
    @test !(x > y)
    @test !(x < x)
    @test !(x < 1)
    @test interval(1, 2) < interval(3, 4)
    @test !(interval(3, 4) < interval(1, 2))
    @test_throws InconclusiveBooleanOperation x < interval(1, 2)
    @test_throws InconclusiveBooleanOperation interval(1, 3) < interval(2, 4)
    @test x ≤ x
    @test x ≥ x
    @test_throws InconclusiveBooleanOperation interval(1, 3) ≤ interval(2, 4)

    @test_throws InconclusiveBooleanOperation nai(Interval{Float64}) == nai(Interval{Float64})
    @test_throws InconclusiveBooleanOperation nai(Interval{Float64}) < interval(1)
    @test emptyinterval(Interval{Float64}) == emptyinterval(Interval{Float64})
    @test isequal(emptyinterval(Interval{Float64}), emptyinterval(Interval{Float64}))
    @test emptyinterval(Interval{Float64}) != interval(1, 2)
    @test_throws InconclusiveBooleanOperation emptyinterval(Interval{Float64}) == nai(Interval{Float64})
    @test emptyinterval(Interval{Float64}) < interval(1)

    @test isequal_interval(maximum([interval(1, 2), interval(3, 4)]), interval(3, 4))
    @test all(isequal_interval.(sort([interval(3, 4), interval(1, 2)]), [interval(1, 2), interval(3, 4)]))

    @test bareinterval(1) == bareinterval(1)
    @test bareinterval(1) != bareinterval(2)
    @test bareinterval(BigFloat, 1) == bareinterval(BigFloat, 1)
    @test isequal(bareinterval(BigFloat, 1), bareinterval(BigFloat, 1))
    @test bareinterval(1, 2) != bareinterval(3, 4)
    @test_throws InconclusiveBooleanOperation bareinterval(1, 2) == bareinterval(1, 2)
    @test emptyinterval(BareInterval{Float64}) == emptyinterval(BareInterval{Float64})

    @test complex(interval(1), interval(2)) == complex(interval(1), interval(2))
    @test complex(interval(1), interval(0)) == interval(1)
    @test complex(interval(1, 2), interval(1, 2)) != complex(interval(3, 4), interval(1, 2))
    @test complex(interval(1, 2), interval(0, 1)) != interval(5, 6)
    @test interval(5, 6) != complex(interval(1, 2), interval(0, 1))
    @test_throws InconclusiveBooleanOperation complex(interval(1, 2), interval(1, 2)) == complex(interval(1, 2), interval(1, 2))

    # `==` agrees with `isequal_interval`, except that it errors for overlapping
    # intervals which are not both thin (the empty interval is disjoint from everything)
    zs = (emptyinterval(), interval(1), interval(1, 2), interval(3, 4))
    @testset "agreement with isequal_interval" for xs ∈ (
            (emptyinterval(BareInterval{Float64}), bareinterval(1), bareinterval(2), bareinterval(1, 2), bareinterval(2, 3), bareinterval(3, 4), entireinterval(BareInterval{Float64}), bareinterval(BigFloat, 1), bareinterval(BigFloat, 1, 2)),
            (emptyinterval(), interval(1), interval(2), interval(1, 2), interval(2, 3), interval(3, 4), entireinterval(), interval(BigFloat, 1), interval(BigFloat, 1, 2)),
            (zs..., (complex(a, b) for a ∈ zs for b ∈ zs)...),
        )
        for x ∈ xs, y ∈ xs
            if isdisjoint_interval(x, y) | (isthin(x) & isthin(y))
                @test (x == y) === isequal_interval(x, y)
                @test (x != y) === !isequal_interval(x, y)
            else
                @test_throws InconclusiveBooleanOperation x == y
            end
        end
    end
end

@testset "isfinite, isnan, isinteger, issubnormal" begin
    x = interval(1)

    @test isfinite(x)
    @test isfinite(interval(1, 2))
    @test !isinf(interval(1, 2))
    @test isfinite(emptyinterval(Interval{Float64}))
    @test_throws InconclusiveBooleanOperation isfinite(interval(1, Inf))
    @test_throws InconclusiveBooleanOperation isfinite(nai(Interval{Float64}))

    @test isnan(nai(Interval{Float64}))
    @test !isnan(interval(1))

    @test isinteger(x)
    @test !isinteger(interval(1.5))
    @test !isinteger(interval(1.2, 1.8))
    @test !isinteger(interval(1.2, 1.9))
    @test !isinteger(emptyinterval(Interval{Float64}))
    @test_throws InconclusiveBooleanOperation isinteger(interval(1, 2))
    @test_throws InconclusiveBooleanOperation isinteger(interval(1.5, 2.5))

    @test issubnormal(interval(1e-320))
    @test issubnormal(interval(-1e-320, -1e-321))
    @test issubnormal(interval(floatmin(Float64)/4, floatmin(Float64)/2))
    @test issubnormal(interval(-floatmin(Float64)/2, -floatmin(Float64)/4))
    @test !issubnormal(interval(1.0))
    @test !issubnormal(interval(1, 2))
    @test !issubnormal(interval(0.0))
    @test !issubnormal(emptyinterval(Interval{Float64}))
    @test_throws InconclusiveBooleanOperation issubnormal(interval(0.0, 1.0))
    @test_throws InconclusiveBooleanOperation issubnormal(interval(-floatmin(Float64), floatmin(Float64)))
end

@testset "InconclusiveBooleanOperation display" begin
    @test InconclusiveBooleanOperation <: Exception

    e = try
        interval(1, 3) == interval(2, 4)
    catch err
        err
    end
    @test e isa InconclusiveBooleanOperation
    msg = sprint(showerror, e)
    @test startswith(msg, "InconclusiveBooleanOperation:")
    @test occursin("==", msg) & occursin("isequal_interval", msg)

    e = try
        interval(1, 3) < interval(2, 4)
    catch err
        err
    end
    @test occursin("strictprecedes", sprint(showerror, e))

    e = try
        isfinite(interval(1, Inf))
    catch err
        err
    end
    @test occursin("isbounded", sprint(showerror, e))

    e = try
        isinteger(interval(1, 2))
    catch err
        err
    end
    @test occursin("isthininteger", sprint(showerror, e))

    e = try
        issubnormal(interval(0.0, 1.0))
    catch err
        err
    end
    @test occursin("issubset_interval", sprint(showerror, e))
end

@testset "disallowed Base set functions" begin
    x = interval(1)

    @test_throws ArgumentError x ∈ x
    @test_throws ArgumentError isempty(x)
    @test_throws ArgumentError isapprox(x, x)
    @test_throws ArgumentError isdisjoint(x, x)
    @test_throws ArgumentError issubset(x, x)
    @test_throws ArgumentError issetequal(x, x)

    @test_throws ArgumentError intersect(x)
    @test_throws ArgumentError intersect(x, x)
    @test_throws ArgumentError intersect(x, 2, [1], 4.0, 5)
    @test_throws ArgumentError intersect(x, interval(2.0), interval(3.0))

    @test_throws ArgumentError union(x)
    @test_throws ArgumentError union(x, x)
    @test_throws ArgumentError union(x, 2, [1], 4.0, 5)
    @test_throws ArgumentError union(x, interval(2.0), interval(3.0))
    @test_throws ArgumentError symdiff(x, interval(2.0))
    @test_throws ArgumentError symdiff(x, interval(2.0), interval(3.0))
    @test_throws ArgumentError union!(BitSet(), x)
    @test_throws ArgumentError union!(Int[], x)

    @test_throws ArgumentError setdiff(x)
    @test_throws ArgumentError setdiff(x, x)
    @test_throws ArgumentError setdiff(x, 2, [1], 4.0, 5)
    @test_throws ArgumentError setdiff(x, interval(2.0), interval(3.0))
    @test_throws ArgumentError setdiff!(Set(), x)
end

@testset "Broadcasting" begin
    x = interval(1, 2)

    for f ∈ (+, -, *, /)
        @test isequal_interval(f.(x, x), f(x, x))
    end
end

@testset "Real behaviour" begin
    @test size(interval(1)) == ()
    @test isequal_interval(real(interval(-1, 1)), interval(-1, 1))
end
