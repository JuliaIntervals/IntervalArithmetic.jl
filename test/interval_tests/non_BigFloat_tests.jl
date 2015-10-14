using ValidatedNumerics
using FactCheck

facts("Tests with rational intervals") do

    a = Interval(1//2, 3//4)
    b = Interval(3//7, 9//12)

    @fact a + b --> Interval(13//14, 3//2)

    @fact sqrt(a + b) --> Interval(0.9636241116594315, 1.224744871391589)

    @fact rationalize(1//2) --> 1//2
    @fact rationalize(BigInt, 1//2) --> BigInt(1)//2

end

facts("Tests with float intervals") do

    c = @floatinterval(0.1, 0.2)

    @fact isa(@floatinterval(0.1), Interval) --> true
    @fact c --> Interval(0.09999999999999999, 0.2)

    @fact widen(c) --> Interval(0.09999999999999998, 0.20000000000000004)

    @fact @floatinterval(pi) --> Interval(3.141592653589793, 3.1415926535897936)
end

facts("Testing functions of intervals") do
    f(x) = x + 0.1

    c = @floatinterval(0.1, 0.2)
    @pending f(c) --> Interval(0.19999999999999998, 0.30000000000000004)

    d = @interval(0.1, 0.2)
    @pending f(d) --> Interval(1.9999999999999998e-01, 3.0000000000000004e-01)
end

facts("Testing conversions") do
    f = @interval(0.1, 0.2)
    @pending @floatinterval(f) --> Interval(0.09999999999999999, 0.2)

    g = @floatinterval(0.1, 0.2)
    @pending @interval(g) --> Interval(9.9999999999999992e-02, 2.0000000000000001e-01)
end
