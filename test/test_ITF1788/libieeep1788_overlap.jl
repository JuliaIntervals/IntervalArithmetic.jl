@testset "minimal_overlap_test" begin
    @test overlap(emptyinterval(), emptyinterval()) === _both_empty
    @test overlap(emptyinterval(), interval(1.0,2.0)) === _first_empty
    @test overlap(interval(1.0,2.0), emptyinterval()) === _second_empty
    @test overlap(interval(-Inf,2.0), interval(3.0,Inf)) === _before
    @test overlap(interval(-Inf,2.0), interval(3.0,4.0)) === _before
    @test overlap(interval(2.0,2.0), interval(3.0,4.0)) === _before
    @test overlap(interval(1.0,2.0), interval(3.0,4.0)) === _before
    @test overlap(interval(1.0,2.0), interval(3.0,3.0)) === _before
    @test overlap(interval(2.0,2.0), interval(3.0,3.0)) === _before
    @test overlap(interval(2.0,2.0), interval(3.0,Inf)) === _before
    @test overlap(interval(-Inf,2.0), interval(2.0,3.0)) === _meets
    @test overlap(interval(1.0,2.0), interval(2.0,3.0)) === _meets
    @test overlap(interval(1.0,2.0), interval(2.0,Inf)) === _meets
    @test overlap(interval(1.0,2.0), interval(1.5,2.5)) === _overlaps
    @test overlap(interval(1.0,2.0), interval(1.0,Inf)) === _starts
    @test overlap(interval(1.0,2.0), interval(1.0,3.0)) === _starts
    @test overlap(interval(1.0,1.0), interval(1.0,3.0)) === _starts
    @test overlap(interval(1.0,2.0), entireinterval()) === _contained_by
    @test overlap(interval(1.0,2.0), interval(-Inf,3.0)) === _contained_by
    @test overlap(interval(1.0,2.0), interval(0.0,3.0)) === _contained_by
    @test overlap(interval(2.0,2.0), interval(0.0,3.0)) === _contained_by
    @test overlap(interval(2.0,2.0), interval(0.0,Inf)) === _contained_by
    @test overlap(interval(1.0,2.0), interval(-Inf,2.0)) === _finishes
    @test overlap(interval(1.0,2.0), interval(0.0,2.0)) === _finishes
    @test overlap(interval(2.0,2.0), interval(0.0,2.0)) === _finishes
    @test overlap(interval(1.0,2.0), interval(1.0,2.0)) === _equals
    @test overlap(interval(1.0,1.0), interval(1.0,1.0)) === _equals
    @test overlap(interval(-Inf,1.0), interval(-Inf,1.0)) === _equals
    @test overlap(entireinterval(), entireinterval()) === _equals
    @test overlap(interval(3.0,4.0), interval(2.0,2.0)) === _after
    @test overlap(interval(3.0,4.0), interval(1.0,2.0)) === _after
    @test overlap(interval(3.0,3.0), interval(1.0,2.0)) === _after
    @test overlap(interval(3.0,3.0), interval(2.0,2.0)) === _after
    @test overlap(interval(3.0,Inf), interval(2.0,2.0)) === _after
    @test overlap(interval(2.0,3.0), interval(1.0,2.0)) === _met_by
    @test overlap(interval(2.0,3.0), interval(-Inf,2.0)) === _met_by
    @test overlap(interval(1.5,2.5), interval(1.0,2.0)) === _overlapped_by
    @test overlap(interval(1.5,2.5), interval(-Inf,2.0)) === _overlapped_by
    @test overlap(interval(1.0,Inf), interval(1.0,2.0)) === _started_by
    @test overlap(interval(1.0,3.0), interval(1.0,2.0)) === _started_by
    @test overlap(interval(1.0,3.0), interval(1.0,1.0)) === _started_by
    @test overlap(interval(-Inf,3.0), interval(1.0,2.0)) === _contains
    @test overlap(entireinterval(), interval(1.0,2.0)) === _contains
    @test overlap(interval(0.0,3.0), interval(1.0,2.0)) === _contains
    @test overlap(interval(0.0,3.0), interval(2.0,2.0)) === _contains
    @test overlap(interval(-Inf,2.0), interval(1.0,2.0)) === _finished_by
    @test overlap(interval(0.0,2.0), interval(1.0,2.0)) === _finished_by
    @test overlap(interval(0.0,2.0), interval(2.0,2.0)) === _finished_by

end

@testset "minimal_overlap_dec_test" begin
    @test overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === _both_empty
    @test overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), com)) === _first_empty
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(emptyinterval(), trv)) === _second_empty
    @test overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(3.0,4.0), def)) === _before
    @test overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(3.0,4.0), com)) === _before
    @test overlap(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(3.0,3.0), trv)) === _before
    @test overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(3.0,3.0), def)) === _before
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(2.0,3.0), def)) === _meets
    @test overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(1.5,2.5), def)) === _overlaps
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,3.0), com)) === _starts
    @test overlap(DecoratedInterval(interval(1.0,1.0), trv), DecoratedInterval(interval(1.0,3.0), def)) === _starts
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,3.0), dac)) === _contained_by
    @test overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(0.0,3.0), def)) === _contained_by
    @test overlap(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), com)) === _finishes
    @test overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(0.0,2.0), dac)) === _finishes
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) === _equals
    @test overlap(DecoratedInterval(interval(1.0,1.0), dac), DecoratedInterval(interval(1.0,1.0), dac)) === _equals
    @test overlap(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(2.0,2.0), trv)) === _after
    @test overlap(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,2.0), def)) === _after
    @test overlap(DecoratedInterval(interval(3.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === _after
    @test overlap(DecoratedInterval(interval(3.0,3.0), def), DecoratedInterval(interval(2.0,2.0), trv)) === _after
    @test overlap(DecoratedInterval(interval(2.0,3.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === _met_by
    @test overlap(DecoratedInterval(interval(1.5,2.5), com), DecoratedInterval(interval(1.0,2.0), com)) === _overlapped_by
    @test overlap(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(interval(1.0,2.0), def)) === _started_by
    @test overlap(DecoratedInterval(interval(1.0,3.0), com), DecoratedInterval(interval(1.0,1.0), dac)) === _started_by
    @test overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === _contains
    @test overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(2.0,2.0), def)) === _contains
    @test overlap(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === _finished_by
    @test overlap(DecoratedInterval(interval(0.0,2.0), dac), DecoratedInterval(interval(2.0,2.0), def)) === _finished_by

end

