# AutoDiff tests

using ValidatedNumerics
using FactCheck

Jet = ValidatedNumerics.Jet

facts("Jet tests") do
    a = Jet(1, 1)

    @fact zero(a) == Jet(0, 0) --> true
    @fact one(a)  == Jet(1, 0) --> true
    @fact -a == Jet(-1, -1) --> true
    @fact +a == 2a - a --> true

end

facts("AutoDiff tests") do

    @fact D(x -> x^2, 3) == 6 --> true
    @fact D(x -> (x+1)/(x-2), 1) == -3.0 --> true

    f(x) = sin(2x) - x

    for a in (-3, 3, 7, 11)
        @fact D(f, a) == 2*cos(2a) - 1 --> true
        @fact D(tan, a) == 1. / (cos(a)^2) --> true

	if a > 0.
	    @fact D(log, a) == 1. / a --> true
            @fact D(x -> x^(1//2), a) == 0.5*a^(-0.5) --> true
            @fact D(x -> x^0.5, a) == 0.5*a^(-0.5) --> true

        end

    end

    for a in (-0.3, 0.0, 0.1)
        @fact D(acos, a) == -1. / sqrt(1 - a^2) --> true
        @fact D(atan, a) == 1. / (1 + a^2) --> true
    end



end


jacobian = ValidatedNumerics.jacobian

facts("Jacobian tests") do
    f(xvec) = ( (x,y)=xvec; [x+y, x-y] )

    for a in ([1, 2], [3, 4])
        @fact jacobian(f, a) == [1 1; 1 -1] --> true
    end

end

