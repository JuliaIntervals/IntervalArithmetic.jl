@testset "minimal_is_empty_test" begin

    @test isempty(emptyinterval()) == true

    @test isempty(interval(-Inf,+Inf)) == false

    @test isempty(interval(1.0,2.0)) == false

    @test isempty(interval(-1.0,2.0)) == false

    @test isempty(interval(-3.0,-2.0)) == false

    @test isempty(interval(-Inf,2.0)) == false

    @test isempty(interval(-Inf,0.0)) == false

    @test isempty(interval(-Inf,-0.0)) == false

    @test isempty(interval(0.0,Inf)) == false

    @test isempty(interval(-0.0,Inf)) == false

    @test isempty(interval(-0.0,0.0)) == false

    @test isempty(interval(0.0,-0.0)) == false

    @test isempty(interval(0.0,0.0)) == false

    @test isempty(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_empty_dec_test" begin

    @test isempty(nai()) == false

    @test isempty(DecoratedInterval(emptyinterval(), trv)) == true

    @test isempty(DecoratedInterval(interval(-Inf,+Inf), def)) == false

    @test isempty(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isempty(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isempty(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isempty(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isempty(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isempty(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isempty(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isempty(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isempty(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isempty(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isempty(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isempty(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

end

@testset "minimal_is_entire_test" begin

    @test isentire(emptyinterval()) == false

    @test isentire(interval(-Inf,+Inf)) == true

    @test isentire(interval(1.0,2.0)) == false

    @test isentire(interval(-1.0,2.0)) == false

    @test isentire(interval(-3.0,-2.0)) == false

    @test isentire(interval(-Inf,2.0)) == false

    @test isentire(interval(-Inf,0.0)) == false

    @test isentire(interval(-Inf,-0.0)) == false

    @test isentire(interval(0.0,Inf)) == false

    @test isentire(interval(-0.0,Inf)) == false

    @test isentire(interval(-0.0,0.0)) == false

    @test isentire(interval(0.0,-0.0)) == false

    @test isentire(interval(0.0,0.0)) == false

    @test isentire(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_entire_dec_test" begin

    @test isentire(nai()) == false

    @test isentire(DecoratedInterval(emptyinterval(), trv)) == false

    @test isentire(DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isentire(DecoratedInterval(interval(-Inf,+Inf), def)) == true

    @test isentire(DecoratedInterval(interval(-Inf,+Inf), dac)) == true

    @test isentire(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isentire(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isentire(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isentire(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isentire(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isentire(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isentire(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isentire(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isentire(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isentire(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isentire(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isentire(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

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

    @test ≛(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test ≛(interval(1.0,2.1), interval(1.0,2.0)) == false

    @test ≛(emptyinterval(), emptyinterval()) == true

    @test ≛(emptyinterval(), interval(1.0,2.0)) == false

    @test ≛(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test ≛(interval(1.0,2.4), interval(-Inf,+Inf)) == false

    @test ≛(interval(1.0,Inf), interval(1.0,Inf)) == true

    @test ≛(interval(1.0,2.4), interval(1.0,Inf)) == false

    @test ≛(interval(-Inf,2.0), interval(-Inf,2.0)) == true

    @test ≛(interval(-Inf,2.4), interval(-Inf,2.0)) == false

    @test ≛(interval(-2.0,0.0), interval(-2.0,0.0)) == true

    @test ≛(interval(-0.0,2.0), interval(0.0,2.0)) == true

    @test ≛(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test ≛(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test ≛(interval(0.0,-0.0), interval(0.0,0.0)) == true

end

@testset "minimal_equal_dec_test" begin

    @test ≛(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test ≛(DecoratedInterval(interval(1.0,2.1), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test ≛(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test ≛(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test ≛(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test ≛(nai(), nai()) == false

    @test ≛(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test ≛(nai(), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test ≛(DecoratedInterval(interval(-Inf,+Inf), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test ≛(DecoratedInterval(interval(1.0,2.4), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test ≛(DecoratedInterval(interval(1.0,Inf), trv), DecoratedInterval(interval(1.0,Inf), trv)) == true

    @test ≛(DecoratedInterval(interval(1.0,2.4), def), DecoratedInterval(interval(1.0,Inf), trv)) == false

    @test ≛(DecoratedInterval(interval(-Inf,2.0), trv), DecoratedInterval(interval(-Inf,2.0), trv)) == true

    @test ≛(DecoratedInterval(interval(-Inf,2.4), def), DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test ≛(DecoratedInterval(interval(-2.0,0.0), trv), DecoratedInterval(interval(-2.0,0.0), trv)) == true

    @test ≛(DecoratedInterval(interval(-0.0,2.0), def), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test ≛(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test ≛(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test ≛(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

end

@testset "minimal_subset_test" begin

    @test issubset(emptyinterval(), emptyinterval()) == true

    @test issubset(emptyinterval(), interval(0.0,4.0)) == true

    @test issubset(emptyinterval(), interval(-0.0,4.0)) == true

    @test issubset(emptyinterval(), interval(-0.1,1.0)) == true

    @test issubset(emptyinterval(), interval(-0.1,0.0)) == true

    @test issubset(emptyinterval(), interval(-0.1,-0.0)) == true

    @test issubset(emptyinterval(), interval(-Inf,+Inf)) == true

    @test issubset(interval(0.0,4.0), emptyinterval()) == false

    @test issubset(interval(-0.0,4.0), emptyinterval()) == false

    @test issubset(interval(-0.1,1.0), emptyinterval()) == false

    @test issubset(interval(-Inf,+Inf), emptyinterval()) == false

    @test issubset(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test issubset(interval(-0.0,4.0), interval(-Inf,+Inf)) == true

    @test issubset(interval(-0.1,1.0), interval(-Inf,+Inf)) == true

    @test issubset(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test issubset(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test issubset(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test issubset(interval(1.0,2.0), interval(-0.0,4.0)) == true

    @test issubset(interval(0.1,0.2), interval(0.0,4.0)) == true

    @test issubset(interval(0.1,0.2), interval(-0.0,4.0)) == true

    @test issubset(interval(-0.1,-0.1), interval(-4.0, 3.4)) == true

    @test issubset(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test issubset(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test issubset(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test issubset(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test issubset(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test issubset(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_subset_dec_test" begin

    @test issubset(nai(), nai()) == false

    @test issubset(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,1.0), trv)) == true

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,0.0), trv)) == true

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,-0.0), trv)) == true

    @test issubset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test issubset(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset(DecoratedInterval(interval(-0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test issubset(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test issubset(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test issubset(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test issubset(DecoratedInterval(interval(-0.1,-0.1), trv), DecoratedInterval(interval(-4.0, 3.4), trv)) == true

    @test issubset(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test issubset(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test issubset(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test issubset(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test issubset(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test issubset(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_less_test" begin

    @test isweaklyless(emptyinterval(), emptyinterval()) == true

    @test isweaklyless(interval(1.0,2.0), emptyinterval()) == false

    @test isweaklyless(emptyinterval(), interval(1.0,2.0)) == false

    @test isweaklyless(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isweaklyless(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test isweaklyless(interval(0.0,2.0), interval(-Inf,+Inf)) == false

    @test isweaklyless(interval(-0.0,2.0), interval(-Inf,+Inf)) == false

    @test isweaklyless(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test isweaklyless(interval(-Inf,+Inf), interval(0.0,2.0)) == false

    @test isweaklyless(interval(-Inf,+Inf), interval(-0.0,2.0)) == false

    @test isweaklyless(interval(0.0,2.0), interval(0.0,2.0)) == true

    @test isweaklyless(interval(0.0,2.0), interval(-0.0,2.0)) == true

    @test isweaklyless(interval(0.0,2.0), interval(1.0,2.0)) == true

    @test isweaklyless(interval(-0.0,2.0), interval(1.0,2.0)) == true

    @test isweaklyless(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test isweaklyless(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test isweaklyless(interval(1.0,3.5), interval(3.0,4.0)) == true

    @test isweaklyless(interval(1.0,4.0), interval(3.0,4.0)) == true

    @test isweaklyless(interval(-2.0,-1.0), interval(-2.0,-1.0)) == true

    @test isweaklyless(interval(-3.0,-1.5), interval(-2.0,-1.0)) == true

    @test isweaklyless(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test isweaklyless(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test isweaklyless(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test isweaklyless(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test isweaklyless(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test isweaklyless(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_less_dec_test" begin

    @test isweaklyless(nai(), nai()) == false

    @test isweaklyless(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isweaklyless(DecoratedInterval(interval(1.0,2.0), trv), nai()) == false

    @test isweaklyless(nai(), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test isweaklyless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweaklyless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,2.0), def)) == false

    @test isweaklyless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == false

    @test isweaklyless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test isweaklyless(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(-2.0,-1.0), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(-3.0,-1.5), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test isweaklyless(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweaklyless(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

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

    @test isinterior(emptyinterval(), emptyinterval()) == true

    @test isinterior(emptyinterval(), interval(0.0,4.0)) == true

    @test isinterior(interval(0.0,4.0), emptyinterval()) == false

    @test isinterior(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isinterior(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test isinterior(emptyinterval(), interval(-Inf,+Inf)) == true

    @test isinterior(interval(-Inf,+Inf), interval(0.0,4.0)) == false

    @test isinterior(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test isinterior(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test isinterior(interval(-2.0,2.0), interval(-2.0,4.0)) == false

    @test isinterior(interval(-0.0,-0.0), interval(-2.0,4.0)) == true

    @test isinterior(interval(0.0,0.0), interval(-2.0,4.0)) == true

    @test isinterior(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isinterior(interval(0.0,4.4), interval(0.0,4.0)) == false

    @test isinterior(interval(-1.0,-1.0), interval(0.0,4.0)) == false

    @test isinterior(interval(2.0,2.0), interval(-2.0,-1.0)) == false

end

@testset "minimal_interior_dec_test" begin

    @test isinterior(nai(), nai()) == false

    @test isinterior(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isinterior(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isinterior(DecoratedInterval(interval(0.0,4.0), def), nai()) == false

    @test isinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isinterior(DecoratedInterval(interval(0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test isinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isinterior(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isinterior(DecoratedInterval(interval(-2.0,2.0), trv), DecoratedInterval(interval(-2.0,4.0), def)) == false

    @test isinterior(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isinterior(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isinterior(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isinterior(DecoratedInterval(interval(0.0,4.4), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isinterior(DecoratedInterval(interval(-1.0,-1.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test isinterior(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(-2.0,-1.0), trv)) == false

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

    @test isdisjoint(emptyinterval(), interval(3.0,4.0)) == true

    @test isdisjoint(interval(3.0,4.0), emptyinterval()) == true

    @test isdisjoint(emptyinterval(), emptyinterval()) == true

    @test isdisjoint(interval(3.0,4.0), interval(1.0,2.0)) == true

    @test isdisjoint(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isdisjoint(interval(0.0,-0.0), interval(-0.0,0.0)) == false

    @test isdisjoint(interval(3.0,4.0), interval(1.0,7.0)) == false

    @test isdisjoint(interval(3.0,4.0), interval(-Inf,+Inf)) == false

    @test isdisjoint(interval(-Inf,+Inf), interval(1.0,7.0)) == false

    @test isdisjoint(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

end

@testset "minimal_disjoint_dec_test" begin

    @test isdisjoint(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test isdisjoint(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test isdisjoint(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isdisjoint(nai(), nai()) == false

    @test isdisjoint(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test isdisjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjoint(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test isdisjoint(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isdisjoint(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == false

    @test isdisjoint(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,7.0), def)) == false

    @test isdisjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isdisjoint(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,7.0), trv)) == false

    @test isdisjoint(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

end
