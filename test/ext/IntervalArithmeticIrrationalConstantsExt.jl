using Test
using IntervalArithmetic
import IrrationalConstants
import InteractiveUtils

const IC_CONSTANTS = (
    IrrationalConstants.twoπ, IrrationalConstants.fourπ, IrrationalConstants.halfπ,
    IrrationalConstants.quartπ, IrrationalConstants.invπ, IrrationalConstants.inv2π,
    IrrationalConstants.inv4π, IrrationalConstants.fourinvπ, IrrationalConstants.twoinvπ,
    IrrationalConstants.sqrt2, IrrationalConstants.sqrt3, IrrationalConstants.sqrtπ,
    IrrationalConstants.sqrt2π, IrrationalConstants.sqrt4π, IrrationalConstants.sqrthalfπ,
    IrrationalConstants.invsqrt2, IrrationalConstants.invsqrtπ, IrrationalConstants.invsqrt2π,
    IrrationalConstants.logtwo, IrrationalConstants.logten, IrrationalConstants.loghalf,
    IrrationalConstants.logπ, IrrationalConstants.log2π, IrrationalConstants.log4π)

@testset "Extension loading" begin
    @test Base.get_extension(IntervalArithmetic, :IntervalArithmeticIrrationalConstantsExt) !== nothing
end

@testset "Tight enclosures" begin
    for c ∈ IC_CONSTANTS
        x = interval(c)
        @test x isa Interval{Float64}
        @test inf(x) <= BigFloat(c; precision = 256) <= sup(x)
        @test sup(x) == nextfloat(inf(x))
        @test decoration(x) === com
        @test isguaranteed(x)
        b = bareinterval(BigFloat, c)
        @test inf(x) <= inf(b) && sup(b) <= sup(x)
        # the generated bareinterval in src/IntervalArithmetic.jl cannot see the extension _round methods
        @test_throws MethodError bareinterval(Float64, c)
    end
end

@testset "Spot values" begin
    @test isequal_interval(interval(IrrationalConstants.sqrt2), interval(1.414213562373095, 1.4142135623730951))
    @test isequal_interval(interval(IrrationalConstants.logtwo), interval(0.6931471805599453, 0.6931471805599454))
    @test isequal_interval(interval(IrrationalConstants.twoπ), interval(6.283185307179586, 6.283185307179587))
    @test isequal_interval(interval(IrrationalConstants.loghalf), interval(-0.6931471805599454, -0.6931471805599453))
    @test isequal_interval(interval(Float32, IrrationalConstants.sqrt2), interval(Float32, 1.4142135f0, 1.4142137f0))
    @test isequal_interval(interval(Rational{Int}, IrrationalConstants.sqrt2), interval(54608393//38613965, 77227930//54608393))
end

@testset "All exported constants and bound types" begin
    for irr_name ∈ names(IrrationalConstants; all = false, imported = false)
        irr = getproperty(IrrationalConstants, irr_name)
        isa(irr, IrrationalConstants.IrrationalConstant) || continue

        for T ∈ (Float16, Float32, Float64, BigFloat)
            @test in_interval(irr, interval(T, irr))
            if T !== BigFloat
                @test nextfloat(inf(interval(T, irr))) == sup(interval(T, irr))
            end
        end

        for T ∈ InteractiveUtils.subtypes(Signed)
            @test in_interval(irr, interval(Rational{T}, irr)) broken = (irr == IrrationalConstants.invsqrt2π && T == Int8 && VERSION < v"1.14")
        end

        irr < 0 && continue

        for T ∈ InteractiveUtils.subtypes(Unsigned)
            @test in_interval(irr, interval(Rational{T}, irr))
        end
    end
end

@testset "BigFloat precision" begin
    x = interval(BigFloat, IrrationalConstants.sqrt2)
    @test precision(inf(x)) == precision(BigFloat)
    @test in_interval(IrrationalConstants.sqrt2, x)
    setprecision(BigFloat, 512) do
        y = interval(BigFloat, IrrationalConstants.sqrt2)
        @test precision(inf(y)) == 512
        @test in_interval(IrrationalConstants.sqrt2, y)
    end
end

@testset "_round" begin
    for c ∈ IC_CONSTANTS
        lo = IntervalArithmetic._round(Float64, c, RoundDown)
        hi = IntervalArithmetic._round(Float64, c, RoundUp)
        @test lo < hi
        @test lo < BigFloat(c; precision = 256) < hi
        for T ∈ (Float16, Float32, Float64, BigFloat, Rational{Int})
            @test IntervalArithmetic._round(T, c, RoundDown) isa T
            @test IntervalArithmetic._round(T, c, RoundUp) isa T
        end
    end
end

@testset "_intervalize" begin
    ext = Base.get_extension(IntervalArithmetic, :IntervalArithmeticIrrationalConstantsExt)
    @test ext._intervalize(2) == :(IA.bareinterval(BigFloat, 2))
    for op ∈ (:+, :-, :*, :/, :sqrt, :log, :inv)
        @test ext._intervalize(op) === op
    end
    @test ext._intervalize(:π) == :(IA.bareinterval(BigFloat, π))
    ex = ext._intervalize(:(2 * π))
    @test ex.head === :call
    @test ex.args[1] === :*
    @test ex.args[2] == :(IA.bareinterval(BigFloat, 2))
    @test ex.args[3] == :(IA.bareinterval(BigFloat, π))
    @test ext._intervalize(:(a = b)) == :(a = b)
    @test ext._intervalize("str") == "str"
    @test ext._intervalize(nothing) === nothing
end

@testset "Cross-constant consistency" begin
    @test issubset_interval(interval(IrrationalConstants.twoπ), interval(2) * interval(π))
    @test issubset_interval(interval(IrrationalConstants.halfπ), interval(π) / interval(2))
    @test issubset_interval(interval(IrrationalConstants.quartπ), interval(π) / interval(4))
    @test issubset_interval(interval(IrrationalConstants.invsqrt2), interval(1) / sqrt(interval(2)))
    @test issubset_interval(interval(IrrationalConstants.sqrt2π), sqrt(interval(2) * interval(π)))
    @test issubset_interval(interval(IrrationalConstants.loghalf), -interval(IrrationalConstants.logtwo))
    @test issubset_interval(interval(IrrationalConstants.log4π), interval(IrrationalConstants.logtwo) + interval(IrrationalConstants.log2π))
    @test issubset_interval(interval(IrrationalConstants.fourπ), interval(2) * interval(IrrationalConstants.twoπ))
    @test issubset_interval(interval(IrrationalConstants.fourinvπ), interval(2) * interval(IrrationalConstants.twoinvπ))
end

@testset "Unsupported irrationals" begin
    @test_throws ArgumentError interval(Irrational{:notaconstant}())
end
