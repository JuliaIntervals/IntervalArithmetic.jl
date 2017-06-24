#= Instructions:

- Pkg.add("PkgBenchmark.jl")
- using PkgBenchmark

- results = benchmarkpkg("IntervalArithmetic")
- showall(results)

- results = judge("IntervalArithmetic", "v0.9.1")  # compare current version to that tag
- showall(results)
=#


using IntervalArithmetic

@benchgroup "Constructors" begin
    @bench "Interval" Interval(1, 2)
end

@benchgroup "@interval" begin

    @bench "@interval" @interval(0.1)
    @bench "pi" @interval(pi)
    @bench "expression" @interval(sin(0.1) + cos(0.2))
end

@benchgroup "Arithmetic" begin

    a = Interval(1, 2)
    b = Interval(3, 4)

    for op in (+, -, *, /)
        @bench string(op) $(op)($a, $b)
    end
end

@benchgroup "Elementary functions" begin
    for op in (exp, log, sin, tan)
        @bench string(op) $(op)($a)
    end
end

@benchgroup "Sum" begin

    sum1(N) = sum(Interval(i, i+1) for i in 1:N)
    sum2(N) = (one = Interval(1.0); sum(one / (i^2) for i in 1:N) )

    @bench "Sum1" sum1(1000)
    @bench "Sum2" sum2(1000)
end
