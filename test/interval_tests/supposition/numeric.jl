using Test
using IntervalArithmetic
using Supposition, Supposition.Data

# Define properties to be checked
function degenerate_interval(a)
    x = interval(a)
    y = interval(a, a)
    x === y
end

@testset "Float tests" begin
    # Define number generators
    floatgen = Data.Floats()

    # Check properties
    @check max_examples=1000 degenerate_interval(floatgen)
end

@testset "Rational tests" begin
    # Define number generators
    intgen = Data.Integers(typemin(Int)+1,typemax(Int)) # Don't allow typemin(Int) to avoid overflow
    rationalgen = @composed function generate_rational(num=intgen, den=intgen)
        assume!(!(iszero(num) && iszero(den)))
        return num // den
    end

    # Check properties
    @check max_examples = 1000 degenerate_interval(rationalgen)
end
