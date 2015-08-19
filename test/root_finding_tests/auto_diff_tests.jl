# AutoDiff tests

facts("AutoDiff tests") do
    @fact D(x -> x^2, 3) == 6 --> true

    f(x) = sin(2x) - x
    for a in [3, 7, 11]
        @fact D(f, a) == 2*cos(2a) - 1 --> true
    end

end
