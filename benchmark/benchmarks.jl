#= Instructions:

- Pkg.add("PkgBenchmark.jl")
- using PkgBenchmark

- results = benchmarkpkg("IntervalArithmetic")
- showall(results)

- results = judge("IntervalArithmetic", "v0.9.1")  # compare current version to that tag
- showall(results)

To export the benchmark results to a markdown file, do

- export_markdown("results.md", results)
=#

using BenchmarkTools, IntervalArithmetic

const SUITE = BenchmarkGroup() # parent BenchmarkGroup to contain our suite

S = SUITE["Constructors"] = BenchmarkGroup()
S["Interval"] = @benchmarkable Interval(1, 2)

S = SUITE["Intervals"] = BenchmarkGroup()
S["@interval"] = @benchmarkable @interval(0.1)
S["pi"] = @benchmarkable @interval(pi)
S["expression"] = @benchmarkable @interval(sin(0.1) + cos(0.2))

S = SUITE["Arithmetic"] = BenchmarkGroup()
begin
    a = Interval(1, 2)
    b = Interval(3, 4)

    for op in (+, -, *, /)
        S[string(op)] = @benchmarkable $(op)($a, $b)
    end
end

S = SUITE["Elementary functions"] = BenchmarkGroup()
begin
    for op in (exp, log, sin, tan)
        S[string(op)] = @benchmarkable $(op)($a)
    end
end

S = SUITE["Sum"] = BenchmarkGroup()
begin
    sum1(N) = sum(Interval(i, i+1) for i in 1:N)
    sum2(N) = (one = Interval(1.0); sum(one / (i^2) for i in 1:N))
    S["Sum1"] = @benchmarkable sum1(1000)
    S["Sum2"] = @benchmarkable sum2(1000)
end
