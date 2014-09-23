@test sin(@interval(0.5)) ==
    @interval(big(0.47942553860420295), big(0.47942553860420301))
@test sin(@interval(0.5, 1.67)) ==
    @interval(big(4.7942553860420295e-01), big(1.0))
@test sin(@interval(1.67,3.2)) ==
    @interval(big(-5.8374143427580093e-02), big(9.9508334981018021e-01))
@test sin(@interval(2.1, 5.6)) ==
    @interval(big(-1.0), big(8.6320936664887404e-01))
@test sin(@interval(0.5,8.5)) == @interval(-1.0, 1.0)
@test cos(@interval(0.5)) ==
    @interval(big(0.87758256189037265), big(0.87758256189037276))
@test cos(@interval(0.5,1.67)) ==
    @interval(big(-0.099041036598728246), big(0.87758256189037276))
@test cos(@interval(2.1, 5.6)) ==
    @interval(big(-1.0), big(0.77556587851025016))
@test cos(@interval(0.5,8.5)) == @interval(big(-1.0), big(1.0))
@test cos(@interval(1.67,3.2)) == @interval(big(-1.0), big(-0.099041036598728011))
@test tan(@interval(0.5)) ==
    @interval(big(0.54630248984379048), big(0.5463024898437906))
@test tan(@interval(0.5,1.67)) == @interval(big(-Inf), big(Inf))
@test tan(@interval(1.67, 3.2)) ==
    @interval(big(-10.047182299210307), big(0.058473854459578652))
