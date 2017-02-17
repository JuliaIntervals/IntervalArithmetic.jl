if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using ValidatedNumerics, ValidatedNumerics.RootFinding
using ForwardDiff

const Dual = ForwardDiff.Dual

@testset "Promotion between Dual and Interval" begin
    @test promote(ForwardDiff.Dual(2, 1), Interval(1, 2)) ==
        (Dual(2..2, 1..1), Dual(1..2, 0..0))

    @test promote(Interval(2, 3), Dual(2, 1)) == (Dual(Interval(2, 3), Interval(0)),
            Dual(Interval(2.0), Interval(1.0)))

end
