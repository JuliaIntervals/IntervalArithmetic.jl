@testset "IntervalArithmeticArblibExt" begin
    Arf = Arblib.Arf
    ArfRef = Arblib.ArfRef
    Arb = Arblib.Arb
    ArbRef = Arblib.ArbRef
    Acb = Arblib.Acb
    setball = Arblib.setball

    # There is a bug in Flint before version 3.3.0 that gives NaN for
    # getinterval on balls with infinite midpoint and radius. Check if
    # we are using such a version to mark tests as broken.
    broken_getinterval = isnan(Arblib.getinterval(setball(Arb, -Inf, Inf))[2])

    @testset "Promotion rules" begin
        # Arf behaves like normal promotion with Interval
        @test promote_type(Arf, Interval{Float64}) == Interval{Arf}
        @test promote_type(Arf, Interval{BigFloat}) == Interval{Arf}
        @test promote_type(Arf, Interval{Rational{Int}}) == Interval{Arf}
        @test promote_type(ArfRef, Interval{Float64}) == Interval{Arf}
        @test promote_type(ArfRef, Interval{BigFloat}) == Interval{Arf}
        @test promote_type(ArfRef, Interval{Rational{Int}}) == Interval{Arf}
        @test promote_type(Interval{Float64}, Arf) == Interval{Arf}
        @test promote_type(Interval{BigFloat}, Arf) == Interval{Arf}
        @test promote_type(Interval{Rational{Int}}, Arf) == Interval{Arf}
        @test promote_type(Interval{Float64}, ArfRef) == Interval{Arf}
        @test promote_type(Interval{BigFloat}, ArfRef) == Interval{Arf}
        @test promote_type(Interval{Rational{Int}}, ArfRef) == Interval{Arf}



        # Promotion between Arb and Interval is not allowed
        @test_throws ArgumentError promote_type(Arb, Interval{Float64})
        @test_throws ArgumentError promote_type(Arb, Interval{BigFloat})
        @test_throws ArgumentError promote_type(Arb, Interval{Arf})
        @test_throws ArgumentError promote_type(Arb, Interval{Arb})
        @test_throws ArgumentError promote_type(ArbRef, Interval{Float64})
        @test_throws ArgumentError promote_type(ArbRef, Interval{BigFloat})
        @test_throws ArgumentError promote_type(ArbRef, Interval{Arf})
        @test_throws ArgumentError promote_type(ArbRef, Interval{Arb})
        @test_throws ArgumentError promote_type(Interval{Float64}, Arb)
        @test_throws ArgumentError promote_type(Interval{BigFloat}, Arb)
        @test_throws ArgumentError promote_type(Interval{Arf}, Arb)
        @test_throws ArgumentError promote_type(Interval{Arb}, Arb)
        @test_throws ArgumentError promote_type(Interval{Float64}, ArbRef)
        @test_throws ArgumentError promote_type(Interval{BigFloat}, ArbRef)
        @test_throws ArgumentError promote_type(Interval{Arf}, ArbRef)
        @test_throws ArgumentError promote_type(Interval{Arb}, ArbRef)
    end

    @testset "Interval from Arb" begin
        @testset "promote_numtype" begin
            @test IntervalArithmetic.promote_numtype(Arb, Arb) == BigFloat
            @test IntervalArithmetic.promote_numtype(Arb, ArbRef) == BigFloat
            @test IntervalArithmetic.promote_numtype(ArbRef, Arb) == BigFloat
            @test IntervalArithmetic.promote_numtype(ArbRef, ArbRef) == BigFloat

            @test IntervalArithmetic.promote_numtype(Arb, Float64) == BigFloat
            @test IntervalArithmetic.promote_numtype(ArbRef, Float64) == BigFloat
            @test IntervalArithmetic.promote_numtype(Arb, Rational{Int}) == BigFloat
            @test IntervalArithmetic.promote_numtype(ArbRef, Rational{Int}) == BigFloat

            @test IntervalArithmetic.promote_numtype(Arb, Arf) == Arf
            @test IntervalArithmetic.promote_numtype(ArbRef, Arf) == Arf
            @test IntervalArithmetic.promote_numtype(Arb, ArfRef) == Arf
            @test IntervalArithmetic.promote_numtype(ArbRef, ArfRef) == Arf
        end

        @testset "Single argument constructor" begin
            # Valid intervals
            xs = Arb[
                0,
                1,
                π,
                ℯ,
                1//3,
                Arb((1, 2)),
                Arb((-Inf, Inf)),
                setball(Arb, 5, Inf),
                #setball(Arb, -Inf, Inf),
                #setball(Arb, Inf, Inf),
            ]

            for x in xs
                @test interval(x) isa Interval{BigFloat}

                for T in [BigFloat, Arf, Float64, Float32]
                    y = interval(T, x)
                    @test y isa Interval{T}
                    @test !isnai(y)
                    @test isbounded(y) == isfinite(x)
                    @test Arblib.contains(Arb(y), x)
                end
            end

            # These are bugs in Flint
            # @test isequal_interval(interval(setball(Arb, -Inf, Inf)), interval(-Inf, Inf)) broken =
            #     broken_getinterval
            # @test isequal_interval(interval(setball(Arb, Inf, Inf)), interval(-Inf, Inf)) broken =
            #     broken_getinterval

            # Invalid intervals
            @test isnai(interval(Arb(-Inf)))
            @test isnai(interval(Arb(Inf)))
            @test isnai(interval(Arb(NaN)))
        end

        @testset "Two argument constructor" begin
            # Valid infs and sups
            # All <=3
            as1 = Real[0, 1, ℯ, 1//3, 0.1, BigFloat(1.1), BigInt(3)]
            # All >=3
            bs1 = Real[3, π, 7//2, BigFloat(4.1), BigInt(4)]

            for a in as1
                for b in bs1
                    a_Arb = Arb(a)
                    b_Arb = Arb(b)

                    y1 = interval(a, b_Arb)
                    y2 = interval(a_Arb, b)
                    y3 = interval(a_Arb, b_Arb)

                    @test y1 isa Interval{BigFloat}
                    @test y2 isa Interval{BigFloat}
                    @test y3 isa Interval{BigFloat}

                    @test Arblib.overlaps(Arb(y1), a_Arb)
                    @test Arblib.overlaps(Arb(y1), b_Arb)
                    @test Arblib.overlaps(Arb(y2), a_Arb)
                    @test Arblib.overlaps(Arb(y2), b_Arb)
                    @test Arblib.overlaps(Arb(y3), a_Arb)
                    @test Arblib.overlaps(Arb(y3), b_Arb)

                    # TODO: Doesn't work for Arf because it doesn't support nextfloat
                    for T in [BigFloat, Float64, Float32]
                        y1 = interval(T, a, b_Arb)
                        y2 = interval(T, a_Arb, b)
                        y3 = interval(T, a_Arb, b_Arb)

                        @test y1 isa Interval{T}
                        @test y2 isa Interval{T}
                        @test y3 isa Interval{T}

                        @test Arblib.overlaps(Arb(y1), a_Arb)
                        @test Arblib.overlaps(Arb(y1), b_Arb)
                        @test Arblib.overlaps(Arb(y2), a_Arb)
                        @test Arblib.overlaps(Arb(y2), b_Arb)
                        @test Arblib.overlaps(Arb(y3), a_Arb)
                        @test Arblib.overlaps(Arb(y3), b_Arb)
                    end
                end
            end

            # Overlapping intervals
            @test isequal_interval(
                interval(interval(1, 3), interval(2, 4)),
                interval(setball(Arb, 2, 1), setball(Arb, 3, 1)),
            )
            @test isequal_interval(
                interval(interval(1, 3), interval(0, 4)),
                interval(setball(Arb, 2, 1), setball(Arb, 2, 2)),
            )
            @test isequal_interval(
                interval(interval(1, 5), interval(2, 4)),
                interval(setball(Arb, 3, 2), setball(Arb, 3, 1)),
            )

            # Infinite, but valid, intervals
            as2 = [
                Arb(-Inf),
                # setball(Arb, -Inf, 1),
                Arb((-Inf, Inf)),
                # setball(Arb, -Inf, Inf),
                setball(Arb, 0, Inf),
                # setball(Arb, Inf, Inf),
            ]

            bs2 = [
                Arb(Inf),
                # setball(Arb, Inf, 1),
                Arb((-Inf, Inf)),
                # setball(Arb, -Inf, Inf),
                setball(Arb, 0, Inf),
                # setball(Arb, Inf, Inf),
            ]

            for a in as2
                for b in bs2
                    # This is a bug in Flint
                    broken =
                        broken_getinterval && (
                            isequal(a, setball(Arb, Inf, Inf)) ||
                            isequal(b, setball(Arb, -Inf, Inf))
                        )
                    @test isequal_interval(interval(a, b), interval(-Inf, Inf)) broken =
                        broken
                end
            end

            for a in as2
                # This is a bug in Flint
                broken = broken_getinterval && isequal(a, setball(Arb, Inf, Inf))
                @test isequal_interval(interval(a, Inf), interval(-Inf, Inf)) broken =
                    broken
            end

            for b in bs2
                # This is a bug in Flint
                broken = broken_getinterval && isequal(b, setball(Arb, -Inf, Inf))
                @test isequal_interval(interval(-Inf, b), interval(-Inf, Inf)) broken =
                    broken
            end

            # Invalid intervals

            # [-Inf, -Inf] or [Inf, Inf]
            @test isnai(interval(Arb(-Inf), Arb(-Inf)))
            @test isnai(interval(-Inf, Arb(-Inf)))
            @test isnai(interval(Arb(-Inf), -Inf))
            @test isnai(interval(setball(Arb, -Inf, 1), Arb(-Inf)))
            @test isnai(interval(Arb(-Inf), setball(Arb, -Inf, 1)))
            @test isnai(interval(Arb(Inf), Arb(Inf)))
            @test isnai(interval(Inf, Arb(Inf)))
            @test isnai(interval(Arb(Inf), Inf))
            @test isnai(interval(setball(Arb, Inf, 1), Arb(Inf)))
            @test isnai(interval(Arb(Inf), setball(Arb, Inf, 1)))

            # With NaN
            @test isnai(interval(Arb(NaN), 0))
            @test isnai(interval(setball(Arb, NaN, Inf), 0))
            @test isnai(interval(Arb(NaN), -Inf))
            @test isnai(interval(Arb(NaN), Inf))
            @test isnai(interval(0, Arb(NaN)))
            @test isnai(interval(0, setball(Arb, NaN, Inf)))
            @test isnai(interval(-Inf, Arb(NaN)))
            @test isnai(interval(Inf, Arb(NaN)))

            # A few tests to check that :midpoint constructor seems ok
            @test isequal_interval(
                interval(setball(Arb, 0, 1), format = :midpoint),
                interval(-1, 1),
            )
            @test isequal_interval(
                interval(setball(Arb, 0, 1), setball(Arb, 4, 1), format = :midpoint),
                interval(-6, 6),
            )
            @test_throws DomainError interval(0, Arb((-1, 1)), format = :midpoint)
        end

        @testset "Complex intervals" begin
            @test isequal_interval(
                interval(1 + 2im, 3 + 4im),
                interval(Acb(setball(Arb, 2, 1), setball(Arb, 3, 1))),
            )
            @test isequal_interval(
                interval(Float64, 1 + 2im, 3 + 4im),
                interval(Acb(setball(Arb, 2, 1), setball(Arb, 3, 1))),
            )

            @test isequal_interval(
                interval(1 + 2im, 3 + 4im),
                interval(Acb(1, 2), Acb(3, 4)),
            )

            @test isequal_interval(interval(1 + 2im, 3 + 4im), interval(Acb(1, 2), 3 + 4im))
            @test isequal_interval(interval(1 - 2im, 3), interval(Acb(1, -2), 3))
            @test isequal_interval(
                interval(1 - 2im, 3),
                interval(Acb(1, -2), interval(3, 3)),
            )

            @test isequal_interval(interval(1 + 2im, 3 + 4im), interval(1 + 2im, Acb(3, 4)))
            @test isequal_interval(interval(1, 3 + 2im), interval(1, Acb(3, 2)))
            @test isequal_interval(interval(1, 3 + 2im), interval(interval(1), Acb(3, 2)))
        end

        @testset "convert" begin
            @test isguaranteed(convert(Interval{Float64}, Arb(1)))
            @test isguaranteed(convert(Interval{Float64}, Acb(1)))
            @test_throws DomainError convert(Interval{Float64}, Acb(1, 1))

            @test isguaranteed(convert(Complex{Interval{Float64}}, Arb(1)))
            @test isguaranteed(convert(Complex{Interval{Float64}}, Acb(1)))
            @test isguaranteed(convert(Complex{Interval{Float64}}, Acb(1, 1)))
        end
    end

    @testset "Arb from Interval" begin
        # Check constructor
        @test isequal(Arb((0, 1)), Arb(interval(0, 1)))
        @test isequal(setball(Arb, NaN, Inf), Arb(nai(Float64)))
        @test Arblib.overlaps(Arb(π), Arb(interval(π)))
        @test Arblib.overlaps(Arb(π), Arb(interval(BigFloat, π)))
        @test isequal(Arblib.indeterminate!(Arb()), Arb(emptyinterval()))
        @test isequal(Acb(1, 2), Acb(interval(1 + 2im)))

        # Check Arblib.set!
        @test isequal(Arb((0, 1)), Arblib.set!(Arb(), interval(0, 1)))
        @test isequal(setball(Arb, NaN, Inf), Arblib.set!(Arb(), nai(Float64)))
        @test isequal(Arb(interval(π)), Arblib.set!(Arb(), interval(π)))
        @test isequal(Arb(interval(BigFloat, π)), Arblib.set!(Arb(), interval(BigFloat, π)))
        @test isequal(Arblib.indeterminate!(Arb()), Arblib.set!(Arb(), emptyinterval()))
        @test isequal(Acb(1, 2), Arblib.set!(Acb(), interval(1 + 2im)))
        # Check that prec argument works
        @test Arblib.contains_interior(
            Arblib.set!(Arb(), interval(BigFloat, π), prec = 64),
            Arb(interval(BigFloat, π)),
        )

        # Check _precision
        # One argument
        @test Arblib._precision(interval(1, 2)) == precision(Arb)
        @test Arblib._precision(interval(BigFloat, BigFloat(1, precision = 80))) == 80
        @test Arblib._precision(
            interval(BigFloat, BigFloat(1, precision = 80), BigFloat(1, precision = 64)),
        ) == 80
        @test Arblib._precision(
            interval(BigFloat, BigFloat(1, precision = 64), BigFloat(1, precision = 80)),
        ) == 80

        # Check that precision is preserved
        @test precision(
            Arb(interval(BigFloat(1, precision = 80), BigFloat(2, precision = 64))),
        ) == 80
        @test precision(Arb(interval(Arf(0, prec = 64), Arf(1, prec = 80)))) == 80
    end

    # Check that the ambiguity related changes actually work
    @testset "ExactReal" begin
        @test Arblib.Mag(exact(5)) == Arblib.Mag(5)
        @test Arf(exact(5)) == Arf(5)
        @test Arb(exact(5)) == Arb(5)

        @test promote_type(Arf, ExactReal{Float64}) == Arf
        @test promote_type(ArfRef, ExactReal{Float64}) == Arf
        @test promote_type(ExactReal{Float64}, Arf) == Arf
        @test promote_type(ExactReal{Float64}, ArfRef) == Arf

        @test promote_type(Arb, ExactReal{Float64}) == Arb
        @test promote_type(ArbRef, ExactReal{Float64}) == Arb
        @test promote_type(ExactReal{Float64}, Arb) == Arb
        @test promote_type(ExactReal{Float64}, ArbRef) == Arb
    end
end
