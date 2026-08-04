using IntervalArithmetic: interval_diff

# the arguments must be locals of a function for `@allocated` to be meaningful,
# and the call must be compiled before it is measured
function alloc_hull8(x)
    hull(x, x, x, x, x, x, x, x)
    return @allocated hull(x, x, x, x, x, x, x, x)
end

function alloc_intersect8(x)
    intersect_interval(x, x, x, x, x, x, x, x)
    return @allocated intersect_interval(x, x, x, x, x, x, x, x)
end

@testset "hull and intersect_interval" begin
    # the empty interval is neutral for `hull` and absorbing for
    # `intersect_interval`, in either position and for both interval types
    for T ∈ (Float64, Float32, BigFloat, Rational{Int})
        x = bareinterval(T, 1, 2)
        e = emptyinterval(BareInterval{T})

        @test isequal_interval(hull(e, e), e)
        @test isequal_interval(hull(x, e), x)
        @test isequal_interval(hull(e, x), x)
        @test isequal_interval(hull(x, bareinterval(T, 5, 6)), bareinterval(T, 1, 6))

        @test isempty_interval(intersect_interval(e, e))
        @test isempty_interval(intersect_interval(x, e))
        @test isempty_interval(intersect_interval(e, x))
        @test isempty_interval(intersect_interval(x, bareinterval(T, 5, 6)))
        @test isequal_interval(intersect_interval(x, bareinterval(T, 0, 3)), x)

        y = interval(T, 1, 2)
        f = emptyinterval(Interval{T})

        @test isempty_interval(hull(f, f))
        @test isequal_interval(hull(y, f), y)
        @test isequal_interval(hull(f, y), y)
        @test isempty_interval(intersect_interval(y, f))
        @test isempty_interval(intersect_interval(f, y))
    end

    # an NaI operand poisons the result, in either position and at any arity
    n = nai(Float64)
    x = interval(1, 2)

    @test isnai(hull(n, x)) & isnai(hull(x, n)) & isnai(hull(n, n))
    @test isnai(intersect_interval(n, x)) & isnai(intersect_interval(x, n))
    @test isnai(hull(x, x, n)) & isnai(hull(x, n, x)) & isnai(hull(n, x, x))
    @test isnai(hull(x, x, x, n))
    @test isnai(intersect_interval(x, x, n)) & isnai(intersect_interval(n, x, x))

    # `dec = :default` yields `trv`, `dec = :auto` the minimal input decoration
    y = interval(3, 4)
    z = interval(5, Inf)

    @test decoration(hull(x, y)) == trv
    @test decoration(hull(x, y; dec = :auto)) == com
    @test decoration(hull(x, z; dec = :auto)) == dac
    @test decoration(hull(x, y; dec = def)) == def
    @test decoration(intersect_interval(x, y)) == trv
    @test decoration(intersect_interval(x, interval(2, 3); dec = :auto)) == com
    @test_throws ArgumentError hull(x, y; dec = :nonsense)
    @test_throws ArgumentError intersect_interval(x, y; dec = :nonsense)

    # `dec = :auto` cannot promise `com` for an unbounded hull
    @test decoration(hull(interval(-Inf, 0), interval(1, 2); dec = :auto)) == dac

    # bare intervals accept the variadic forms, without a `dec` keyword
    bs = (bareinterval(1, 2), bareinterval(-3, 0), bareinterval(5, 6))

    @test isequal_interval(hull(bs...), bareinterval(-3, 6))
    @test isequal_interval(hull(bs..., bareinterval(7, 9)), bareinterval(-3, 9))
    @test isempty_interval(intersect_interval(bs...))
    @test isequal_interval(
        intersect_interval(bareinterval(0, 4), bareinterval(1, 5), bareinterval(2, 6)),
        bareinterval(2, 4))
    @test_throws MethodError hull(bs...; dec = :auto)

    # the variadic forms agree with the pairwise reduction they replace
    args = (interval(1, 2), interval(-3, 0), interval(5, 6), interval(-1, 8),
        interval(0, 1), interval(-2, 2), interval(4, 7), interval(-5, 5))
    for dec ∈ (:default, :auto, trv, def, com)
        for k ∈ 3:8
            xs = args[1:k]
            @test isequal_interval(hull(xs...; dec = dec), reduce((a, b) -> hull(a, b; dec = dec), xs))
            @test decoration(hull(xs...; dec = dec)) == decoration(reduce((a, b) -> hull(a, b; dec = dec), xs))
            @test isequal_interval(intersect_interval(xs...; dec = dec), reduce((a, b) -> intersect_interval(a, b; dec = dec), xs))
            @test decoration(intersect_interval(xs...; dec = dec)) == decoration(reduce((a, b) -> intersect_interval(a, b; dec = dec), xs))
        end
    end

    # The variadic methods must specialize on the number of arguments: without
    # that, the reductions over the arguments allocate and dispatch dynamically
    # past six arguments, which costs two orders of magnitude.
    @test alloc_hull8(interval(1, 2)) == 0
    @test alloc_intersect8(interval(1, 2)) == 0
    @test alloc_hull8(bareinterval(1, 2)) == 0
    @test alloc_intersect8(bareinterval(1, 2)) == 0

    # `isguaranteed` is the conjunction over all the arguments
    ng = convert(Interval{Float64}, 1)

    @test !isguaranteed(hull(x, ng))
    @test !isguaranteed(hull(x, y, ng))
    @test !isguaranteed(hull(x, y, x, ng))
    @test isguaranteed(hull(x, y, x))
    @test !isguaranteed(intersect_interval(x, y, ng))

    # mixed bound types promote, at any arity
    @test numtype(hull(interval(Float32, 1, 2), interval(Float64, 3, 4))) === Float64
    @test numtype(hull(interval(Float32, 1, 2), interval(Float32, 0, 1), interval(Float64, 3, 4))) === Float64
    @test numtype(intersect_interval(interval(Float32, 1, 2), interval(Float32, 0, 3), interval(Float64, 1, 4))) === Float64

    # a zero lower bound of the result still reports as `-0.0`
    @test inf(hull(interval(0, 1), interval(2, 3))) === -0.0
    @test inf(intersect_interval(interval(0, 1), interval(-1, 3))) === -0.0
