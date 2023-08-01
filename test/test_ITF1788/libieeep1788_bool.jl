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

    @test equal(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test equal(interval(1.0,2.1), interval(1.0,2.0)) == false

    @test equal(emptyinterval(), emptyinterval()) == true

    @test equal(emptyinterval(), interval(1.0,2.0)) == false

    @test equal(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test equal(interval(1.0,2.4), interval(-Inf,+Inf)) == false

    @test equal(interval(1.0,Inf), interval(1.0,Inf)) == true

    @test equal(interval(1.0,2.4), interval(1.0,Inf)) == false

    @test equal(interval(-Inf,2.0), interval(-Inf,2.0)) == true

    @test equal(interval(-Inf,2.4), interval(-Inf,2.0)) == false

    @test equal(interval(-2.0,0.0), interval(-2.0,0.0)) == true

    @test equal(interval(-0.0,2.0), interval(0.0,2.0)) == true

    @test equal(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test equal(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test equal(interval(0.0,-0.0), interval(0.0,0.0)) == true

end

@testset "minimal_equal_dec_test" begin

    @test equal(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test equal(DecoratedInterval(interval(1.0,2.1), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test equal(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test equal(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test equal(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test equal(nai(), nai()) == false

    @test equal(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test equal(nai(), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test equal(DecoratedInterval(interval(-Inf,+Inf), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test equal(DecoratedInterval(interval(1.0,2.4), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test equal(DecoratedInterval(interval(1.0,Inf), trv), DecoratedInterval(interval(1.0,Inf), trv)) == true

    @test equal(DecoratedInterval(interval(1.0,2.4), def), DecoratedInterval(interval(1.0,Inf), trv)) == false

    @test equal(DecoratedInterval(interval(-Inf,2.0), trv), DecoratedInterval(interval(-Inf,2.0), trv)) == true

    @test equal(DecoratedInterval(interval(-Inf,2.4), def), DecoratedInterval(interval(-Inf,2.0), trv)) == false

    @test equal(DecoratedInterval(interval(-2.0,0.0), trv), DecoratedInterval(interval(-2.0,0.0), trv)) == true

    @test equal(DecoratedInterval(interval(-0.0,2.0), def), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test equal(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test equal(DecoratedInterval(interval(-0.0,0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test equal(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

end

@testset "minimal_subset_test" begin

    @test subset(emptyinterval(), emptyinterval()) == true

    @test subset(emptyinterval(), interval(0.0,4.0)) == true

    @test subset(emptyinterval(), interval(-0.0,4.0)) == true

    @test subset(emptyinterval(), interval(-0.1,1.0)) == true

    @test subset(emptyinterval(), interval(-0.1,0.0)) == true

    @test subset(emptyinterval(), interval(-0.1,-0.0)) == true

    @test subset(emptyinterval(), interval(-Inf,+Inf)) == true

    @test subset(interval(0.0,4.0), emptyinterval()) == false

    @test subset(interval(-0.0,4.0), emptyinterval()) == false

    @test subset(interval(-0.1,1.0), emptyinterval()) == false

    @test subset(interval(-Inf,+Inf), emptyinterval()) == false

    @test subset(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test subset(interval(-0.0,4.0), interval(-Inf,+Inf)) == true

    @test subset(interval(-0.1,1.0), interval(-Inf,+Inf)) == true

    @test subset(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test subset(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test subset(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test subset(interval(1.0,2.0), interval(-0.0,4.0)) == true

    @test subset(interval(0.1,0.2), interval(0.0,4.0)) == true

    @test subset(interval(0.1,0.2), interval(-0.0,4.0)) == true

    @test subset(interval(-0.1,-0.1), interval(-4.0, 3.4)) == true

    @test subset(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test subset(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test subset(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test subset(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test subset(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test subset(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_subset_dec_test" begin

    @test subset(nai(), nai()) == false

    @test subset(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test subset(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,1.0), trv)) == true

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,0.0), trv)) == true

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-0.1,-0.0), trv)) == true

    @test subset(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test subset(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test subset(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test subset(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test subset(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test subset(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test subset(DecoratedInterval(interval(-0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test subset(DecoratedInterval(interval(-0.1,1.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test subset(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test subset(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test subset(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test subset(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test subset(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test subset(DecoratedInterval(interval(0.1,0.2), trv), DecoratedInterval(interval(-0.0,4.0), def)) == true

    @test subset(DecoratedInterval(interval(-0.1,-0.1), trv), DecoratedInterval(interval(-4.0, 3.4), trv)) == true

    @test subset(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test subset(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test subset(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test subset(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test subset(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test subset(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

end

@testset "minimal_less_test" begin

    @test less(emptyinterval(), emptyinterval()) == true

    @test less(interval(1.0,2.0), emptyinterval()) == false

    @test less(emptyinterval(), interval(1.0,2.0)) == false

    @test less(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test less(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test less(interval(0.0,2.0), interval(-Inf,+Inf)) == false

    @test less(interval(-0.0,2.0), interval(-Inf,+Inf)) == false

    @test less(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test less(interval(-Inf,+Inf), interval(0.0,2.0)) == false

    @test less(interval(-Inf,+Inf), interval(-0.0,2.0)) == false

    @test less(interval(0.0,2.0), interval(0.0,2.0)) == true

    @test less(interval(0.0,2.0), interval(-0.0,2.0)) == true

    @test less(interval(0.0,2.0), interval(1.0,2.0)) == true

    @test less(interval(-0.0,2.0), interval(1.0,2.0)) == true

    @test less(interval(1.0,2.0), interval(1.0,2.0)) == true

    @test less(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test less(interval(1.0,3.5), interval(3.0,4.0)) == true

    @test less(interval(1.0,4.0), interval(3.0,4.0)) == true

    @test less(interval(-2.0,-1.0), interval(-2.0,-1.0)) == true

    @test less(interval(-3.0,-1.5), interval(-2.0,-1.0)) == true

    @test less(interval(0.0,0.0), interval(-0.0,-0.0)) == true

    @test less(interval(-0.0,-0.0), interval(0.0,0.0)) == true

    @test less(interval(-0.0,0.0), interval(0.0,0.0)) == true

    @test less(interval(-0.0,0.0), interval(0.0,-0.0)) == true

    @test less(interval(0.0,-0.0), interval(0.0,0.0)) == true

    @test less(interval(0.0,-0.0), interval(-0.0,0.0)) == true

end

@testset "minimal_less_dec_test" begin

    @test less(nai(), nai()) == false

    @test less(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test less(DecoratedInterval(interval(1.0,2.0), trv), nai()) == false

    @test less(nai(), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test less(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test less(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test less(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test less(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test less(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test less(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test less(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test less(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test less(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,2.0), def)) == false

    @test less(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == false

    @test less(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), trv)) == true

    @test less(DecoratedInterval(interval(0.0,2.0), trv), DecoratedInterval(interval(-0.0,2.0), trv)) == true

    @test less(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test less(DecoratedInterval(interval(-0.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test less(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == true

    @test less(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test less(DecoratedInterval(interval(1.0,3.5), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test less(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test less(DecoratedInterval(interval(-2.0,-1.0), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test less(DecoratedInterval(interval(-3.0,-1.5), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

    @test less(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == true

    @test less(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(0.0,0.0), def)) == true

    @test less(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test less(DecoratedInterval(interval(-0.0,0.0), trv), DecoratedInterval(interval(0.0,-0.0), trv)) == true

    @test less(DecoratedInterval(interval(0.0,-0.0), def), DecoratedInterval(interval(0.0,0.0), trv)) == true

    @test less(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == true

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

    @test interior(emptyinterval(), emptyinterval()) == true

    @test interior(emptyinterval(), interval(0.0,4.0)) == true

    @test interior(interval(0.0,4.0), emptyinterval()) == false

    @test interior(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test interior(interval(0.0,4.0), interval(-Inf,+Inf)) == true

    @test interior(emptyinterval(), interval(-Inf,+Inf)) == true

    @test interior(interval(-Inf,+Inf), interval(0.0,4.0)) == false

    @test interior(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test interior(interval(1.0,2.0), interval(0.0,4.0)) == true

    @test interior(interval(-2.0,2.0), interval(-2.0,4.0)) == false

    @test interior(interval(-0.0,-0.0), interval(-2.0,4.0)) == true

    @test interior(interval(0.0,0.0), interval(-2.0,4.0)) == true

    @test interior(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test interior(interval(0.0,4.4), interval(0.0,4.0)) == false

    @test interior(interval(-1.0,-1.0), interval(0.0,4.0)) == false

    @test interior(interval(2.0,2.0), interval(-2.0,-1.0)) == false

end

@testset "minimal_interior_dec_test" begin

    @test interior(nai(), nai()) == false

    @test interior(nai(), DecoratedInterval(emptyinterval(), trv)) == false

    @test interior(nai(), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test interior(DecoratedInterval(interval(0.0,4.0), def), nai()) == false

    @test interior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test interior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test interior(DecoratedInterval(interval(0.0,4.0), def), DecoratedInterval(emptyinterval(), trv)) == false

    @test interior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test interior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test interior(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test interior(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test interior(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test interior(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == true

    @test interior(DecoratedInterval(interval(-2.0,2.0), trv), DecoratedInterval(interval(-2.0,4.0), def)) == false

    @test interior(DecoratedInterval(interval(-0.0,-0.0), trv), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test interior(DecoratedInterval(interval(0.0,0.0), def), DecoratedInterval(interval(-2.0,4.0), trv)) == true

    @test interior(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test interior(DecoratedInterval(interval(0.0,4.4), trv), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test interior(DecoratedInterval(interval(-1.0,-1.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test interior(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(-2.0,-1.0), trv)) == false

end

@testset "minimal_strictly_less_test" begin

    @test strictless(emptyinterval(), emptyinterval()) == true

    @test strictless(interval(1.0,2.0), emptyinterval()) == false

    @test strictless(emptyinterval(), interval(1.0,2.0)) == false

    @test strictless(interval(-Inf,+Inf), interval(-Inf,+Inf)) == true

    @test strictless(interval(1.0,2.0), interval(-Inf,+Inf)) == false

    @test strictless(interval(-Inf,+Inf), interval(1.0,2.0)) == false

    @test strictless(interval(1.0,2.0), interval(1.0,2.0)) == false

    @test strictless(interval(1.0,2.0), interval(3.0,4.0)) == true

    @test strictless(interval(1.0,3.5), interval(3.0,4.0)) == true

    @test strictless(interval(1.0,4.0), interval(3.0,4.0)) == false

    @test strictless(interval(0.0,4.0), interval(0.0,4.0)) == false

    @test strictless(interval(-0.0,4.0), interval(0.0,4.0)) == false

    @test strictless(interval(-2.0,-1.0), interval(-2.0,-1.0)) == false

    @test strictless(interval(-3.0,-1.5), interval(-2.0,-1.0)) == true

end

@testset "minimal_strictly_less_dec_test" begin

    @test strictless(nai(), nai()) == false

    @test strictless(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test strictless(DecoratedInterval(interval(1.0,2.0), trv), nai()) == false

    @test strictless(nai(), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test strictless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test strictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(emptyinterval(), trv)) == false

    @test strictless(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), def)) == false

    @test strictless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == true

    @test strictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test strictless(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test strictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(1.0,2.0), trv)) == false

    @test strictless(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test strictless(DecoratedInterval(interval(1.0,3.5), def), DecoratedInterval(interval(3.0,4.0), trv)) == true

    @test strictless(DecoratedInterval(interval(1.0,4.0), trv), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test strictless(DecoratedInterval(interval(0.0,4.0), trv), DecoratedInterval(interval(0.0,4.0), def)) == false

    @test strictless(DecoratedInterval(interval(-0.0,4.0), def), DecoratedInterval(interval(0.0,4.0), trv)) == false

    @test strictless(DecoratedInterval(interval(-2.0,-1.0), def), DecoratedInterval(interval(-2.0,-1.0), def)) == false

    @test strictless(DecoratedInterval(interval(-3.0,-1.5), trv), DecoratedInterval(interval(-2.0,-1.0), trv)) == true

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

    @test disjoint(emptyinterval(), interval(3.0,4.0)) == true

    @test disjoint(interval(3.0,4.0), emptyinterval()) == true

    @test disjoint(emptyinterval(), emptyinterval()) == true

    @test disjoint(interval(3.0,4.0), interval(1.0,2.0)) == true

    @test disjoint(interval(0.0,0.0), interval(-0.0,-0.0)) == false

    @test disjoint(interval(0.0,-0.0), interval(-0.0,0.0)) == false

    @test disjoint(interval(3.0,4.0), interval(1.0,7.0)) == false

    @test disjoint(interval(3.0,4.0), interval(-Inf,+Inf)) == false

    @test disjoint(interval(-Inf,+Inf), interval(1.0,7.0)) == false

    @test disjoint(interval(-Inf,+Inf), interval(-Inf,+Inf)) == false

end

@testset "minimal_disjoint_dec_test" begin

    @test disjoint(nai(), DecoratedInterval(interval(3.0,4.0), def)) == false

    @test disjoint(DecoratedInterval(interval(3.0,4.0), trv), nai()) == false

    @test disjoint(DecoratedInterval(emptyinterval(), trv), nai()) == false

    @test disjoint(nai(), nai()) == false

    @test disjoint(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(3.0,4.0), def)) == true

    @test disjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test disjoint(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) == true

    @test disjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(1.0,2.0), def)) == true

    @test disjoint(DecoratedInterval(interval(0.0,0.0), trv), DecoratedInterval(interval(-0.0,-0.0), trv)) == false

    @test disjoint(DecoratedInterval(interval(0.0,-0.0), trv), DecoratedInterval(interval(-0.0,0.0), trv)) == false

    @test disjoint(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,7.0), def)) == false

    @test disjoint(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

    @test disjoint(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(1.0,7.0), trv)) == false

    @test disjoint(DecoratedInterval(interval(-Inf,+Inf), trv), DecoratedInterval(interval(-Inf,+Inf), trv)) == false

end
