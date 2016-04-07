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

    @fact A * b -->
        [
            @interval(-12, 12),
            @interval(-12, 12)
        ]

    # Example from Moore et al., Introduction to Interval Analysis (2009), pg. 88:

    @fact A \ b -->
        [
            @interval(-5, 5),
            @interval(-4, 4)
        ]

end
