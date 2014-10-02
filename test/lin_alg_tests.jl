# Example from Moore et al., Introduction to Interval Analysis (2009), pg. 88:

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

@test A \ b ==
  [
    Interval(-5, 5),
    Interval(-4, 4)
  ]
