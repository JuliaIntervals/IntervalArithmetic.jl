
using FactCheck
using ValidatedNumerics

facts("DecoratedInterval tests") do
    a = DecoratedInterval(@interval(1, 2), com)
    @fact decoration(a) --> com

    b = sqrt(a)
    @fact interval(b) --> sqrt(interval(a))
    @fact decoration(b) --> com

    a = DecoratedInterval(@interval(-1, 1), com)
    b = sqrt(a)
    @fact interval(b) --> sqrt(Interval(0, 1))
    @fact decoration(b) --> trv

end
