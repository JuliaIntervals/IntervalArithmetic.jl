using Test
using IntervalArithmetic
using Supposition, Supposition.Data

@testset "Rational tests" begin
    # Define number generators
    #intgen = Data.Integers(typemin(Int)+1,typemax(Int)) # Don't allow den==typemin(Int) to avoid overflow
    intgen = Data.Integers(typemin(Int8)+Int8(1),typemax(Int8)) # Don't allow den==typemin(Int8) to avoid overflow
    rationalgen = @composed function generate_rational(num=intgen, den=intgen)
        assume!(!(iszero(num) && iszero(den)))
        return num // den
    end

    # Check properties
    @check function degenerate_interval(r=rationalgen)
        x = interval(r)
        y = interval(r, r)
        assume!(!any(decoration.((x,y)) .== ill)) # Exclude ill-formed intervals
        isequal_interval(x, y)
    end
end
