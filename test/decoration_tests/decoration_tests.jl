
using FactCheck
using ValidatedNumerics

facts("DecoratedInterval tests") do
    a = DecoratedInterval(@interval(1, 2), com)
    @fact decoration(a) --> com

    b = sqrt(a)
    @fact interval_part(b) --> sqrt(interval_part(a))
    @fact decoration(b) --> com

    a = DecoratedInterval(@interval(-1, 1), com)
    b = sqrt(a)
    @fact interval_part(b) --> sqrt(Interval(0, 1))
    @fact decoration(b) --> trv

    d = DecoratedInterval(a, dac)
    @fact decoration(d) --> dac

    @fact decoration(DecoratedInterval(1.1)) --> com
    @fact decoration(DecoratedInterval(1.1, dac)) --> dac

    @fact decoration(DecoratedInterval(2, 0.1, com)) --> ill
    @fact decoration(DecoratedInterval(2, 0.1)) --> ill
    @fact isnai(interval_part(DecoratedInterval(2, 0.1))) --> true
    @fact decoration(@decorated(2, 0.1)) --> ill
    @fact decoration(DecoratedInterval(big(2), big(1))) --> ill
    @fact isnai(interval_part((DecoratedInterval(big(2), big(1))))) --> true
    @fact isnai(interval_part(@decorated(big(2), big(1)))) --> true

    # Disabling the following tests, because Julia 0.5 has some strange behaviour here
    # @fact_throws ArgumentError DecoratedInterval(BigInt(1), 1//10)
    # @fact_throws ArgumentError @decorated(BigInt(1), 1//10)
end
