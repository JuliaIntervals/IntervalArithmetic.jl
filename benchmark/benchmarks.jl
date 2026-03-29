using BenchmarkTools
using IntervalArithmetic

import MPFI
import Random

MPFI.BigInterval(x::ExactReal) = MPFI.BigInterval(x.value)
Base.:(^)(x::MPFI.BigInterval, y::ExactReal) = x^y.value

Random.seed!(0)

basic_arithmetic = [+, *, -, /]
basic_functions = [exp, cosh, sinh, tanh, inv, sqrt, abs, log, sin, cos, tan, acos, asin, atan]

interval_constructors = Dict(
    "bareinterval" => bareinterval,
    "interval" => interval,
    "BigFloat bareinterval" => (x, y) -> bareinterval(BigFloat, x, y),
    "BigFloat interval" => (x, y) -> interval(BigFloat, x, y),
    "BigFloat MPFI" => MPFI.BigInterval
)

suites = ["basics", "Dietmar-Ratz"]

bounds = map(range(0.01, 10 ; length = 100)) do i
    x = i * randn()
    y = i * randn()
    x > y && return (y, x)
    return (x, y)
end

SUITE = BenchmarkGroup()

for (name, T) in interval_constructors
    xx = [T(x, y) for (x, y) in bounds]
    yy = reverse(xx)

    SUITE[name] = BenchmarkGroup(split(name))
    SUITE[name]["basics"] = BenchmarkGroup(["arithmetic"])
    SUITE[name]["Dietmar-Ratz"] = BenchmarkGroup(["arithmetic"])

    for f in basic_functions
        SUITE[name]["basics"][string(f)] = @benchmarkable ($f).($xx)
    end

    for op in basic_arithmetic
        SUITE[name]["basics"][string(op)] = @benchmarkable ($op).($xx, $yy)
    end
end