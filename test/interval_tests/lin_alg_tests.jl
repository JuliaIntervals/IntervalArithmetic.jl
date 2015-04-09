using ValidatedNumerics
using FactCheck

A =
    [
        @interval( 2, 4)    @interval(-2, 1) ;
        @interval(-1, 2)    @interval( 2, 4)
    ]

b =
    [
        @interval(-2, 2),
        @interval(-2, 2)
    ]


facts("Linear algebra with intervals tests") do

    @fact A * b =>
    [
        Interval(-12, 12),
        Interval(-12, 12)
    ]

    # Example from Moore et al., Introduction to Interval Analysis (2009), pg. 88:

    @fact A \ b =>
      [
        Interval(-5, 5),
        Interval(-4, 4)
      ]

end
