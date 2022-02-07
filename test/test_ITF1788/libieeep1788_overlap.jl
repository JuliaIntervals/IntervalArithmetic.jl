@testset "minimal_overlap_test" begin

    @test_broken MISSING_overlap(emptyinterval(), emptyinterval()) === bothEmpty

    @test_broken MISSING_overlap(emptyinterval(), interval(1.0,2.0)) === firstEmpty

    @test_broken MISSING_overlap(interval(1.0,2.0), emptyinterval()) === secondEmpty

    @test_broken MISSING_overlap(interval(-Inf,2.0), interval(3.0,Inf)) === before

    @test_broken MISSING_overlap(interval(-Inf,2.0), interval(3.0,4.0)) === before

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(3.0,4.0)) === before

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(3.0,4.0)) === before

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(3.0,3.0)) === before

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(3.0,3.0)) === before

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(3.0,Inf)) === before

    @test_broken MISSING_overlap(interval(-Inf,2.0), interval(2.0,3.0)) === meets

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(2.0,3.0)) === meets

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(2.0,Inf)) === meets

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(1.5,2.5)) === overlaps

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(1.0,Inf)) === starts

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(1.0,3.0)) === starts

    @test_broken MISSING_overlap(interval(1.0,1.0), interval(1.0,3.0)) === starts

    @test_broken MISSING_overlap(interval(1.0,2.0), entireinterval()) === containedBy

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(-Inf,3.0)) === containedBy

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(0.0,3.0)) === containedBy

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(0.0,3.0)) === containedBy

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(0.0,Inf)) === containedBy

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(-Inf,2.0)) === finishes

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(0.0,2.0)) === finishes

    @test_broken MISSING_overlap(interval(2.0,2.0), interval(0.0,2.0)) === finishes

    @test_broken MISSING_overlap(interval(1.0,2.0), interval(1.0,2.0)) === equals

    @test_broken MISSING_overlap(interval(1.0,1.0), interval(1.0,1.0)) === equals

    @test_broken MISSING_overlap(interval(-Inf,1.0), interval(-Inf,1.0)) === equals

    @test_broken MISSING_overlap(entireinterval(), entireinterval()) === equals

    @test_broken MISSING_overlap(interval(3.0,4.0), interval(2.0,2.0)) === after

    @test_broken MISSING_overlap(interval(3.0,4.0), interval(1.0,2.0)) === after

    @test_broken MISSING_overlap(interval(3.0,3.0), interval(1.0,2.0)) === after

    @test_broken MISSING_overlap(interval(3.0,3.0), interval(2.0,2.0)) === after

    @test_broken MISSING_overlap(interval(3.0,Inf), interval(2.0,2.0)) === after

    @test_broken MISSING_overlap(interval(2.0,3.0), interval(1.0,2.0)) === metBy

    @test_broken MISSING_overlap(interval(2.0,3.0), interval(-Inf,2.0)) === metBy

    @test_broken MISSING_overlap(interval(1.5,2.5), interval(1.0,2.0)) === overlappedBy

    @test_broken MISSING_overlap(interval(1.5,2.5), interval(-Inf,2.0)) === overlappedBy

    @test_broken MISSING_overlap(interval(1.0,Inf), interval(1.0,2.0)) === startedBy

    @test_broken MISSING_overlap(interval(1.0,3.0), interval(1.0,2.0)) === startedBy

    @test_broken MISSING_overlap(interval(1.0,3.0), interval(1.0,1.0)) === startedBy

    @test_broken MISSING_overlap(interval(-Inf,3.0), interval(1.0,2.0)) === contains

    @test_broken MISSING_overlap(entireinterval(), interval(1.0,2.0)) === contains

    @test_broken MISSING_overlap(interval(0.0,3.0), interval(1.0,2.0)) === contains

    @test_broken MISSING_overlap(interval(0.0,3.0), interval(2.0,2.0)) === contains

    @test_broken MISSING_overlap(interval(-Inf,2.0), interval(1.0,2.0)) === finishedBy

    @test_broken MISSING_overlap(interval(0.0,2.0), interval(1.0,2.0)) === finishedBy

    @test_broken MISSING_overlap(interval(0.0,2.0), interval(2.0,2.0)) === finishedBy

end

@testset "minimal_overlap_dec_test" begin

    @test_broken MISSING_overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === bothEmpty

    @test_broken MISSING_overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), com)) === firstEmpty

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(emptyinterval(), trv)) === secondEmpty

    @test_broken MISSING_overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(3.0,4.0), def)) === before

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(3.0,4.0), com)) === before

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(3.0,3.0), trv)) === before

    @test_broken MISSING_overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(3.0,3.0), def)) === before

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(2.0,3.0), def)) === meets

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(1.5,2.5), def)) === overlaps

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,3.0), com)) === starts

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,1.0), trv), DecoratedInterval(interval(1.0,3.0), def)) === starts

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,3.0), dac)) === containedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(0.0,3.0), def)) === containedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), com)) === finishes

    @test_broken MISSING_overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(0.0,2.0), dac)) === finishes

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) === equals

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,1.0), dac), DecoratedInterval(interval(1.0,1.0), dac)) === equals

    @test_broken MISSING_overlap(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(2.0,2.0), trv)) === after

    @test_broken MISSING_overlap(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,2.0), def)) === after

    @test_broken MISSING_overlap(DecoratedInterval(interval(3.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === after

    @test_broken MISSING_overlap(DecoratedInterval(interval(3.0,3.0), def), DecoratedInterval(interval(2.0,2.0), trv)) === after

    @test_broken MISSING_overlap(DecoratedInterval(interval(2.0,3.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === metBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.5,2.5), com), DecoratedInterval(interval(1.0,2.0), com)) === overlappedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(interval(1.0,2.0), def)) === startedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(1.0,3.0), com), DecoratedInterval(interval(1.0,1.0), dac)) === startedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === contains

    @test_broken MISSING_overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(2.0,2.0), def)) === contains

    @test_broken MISSING_overlap(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === finishedBy

    @test_broken MISSING_overlap(DecoratedInterval(interval(0.0,2.0), dac), DecoratedInterval(interval(2.0,2.0), def)) === finishedBy

end

