using ValidatedNumerics
using FactCheck



facts("Interval loop tests") do
    i = 1

    @fact Interval(i,i).lo => 1
    @fact @interval(i).lo => 1


    for i in 1:10
        a = @interval(i)
        @fact a.lo => i
    end

end
