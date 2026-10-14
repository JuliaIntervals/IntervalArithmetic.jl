using Test
using IntervalArithmetic

@testset "bisect bare intervals" begin
    x = bareinterval(0, 1)
    @test all(isequal_interval.(bisect(x), (bareinterval(0, 0.5), bareinterval(0.5, 1))))
    @test all(isequal_interval.(bisect(x), bisect(x, 0.5)))
    @test all(isequal_interval.(bisect(x, 0.25), (bareinterval(0, 0.25), bareinterval(0.25, 1))))
    @test sup(bisect(x)[1]) == inf(bisect(x)[2]) == mid(x, 0.5)

    @test_throws DomainError bisect(x, 0.0)
    @test_throws DomainError bisect(x, 1.0)
    @test_throws DomainError bisect(x, -0.1)
    @test_throws DomainError bisect(x, 1.5)
    @test_throws DomainError bisect(x, NaN)

    for z ∈ (bareinterval(1, 1), bareinterval(0.1, nextfloat(0.1)))
        @test isatomic(z)
        @test all(isequal_interval.(bisect(z), (z, emptyinterval(BareInterval{Float64}))))
    end

    e = emptyinterval(BareInterval{Float64})
    @test all(isequal_interval.(bisect(e), (e, e)))

    @test all(isequal_interval.(bisect(entireinterval(BareInterval{Float64})), (bareinterval(-Inf, 0), bareinterval(0, Inf))))
    z = bisect(entireinterval(BareInterval{Float64}), nextfloat(0.5))
    @test sup(z[1]) == inf(z[2]) > 0
    z = bisect(entireinterval(BareInterval{Float64}), prevfloat(0.5))
    @test sup(z[1]) == inf(z[2]) < 0

    z = bisect(bareinterval(-Inf, 1))
    @test sup(z[1]) == inf(z[2]) == -floatmax(Float64)
    z = bisect(bareinterval(1, Inf))
    @test sup(z[1]) == inf(z[2]) == floatmax(Float64)

    @test all(isequal_interval.(bisect(bareinterval(1//1, 2//1)), (bareinterval(1//1, 3//2), bareinterval(3//2, 2//1))))

    @test bisect(bareinterval(Float32, 0, 1)) isa Tuple{BareInterval{Float32},BareInterval{Float32}}
    @test bisect(bareinterval(BigFloat, 0, 1)) isa Tuple{BareInterval{BigFloat},BareInterval{BigFloat}}

    for w ∈ (bareinterval(0, 1), bareinterval(-2, 3), bareinterval(-Inf, 1), entireinterval(BareInterval{Float64}), bareinterval(1//1, 2//1))
        @test isequal_interval(hull(bisect(w)...), w)
    end
end

@testset "bisect decorated intervals" begin
    x = emptyinterval()
    @test all(isequal_interval.(bisect(x), (x, x)))

    x = I"0.1"
    @test isatomic(x)
    @test all(isequal_interval.(bisect(x), (x, emptyinterval())))

    x = interval(0, 1)
    @test all(isequal_interval.(bisect(x, 0.5), (interval(0, 0.5), interval(0.5, 1))))
    @test all(isequal_interval.(bisect(x, 0.25), (interval(0, 0.25), interval(0.25, 1))))
    @test all(isequal_interval.(bisect(x), (interval(0, 0.5), interval(0.5, 1))))
    @test all(d -> d == com, decoration.(bisect(x)))
    @test all(isguaranteed, bisect(x))
    @test_throws DomainError bisect(x, 2)

    x = interval(-Inf, Inf)
    @test all(isequal_interval.(bisect(x, 0.5), (interval(-Inf, 0), interval(0, Inf))))
    @test all(d -> d == dac, decoration.(bisect(x)))
    z = bisect(x, nextfloat(0.5))
    @test sup(z[1]) == inf(z[2]) > 0
    z = bisect(x, prevfloat(0.5))
    @test sup(z[1]) == inf(z[2]) < 0

    x = IntervalArithmetic.setdecoration(interval(0, 1), trv)
    @test all(d -> d == trv, decoration.(bisect(x)))
    x = IntervalArithmetic.setdecoration(interval(0, 1), def)
    @test all(d -> d == def, decoration.(bisect(x)))

    x = convert(Interval{Float64}, 1) + interval(0, 1)
    @test all(z -> !isguaranteed(z), bisect(x))

    z = @test_logs (:warn,) bisect(nai())
    @test isnai(z[1]) & isnai(z[2])
end

@testset "bisect vectors of intervals" begin
    v = [interval(0, 1), interval(0, 2)]
    w = bisect(v, 1, 0.5)
    @test all(isequal_interval.(w[1], [interval(0, 0.5), interval(0, 2)])) &
          all(isequal_interval.(w[2], [interval(0.5, 1), interval(0, 2)]))
    w = bisect(v, 2, 0.5)
    @test all(isequal_interval.(w[1], [interval(0, 1), interval(0, 1)])) &
          all(isequal_interval.(w[2], [interval(0, 1), interval(1, 2)]))
    w = bisect(v, 1, 0.25)
    @test all(isequal_interval.(w[1], [interval(0, 0.25), interval(0, 2)])) &
          all(isequal_interval.(w[2], [interval(0.25, 1), interval(0, 2)]))
    w = bisect(v, 2, 0.25)
    @test all(isequal_interval.(w[1], [interval(0, 1), interval(0, 0.5)])) &
          all(isequal_interval.(w[2], [interval(0, 1), interval(0.5, 2)]))
    w = bisect(v, 1)
    @test all(isequal_interval.(w[1], [interval(0, 0.5), interval(0, 2)])) &
          all(isequal_interval.(w[2], [interval(0.5, 1), interval(0, 2)]))
    w = bisect(v, 2)
    @test all(isequal_interval.(w[1], [interval(0, 1), interval(0, 1)])) &
          all(isequal_interval.(w[2], [interval(0, 1), interval(1, 2)]))

    @test (w[1] !== v) & (w[2] !== v)
    @test all(isequal_interval.(v, [interval(0, 1), interval(0, 2)]))

    b = [bareinterval(0, 1), bareinterval(0, 4)]
    w = bisect(b, 2, 0.25)
    @test all(isequal_interval.(w[1], [bareinterval(0, 1), bareinterval(0, 1)])) &
          all(isequal_interval.(w[2], [bareinterval(0, 1), bareinterval(1, 4)]))

    @test_throws BoundsError bisect(v, 3)

    v = [interval(-Inf, Inf), interval(-Inf, Inf)]
    w = bisect(v, 1, 0.5)
    @test all(isequal_interval.(w[1], [interval(-Inf, 0), interval(-Inf, Inf)])) &
          all(isequal_interval.(w[2], [interval(0, Inf), interval(-Inf, Inf)]))
end

@testset "mince a single interval" begin
    x = bareinterval(0, 1)
    v = mince(x, 4)
    @test v isa Vector{BareInterval{Float64}}
    @test all(isequal_interval.(v, [bareinterval(0, 0.25), bareinterval(0.25, 0.5), bareinterval(0.5, 0.75), bareinterval(0.75, 1)]))
    @test all(i -> sup(v[i]) == inf(v[i+1]), 1:3)
    @test isequal_interval(reduce(hull, v), x)
    @test isequal_interval(only(mince(x, 1)), x)
    @test_throws ArgumentError mince(x, 0)

    e = emptyinterval(BareInterval{Float64})
    @test all(isempty_interval, mince(e, 3))
    @test length(mince(e, 3)) == 3
    @test isempty(mince(e, 0))
    @test all(isempty_interval, mince(emptyinterval(), 3))
    @test all(isnai, mince(nai(Float64), 3))
    v = @test_logs mince(nai(), 2)
    @test all(isnai, v)

    ng = convert(Interval{Float64}, 1)
    mng = mince(emptyinterval(ng), 2)
    @test (length(mng) == 2) && all(z -> !isguaranteed(z), mng)
    mng = mince(nai(ng), 2)
    @test (length(mng) == 2) && all(z -> !isguaranteed(z), mng)

    @test_throws DomainError mince(bareinterval(-Inf, 1), 2)
    @test_throws "cannot split an unbounded interval" mince(entireinterval(BareInterval{Float64}), 2)
    @test_throws "cannot split an unbounded interval" mince(entireinterval(), 2)
    @test_throws "cannot split an unbounded interval" mince(interval(0, Inf), 2)
    @test_throws "cannot split an unbounded interval" mince(interval(1, Inf), 2)
    @test_throws "cannot split an unbounded interval" mince([interval(0, 1), entireinterval()], 2)

    II = interval(-1, 1)
    v = mince(II, 4)
    @test v isa Vector{Interval{Float64}}
    @test all(isequal_interval.(v, [interval(-1, -0.5), interval(-0.5, 0), interval(0, 0.5), interval(0.5, 1)]))
    @test isequal_interval(hull(v...), II)
    @test all(d -> d == com, decoration.(v))
    @test all(isguaranteed, v)
    v = mince(II, 8)
    @test length(v) == 8
    @test isequal_interval(hull(v...), II)

    @test all(z -> !isguaranteed(z), mince(ng + interval(0, 1), 2))

    for x ∈ (interval(-1, 1), interval(0, 1e300), interval(-1e300, 1e300), interval(3, 3))
        for n ∈ (1, 2, 3, 7)
            v = mince(x, n)
            @test length(v) == n
            @test isequal_interval(reduce(hull, v), x)
            @test all(z -> !isnan(inf(z)) & !isnan(sup(z)), v)
        end
    end

    @test all(isequal_interval.(mince(bareinterval(0//1, 1//1), 4), [bareinterval(0//1, 1//4), bareinterval(1//4, 1//2), bareinterval(1//2, 3//4), bareinterval(3//4, 1//1)]))
    @test mince(bareinterval(Float32, 0, 1), 3) isa Vector{BareInterval{Float32}}
    @test mince(interval(BigFloat, 0, 1), 3) isa Vector{Interval{BigFloat}}
end

@testset "mince vectors of intervals" begin
    pieces = [interval(-1, -0.5), interval(-0.5, 0), interval(0, 0.5), interval(0.5, 1)]

    x = [interval(0, 1), interval(0, 1)]
    v = mince(x, (2, 2))
    @test all(isequal_interval.(v[1], [interval(0, 0.5), interval(0, 0.5)])) &
          all(isequal_interval.(v[2], [interval(0.5, 1), interval(0, 0.5)])) &
          all(isequal_interval.(v[3], [interval(0, 0.5), interval(0.5, 1)])) &
          all(isequal_interval.(v[4], [interval(0.5, 1), interval(0.5, 1)]))
    @test all(box -> box isa Vector{Interval{Float64}}, v)

    ib2 = fill(interval(-1, 1), 2)
    vb2 = mince(ib2, 4)
    @test length(vb2) == 4^2
    vv = [[p₁, p₂] for p₂ ∈ pieces for p₁ ∈ pieces]
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, vb2, vv)
    @test all(enumerate(ib2)) do (i, xᵢ)
        isequal_interval(reduce(hull, [box[i] for box ∈ vb2]), xᵢ)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib2, (4, 4)), vb2)
    vb2bis = mince(ib2, (1, 4))
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, vb2bis, [[interval(-1, 1), p₂] for p₂ ∈ pieces])
    @test all(enumerate(ib2)) do (i, xᵢ)
        isequal_interval(reduce(hull, [box[i] for box ∈ vb2bis]), xᵢ)
    end

    ib3 = fill(interval(-1, 1), 3)
    vb3 = mince(ib3, 4)
    @test length(vb3) == 4^3
    @test all(enumerate(ib3)) do (i, xᵢ)
        isequal_interval(reduce(hull, [box[i] for box ∈ vb3]), xᵢ)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib3, (4, 4, 4)), vb3)
    vb3bis = mince(ib3, (2, 1, 1))
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, vb3bis,
        [[interval(-1, 0), interval(-1, 1), interval(-1, 1)], [interval(0, 1), interval(-1, 1), interval(-1, 1)]])
    @test all(enumerate(ib3)) do (i, xᵢ)
        isequal_interval(reduce(hull, [box[i] for box ∈ vb3bis]), xᵢ)
    end

    ib4 = fill(interval(-1, 1), 4)
    vb4 = mince(ib4, 4)
    @test length(vb4) == 4^4
    @test all(enumerate(ib4)) do (i, xᵢ)
        isequal_interval(reduce(hull, [box[i] for box ∈ vb4]), xᵢ)
    end
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib4, (4, 4, 4, 4)), vb4)
    @test mapreduce((x, y) -> all(isequal_interval.(x, y)), &, mince(ib4, (1, 1, 1, 1)), (ib4,))

    @test_throws DimensionMismatch mince(ib2, (2, 2, 2))

    v = mince([emptyinterval(), interval(0, 1)], (1, 2))
    @test length(v) == 2
    @test all(box -> isempty_interval(box[1]), v)
end

@testset "mince! monotonicity and resizing" begin
    # `LinRange` interpolation is not monotone in floating-point arithmetic
    for (x, n) ∈ ((bareinterval(1.0, nextfloat(1.0)), 13), (bareinterval(0.1, 0.3), 7),
                  (bareinterval(-1.0, nextfloat(-1.0, 3)), 11))
        v = mince(x, n)
        @test length(v) == n
        @test all(p -> inf(p) ≤ sup(p), v)
        @test inf(first(v)) == inf(x)
        @test sup(last(v)) == sup(x)
        @test all(k -> sup(v[k]) == inf(v[k+1]), 1:n-1)
        @test issubset_interval(x, reduce(hull, v))
    end
    d = mince(interval(1.0, nextfloat(1.0)), 13)
    @test all(p -> diam(p) ≥ 0, d)
    @test all(p -> decoration(p) === com, d)

    # the scalar methods resize the output, matching the vector method contract
    v = Vector{BareInterval{Float64}}(undef, 2)
    @test mince!(v, bareinterval(0, 1), 8) === v
    @test length(v) == 8
    @test all(isequal_interval.(v, mince(bareinterval(0, 1), 8)))
    w = Vector{Interval{Float64}}(undef, 5)
    @test mince!(w, interval(0, 1), 2) === w
    @test length(w) == 2
    @test all(isequal_interval.(w, [interval(0, 0.5), interval(0.5, 1)]))
end

@testset "mince!" begin
    v = Vector{BareInterval{Float64}}(undef, 3)
    @test mince!(v, bareinterval(0, 1), 3) === v
    @test all(isequal_interval.(v, mince(bareinterval(0, 1), 3)))

    w = Vector{Interval{Float64}}(undef, 2)
    @test mince!(w, interval(0, 1), 2) === w
    @test all(isequal_interval.(w, [interval(0, 0.5), interval(0.5, 1)]))

    x = [interval(0, 1), interval(0, 1)]
    u = Vector{Vector{Interval{Float64}}}(undef, 0)
    @test mince!(u, x, (2, 2)) === u
    @test length(u) == 4
    @test mapreduce((s, t) -> all(isequal_interval.(s, t)), &, u, mince(x, (2, 2)))
    @test_throws DimensionMismatch mince!(u, x, (2, 2, 2))

    u2 = Vector{Vector{Interval{Float64}}}(undef, 0)
    @test mince!(u2, x, 2) === u2
    @test mapreduce((s, t) -> all(isequal_interval.(s, t)), &, u2, u)
end
