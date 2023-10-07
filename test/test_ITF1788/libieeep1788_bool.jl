@testset "minimal_is_empty_test" begin

    @test isempty_interval(emptyinterval()) == true

    @test isempty_interval(interval(-Inf,+Inf)) == false

    @test isempty_interval(interval(1.0,2.0)) == false

    @test isempty_interval(interval(-1.0,2.0)) == false

    @test isempty_interval(interval(-3.0,-2.0)) == false

    @test isempty_interval(interval(-Inf,2.0)) == false

    @test isempty_interval(interval(-Inf,0.0)) == false

    @test isempty_interval(interval(-Inf,-0.0)) == false

    @test isempty_interval(interval(0.0,Inf)) == false

    @test isempty_interval(interval(-0.0,Inf)) == false

    @test isempty_interval(interval(-0.0,0.0)) == false

    @test isempty_interval(interval(0.0,-0.0)) == false

    @test isempty_interval(interval(0.0,0.0)) == false

    @test isempty_interval(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_empty_dec_test" begin

    @test isempty_interval(nai()) == false

    @test isempty_interval(DecoratedInterval(emptyinterval(), trv)) == true

    @test isempty_interval(DecoratedInterval(interval(-Inf,+Inf), def)) == false

    @test isempty_interval(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isempty_interval(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isempty_interval(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isempty_interval(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isempty_interval(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isempty_interval(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

end

@testset "minimal_is_entire_test" begin

    @test isentire_interval(emptyinterval()) == false

    @test isentire_interval(interval(-Inf,+Inf)) == true

    @test isentire_interval(interval(1.0,2.0)) == false

    @test isentire_interval(interval(-1.0,2.0)) == false

    @test isentire_interval(interval(-3.0,-2.0)) == false

    @test isentire_interval(interval(-Inf,2.0)) == false

    @test isentire_interval(interval(-Inf,0.0)) == false

    @test isentire_interval(interval(-Inf,-0.0)) == false

    @test isentire_interval(interval(0.0,Inf)) == false

    @test isentire_interval(interval(-0.0,Inf)) == false

    @test isentire_interval(interval(-0.0,0.0)) == false

    @test isentire_interval(interval(0.0,-0.0)) == false

    @test isentire_interval(interval(0.0,0.0)) == false

    @test isentire_interval(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_entire_dec_test" begin

    @test isentire_interval(nai()) == false

    @test isentire_interval(DecoratedInterval(emptyinterval(), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isentire_interval(DecoratedInterval(interval(-Inf,+Inf), def)) == true

    @test isentire_interval(DecoratedInterval(interval(-Inf,+Inf), dac)) == true

    @test isentire_interval(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isentire_interval(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isentire_interval(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isentire_interval(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isentire_interval(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isentire_interval(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

end

@testset "minimal_is_nai_dec_test" begin

    @test isnai(nai()) == true

    @test isnai(DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isnai(DecoratedInterval(interval(-Inf,+Inf), def)) == false

    @test isnai(DecoratedInterval(interval(-Inf,+Inf), dac)) == false

    @test isnai(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isnai(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isnai(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isnai(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isnai(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isnai(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isnai(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isnai(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isnai(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isnai(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isnai(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isnai(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

end

@testset "minimal_equal_test" begin

    @test isequal_interval(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test isequal_interval(interval(1.0,2.1), interval(1.0,2.0)) == false

    @test isequal_interval(emptyinterval(), emptyinterval()) == true

    @test isequal_interval(emptyinterval(), interval(1.0,2.0)) == false

    @test isequal_interval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isequal_interval(interval(1.0,2.4), interval(-Inf,+Inf)) == false

    @test isequal_interval(interval(1.0,Inf), interval(1.0,Inf)) == true

    @test isequal_interval(interval(1.0,2.4), interval(1.0,Inf)) == false

    @test isequal_interval(interval(-Inf,2.0), interval(-Inf,2.0)) == true

    @test isequal_interval(interval(-Inf,2.4), interval(-Inf,2.0)) == false

    @test isequal_interval(interval(-2.0,0.0), interval(-2.0,0.0)) == true

    @test isequal_interval(interval(-0.0,2.0), interval(0.0,2.0)) == true

    @test isequal_interval(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test isequal_interval(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test isequal_interval(interval(0.0,-0.0), interval(0.0,0.0)) == true

end

@testset "minimal_equal_dec_test" begin

    @test isequal_interval(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(1.0,2.1), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequal_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isequal_interval(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isequal_interval(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isequal_interval(nai(), nai()) == false

    @test isequal_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequal_interval(nai(), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequal_interval(DecoratedInterval(interval(-Inf,+Inf), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(1.0,2.4), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isequal_interval(DecoratedInterval(interval(1.0,Inf), trv), DecoratedInterval(interval(1.0,Inf), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(1.0,2.4), def), DecoratedInterval(interval(1.0,Inf), trv)) == false

    @test isequal_interval(DecoratedInterval(interval(-Inf,2.0), trv), DecoratedInterval(interval(-Inf,2.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(-Inf,2.4), def), DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isequal_interval(DecoratedInterval(interval(-2.0,0.0), trv), DecoratedInterval(interval(-2.0,0.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(-0.0,2.0), def), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isequal_interval(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

end

@testset "minimal_subset_test" begin

    @test issubset_interval(emptyinterval(), emptyinterval()) == true

    @test issubset_interval(emptyinterval(), interval(0.0,4.0)) == true

    @test issubset_interval(emptyinterval(), interval(-0.0,4.0)) == true

    @test issubset_interval(emptyinterval(), interval(-0.1,1.0)) == true

    @test issubset_interval(emptyinterval(), interval(-0.1,0.0)) == true

    @test issubset_interval(emptyinterval(), interval(-0.1,-0.0)) == true

    @test issubset_interval(emptyinterval(), interval(-Inf,+Inf)) == true

    @test issubset_interval(interval(0.0,4.0), emptyinterval()) == false

    @test issubset_interval(interval(-0.0,4.0), emptyinterval()) == false

    @test issubset_interval(interval(-0.1,1.0), emptyinterval()) == false

    @test issubset_interval(interval(-Inf,+Inf), emptyinterval()) == false

    @test issubset_interval(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test issubset_interval(interval(-0.0,4.0), interval(-Inf,+Inf)) == true

    @test issubset_interval(interval(-0.1,1.0), interval(-Inf,+Inf)) == true

    @test issubset_interval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test issubset_interval(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test issubset_interval(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test issubset_interval(interval(1.0,2.0), interval(-0.0,4.0)) == true

    @test issubset_interval(interval(0.1,0.2), interval(0.0,4.0)) == true

    @test issubset_interval(interval(0.1,0.2), interval(-0.0,4.0)) == true

    @test issubset_interval(interval(-0.1,-0.1), interval(-4.0, 3.4)) == true

    @test issubset_interval(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test issubset_interval(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test issubset_interval(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test issubset_interval(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test issubset_interval(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test issubset_interval(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_subset_dec_test" begin

    @test issubset_interval(nai(), nai()) == false

    @test issubset_interval(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset_interval(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,1.0), trv)) == true

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,-0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset_interval(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset_interval(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset_interval(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset_interval(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.1,-0.1), trv), DecoratedInterval(interval(-4.0, 3.4), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test issubset_interval(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_less_test" begin

    @test isweakless(emptyinterval(), emptyinterval()) == true

    @test isweakless(interval(1.0,2.0), emptyinterval()) == false

    @test isweakless(emptyinterval(), interval(1.0,2.0)) == false

    @test isweakless(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isweakless(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test isweakless(interval(0.0,2.0), interval(-Inf,+Inf)) == false

    @test isweakless(interval(-0.0,2.0), interval(-Inf,+Inf)) == false

    @test isweakless(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test isweakless(interval(-Inf,+Inf), interval(0.0,2.0)) == false

    @test isweakless(interval(-Inf,+Inf), interval(-0.0,2.0)) == false

    @test isweakless(interval(0.0,2.0), interval(0.0,2.0)) == true

    @test isweakless(interval(0.0,2.0), interval(-0.0,2.0)) == true

    @test isweakless(interval(0.0,2.0), interval(1.0,2.0)) == true

    @test isweakless(interval(-0.0,2.0), interval(1.0,2.0)) == true

    @test isweakless(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test isweakless(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test isweakless(interval(1.0,3.5), interval(3.0,4.0)) == true

    @test isweakless(interval(1.0,4.0), interval(3.0,4.0)) == true

    @test isweakless(interval(-2.0,-1.0), interval(-2.0,-1.0)) == true

    @test isweakless(interval(-3.0,-1.5), interval(-2.0,-1.0)) == true

    @test isweakless(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test isweakless(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test isweakless(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test isweakless(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test isweakless(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test isweakless(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_less_dec_test" begin

    @test isweakless(nai(), nai()) == false

    @test isweakless(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isweakless(DecoratedInterval(interval(1.0,2.0), trv), nai()) == false

    @test isweakless(nai(), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test isweakless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isweakless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isweakless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakless(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweakless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweakless(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweakless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isweakless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,2.0), def)) == false

    @test isweakless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == false

    @test isweakless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test isweakless(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test isweakless(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(-2.0,-1.0), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(-3.0,-1.5), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test isweakless(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweakless(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_precedes_test" begin

    @test precedes(emptyinterval(), interval(3.0,4.0)) == true

    @test precedes(interval(3.0,4.0), emptyinterval()) == true

    @test precedes(emptyinterval(), emptyinterval()) == true

    @test precedes(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test precedes(interval(0.0,2.0), interval(-Inf,+Inf)) == false

    @test precedes(interval(-0.0,2.0), interval(-Inf,+Inf)) == false

    @test precedes(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test precedes(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

    @test precedes(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test precedes(interval(1.0,3.0), interval(3.0,4.0)) == true

    @test precedes(interval(-3.0, -1.0), interval(-1.0,0.0)) == true

    @test precedes(interval(-3.0, -1.0), interval(-1.0,-0.0)) == true

    @test precedes(interval(1.0,3.5), interval(3.0,4.0)) == false

    @test precedes(interval(1.0,4.0), interval(3.0,4.0)) == false

    @test precedes(interval(-3.0, -0.1), interval(-1.0,0.0)) == false

    @test precedes(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test precedes(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test precedes(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test precedes(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test precedes(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test precedes(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_precedes_dec_test" begin

    @test precedes(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test precedes(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test precedes(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test precedes(nai(), nai()) == false

    @test precedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test precedes(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test precedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test precedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test precedes(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test precedes(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test precedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test precedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test precedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test precedes(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test precedes(DecoratedInterval(interval(-3.0, -1.0), def), DecoratedInterval(interval(-1.0,0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(-3.0, -1.0), trv), DecoratedInterval(interval(-1.0,-0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test precedes(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test precedes(DecoratedInterval(interval(-3.0, -0.1), trv), DecoratedInterval(interval(-1.0,0.0), trv)) == false

    @test precedes(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test precedes(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test precedes(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_interior_test" begin

    @test isstrictsubset_interval(emptyinterval(), emptyinterval()) == true

    @test isstrictsubset_interval(emptyinterval(), interval(0.0,4.0)) == true

    @test isstrictsubset_interval(interval(0.0,4.0), emptyinterval()) == false

    @test isstrictsubset_interval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(emptyinterval(), interval(-Inf,+Inf)) == true

    @test isstrictsubset_interval(interval(-Inf,+Inf), interval(0.0,4.0)) == false

    @test isstrictsubset_interval(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test isstrictsubset_interval(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test isstrictsubset_interval(interval(-2.0,2.0), interval(-2.0,4.0)) == false

    @test isstrictsubset_interval(interval(-0.0,-0.0), interval(-2.0,4.0)) == true

    @test isstrictsubset_interval(interval(0.0,0.0), interval(-2.0,4.0)) == true

    @test isstrictsubset_interval(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isstrictsubset_interval(interval(0.0,4.4), interval(0.0,4.0)) == false

    @test isstrictsubset_interval(interval(-1.0,-1.0), interval(0.0,4.0)) == false

    @test isstrictsubset_interval(interval(2.0,2.0), interval(-2.0,-1.0)) == false

end

@testset "minimal_interior_dec_test" begin

    @test isstrictsubset_interval(nai(), nai()) == false

    @test isstrictsubset_interval(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isstrictsubset_interval(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,4.0), def), nai()) == false

    @test isstrictsubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(-2.0,2.0), trv), DecoratedInterval(interval(-2.0,4.0), def)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(0.0,4.4), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(-1.0,-1.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test isstrictsubset_interval(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(-2.0,-1.0), trv)) == false

end

@testset "minimal_strictly_less_test" begin

    @test isstrictless(emptyinterval(), emptyinterval()) == true

    @test isstrictless(interval(1.0,2.0), emptyinterval()) == false

    @test isstrictless(emptyinterval(), interval(1.0,2.0)) == false

    @test isstrictless(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isstrictless(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test isstrictless(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test isstrictless(interval(1.0,2.0), interval(1.0,2.0)) == false

    @test isstrictless(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test isstrictless(interval(1.0,3.5), interval(3.0,4.0)) == true

    @test isstrictless(interval(1.0,4.0), interval(3.0,4.0)) == false

    @test isstrictless(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test isstrictless(interval(-0.0,4.0), interval(0.0,4.0)) == false

    @test isstrictless(interval(-2.0,-1.0), interval(-2.0,-1.0)) == false

    @test isstrictless(interval(-3.0,-1.5), interval(-2.0,-1.0)) == true

end

@testset "minimal_strictly_less_dec_test" begin

    @test isstrictless(nai(), nai()) == false

    @test isstrictless(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isstrictless(DecoratedInterval(interval(1.0,2.0), trv), nai()) == false

    @test isstrictless(nai(), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test isstrictless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isstrictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isstrictless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test isstrictless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isstrictless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isstrictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isstrictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isstrictless(DecoratedInterval(interval(1.0,3.5), def), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isstrictless(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test isstrictless(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test isstrictless(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictless(DecoratedInterval(interval(-2.0,-1.0), def), DecoratedInterval(interval(-2.0,-1.0), def)) == false

    @test isstrictless(DecoratedInterval(interval(-3.0,-1.5), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

end

@testset "minimal_strictly_precedes_test" begin

    @test strictprecedes(emptyinterval(), interval(3.0,4.0)) == true

    @test strictprecedes(interval(3.0,4.0), emptyinterval()) == true

    @test strictprecedes(emptyinterval(), emptyinterval()) == true

    @test strictprecedes(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test strictprecedes(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test strictprecedes(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

    @test strictprecedes(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test strictprecedes(interval(1.0,3.0), interval(3.0,4.0)) == false

    @test strictprecedes(interval(-3.0,-1.0), interval(-1.0,0.0)) == false

    @test strictprecedes(interval(-3.0,-0.0), interval(0.0,1.0)) == false

    @test strictprecedes(interval(-3.0,0.0), interval(-0.0,1.0)) == false

    @test strictprecedes(interval(1.0,3.5), interval(3.0,4.0)) == false

    @test strictprecedes(interval(1.0,4.0), interval(3.0,4.0)) == false

    @test strictprecedes(interval(-3.0,-0.1), interval(-1.0,0.0)) == false

end

@testset "minimal_strictly_precedes_dec_test" begin

    @test strictprecedes(nai(), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(3.0,4.0), def), nai()) == false

    @test strictprecedes(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test strictprecedes(nai(), nai()) == false

    @test strictprecedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test strictprecedes(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == true

    @test strictprecedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test strictprecedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test strictprecedes(DecoratedInterval(interval(1.0,3.0), def), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(-3.0,-1.0), trv), DecoratedInterval(interval(-1.0,0.0), def)) == false

    @test strictprecedes(DecoratedInterval(interval(-3.0,-0.0), def), DecoratedInterval(interval(0.0,1.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(-3.0,0.0), trv), DecoratedInterval(interval(-0.0,1.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test strictprecedes(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test strictprecedes(DecoratedInterval(interval(-3.0,-0.1), trv), DecoratedInterval(interval(-1.0,0.0), trv)) == false

end

@testset "minimal_disjoint_test" begin

    @test isdisjoint_interval(emptyinterval(), interval(3.0,4.0)) == true

    @test isdisjoint_interval(interval(3.0,4.0), emptyinterval()) == true

    @test isdisjoint_interval(emptyinterval(), emptyinterval()) == true

    @test isdisjoint_interval(interval(3.0,4.0), interval(1.0,2.0)) == true

    @test isdisjoint_interval(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isdisjoint_interval(interval(0.0,-0.0), interval(-0.0,0.0)) == false

    @test isdisjoint_interval(interval(3.0,4.0), interval(1.0,7.0)) == false

    @test isdisjoint_interval(interval(3.0,4.0), interval(-Inf,+Inf)) == false

    @test isdisjoint_interval(interval(-Inf,+Inf), interval(1.0,7.0)) == false

    @test isdisjoint_interval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

end

@testset "minimal_disjoint_dec_test" begin

    @test isdisjoint_interval(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test isdisjoint_interval(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isdisjoint_interval(nai(), nai()) == false

    @test isdisjoint_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test isdisjoint_interval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjoint_interval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjoint_interval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test isdisjoint_interval(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,7.0), def)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,7.0), trv)) == false

    @test isdisjoint_interval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

end
