using FactCheck

facts("Operations on boxes") do
    A = IntervalBox(1..2, 3..4)
    B = IntervalBox(0..2, 3..6)

    @fact 2*A --> IntervalBox(2..4, 6..8)
    @fact A + B --> IntervalBox(1..4, 6..10)
    @fact dot(A, B) --> @interval(9, 28)

    @fact A ⊆ B --> true

    X = IntervalBox(1..2, 3..4)
    Y = IntervalBox(3..4, 3..4)

    @fact isempty(X ∩ Y) --> true

    v = [@interval(i, i+1) for i in 1:10]
    V = IntervalBox(v...)

    @fact length(V) --> 10

end

facts("@box tests") do
    @box f(x, y) = (x + y, x - y)

    X = IntervalBox(1..1, 2..2)
    @fact f(X) --> IntervalBox(3..3, -1 .. -1)

end
