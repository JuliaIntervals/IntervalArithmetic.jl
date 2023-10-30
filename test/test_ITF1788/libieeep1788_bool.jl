@testset "minimal_is_empty_test" begin

    @test isempty_interval(emptyinterval(BareInterval{Float64})) == true

    @test isempty_interval(bareinterval(-Inf,+Inf)) == false

    @test isempty_interval(bareinterval(1.0,2.0)) == false

    @test isempty_interval(bareinterval(-1.0,2.0)) == false

    @test isempty_interval(bareinterval(-3.0,-2.0)) == false

    @test isempty_interval(bareinterval(-Inf,2.0)) == false

    @test isempty_interval(bareinterval(-Inf,0.0)) == false

    @test isempty_interval(bareinterval(-Inf,-0.0)) == false

    @test isempty_interval(bareinterval(0.0,Inf)) == false

    @test isempty_interval(bareinterval(-0.0,Inf)) == false

    @test isempty_interval(bareinterval(-0.0,0.0)) == false

    @test isempty_interval(bareinterval(0.0,-0.0)) == false

    @test isempty_interval(bareinterval(0.0,0.0)) == false

    @test isempty_interval(bareinterval(-0.0,-0.0)) == false

end

@testset "minimal_is_empty_dec_test" begin

    @test isempty_interval(nai()) == false

    @test isempty_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isempty_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.def)) == false

    @test isempty_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)) == false

    @test isempty_interval(Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(-3.0,-2.0), IntervalArithmetic.dac)) == false

    @test isempty_interval(Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def)) == false

    @test isempty_interval(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.com)) == false

    @test isempty_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == false

    @test isempty_interval(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == false

end

@testset "minimal_is_entire_test" begin

    @test isentire_interval(emptyinterval(BareInterval{Float64})) == false

    @test isentire_interval(bareinterval(-Inf,+Inf)) == true

    @test isentire_interval(bareinterval(1.0,2.0)) == false

    @test isentire_interval(bareinterval(-1.0,2.0)) == false

    @test isentire_interval(bareinterval(-3.0,-2.0)) == false

    @test isentire_interval(bareinterval(-Inf,2.0)) == false

    @test isentire_interval(bareinterval(-Inf,0.0)) == false

    @test isentire_interval(bareinterval(-Inf,-0.0)) == false

    @test isentire_interval(bareinterval(0.0,Inf)) == false

    @test isentire_interval(bareinterval(-0.0,Inf)) == false

    @test isentire_interval(bareinterval(-0.0,0.0)) == false

    @test isentire_interval(bareinterval(0.0,-0.0)) == false

    @test isentire_interval(bareinterval(0.0,0.0)) == false

    @test isentire_interval(bareinterval(-0.0,-0.0)) == false

end

@testset "minimal_is_entire_dec_test" begin

    @test isentire_interval(nai()) == false

    @test isentire_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isentire_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.def)) == true

    @test isentire_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.dac)) == true

    @test isentire_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)) == false

    @test isentire_interval(Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-3.0,-2.0), IntervalArithmetic.dac)) == false

    @test isentire_interval(Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def)) == false

    @test isentire_interval(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.com)) == false

    @test isentire_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == false

    @test isentire_interval(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == false

end

@testset "minimal_is_nai_dec_test" begin

    @test isnai(nai()) == true

    @test isnai(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.def)) == false

    @test isnai(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.dac)) == false

    @test isnai(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)) == false

    @test isnai(Interval(bareinterval(-1.0,2.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-3.0,-2.0), IntervalArithmetic.dac)) == false

    @test isnai(Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-Inf,0.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-Inf,-0.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(0.0,Inf), IntervalArithmetic.def)) == false

    @test isnai(Interval(bareinterval(-0.0,Inf), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.com)) == false

    @test isnai(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == false

    @test isnai(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == false

end

@testset "minimal_equal_test" begin

    @test isequal_interval(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) == true

    @test isequal_interval(bareinterval(1.0,2.1), bareinterval(1.0,2.0)) == false

    @test isequal_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test isequal_interval(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) == false

    @test isequal_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == true

    @test isequal_interval(bareinterval(1.0,2.4), bareinterval(-Inf,+Inf)) == false

    @test isequal_interval(bareinterval(1.0,Inf), bareinterval(1.0,Inf)) == true

    @test isequal_interval(bareinterval(1.0,2.4), bareinterval(1.0,Inf)) == false

    @test isequal_interval(bareinterval(-Inf,2.0), bareinterval(-Inf,2.0)) == true

    @test isequal_interval(bareinterval(-Inf,2.4), bareinterval(-Inf,2.0)) == false

    @test isequal_interval(bareinterval(-2.0,0.0), bareinterval(-2.0,0.0)) == true

    @test isequal_interval(bareinterval(-0.0,2.0), bareinterval(0.0,2.0)) == true

    @test isequal_interval(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test isequal_interval(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) == true

    @test isequal_interval(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) == true

end

@testset "minimal_equal_dec_test" begin

    @test isequal_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(1.0,2.1), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), nai()) == false

    @test isequal_interval(nai(), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isequal_interval(nai(), nai()) == false

    @test isequal_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isequal_interval(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isequal_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.def), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(1.0,2.4), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isequal_interval(Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(1.0,2.4), IntervalArithmetic.def), Interval(bareinterval(1.0,Inf), IntervalArithmetic.trv)) == false

    @test isequal_interval(Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(-Inf,2.4), IntervalArithmetic.def), Interval(bareinterval(-Inf,2.0), IntervalArithmetic.trv)) == false

    @test isequal_interval(Interval(bareinterval(-2.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0,0.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(-0.0,2.0), IntervalArithmetic.def), Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.def), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test isequal_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

end

@testset "minimal_subset_test" begin

    @test issubset_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(0.0,4.0)) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,4.0)) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,1.0)) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,0.0)) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,-0.0)) == true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,+Inf)) == true

    @test issubset_interval(bareinterval(0.0,4.0), emptyinterval(BareInterval{Float64})) == false

    @test issubset_interval(bareinterval(-0.0,4.0), emptyinterval(BareInterval{Float64})) == false

    @test issubset_interval(bareinterval(-0.1,1.0), emptyinterval(BareInterval{Float64})) == false

    @test issubset_interval(bareinterval(-Inf,+Inf), emptyinterval(BareInterval{Float64})) == false

    @test issubset_interval(bareinterval(0.0,4.0), bareinterval(-Inf,+Inf)) == true

    @test issubset_interval(bareinterval(-0.0,4.0), bareinterval(-Inf,+Inf)) == true

    @test issubset_interval(bareinterval(-0.1,1.0), bareinterval(-Inf,+Inf)) == true

    @test issubset_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) == true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(0.0,4.0)) == true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(-0.0,4.0)) == true

    @test issubset_interval(bareinterval(0.1,0.2), bareinterval(0.0,4.0)) == true

    @test issubset_interval(bareinterval(0.1,0.2), bareinterval(-0.0,4.0)) == true

    @test issubset_interval(bareinterval(-0.1,-0.1), bareinterval(-4.0, 3.4)) == true

    @test issubset_interval(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) == true

    @test issubset_interval(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test issubset_interval(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) == true

    @test issubset_interval(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) == true

    @test issubset_interval(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test issubset_interval(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) == true

end

@testset "minimal_subset_dec_test" begin

    @test issubset_interval(nai(), nai()) == false

    @test issubset_interval(nai(), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test issubset_interval(nai(), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.0,4.0), IntervalArithmetic.def)) == true

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.1,0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-0.1,-0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test issubset_interval(Interval(bareinterval(-0.0,4.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test issubset_interval(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test issubset_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test issubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(-0.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(-0.1,1.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(-0.0,4.0), IntervalArithmetic.def)) == true

    @test issubset_interval(Interval(bareinterval(0.1,0.2), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(0.1,0.2), IntervalArithmetic.trv), Interval(bareinterval(-0.0,4.0), IntervalArithmetic.def)) == true

    @test issubset_interval(Interval(bareinterval(-0.1,-0.1), IntervalArithmetic.trv), Interval(bareinterval(-4.0, 3.4), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.def)) == true

    @test issubset_interval(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.def), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test issubset_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv)) == true

end

@testset "minimal_less_test" begin

    @test isweakless(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test isweakless(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) == false

    @test isweakless(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) == false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test isweakless(bareinterval(0.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test isweakless(bareinterval(-0.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) == false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(0.0,2.0)) == false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(-0.0,2.0)) == false

    @test isweakless(bareinterval(0.0,2.0), bareinterval(0.0,2.0)) == true

    @test isweakless(bareinterval(0.0,2.0), bareinterval(-0.0,2.0)) == true

    @test isweakless(bareinterval(0.0,2.0), bareinterval(1.0,2.0)) == true

    @test isweakless(bareinterval(-0.0,2.0), bareinterval(1.0,2.0)) == true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) == true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) == true

    @test isweakless(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) == true

    @test isweakless(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) == true

    @test isweakless(bareinterval(-2.0,-1.0), bareinterval(-2.0,-1.0)) == true

    @test isweakless(bareinterval(-3.0,-1.5), bareinterval(-2.0,-1.0)) == true

    @test isweakless(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) == true

    @test isweakless(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test isweakless(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) == true

    @test isweakless(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) == true

    @test isweakless(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test isweakless(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) == true

end

@testset "minimal_less_dec_test" begin

    @test isweakless(nai(), nai()) == false

    @test isweakless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), nai()) == false

    @test isweakless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), nai()) == false

    @test isweakless(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) == false

    @test isweakless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(-0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(0.0,2.0), IntervalArithmetic.def)) == false

    @test isweakless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-0.0,2.0), IntervalArithmetic.trv)) == false

    @test isweakless(Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,2.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(0.0,2.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) == true

    @test isweakless(Interval(bareinterval(-0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == true

    @test isweakless(Interval(bareinterval(1.0,3.5), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(-3.0,-1.5), IntervalArithmetic.trv), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.def)) == true

    @test isweakless(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.def), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test isweakless(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv)) == true

end

@testset "minimal_precedes_test" begin

    @test precedes(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) == true

    @test precedes(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) == true

    @test precedes(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test precedes(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test precedes(bareinterval(0.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test precedes(bareinterval(-0.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test precedes(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) == false

    @test precedes(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == false

    @test precedes(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) == true

    @test precedes(bareinterval(1.0,3.0), bareinterval(3.0,4.0)) == true

    @test precedes(bareinterval(-3.0, -1.0), bareinterval(-1.0,0.0)) == true

    @test precedes(bareinterval(-3.0, -1.0), bareinterval(-1.0,-0.0)) == true

    @test precedes(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) == false

    @test precedes(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) == false

    @test precedes(bareinterval(-3.0, -0.1), bareinterval(-1.0,0.0)) == false

    @test precedes(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) == true

    @test precedes(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test precedes(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) == true

    @test precedes(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) == true

    @test precedes(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) == true

    @test precedes(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) == true

end

@testset "minimal_precedes_dec_test" begin

    @test precedes(nai(), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == false

    @test precedes(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), nai()) == false

    @test precedes(nai(), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test precedes(nai(), nai()) == false

    @test precedes(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == true

    @test precedes(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test precedes(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(-0.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(1.0,3.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == true

    @test precedes(Interval(bareinterval(-3.0, -1.0), IntervalArithmetic.def), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(-3.0, -1.0), IntervalArithmetic.trv), Interval(bareinterval(-1.0,-0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(1.0,3.5), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(-3.0, -0.1), IntervalArithmetic.trv), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv)) == false

    @test precedes(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.def)) == true

    @test precedes(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(-0.0,0.0), IntervalArithmetic.def), Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv)) == true

    @test precedes(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv)) == true

end

@testset "minimal_interior_test" begin

    @test isstrictsubset_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test isstrictsubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(0.0,4.0)) == true

    @test isstrictsubset_interval(bareinterval(0.0,4.0), emptyinterval(BareInterval{Float64})) == false

    @test isstrictsubset_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(bareinterval(0.0,4.0), bareinterval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(bareinterval(-Inf,+Inf), bareinterval(0.0,4.0)) == false

    @test isstrictsubset_interval(bareinterval(0.0,4.0), bareinterval(0.0,4.0)) == false

    @test isstrictsubset_interval(bareinterval(1.0,2.0), bareinterval(0.0,4.0)) == true

    @test isstrictsubset_interval(bareinterval(-2.0,2.0), bareinterval(-2.0,4.0)) == false

    @test isstrictsubset_interval(bareinterval(-0.0,-0.0), bareinterval(-2.0,4.0)) == true

    @test isstrictsubset_interval(bareinterval(0.0,0.0), bareinterval(-2.0,4.0)) == true

    @test isstrictsubset_interval(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) == false

    @test isstrictsubset_interval(bareinterval(0.0,4.4), bareinterval(0.0,4.0)) == false

    @test isstrictsubset_interval(bareinterval(-1.0,-1.0), bareinterval(0.0,4.0)) == false

    @test isstrictsubset_interval(bareinterval(2.0,2.0), bareinterval(-2.0,-1.0)) == false

end

@testset "minimal_interior_dec_test" begin

    @test isstrictsubset_interval(nai(), nai()) == false

    @test isstrictsubset_interval(nai(), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(nai(), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.def), nai()) == false

    @test isstrictsubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(-2.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0,4.0), IntervalArithmetic.def)) == false

    @test isstrictsubset_interval(Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(-2.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.def), Interval(bareinterval(-2.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictsubset_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(0.0,4.4), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test isstrictsubset_interval(Interval(bareinterval(-1.0,-1.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.def)) == false

    @test isstrictsubset_interval(Interval(bareinterval(2.0,2.0), IntervalArithmetic.def), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.trv)) == false

end

@testset "minimal_strictly_less_test" begin

    @test isstrictless(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test isstrictless(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) == false

    @test isstrictless(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) == false

    @test isstrictless(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == true

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test isstrictless(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) == false

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) == false

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) == true

    @test isstrictless(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) == true

    @test isstrictless(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) == false

    @test isstrictless(bareinterval(0.0,4.0), bareinterval(0.0,4.0)) == false

    @test isstrictless(bareinterval(-0.0,4.0), bareinterval(0.0,4.0)) == false

    @test isstrictless(bareinterval(-2.0,-1.0), bareinterval(-2.0,-1.0)) == false

    @test isstrictless(bareinterval(-3.0,-1.5), bareinterval(-2.0,-1.0)) == true

end

@testset "minimal_strictly_less_dec_test" begin

    @test isstrictless(nai(), nai()) == false

    @test isstrictless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), nai()) == false

    @test isstrictless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), nai()) == false

    @test isstrictless(nai(), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) == false

    @test isstrictless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isstrictless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test isstrictless(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) == false

    @test isstrictless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == true

    @test isstrictless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isstrictless(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isstrictless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test isstrictless(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictless(Interval(bareinterval(1.0,3.5), IntervalArithmetic.def), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test isstrictless(Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == false

    @test isstrictless(Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,4.0), IntervalArithmetic.def)) == false

    @test isstrictless(Interval(bareinterval(-0.0,4.0), IntervalArithmetic.def), Interval(bareinterval(0.0,4.0), IntervalArithmetic.trv)) == false

    @test isstrictless(Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.def), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.def)) == false

    @test isstrictless(Interval(bareinterval(-3.0,-1.5), IntervalArithmetic.trv), Interval(bareinterval(-2.0,-1.0), IntervalArithmetic.trv)) == true

end

@testset "minimal_strictly_precedes_test" begin

    @test strictprecedes(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) == true

    @test strictprecedes(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) == true

    @test strictprecedes(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test strictprecedes(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) == false

    @test strictprecedes(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) == false

    @test strictprecedes(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == false

    @test strictprecedes(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) == true

    @test strictprecedes(bareinterval(1.0,3.0), bareinterval(3.0,4.0)) == false

    @test strictprecedes(bareinterval(-3.0,-1.0), bareinterval(-1.0,0.0)) == false

    @test strictprecedes(bareinterval(-3.0,-0.0), bareinterval(0.0,1.0)) == false

    @test strictprecedes(bareinterval(-3.0,0.0), bareinterval(-0.0,1.0)) == false

    @test strictprecedes(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) == false

    @test strictprecedes(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) == false

    @test strictprecedes(bareinterval(-3.0,-0.1), bareinterval(-1.0,0.0)) == false

end

@testset "minimal_strictly_precedes_dec_test" begin

    @test strictprecedes(nai(), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(3.0,4.0), IntervalArithmetic.def), nai()) == false

    @test strictprecedes(nai(), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == false

    @test strictprecedes(nai(), nai()) == false

    @test strictprecedes(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test strictprecedes(Interval(bareinterval(3.0,4.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test strictprecedes(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test strictprecedes(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == true

    @test strictprecedes(Interval(bareinterval(1.0,3.0), IntervalArithmetic.def), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(-3.0,-1.0), IntervalArithmetic.trv), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.def)) == false

    @test strictprecedes(Interval(bareinterval(-3.0,-0.0), IntervalArithmetic.def), Interval(bareinterval(0.0,1.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(-3.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,1.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(1.0,3.5), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv)) == false

    @test strictprecedes(Interval(bareinterval(1.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == false

    @test strictprecedes(Interval(bareinterval(-3.0,-0.1), IntervalArithmetic.trv), Interval(bareinterval(-1.0,0.0), IntervalArithmetic.trv)) == false

end

@testset "minimal_disjoint_test" begin

    @test isdisjoint_interval(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) == true

    @test isdisjoint_interval(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) == true

    @test isdisjoint_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) == true

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(1.0,2.0)) == true

    @test isdisjoint_interval(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) == false

    @test isdisjoint_interval(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) == false

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(1.0,7.0)) == false

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(-Inf,+Inf)) == false

    @test isdisjoint_interval(bareinterval(-Inf,+Inf), bareinterval(1.0,7.0)) == false

    @test isdisjoint_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) == false

end

@testset "minimal_disjoint_dec_test" begin

    @test isdisjoint_interval(nai(), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == false

    @test isdisjoint_interval(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), nai()) == false

    @test isdisjoint_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), nai()) == false

    @test isdisjoint_interval(nai(), nai()) == false

    @test isdisjoint_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) == true

    @test isdisjoint_interval(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isdisjoint_interval(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) == true

    @test isdisjoint_interval(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) == true

    @test isdisjoint_interval(Interval(bareinterval(0.0,0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,-0.0), IntervalArithmetic.trv)) == false

    @test isdisjoint_interval(Interval(bareinterval(0.0,-0.0), IntervalArithmetic.trv), Interval(bareinterval(-0.0,0.0), IntervalArithmetic.trv)) == false

    @test isdisjoint_interval(Interval(bareinterval(3.0,4.0), IntervalArithmetic.def), Interval(bareinterval(1.0,7.0), IntervalArithmetic.def)) == false

    @test isdisjoint_interval(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

    @test isdisjoint_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(1.0,7.0), IntervalArithmetic.trv)) == false

    @test isdisjoint_interval(Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv), Interval(bareinterval(-Inf,+Inf), IntervalArithmetic.trv)) == false

end
