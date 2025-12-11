using BenchmarkTools
using IntervalArithmetic

import MPFI
import Random

MPFI.BigInterval(x::ExactReal) = MPFI.BigInterval(x.value)

Random.seed!(0)

# Dietmar Ratz functions
# NOTE We need to use @exact for bareinterval to be able to use the fast BareInterval constructor automatically
@exact dr1(x) = (x + sin(x)) * exp(-x^2)
@exact dr2(x) = x^4 - 10x^3 + 35x^2 - 50x + 24
@exact dr3(x) = (log(x + 1.25) - 0.84x) ^ 2
@exact dr4(x) = 0.02x^2 - 0.03exp(-(20(x - 0.875))^2)
@exact dr5(x) = exp(x^2)
@exact dr6(x) = x^4 - 12x^3 + 47x^2 - 60x - 20exp(-x)
@exact dr7(x) = x^6 - 15x^4 + 27x^2 + 250
dr8(x) = atan(cos(tan(x)))
dr9(x) = asin(cos(acos(sin(x))))

dr_functions = [dr1, dr2, dr3, dr4, dr5, dr6, dr7, dr8, dr9]
dr_functions = [dr8, dr9]  # MPFI doesn't support ^

basic_arithmetic = [+, *, -, /]
basic_functions = [exp, cosh, sinh, tanh, inv, sqrt, abs, log, sin, cos, tan, acos, asin, atan]

interval_constructors = Dict(
    "bareinterval" => bareinterval,
    "interval" => interval,
    "BigFloat bareinterval" => (x, y) -> bareinterval(BigFloat, x, y),
    "BigFloat interval" => (x, y) -> interval(BigFloat, x, y),
    "BigFloat MPFI" => MPFI.BigInterval
)

bounds = map(1:100) do i
    x = randn()
    y = randn()
    x > y && return (y, x)
    return (x, y)
end

SUITE = BenchmarkGroup()
SUITE["basics"] = BenchmarkGroup(["arithmetic"])
SUITE["Dietmar-Ratz"] = BenchmarkGroup(["arithmetic"])

for (name, T) in interval_constructors
    xx = [T(x, y) for (x, y) in bounds]
    yy = reverse(xx)

    SUITE["basics"][name] = BenchmarkGroup(split(name))

    for f in basic_functions
        SUITE["basics"][name][string(f)] = @benchmarkable ($f).($xx)
    end

    for op in basic_arithmetic
        SUITE["basics"][name][string(op)] = @benchmarkable ($op).($xx, $yy)
    end

    SUITE["Dietmar-Ratz"][name] = BenchmarkGroup(split(name))
    for dr in dr_functions
        SUITE["Dietmar-Ratz"][name][string(dr)] = @benchmarkable ($dr).($xx)
    end
end