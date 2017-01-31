using FactCheck
using ValidatedNumerics

facts("Operations on boxes") do
    A = IntervalBox(1..2, 3..4)
    B = IntervalBox(0..2, 3..6)

    @fact 2*A --> IntervalBox(2..4, 6..8)
    @fact A + B --> IntervalBox(1..4, 6..10)
    @fact dot(A, B) --> @interval(9, 28)

    @fact A ⊆ B --> true
    @fact A ∩ B --> A
    @fact A ∪ B --> B

    X = IntervalBox(1..2, 3..4)
    Y = IntervalBox(3..4, 3..4)

    @fact isempty(X ∩ Y) --> true
    @fact X ∪ Y --> IntervalBox(1..4, 3..4)

    X = IntervalBox(2..4, 3..5)
    Y = IntervalBox(3..5, 4..17)
    @fact X ∩ Y --> IntervalBox(3..4, 4..5)

    v = [@interval(i, i+1) for i in 1:10]
    V = IntervalBox(v...)
    @fact length(V) --> 10

    Y = IntervalBox(1..2)  # single interval
    @fact isa(Y, IntervalBox) --> true
    @fact length(Y) --> 1
    @fact Y --> IntervalBox( (Interval(1., 2.),) )

end

facts("@intervalbox tests") do
    @intervalbox f(x, y) = (x + y, x - y)

    X = IntervalBox(1..1, 2..2)
    @fact f(X) --> IntervalBox(3..3, -1 .. -1)

    @intervalbox g(x, y) = x - y
    @fact isa(g(X), IntervalBox) --> true

    @fact emptyinterval(X) --> IntervalBox(∅, ∅)

end

facts("setdiff for IntervalBox") do
    X = IntervalBox(2..4, 3..5)
    Y = IntervalBox(3..5, 4..6)
    @fact setdiff(X, Y) --> [ IntervalBox(3..4, 3..4),
                              IntervalBox(2..3, 3..5) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, 4..5)
    @fact setdiff(X, Y) --> [ IntervalBox(2..5, 3..4),
                              IntervalBox(2..5, 5..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(4..6, 4..5)
    @fact setdiff(X, Y) --> [ IntervalBox(4..5, 3..4),
                              IntervalBox(4..5, 5..6),
                              IntervalBox(2..4, 3..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(3..4, 4..5)
    @fact setdiff(X, Y) --> [ IntervalBox(3..4, 3..4),
                              IntervalBox(3..4, 5..6),
                              IntervalBox(2..3, 3..6),
                              IntervalBox(4..5, 3..6) ]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(2..4, 10..20)
    @fact setdiff(X, Y) --> typeof(X)[X]


    X = IntervalBox(2..5, 3..6)
    Y = IntervalBox(-10..10, -10..10)
    @fact setdiff(X, Y) --> typeof(X)[]


    X = IntervalBox(1..4, 3..6, 7..10)
    Y = IntervalBox(2..3, 4..5, 8..9)
    @fact setdiff(X, Y) --> [ IntervalBox(2..3, 4..5, 7..8),
                              IntervalBox(2..3, 4..5, 9..10),
                              IntervalBox(2..3, 3..4, 7..10),
                              IntervalBox(2..3, 5..6, 7..10),
                              IntervalBox(1..2, 3..6, 7..10),
                              IntervalBox(3..4, 3..6, 7..10) ]


end
