@testset "minimal_is_common_interval_test" begin

    @test iscommon(interval(-27.0,-27.0)) == true

    @test iscommon(interval(-27.0, 0.0)) == true

    @test iscommon(interval(0.0,0.0)) == true

    @test iscommon(interval(-0.0,-0.0)) == true

    @test iscommon(interval(-0.0,0.0)) == true

    @test iscommon(interval(0.0,-0.0)) == true

    @test iscommon(interval(5.0, 12.4)) == true

    @test iscommon(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023)) == true

    @test iscommon(entireinterval(BareInterval{Float64})) == false

    @test iscommon(emptyinterval(BareInterval{Float64})) == false

    @test iscommon(interval(-Inf, 0.0)) == false

    @test iscommon(interval(0.0, Inf)) == false

end

@testset "minimal_is_common_interval_dec_test" begin

    @test iscommon(Interval(interval(-27.0,-27.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(-27.0, 0.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(0.0,0.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(-0.0,-0.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(-0.0,0.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(0.0,-0.0), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(5.0, 12.4), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.com)) == true

    @test iscommon(Interval(interval(-27.0,-27.0), IntervalArithmetic.trv)) == true

    @test iscommon(Interval(interval(-27.0, 0.0), IntervalArithmetic.def)) == true

    @test iscommon(Interval(interval(0.0,0.0), IntervalArithmetic.dac)) == true

    @test iscommon(Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) == true

    @test iscommon(Interval(interval(-0.0,0.0), IntervalArithmetic.def)) == true

    @test iscommon(Interval(interval(0.0,-0.0), IntervalArithmetic.dac)) == true

    @test iscommon(Interval(interval(5.0, 12.4), IntervalArithmetic.def)) == true

    @test iscommon(Interval(interval(-0x1.FFFFFFFFFFFFFp1023, 0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.trv)) == true

    @test iscommon(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) == false

    @test iscommon(nai()) == false

    @test iscommon(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test iscommon(Interval(interval(-Inf, 0.0), IntervalArithmetic.trv)) == false

    @test iscommon(Interval(interval(0.0, Inf), IntervalArithmetic.def)) == false

end

@testset "minimal_is_singleton_test" begin

    @test isthin(interval(-27.0,-27.0)) == true

    @test isthin(interval(-2.0, -2.0)) == true

    @test isthin(interval(12.0,12.0)) == true

    @test isthin(interval(17.1, 17.1)) == true

    @test isthin(interval(-0.0,-0.0)) == true

    @test isthin(interval(0.0,0.0)) == true

    @test isthin(interval(-0.0, 0.0)) == true

    @test isthin(interval(0.0, -0.0)) == true

    @test isthin(emptyinterval(BareInterval{Float64})) == false

    @test isthin(entireinterval(BareInterval{Float64})) == false

    @test isthin(interval(-1.0, 0.0)) == false

    @test isthin(interval(-1.0, -0.5)) == false

    @test isthin(interval(1.0, 2.0)) == false

    @test isthin(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023)) == false

    @test isthin(interval(-1.0,Inf)) == false

end

@testset "minimal_is_singleton_dec_test" begin

    @test isthin(Interval(interval(-27.0,-27.0), IntervalArithmetic.def)) == true

    @test isthin(Interval(interval(-2.0, -2.0), IntervalArithmetic.trv)) == true

    @test isthin(Interval(interval(12.0,12.0), IntervalArithmetic.dac)) == true

    @test isthin(Interval(interval(17.1, 17.1), IntervalArithmetic.com)) == true

    @test isthin(Interval(interval(-0.0,-0.0), IntervalArithmetic.def)) == true

    @test isthin(Interval(interval(0.0,0.0), IntervalArithmetic.com)) == true

    @test isthin(Interval(interval(-0.0, 0.0), IntervalArithmetic.def)) == true

    @test isthin(Interval(interval(0.0, -0.0), IntervalArithmetic.dac)) == true

    @test isthin(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isthin(nai()) == false

    @test isthin(Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)) == false

    @test isthin(Interval(interval(-1.0, 0.0), IntervalArithmetic.dac)) == false

    @test isthin(Interval(interval(-1.0, -0.5), IntervalArithmetic.com)) == false

    @test isthin(Interval(interval(1.0, 2.0), IntervalArithmetic.def)) == false

    @test isthin(Interval(interval(-Inf,-0x1.FFFFFFFFFFFFFp1023), IntervalArithmetic.dac)) == false

    @test isthin(Interval(interval(-1.0,Inf), IntervalArithmetic.trv)) == false

end

@testset "minimal_is_member_test" begin

    @test in_interval(-27.0, interval(-27.0,-27.0)) == true

    @test in_interval(-27.0, interval(-27.0, 0.0)) == true

    @test in_interval(-7.0, interval(-27.0, 0.0)) == true

    @test in_interval(0.0, interval(-27.0, 0.0)) == true

    @test in_interval(-0.0, interval(0.0,0.0)) == true

    @test in_interval(0.0, interval(0.0,0.0)) == true

    @test in_interval(0.0, interval(-0.0,-0.0)) == true

    @test in_interval(0.0, interval(-0.0,0.0)) == true

    @test in_interval(0.0, interval(0.0,-0.0)) == true

    @test in_interval(5.0, interval(5.0, 12.4)) == true

    @test in_interval(6.3, interval(5.0, 12.4)) == true

    @test in_interval(12.4, interval(5.0, 12.4)) == true

    @test in_interval(0.0, entireinterval(BareInterval{Float64})) == true

    @test in_interval(5.0, entireinterval(BareInterval{Float64})) == true

    @test in_interval(6.3, entireinterval(BareInterval{Float64})) == true

    @test in_interval(12.4, entireinterval(BareInterval{Float64})) == true

    @test in_interval(0x1.FFFFFFFFFFFFFp1023, entireinterval(BareInterval{Float64})) == true

    @test in_interval(-0x1.FFFFFFFFFFFFFp1023, entireinterval(BareInterval{Float64})) == true

    @test in_interval(0x1.0p-1022, entireinterval(BareInterval{Float64})) == true

    @test in_interval(-0x1.0p-1022, entireinterval(BareInterval{Float64})) == true

    @test in_interval(-71.0, interval(-27.0, 0.0)) == false

    @test in_interval(0.1, interval(-27.0, 0.0)) == false

    @test in_interval(-0.01, interval(0.0,0.0)) == false

    @test in_interval(0.000001, interval(0.0,0.0)) == false

    @test in_interval(111110.0, interval(-0.0,-0.0)) == false

    @test in_interval(4.9, interval(5.0, 12.4)) == false

    @test in_interval(-6.3, interval(5.0, 12.4)) == false

    @test in_interval(0.0, emptyinterval(BareInterval{Float64})) == false

    @test in_interval(-4535.3, emptyinterval(BareInterval{Float64})) == false

    @test in_interval(-Inf, emptyinterval(BareInterval{Float64})) == false

    @test in_interval(Inf, emptyinterval(BareInterval{Float64})) == false

    @test in_interval(NaN, emptyinterval(BareInterval{Float64})) == false

    @test in_interval(-Inf, entireinterval(BareInterval{Float64})) == false

    @test in_interval(Inf, entireinterval(BareInterval{Float64})) == false

    @test in_interval(NaN, entireinterval(BareInterval{Float64})) == false

end

@testset "minimal_is_member_dec_test" begin

    @test in_interval(-27.0, Interval(interval(-27.0,-27.0), IntervalArithmetic.trv)) == true

    @test in_interval(-27.0, Interval(interval(-27.0, 0.0), IntervalArithmetic.def)) == true

    @test in_interval(-7.0, Interval(interval(-27.0, 0.0), IntervalArithmetic.dac)) == true

    @test in_interval(0.0, Interval(interval(-27.0, 0.0), IntervalArithmetic.com)) == true

    @test in_interval(-0.0, Interval(interval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test in_interval(0.0, Interval(interval(0.0,0.0), IntervalArithmetic.def)) == true

    @test in_interval(0.0, Interval(interval(-0.0,-0.0), IntervalArithmetic.dac)) == true

    @test in_interval(0.0, Interval(interval(-0.0,0.0), IntervalArithmetic.com)) == true

    @test in_interval(0.0, Interval(interval(0.0,-0.0), IntervalArithmetic.trv)) == true

    @test in_interval(5.0, Interval(interval(5.0, 12.4), IntervalArithmetic.def)) == true

    @test in_interval(6.3, Interval(interval(5.0, 12.4), IntervalArithmetic.dac)) == true

    @test in_interval(12.4, Interval(interval(5.0, 12.4), IntervalArithmetic.com)) == true

    @test in_interval(0.0, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test in_interval(5.0, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)) == true

    @test in_interval(6.3, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) == true

    @test in_interval(12.4, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test in_interval(0x1.FFFFFFFFFFFFFp1023, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)) == true

    @test in_interval(-0x1.FFFFFFFFFFFFFp1023, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) == true

    @test in_interval(0x1.0p-1022, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test in_interval(-0x1.0p-1022, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)) == true

    @test in_interval(-71.0, Interval(interval(-27.0, 0.0), IntervalArithmetic.trv)) == false

    @test in_interval(0.1, Interval(interval(-27.0, 0.0), IntervalArithmetic.def)) == false

    @test in_interval(-0.01, Interval(interval(0.0,0.0), IntervalArithmetic.dac)) == false

    @test in_interval(0.000001, Interval(interval(0.0,0.0), IntervalArithmetic.com)) == false

    @test in_interval(111110.0, Interval(interval(-0.0,-0.0), IntervalArithmetic.trv)) == false

    @test in_interval(4.9, Interval(interval(5.0, 12.4), IntervalArithmetic.def)) == false

    @test in_interval(-6.3, Interval(interval(5.0, 12.4), IntervalArithmetic.dac)) == false

    @test in_interval(0.0, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(0.0, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(-4535.3, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(-4535.3, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(-Inf, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(-Inf, nai()) == false

    @test in_interval(Inf, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(Inf, nai()) == false

    @test in_interval(NaN, Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(NaN, nai()) == false

    @test in_interval(-Inf, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test in_interval(Inf, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.def)) == false

    @test in_interval(NaN, Interval(entireinterval(BareInterval{Float64}), IntervalArithmetic.dac)) == false

end
