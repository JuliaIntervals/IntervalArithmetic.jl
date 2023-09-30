@testset "minimal_is_empty_test" begin

    @test isemptyinterval(emptyinterval()) == true

    @test isemptyinterval(interval(-Inf,+Inf)) == false

    @test isemptyinterval(interval(1.0,2.0)) == false

    @test isemptyinterval(interval(-1.0,2.0)) == false

    @test isemptyinterval(interval(-3.0,-2.0)) == false

    @test isemptyinterval(interval(-Inf,2.0)) == false

    @test isemptyinterval(interval(-Inf,0.0)) == false

    @test isemptyinterval(interval(-Inf,-0.0)) == false

    @test isemptyinterval(interval(0.0,Inf)) == false

    @test isemptyinterval(interval(-0.0,Inf)) == false

    @test isemptyinterval(interval(-0.0,0.0)) == false

    @test isemptyinterval(interval(0.0,-0.0)) == false

    @test isemptyinterval(interval(0.0,0.0)) == false

    @test isemptyinterval(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_empty_dec_test" begin

    @test isemptyinterval(nai()) == false

    @test isemptyinterval(DecoratedInterval(emptyinterval(), trv)) == true

    @test isemptyinterval(DecoratedInterval(interval(-Inf,+Inf), def)) == false

    @test isemptyinterval(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isemptyinterval(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isemptyinterval(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isemptyinterval(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isemptyinterval(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isemptyinterval(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

end

@testset "minimal_is_entire_test" begin

    @test isentireinterval(emptyinterval()) == false

    @test isentireinterval(interval(-Inf,+Inf)) == true

    @test isentireinterval(interval(1.0,2.0)) == false

    @test isentireinterval(interval(-1.0,2.0)) == false

    @test isentireinterval(interval(-3.0,-2.0)) == false

    @test isentireinterval(interval(-Inf,2.0)) == false

    @test isentireinterval(interval(-Inf,0.0)) == false

    @test isentireinterval(interval(-Inf,-0.0)) == false

    @test isentireinterval(interval(0.0,Inf)) == false

    @test isentireinterval(interval(-0.0,Inf)) == false

    @test isentireinterval(interval(-0.0,0.0)) == false

    @test isentireinterval(interval(0.0,-0.0)) == false

    @test isentireinterval(interval(0.0,0.0)) == false

    @test isentireinterval(interval(-0.0,-0.0)) == false

end

@testset "minimal_is_entire_dec_test" begin

    @test isentireinterval(nai()) == false

    @test isentireinterval(DecoratedInterval(emptyinterval(), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isentireinterval(DecoratedInterval(interval(-Inf,+Inf), def)) == true

    @test isentireinterval(DecoratedInterval(interval(-Inf,+Inf), dac)) == true

    @test isentireinterval(DecoratedInterval(interval(1.0,2.0), com)) == false

    @test isentireinterval(DecoratedInterval(interval(-1.0,2.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-3.0,-2.0), dac)) == false

    @test isentireinterval(DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-Inf,0.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-Inf,-0.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(0.0,Inf), def)) == false

    @test isentireinterval(DecoratedInterval(interval(-0.0,Inf), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-0.0,0.0), com)) == false

    @test isentireinterval(DecoratedInterval(interval(0.0,-0.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(0.0,0.0), trv)) == false

    @test isentireinterval(DecoratedInterval(interval(-0.0,-0.0), trv)) == false

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

    @test isequalinterval(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test isequalinterval(interval(1.0,2.1), interval(1.0,2.0)) == false

    @test isequalinterval(emptyinterval(), emptyinterval()) == true

    @test isequalinterval(emptyinterval(), interval(1.0,2.0)) == false

    @test isequalinterval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isequalinterval(interval(1.0,2.4), interval(-Inf,+Inf)) == false

    @test isequalinterval(interval(1.0,Inf), interval(1.0,Inf)) == true

    @test isequalinterval(interval(1.0,2.4), interval(1.0,Inf)) == false

    @test isequalinterval(interval(-Inf,2.0), interval(-Inf,2.0)) == true

    @test isequalinterval(interval(-Inf,2.4), interval(-Inf,2.0)) == false

    @test isequalinterval(interval(-2.0,0.0), interval(-2.0,0.0)) == true

    @test isequalinterval(interval(-0.0,2.0), interval(0.0,2.0)) == true

    @test isequalinterval(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test isequalinterval(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test isequalinterval(interval(0.0,-0.0), interval(0.0,0.0)) == true

end

@testset "minimal_equal_dec_test" begin

    @test isequalinterval(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(1.0,2.1), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequalinterval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isequalinterval(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isequalinterval(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isequalinterval(nai(), nai()) == false

    @test isequalinterval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequalinterval(nai(), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test isequalinterval(DecoratedInterval(interval(-Inf,+Inf), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(1.0,2.4), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isequalinterval(DecoratedInterval(interval(1.0,Inf), trv), DecoratedInterval(interval(1.0,Inf), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(1.0,2.4), def), DecoratedInterval(interval(1.0,Inf), trv)) == false

    @test isequalinterval(DecoratedInterval(interval(-Inf,2.0), trv), DecoratedInterval(interval(-Inf,2.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(-Inf,2.4), def), DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test isequalinterval(DecoratedInterval(interval(-2.0,0.0), trv), DecoratedInterval(interval(-2.0,0.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(-0.0,2.0), def), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isequalinterval(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

end

@testset "minimal_subset_test" begin

    @test isweakinterior(emptyinterval(), emptyinterval()) == true

    @test isweakinterior(emptyinterval(), interval(0.0,4.0)) == true

    @test isweakinterior(emptyinterval(), interval(-0.0,4.0)) == true

    @test isweakinterior(emptyinterval(), interval(-0.1,1.0)) == true

    @test isweakinterior(emptyinterval(), interval(-0.1,0.0)) == true

    @test isweakinterior(emptyinterval(), interval(-0.1,-0.0)) == true

    @test isweakinterior(emptyinterval(), interval(-Inf,+Inf)) == true

    @test isweakinterior(interval(0.0,4.0), emptyinterval()) == false

    @test isweakinterior(interval(-0.0,4.0), emptyinterval()) == false

    @test isweakinterior(interval(-0.1,1.0), emptyinterval()) == false

    @test isweakinterior(interval(-Inf,+Inf), emptyinterval()) == false

    @test isweakinterior(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test isweakinterior(interval(-0.0,4.0), interval(-Inf,+Inf)) == true

    @test isweakinterior(interval(-0.1,1.0), interval(-Inf,+Inf)) == true

    @test isweakinterior(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isweakinterior(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test isweakinterior(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test isweakinterior(interval(1.0,2.0), interval(-0.0,4.0)) == true

    @test isweakinterior(interval(0.1,0.2), interval(0.0,4.0)) == true

    @test isweakinterior(interval(0.1,0.2), interval(-0.0,4.0)) == true

    @test isweakinterior(interval(-0.1,-0.1), interval(-4.0, 3.4)) == true

    @test isweakinterior(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test isweakinterior(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test isweakinterior(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test isweakinterior(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test isweakinterior(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test isweakinterior(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_subset_dec_test" begin

    @test isweakinterior(nai(), nai()) == false

    @test isweakinterior(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakinterior(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,1.0), trv)) == true

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,-0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakinterior(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakinterior(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test isweakinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test isweakinterior(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.1,-0.1), trv), DecoratedInterval(interval(-4.0, 3.4), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test isweakinterior(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

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

    @test weakprecedes(emptyinterval(), interval(3.0,4.0)) == true

    @test weakprecedes(interval(3.0,4.0), emptyinterval()) == true

    @test weakprecedes(emptyinterval(), emptyinterval()) == true

    @test weakprecedes(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test weakprecedes(interval(0.0,2.0), interval(-Inf,+Inf)) == false

    @test weakprecedes(interval(-0.0,2.0), interval(-Inf,+Inf)) == false

    @test weakprecedes(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test weakprecedes(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

    @test weakprecedes(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test weakprecedes(interval(1.0,3.0), interval(3.0,4.0)) == true

    @test weakprecedes(interval(-3.0, -1.0), interval(-1.0,0.0)) == true

    @test weakprecedes(interval(-3.0, -1.0), interval(-1.0,-0.0)) == true

    @test weakprecedes(interval(1.0,3.5), interval(3.0,4.0)) == false

    @test weakprecedes(interval(1.0,4.0), interval(3.0,4.0)) == false

    @test weakprecedes(interval(-3.0, -0.1), interval(-1.0,0.0)) == false

    @test weakprecedes(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test weakprecedes(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test weakprecedes(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test weakprecedes(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test weakprecedes(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test weakprecedes(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_precedes_dec_test" begin

    @test weakprecedes(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test weakprecedes(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test weakprecedes(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test weakprecedes(nai(), nai()) == false

    @test weakprecedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test weakprecedes(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test weakprecedes(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(1.0,3.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test weakprecedes(DecoratedInterval(interval(-3.0, -1.0), def), DecoratedInterval(interval(-1.0,0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(-3.0, -1.0), trv), DecoratedInterval(interval(-1.0,-0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(-3.0, -0.1), trv), DecoratedInterval(interval(-1.0,0.0), trv)) == false

    @test weakprecedes(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test weakprecedes(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test weakprecedes(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_interior_test" begin

    @test isstrictinterior(emptyinterval(), emptyinterval()) == true

    @test isstrictinterior(emptyinterval(), interval(0.0,4.0)) == true

    @test isstrictinterior(interval(0.0,4.0), emptyinterval()) == false

    @test isstrictinterior(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test isstrictinterior(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test isstrictinterior(emptyinterval(), interval(-Inf,+Inf)) == true

    @test isstrictinterior(interval(-Inf,+Inf), interval(0.0,4.0)) == false

    @test isstrictinterior(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test isstrictinterior(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test isstrictinterior(interval(-2.0,2.0), interval(-2.0,4.0)) == false

    @test isstrictinterior(interval(-0.0,-0.0), interval(-2.0,4.0)) == true

    @test isstrictinterior(interval(0.0,0.0), interval(-2.0,4.0)) == true

    @test isstrictinterior(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isstrictinterior(interval(0.0,4.4), interval(0.0,4.0)) == false

    @test isstrictinterior(interval(-1.0,-1.0), interval(0.0,4.0)) == false

    @test isstrictinterior(interval(2.0,2.0), interval(-2.0,-1.0)) == false

end

@testset "minimal_interior_dec_test" begin

    @test isstrictinterior(nai(), nai()) == false

    @test isstrictinterior(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test isstrictinterior(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(0.0,4.0), def), nai()) == false

    @test isstrictinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isstrictinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictinterior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(-2.0,2.0), trv), DecoratedInterval(interval(-2.0,4.0), def)) == false

    @test isstrictinterior(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test isstrictinterior(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(0.0,4.4), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test isstrictinterior(DecoratedInterval(interval(-1.0,-1.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test isstrictinterior(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(-2.0,-1.0), trv)) == false

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

    @test isdisjointinterval(emptyinterval(), interval(3.0,4.0)) == true

    @test isdisjointinterval(interval(3.0,4.0), emptyinterval()) == true

    @test isdisjointinterval(emptyinterval(), emptyinterval()) == true

    @test isdisjointinterval(interval(3.0,4.0), interval(1.0,2.0)) == true

    @test isdisjointinterval(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test isdisjointinterval(interval(0.0,-0.0), interval(-0.0,0.0)) == false

    @test isdisjointinterval(interval(3.0,4.0), interval(1.0,7.0)) == false

    @test isdisjointinterval(interval(3.0,4.0), interval(-Inf,+Inf)) == false

    @test isdisjointinterval(interval(-Inf,+Inf), interval(1.0,7.0)) == false

    @test isdisjointinterval(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

end

@testset "minimal_disjoint_dec_test" begin

    @test isdisjointinterval(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test isdisjointinterval(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test isdisjointinterval(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test isdisjointinterval(nai(), nai()) == false

    @test isdisjointinterval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test isdisjointinterval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjointinterval(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test isdisjointinterval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test isdisjointinterval(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test isdisjointinterval(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == false

    @test isdisjointinterval(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,7.0), def)) == false

    @test isdisjointinterval(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test isdisjointinterval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,7.0), trv)) == false

    @test isdisjointinterval(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

end
