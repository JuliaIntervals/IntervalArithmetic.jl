@testset "minimal_is_empty_test" begin

    @test isempty_interval(emptyinterval(BareInterval{Float64})) === true

    @test isempty_interval(bareinterval(-Inf,+Inf)) === false

    @test isempty_interval(bareinterval(1.0,2.0)) === false

    @test isempty_interval(bareinterval(-1.0,2.0)) === false

    @test isempty_interval(bareinterval(-3.0,-2.0)) === false

    @test isempty_interval(bareinterval(-Inf,2.0)) === false

    @test isempty_interval(bareinterval(-Inf,0.0)) === false

    @test isempty_interval(bareinterval(-Inf,-0.0)) === false

    @test isempty_interval(bareinterval(0.0,Inf)) === false

    @test isempty_interval(bareinterval(-0.0,Inf)) === false

    @test isempty_interval(bareinterval(-0.0,0.0)) === false

    @test isempty_interval(bareinterval(0.0,-0.0)) === false

    @test isempty_interval(bareinterval(0.0,0.0)) === false

    @test isempty_interval(bareinterval(-0.0,-0.0)) === false

end

@testset "minimal_is_empty_dec_test" begin

    @test isempty_interval(nai(Interval{Float64})) === false

    @test isempty_interval(interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isempty_interval(interval(bareinterval(-Inf,+Inf), def)) === false

    @test isempty_interval(interval(bareinterval(1.0,2.0), com)) === false

    @test isempty_interval(interval(bareinterval(-1.0,2.0), trv)) === false

    @test isempty_interval(interval(bareinterval(-3.0,-2.0), dac)) === false

    @test isempty_interval(interval(bareinterval(-Inf,2.0), trv)) === false

    @test isempty_interval(interval(bareinterval(-Inf,0.0), trv)) === false

    @test isempty_interval(interval(bareinterval(-Inf,-0.0), trv)) === false

    @test isempty_interval(interval(bareinterval(0.0,Inf), def)) === false

    @test isempty_interval(interval(bareinterval(-0.0,Inf), trv)) === false

    @test isempty_interval(interval(bareinterval(-0.0,0.0), com)) === false

    @test isempty_interval(interval(bareinterval(0.0,-0.0), trv)) === false

    @test isempty_interval(interval(bareinterval(0.0,0.0), trv)) === false

    @test isempty_interval(interval(bareinterval(-0.0,-0.0), trv)) === false

end

@testset "minimal_is_entire_test" begin

    @test isentire_interval(emptyinterval(BareInterval{Float64})) === false

    @test isentire_interval(bareinterval(-Inf,+Inf)) === true

    @test isentire_interval(bareinterval(1.0,2.0)) === false

    @test isentire_interval(bareinterval(-1.0,2.0)) === false

    @test isentire_interval(bareinterval(-3.0,-2.0)) === false

    @test isentire_interval(bareinterval(-Inf,2.0)) === false

    @test isentire_interval(bareinterval(-Inf,0.0)) === false

    @test isentire_interval(bareinterval(-Inf,-0.0)) === false

    @test isentire_interval(bareinterval(0.0,Inf)) === false

    @test isentire_interval(bareinterval(-0.0,Inf)) === false

    @test isentire_interval(bareinterval(-0.0,0.0)) === false

    @test isentire_interval(bareinterval(0.0,-0.0)) === false

    @test isentire_interval(bareinterval(0.0,0.0)) === false

    @test isentire_interval(bareinterval(-0.0,-0.0)) === false

end

@testset "minimal_is_entire_dec_test" begin

    @test isentire_interval(nai(Interval{Float64})) === false

    @test isentire_interval(interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isentire_interval(interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isentire_interval(interval(bareinterval(-Inf,+Inf), def)) === true

    @test isentire_interval(interval(bareinterval(-Inf,+Inf), dac)) === true

    @test isentire_interval(interval(bareinterval(1.0,2.0), com)) === false

    @test isentire_interval(interval(bareinterval(-1.0,2.0), trv)) === false

    @test isentire_interval(interval(bareinterval(-3.0,-2.0), dac)) === false

    @test isentire_interval(interval(bareinterval(-Inf,2.0), trv)) === false

    @test isentire_interval(interval(bareinterval(-Inf,0.0), trv)) === false

    @test isentire_interval(interval(bareinterval(-Inf,-0.0), trv)) === false

    @test isentire_interval(interval(bareinterval(0.0,Inf), def)) === false

    @test isentire_interval(interval(bareinterval(-0.0,Inf), trv)) === false

    @test isentire_interval(interval(bareinterval(-0.0,0.0), com)) === false

    @test isentire_interval(interval(bareinterval(0.0,-0.0), trv)) === false

    @test isentire_interval(interval(bareinterval(0.0,0.0), trv)) === false

    @test isentire_interval(interval(bareinterval(-0.0,-0.0), trv)) === false

end

@testset "minimal_is_nai_dec_test" begin

    @test isnai(nai(Interval{Float64})) === true

    @test isnai(interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isnai(interval(bareinterval(-Inf,+Inf), def)) === false

    @test isnai(interval(bareinterval(-Inf,+Inf), dac)) === false

    @test isnai(interval(bareinterval(1.0,2.0), com)) === false

    @test isnai(interval(bareinterval(-1.0,2.0), trv)) === false

    @test isnai(interval(bareinterval(-3.0,-2.0), dac)) === false

    @test isnai(interval(bareinterval(-Inf,2.0), trv)) === false

    @test isnai(interval(bareinterval(-Inf,0.0), trv)) === false

    @test isnai(interval(bareinterval(-Inf,-0.0), trv)) === false

    @test isnai(interval(bareinterval(0.0,Inf), def)) === false

    @test isnai(interval(bareinterval(-0.0,Inf), trv)) === false

    @test isnai(interval(bareinterval(-0.0,0.0), com)) === false

    @test isnai(interval(bareinterval(0.0,-0.0), trv)) === false

    @test isnai(interval(bareinterval(0.0,0.0), trv)) === false

    @test isnai(interval(bareinterval(-0.0,-0.0), trv)) === false

end

@testset "minimal_equal_test" begin

    @test isequal_interval(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === true

    @test isequal_interval(bareinterval(1.0,2.1), bareinterval(1.0,2.0)) === false

    @test isequal_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test isequal_interval(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === false

    @test isequal_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === true

    @test isequal_interval(bareinterval(1.0,2.4), bareinterval(-Inf,+Inf)) === false

    @test isequal_interval(bareinterval(1.0,Inf), bareinterval(1.0,Inf)) === true

    @test isequal_interval(bareinterval(1.0,2.4), bareinterval(1.0,Inf)) === false

    @test isequal_interval(bareinterval(-Inf,2.0), bareinterval(-Inf,2.0)) === true

    @test isequal_interval(bareinterval(-Inf,2.4), bareinterval(-Inf,2.0)) === false

    @test isequal_interval(bareinterval(-2.0,0.0), bareinterval(-2.0,0.0)) === true

    @test isequal_interval(bareinterval(-0.0,2.0), bareinterval(0.0,2.0)) === true

    @test isequal_interval(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test isequal_interval(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) === true

    @test isequal_interval(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) === true

end

@testset "minimal_equal_dec_test" begin

    @test isequal_interval(interval(bareinterval(1.0,2.0), def), interval(bareinterval(1.0,2.0), trv)) === true

    @test isequal_interval(interval(bareinterval(1.0,2.1), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isequal_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isequal_interval(interval(emptyinterval(BareInterval{Float64}), trv), nai(Interval{Float64})) === false

    @test isequal_interval(nai(Interval{Float64}), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isequal_interval(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test isequal_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isequal_interval(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), trv)) === false

    @test isequal_interval(interval(bareinterval(-Inf,+Inf), def), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isequal_interval(interval(bareinterval(1.0,2.4), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isequal_interval(interval(bareinterval(1.0,Inf), trv), interval(bareinterval(1.0,Inf), trv)) === true

    @test isequal_interval(interval(bareinterval(1.0,2.4), def), interval(bareinterval(1.0,Inf), trv)) === false

    @test isequal_interval(interval(bareinterval(-Inf,2.0), trv), interval(bareinterval(-Inf,2.0), trv)) === true

    @test isequal_interval(interval(bareinterval(-Inf,2.4), def), interval(bareinterval(-Inf,2.0), trv)) === false

    @test isequal_interval(interval(bareinterval(-2.0,0.0), trv), interval(bareinterval(-2.0,0.0), trv)) === true

    @test isequal_interval(interval(bareinterval(-0.0,2.0), def), interval(bareinterval(0.0,2.0), trv)) === true

    @test isequal_interval(interval(bareinterval(-0.0,-0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

    @test isequal_interval(interval(bareinterval(-0.0,0.0), def), interval(bareinterval(0.0,0.0), trv)) === true

    @test isequal_interval(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

end

@testset "minimal_subset_test" begin

    @test issubset_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(0.0,4.0)) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.0,4.0)) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,1.0)) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,0.0)) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-0.1,-0.0)) === true

    @test issubset_interval(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,+Inf)) === true

    @test issubset_interval(bareinterval(0.0,4.0), emptyinterval(BareInterval{Float64})) === false

    @test issubset_interval(bareinterval(-0.0,4.0), emptyinterval(BareInterval{Float64})) === false

    @test issubset_interval(bareinterval(-0.1,1.0), emptyinterval(BareInterval{Float64})) === false

    @test issubset_interval(bareinterval(-Inf,+Inf), emptyinterval(BareInterval{Float64})) === false

    @test issubset_interval(bareinterval(0.0,4.0), bareinterval(-Inf,+Inf)) === true

    @test issubset_interval(bareinterval(-0.0,4.0), bareinterval(-Inf,+Inf)) === true

    @test issubset_interval(bareinterval(-0.1,1.0), bareinterval(-Inf,+Inf)) === true

    @test issubset_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(0.0,4.0)) === true

    @test issubset_interval(bareinterval(1.0,2.0), bareinterval(-0.0,4.0)) === true

    @test issubset_interval(bareinterval(0.1,0.2), bareinterval(0.0,4.0)) === true

    @test issubset_interval(bareinterval(0.1,0.2), bareinterval(-0.0,4.0)) === true

    @test issubset_interval(bareinterval(-0.1,-0.1), bareinterval(-4.0, 3.4)) === true

    @test issubset_interval(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === true

    @test issubset_interval(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test issubset_interval(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) === true

    @test issubset_interval(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) === true

    @test issubset_interval(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test issubset_interval(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) === true

end

@testset "minimal_subset_dec_test" begin

    @test issubset_interval(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test issubset_interval(nai(Interval{Float64}), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test issubset_interval(nai(Interval{Float64}), interval(bareinterval(0.0,4.0), trv)) === false

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0,4.0), trv)) === true

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.0,4.0), def)) === true

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.1,1.0), trv)) === true

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.1,0.0), trv)) === true

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-0.1,-0.0), trv)) === true

    @test issubset_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test issubset_interval(interval(bareinterval(0.0,4.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test issubset_interval(interval(bareinterval(-0.0,4.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test issubset_interval(interval(bareinterval(-0.1,1.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test issubset_interval(interval(bareinterval(-Inf,+Inf), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test issubset_interval(interval(bareinterval(0.0,4.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test issubset_interval(interval(bareinterval(-0.0,4.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test issubset_interval(interval(bareinterval(-0.1,1.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test issubset_interval(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test issubset_interval(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(1.0,2.0), trv)) === true

    @test issubset_interval(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(0.0,4.0), trv)) === true

    @test issubset_interval(interval(bareinterval(1.0,2.0), def), interval(bareinterval(-0.0,4.0), def)) === true

    @test issubset_interval(interval(bareinterval(0.1,0.2), trv), interval(bareinterval(0.0,4.0), trv)) === true

    @test issubset_interval(interval(bareinterval(0.1,0.2), trv), interval(bareinterval(-0.0,4.0), def)) === true

    @test issubset_interval(interval(bareinterval(-0.1,-0.1), trv), interval(bareinterval(-4.0, 3.4), trv)) === true

    @test issubset_interval(interval(bareinterval(0.0,0.0), trv), interval(bareinterval(-0.0,-0.0), trv)) === true

    @test issubset_interval(interval(bareinterval(-0.0,-0.0), trv), interval(bareinterval(0.0,0.0), def)) === true

    @test issubset_interval(interval(bareinterval(-0.0,0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

    @test issubset_interval(interval(bareinterval(-0.0,0.0), trv), interval(bareinterval(0.0,-0.0), trv)) === true

    @test issubset_interval(interval(bareinterval(0.0,-0.0), def), interval(bareinterval(0.0,0.0), trv)) === true

    @test issubset_interval(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(-0.0,0.0), trv)) === true

end

@testset "minimal_less_test" begin

    @test isweakless(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test isweakless(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === false

    @test isweakless(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test isweakless(bareinterval(0.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test isweakless(bareinterval(-0.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) === false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(0.0,2.0)) === false

    @test isweakless(bareinterval(-Inf,+Inf), bareinterval(-0.0,2.0)) === false

    @test isweakless(bareinterval(0.0,2.0), bareinterval(0.0,2.0)) === true

    @test isweakless(bareinterval(0.0,2.0), bareinterval(-0.0,2.0)) === true

    @test isweakless(bareinterval(0.0,2.0), bareinterval(1.0,2.0)) === true

    @test isweakless(bareinterval(-0.0,2.0), bareinterval(1.0,2.0)) === true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === true

    @test isweakless(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === true

    @test isweakless(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) === true

    @test isweakless(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) === true

    @test isweakless(bareinterval(-2.0,-1.0), bareinterval(-2.0,-1.0)) === true

    @test isweakless(bareinterval(-3.0,-1.5), bareinterval(-2.0,-1.0)) === true

    @test isweakless(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === true

    @test isweakless(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test isweakless(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) === true

    @test isweakless(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) === true

    @test isweakless(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test isweakless(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) === true

end

@testset "minimal_less_dec_test" begin

    @test isweakless(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test isweakless(interval(emptyinterval(BareInterval{Float64}), trv), nai(Interval{Float64})) === false

    @test isweakless(interval(bareinterval(1.0,2.0), trv), nai(Interval{Float64})) === false

    @test isweakless(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), def)) === false

    @test isweakless(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isweakless(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isweakless(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isweakless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isweakless(interval(bareinterval(1.0,2.0), def), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isweakless(interval(bareinterval(0.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isweakless(interval(bareinterval(-0.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isweakless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isweakless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(0.0,2.0), def)) === false

    @test isweakless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-0.0,2.0), trv)) === false

    @test isweakless(interval(bareinterval(0.0,2.0), trv), interval(bareinterval(0.0,2.0), trv)) === true

    @test isweakless(interval(bareinterval(0.0,2.0), trv), interval(bareinterval(-0.0,2.0), trv)) === true

    @test isweakless(interval(bareinterval(0.0,2.0), def), interval(bareinterval(1.0,2.0), def)) === true

    @test isweakless(interval(bareinterval(-0.0,2.0), trv), interval(bareinterval(1.0,2.0), trv)) === true

    @test isweakless(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(1.0,2.0), trv)) === true

    @test isweakless(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(3.0,4.0), def)) === true

    @test isweakless(interval(bareinterval(1.0,3.5), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test isweakless(interval(bareinterval(1.0,4.0), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test isweakless(interval(bareinterval(-2.0,-1.0), trv), interval(bareinterval(-2.0,-1.0), trv)) === true

    @test isweakless(interval(bareinterval(-3.0,-1.5), trv), interval(bareinterval(-2.0,-1.0), trv)) === true

    @test isweakless(interval(bareinterval(0.0,0.0), trv), interval(bareinterval(-0.0,-0.0), trv)) === true

    @test isweakless(interval(bareinterval(-0.0,-0.0), trv), interval(bareinterval(0.0,0.0), def)) === true

    @test isweakless(interval(bareinterval(-0.0,0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

    @test isweakless(interval(bareinterval(-0.0,0.0), trv), interval(bareinterval(0.0,-0.0), trv)) === true

    @test isweakless(interval(bareinterval(0.0,-0.0), def), interval(bareinterval(0.0,0.0), trv)) === true

    @test isweakless(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(-0.0,0.0), trv)) === true

end

@testset "minimal_precedes_test" begin

    @test precedes(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) === true

    @test precedes(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) === true

    @test precedes(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test precedes(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test precedes(bareinterval(0.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test precedes(bareinterval(-0.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test precedes(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) === false

    @test precedes(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === false

    @test precedes(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === true

    @test precedes(bareinterval(1.0,3.0), bareinterval(3.0,4.0)) === true

    @test precedes(bareinterval(-3.0, -1.0), bareinterval(-1.0,0.0)) === true

    @test precedes(bareinterval(-3.0, -1.0), bareinterval(-1.0,-0.0)) === true

    @test precedes(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) === false

    @test precedes(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) === false

    @test precedes(bareinterval(-3.0, -0.1), bareinterval(-1.0,0.0)) === false

    @test precedes(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === true

    @test precedes(bareinterval(-0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test precedes(bareinterval(-0.0,0.0), bareinterval(0.0,0.0)) === true

    @test precedes(bareinterval(-0.0,0.0), bareinterval(0.0,-0.0)) === true

    @test precedes(bareinterval(0.0,-0.0), bareinterval(0.0,0.0)) === true

    @test precedes(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) === true

end

@testset "minimal_precedes_dec_test" begin

    @test precedes(nai(Interval{Float64}), interval(bareinterval(3.0,4.0), def)) === false

    @test precedes(interval(bareinterval(3.0,4.0), trv), nai(Interval{Float64})) === false

    @test precedes(nai(Interval{Float64}), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test precedes(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test precedes(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(3.0,4.0), def)) === true

    @test precedes(interval(bareinterval(3.0,4.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test precedes(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test precedes(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test precedes(interval(bareinterval(0.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test precedes(interval(bareinterval(-0.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test precedes(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test precedes(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test precedes(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test precedes(interval(bareinterval(1.0,3.0), trv), interval(bareinterval(3.0,4.0), def)) === true

    @test precedes(interval(bareinterval(-3.0, -1.0), def), interval(bareinterval(-1.0,0.0), trv)) === true

    @test precedes(interval(bareinterval(-3.0, -1.0), trv), interval(bareinterval(-1.0,-0.0), trv)) === true

    @test precedes(interval(bareinterval(1.0,3.5), trv), interval(bareinterval(3.0,4.0), trv)) === false

    @test precedes(interval(bareinterval(1.0,4.0), trv), interval(bareinterval(3.0,4.0), trv)) === false

    @test precedes(interval(bareinterval(-3.0, -0.1), trv), interval(bareinterval(-1.0,0.0), trv)) === false

    @test precedes(interval(bareinterval(0.0,0.0), trv), interval(bareinterval(-0.0,-0.0), trv)) === true

    @test precedes(interval(bareinterval(-0.0,-0.0), trv), interval(bareinterval(0.0,0.0), def)) === true

    @test precedes(interval(bareinterval(-0.0,0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

    @test precedes(interval(bareinterval(-0.0,0.0), def), interval(bareinterval(0.0,-0.0), trv)) === true

    @test precedes(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(0.0,0.0), trv)) === true

    @test precedes(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(-0.0,0.0), trv)) === true

end

@testset "minimal_interior_test" begin

    @test isinterior(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test isinterior(emptyinterval(BareInterval{Float64}), bareinterval(0.0,4.0)) === true

    @test isinterior(bareinterval(0.0,4.0), emptyinterval(BareInterval{Float64})) === false

    @test isinterior(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === true

    @test isinterior(bareinterval(0.0,4.0), bareinterval(-Inf,+Inf)) === true

    @test isinterior(emptyinterval(BareInterval{Float64}), bareinterval(-Inf,+Inf)) === true

    @test isinterior(bareinterval(-Inf,+Inf), bareinterval(0.0,4.0)) === false

    @test isinterior(bareinterval(0.0,4.0), bareinterval(0.0,4.0)) === false

    @test isinterior(bareinterval(1.0,2.0), bareinterval(0.0,4.0)) === true

    @test isinterior(bareinterval(-2.0,2.0), bareinterval(-2.0,4.0)) === false

    @test isinterior(bareinterval(-0.0,-0.0), bareinterval(-2.0,4.0)) === true

    @test isinterior(bareinterval(0.0,0.0), bareinterval(-2.0,4.0)) === true

    @test isinterior(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === false

    @test isinterior(bareinterval(0.0,4.4), bareinterval(0.0,4.0)) === false

    @test isinterior(bareinterval(-1.0,-1.0), bareinterval(0.0,4.0)) === false

    @test isinterior(bareinterval(2.0,2.0), bareinterval(-2.0,-1.0)) === false

end

@testset "minimal_interior_dec_test" begin

    @test isinterior(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test isinterior(nai(Interval{Float64}), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isinterior(nai(Interval{Float64}), interval(bareinterval(0.0,4.0), trv)) === false

    @test isinterior(interval(bareinterval(0.0,4.0), def), nai(Interval{Float64})) === false

    @test isinterior(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isinterior(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(0.0,4.0), trv)) === true

    @test isinterior(interval(bareinterval(0.0,4.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isinterior(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isinterior(interval(bareinterval(0.0,4.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isinterior(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isinterior(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(0.0,4.0), trv)) === false

    @test isinterior(interval(bareinterval(0.0,4.0), trv), interval(bareinterval(0.0,4.0), trv)) === false

    @test isinterior(interval(bareinterval(1.0,2.0), def), interval(bareinterval(0.0,4.0), trv)) === true

    @test isinterior(interval(bareinterval(-2.0,2.0), trv), interval(bareinterval(-2.0,4.0), def)) === false

    @test isinterior(interval(bareinterval(-0.0,-0.0), trv), interval(bareinterval(-2.0,4.0), trv)) === true

    @test isinterior(interval(bareinterval(0.0,0.0), def), interval(bareinterval(-2.0,4.0), trv)) === true

    @test isinterior(interval(bareinterval(0.0,0.0), trv), interval(bareinterval(-0.0,-0.0), trv)) === false

    @test isinterior(interval(bareinterval(0.0,4.4), trv), interval(bareinterval(0.0,4.0), trv)) === false

    @test isinterior(interval(bareinterval(-1.0,-1.0), trv), interval(bareinterval(0.0,4.0), def)) === false

    @test isinterior(interval(bareinterval(2.0,2.0), def), interval(bareinterval(-2.0,-1.0), trv)) === false

end

@testset "minimal_strictly_less_test" begin

    @test isstrictless(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test isstrictless(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === false

    @test isstrictless(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === false

    @test isstrictless(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === true

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test isstrictless(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) === false

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === false

    @test isstrictless(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === true

    @test isstrictless(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) === true

    @test isstrictless(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) === false

    @test isstrictless(bareinterval(0.0,4.0), bareinterval(0.0,4.0)) === false

    @test isstrictless(bareinterval(-0.0,4.0), bareinterval(0.0,4.0)) === false

    @test isstrictless(bareinterval(-2.0,-1.0), bareinterval(-2.0,-1.0)) === false

    @test isstrictless(bareinterval(-3.0,-1.5), bareinterval(-2.0,-1.0)) === true

end

@testset "minimal_strictly_less_dec_test" begin

    @test isstrictless(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test isstrictless(interval(emptyinterval(BareInterval{Float64}), trv), nai(Interval{Float64})) === false

    @test isstrictless(interval(bareinterval(1.0,2.0), trv), nai(Interval{Float64})) === false

    @test isstrictless(nai(Interval{Float64}), interval(bareinterval(1.0,2.0), def)) === false

    @test isstrictless(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isstrictless(interval(bareinterval(1.0,2.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test isstrictless(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,2.0), def)) === false

    @test isstrictless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === true

    @test isstrictless(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isstrictless(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isstrictless(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test isstrictless(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test isstrictless(interval(bareinterval(1.0,3.5), def), interval(bareinterval(3.0,4.0), trv)) === true

    @test isstrictless(interval(bareinterval(1.0,4.0), trv), interval(bareinterval(3.0,4.0), def)) === false

    @test isstrictless(interval(bareinterval(0.0,4.0), trv), interval(bareinterval(0.0,4.0), def)) === false

    @test isstrictless(interval(bareinterval(-0.0,4.0), def), interval(bareinterval(0.0,4.0), trv)) === false

    @test isstrictless(interval(bareinterval(-2.0,-1.0), def), interval(bareinterval(-2.0,-1.0), def)) === false

    @test isstrictless(interval(bareinterval(-3.0,-1.5), trv), interval(bareinterval(-2.0,-1.0), trv)) === true

end

@testset "minimal_strictly_precedes_test" begin

    @test strictprecedes(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) === true

    @test strictprecedes(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) === true

    @test strictprecedes(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test strictprecedes(bareinterval(1.0,2.0), bareinterval(-Inf,+Inf)) === false

    @test strictprecedes(bareinterval(-Inf,+Inf), bareinterval(1.0,2.0)) === false

    @test strictprecedes(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === false

    @test strictprecedes(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === true

    @test strictprecedes(bareinterval(1.0,3.0), bareinterval(3.0,4.0)) === false

    @test strictprecedes(bareinterval(-3.0,-1.0), bareinterval(-1.0,0.0)) === false

    @test strictprecedes(bareinterval(-3.0,-0.0), bareinterval(0.0,1.0)) === false

    @test strictprecedes(bareinterval(-3.0,0.0), bareinterval(-0.0,1.0)) === false

    @test strictprecedes(bareinterval(1.0,3.5), bareinterval(3.0,4.0)) === false

    @test strictprecedes(bareinterval(1.0,4.0), bareinterval(3.0,4.0)) === false

    @test strictprecedes(bareinterval(-3.0,-0.1), bareinterval(-1.0,0.0)) === false

end

@testset "minimal_strictly_precedes_dec_test" begin

    @test strictprecedes(nai(Interval{Float64}), interval(bareinterval(3.0,4.0), trv)) === false

    @test strictprecedes(interval(bareinterval(3.0,4.0), def), nai(Interval{Float64})) === false

    @test strictprecedes(nai(Interval{Float64}), interval(emptyinterval(BareInterval{Float64}), trv)) === false

    @test strictprecedes(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test strictprecedes(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test strictprecedes(interval(bareinterval(3.0,4.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test strictprecedes(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test strictprecedes(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test strictprecedes(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(1.0,2.0), trv)) === false

    @test strictprecedes(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test strictprecedes(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(3.0,4.0), trv)) === true

    @test strictprecedes(interval(bareinterval(1.0,3.0), def), interval(bareinterval(3.0,4.0), trv)) === false

    @test strictprecedes(interval(bareinterval(-3.0,-1.0), trv), interval(bareinterval(-1.0,0.0), def)) === false

    @test strictprecedes(interval(bareinterval(-3.0,-0.0), def), interval(bareinterval(0.0,1.0), trv)) === false

    @test strictprecedes(interval(bareinterval(-3.0,0.0), trv), interval(bareinterval(-0.0,1.0), trv)) === false

    @test strictprecedes(interval(bareinterval(1.0,3.5), trv), interval(bareinterval(3.0,4.0), trv)) === false

    @test strictprecedes(interval(bareinterval(1.0,4.0), trv), interval(bareinterval(3.0,4.0), def)) === false

    @test strictprecedes(interval(bareinterval(-3.0,-0.1), trv), interval(bareinterval(-1.0,0.0), trv)) === false

end

@testset "minimal_disjoint_test" begin

    @test isdisjoint_interval(emptyinterval(BareInterval{Float64}), bareinterval(3.0,4.0)) === true

    @test isdisjoint_interval(bareinterval(3.0,4.0), emptyinterval(BareInterval{Float64})) === true

    @test isdisjoint_interval(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === true

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(1.0,2.0)) === true

    @test isdisjoint_interval(bareinterval(0.0,0.0), bareinterval(-0.0,-0.0)) === false

    @test isdisjoint_interval(bareinterval(0.0,-0.0), bareinterval(-0.0,0.0)) === false

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(1.0,7.0)) === false

    @test isdisjoint_interval(bareinterval(3.0,4.0), bareinterval(-Inf,+Inf)) === false

    @test isdisjoint_interval(bareinterval(-Inf,+Inf), bareinterval(1.0,7.0)) === false

    @test isdisjoint_interval(bareinterval(-Inf,+Inf), bareinterval(-Inf,+Inf)) === false

end

@testset "minimal_disjoint_dec_test" begin

    @test isdisjoint_interval(nai(Interval{Float64}), interval(bareinterval(3.0,4.0), def)) === false

    @test isdisjoint_interval(interval(bareinterval(3.0,4.0), trv), nai(Interval{Float64})) === false

    @test isdisjoint_interval(interval(emptyinterval(BareInterval{Float64}), trv), nai(Interval{Float64})) === false

    @test isdisjoint_interval(nai(Interval{Float64}), nai(Interval{Float64})) === false

    @test isdisjoint_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(3.0,4.0), def)) === true

    @test isdisjoint_interval(interval(bareinterval(3.0,4.0), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isdisjoint_interval(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === true

    @test isdisjoint_interval(interval(bareinterval(3.0,4.0), trv), interval(bareinterval(1.0,2.0), def)) === true

    @test isdisjoint_interval(interval(bareinterval(0.0,0.0), trv), interval(bareinterval(-0.0,-0.0), trv)) === false

    @test isdisjoint_interval(interval(bareinterval(0.0,-0.0), trv), interval(bareinterval(-0.0,0.0), trv)) === false

    @test isdisjoint_interval(interval(bareinterval(3.0,4.0), def), interval(bareinterval(1.0,7.0), def)) === false

    @test isdisjoint_interval(interval(bareinterval(3.0,4.0), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

    @test isdisjoint_interval(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(1.0,7.0), trv)) === false

    @test isdisjoint_interval(interval(bareinterval(-Inf,+Inf), trv), interval(bareinterval(-Inf,+Inf), trv)) === false

end
