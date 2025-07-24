using Test
using IntervalArithmetic
using Aqua

@testset "Aqua tests (performance)" begin
    # This tests that we don't accidentally run into
    # https://github.com/JuliaLang/julia/issues/29393
    # Aqua.test_unbound_args(IntervalArithmetic)
    ua = Aqua.detect_unbound_args_recursively(IntervalArithmetic)
    @test length(ua) == 0

    # See: https://github.com/SciML/OrdinaryDiffEq.jl/issues/1750
    # Test that we're not introducing method ambiguities across deps
    ambs = Aqua.detect_ambiguities(IntervalArithmetic; recursive = true)
    pkg_match(pkgname, pkdir::Nothing) = false
    pkg_match(pkgname, pkdir::AbstractString) = occursin(pkgname, pkdir)
    filter!(x -> pkg_match("IntervalArithmetic", pkgdir(last(x).module)), ambs)
    for method_ambiguity ∈ ambs
        @show method_ambiguity
    end
    @test length(ambs) == 0
end

@testset "Aqua tests (additional)" begin
    Aqua.test_all(IntervalArithmetic; ambiguities = VERSION ≥ v"1.11")
end