end

@testset "removed interval" begin
    @test_throws ArgumentError intersect(interval(1))
    @test_throws ArgumentError intersect(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError intersect(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError union(interval(1))
    @test_throws ArgumentError union(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError union(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError setdiff(interval(1))
    @test_throws ArgumentError setdiff(interval(1), 2, [1], 4., 5)
    @test_throws ArgumentError setdiff(interval(1), interval(2.), interval(3.))
    @test_throws ArgumentError symdiff(interval(1), interval(2.), interval(3.))
end

@testset "interiordiff" begin
    x = interval(2, 4)
    y = interval(3, 5)

    @test typeof(interiordiff(x, y)) == Vector{Interval{Float64}}

    @test all(isequal_interval.(interiordiff(x, x), [interval(2), interval(4)]))
    @test all(isequal_interval.(interiordiff(x, emptyinterval(x)), [x]))

    @test all(isequal_interval.(interiordiff(x, y), [interval(2, 3)]))
    @test all(isequal_interval.(interiordiff(y, x), [interval(4, 5)]))

    y = interval(2, 5)

    @test all(isequal_interval.(interiordiff(x, y), [interval(2)]))
    @test all(isequal_interval.(interiordiff(y, x), [interval(2), interval(4, 5)]))

    x = interval(2, 5)
    y = interval(3, 4)
    @test all(isequal_interval.(interiordiff(x, y), [interval(2, 3), interval(4, 5)]))

    x = interval(1, 3)
    z = interval(0, 5)
    @test interiordiff(x, z) == Interval{Float64}[]
    @test all(isequal_interval.(interiordiff(z, x), [interval(0, 1), interval(3, 5)]))
end

@testset "interval_diff" begin
    A, B = interval_diff(interval(1, 10), interval(2, 5))
    @test isequal_interval(A, interval(1, 2))
    @test isequal_interval(B, interval(5, 10))

    @test isequal_interval(
        only(interval_diff(interval(1, 10), interval(1, 5))),
        interval(5, 10)
    )

    @test isequal_interval(
        only(interval_diff(interval(1, 10), interval(7, 12))),
        interval(1, 7)
    )

    @test interval_diff(interval(1, 10), interval(-1, 14)) == []
    @test interval_diff(interval(1, 10), interval(1, 10)) == []
end
