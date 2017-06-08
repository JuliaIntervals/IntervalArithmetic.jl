#= Instructions:

- Pkg.add("PkgBenchmark.jl")
- using PkgBenchmark

- results = benchmarkpkg("IntervalArithmetic")
- showall(results)

- results = judge("IntervalArithmetic", "v0.9.1")  # compare current version to that tag
- showall(results)
=#



using IntervalArithmetic

@benchgroup "Constructor" begin
    @bench "Interval" Interval(1, 2)
end

@benchgroup "Arithmetic" begin

    a = Interval(1, 2)
    b = Interval(3, 4)

    for op in (+, -, *, /)
        @bench string(op) $(op)($a, $b)
    end
end
