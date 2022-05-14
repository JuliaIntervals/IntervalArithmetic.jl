@testset "minimal_overlap_test" begin
    @test overlap(emptyinterval(), emptyinterval()) === Overlap.both_empty
    @test overlap(emptyinterval(), interval(1.0,2.0)) === Overlap.first_empty
    @test overlap(interval(1.0,2.0), emptyinterval()) === Overlap.second_empty
    @test overlap(interval(-Inf,2.0), interval(3.0,Inf)) === Overlap.before
    @test overlap(interval(-Inf,2.0), interval(3.0,4.0)) === Overlap.before
    @test overlap(interval(2.0,2.0), interval(3.0,4.0)) === Overlap.before
    @test overlap(interval(1.0,2.0), interval(3.0,4.0)) === Overlap.before
    @test overlap(interval(1.0,2.0), interval(3.0,3.0)) === Overlap.before
    @test overlap(interval(2.0,2.0), interval(3.0,3.0)) === Overlap.before
    @test overlap(interval(2.0,2.0), interval(3.0,Inf)) === Overlap.before
    @test overlap(interval(-Inf,2.0), interval(2.0,3.0)) === Overlap.meets
    @test overlap(interval(1.0,2.0), interval(2.0,3.0)) === Overlap.meets
    @test overlap(interval(1.0,2.0), interval(2.0,Inf)) === Overlap.meets
    @test overlap(interval(1.0,2.0), interval(1.5,2.5)) === Overlap.overlaps
    @test overlap(interval(1.0,2.0), interval(1.0,Inf)) === Overlap.starts
    @test overlap(interval(1.0,2.0), interval(1.0,3.0)) === Overlap.starts
    @test overlap(interval(1.0,1.0), interval(1.0,3.0)) === Overlap.starts
    @test overlap(interval(1.0,2.0), entireinterval()) === Overlap.contained_by
    @test overlap(interval(1.0,2.0), interval(-Inf,3.0)) === Overlap.contained_by
    @test overlap(interval(1.0,2.0), interval(0.0,3.0)) === Overlap.contained_by
    @test overlap(interval(2.0,2.0), interval(0.0,3.0)) === Overlap.contained_by
    @test overlap(interval(2.0,2.0), interval(0.0,Inf)) === Overlap.contained_by
    @test overlap(interval(1.0,2.0), interval(-Inf,2.0)) === Overlap.finishes
    @test overlap(interval(1.0,2.0), interval(0.0,2.0)) === Overlap.finishes
    @test overlap(interval(2.0,2.0), interval(0.0,2.0)) === Overlap.finishes
    @test overlap(interval(1.0,2.0), interval(1.0,2.0)) === Overlap.equals
    @test overlap(interval(1.0,1.0), interval(1.0,1.0)) === Overlap.equals
    @test overlap(interval(-Inf,1.0), interval(-Inf,1.0)) === Overlap.equals
    @test overlap(entireinterval(), entireinterval()) === Overlap.equals
    @test overlap(interval(3.0,4.0), interval(2.0,2.0)) === Overlap.after
    @test overlap(interval(3.0,4.0), interval(1.0,2.0)) === Overlap.after
    @test overlap(interval(3.0,3.0), interval(1.0,2.0)) === Overlap.after
    @test overlap(interval(3.0,3.0), interval(2.0,2.0)) === Overlap.after
    @test overlap(interval(3.0,Inf), interval(2.0,2.0)) === Overlap.after
    @test overlap(interval(2.0,3.0), interval(1.0,2.0)) === Overlap.met_by
    @test overlap(interval(2.0,3.0), interval(-Inf,2.0)) === Overlap.met_by
    @test overlap(interval(1.5,2.5), interval(1.0,2.0)) === Overlap.overlapped_by
    @test overlap(interval(1.5,2.5), interval(-Inf,2.0)) === Overlap.overlapped_by
    @test overlap(interval(1.0,Inf), interval(1.0,2.0)) === Overlap.started_by
    @test overlap(interval(1.0,3.0), interval(1.0,2.0)) === Overlap.started_by
    @test overlap(interval(1.0,3.0), interval(1.0,1.0)) === Overlap.started_by
    @test overlap(interval(-Inf,3.0), interval(1.0,2.0)) === Overlap.contains
    @test overlap(entireinterval(), interval(1.0,2.0)) === Overlap.contains
    @test overlap(interval(0.0,3.0), interval(1.0,2.0)) === Overlap.contains
    @test overlap(interval(0.0,3.0), interval(2.0,2.0)) === Overlap.contains
    @test overlap(interval(-Inf,2.0), interval(1.0,2.0)) === Overlap.finished_by
    @test overlap(interval(0.0,2.0), interval(1.0,2.0)) === Overlap.finished_by
    @test overlap(interval(0.0,2.0), interval(2.0,2.0)) === Overlap.finished_by

end

@testset "minimal_overlap_dec_test" begin
    @test overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(emptyinterval(), trv)) === Overlap.both_empty
    @test overlap(DecoratedInterval(emptyinterval(), trv), DecoratedInterval(interval(1.0,2.0), com)) === Overlap.first_empty
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(emptyinterval(), trv)) === Overlap.second_empty
    @test overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(3.0,4.0), def)) === Overlap.before
    @test overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(3.0,4.0), com)) === Overlap.before
    @test overlap(DecoratedInterval(interval(1.0,2.0), com), DecoratedInterval(interval(3.0,3.0), trv)) === Overlap.before
    @test overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(3.0,3.0), def)) === Overlap.before
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(2.0,3.0), def)) === Overlap.meets
    @test overlap(DecoratedInterval(interval(1.0,2.0), dac), DecoratedInterval(interval(1.5,2.5), def)) === Overlap.overlaps
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,3.0), com)) === Overlap.starts
    @test overlap(DecoratedInterval(interval(1.0,1.0), trv), DecoratedInterval(interval(1.0,3.0), def)) === Overlap.starts
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(0.0,3.0), dac)) === Overlap.contained_by
    @test overlap(DecoratedInterval(interval(2.0,2.0), trv), DecoratedInterval(interval(0.0,3.0), def)) === Overlap.contained_by
    @test overlap(DecoratedInterval(interval(1.0,2.0), trv), DecoratedInterval(interval(0.0,2.0), com)) === Overlap.finishes
    @test overlap(DecoratedInterval(interval(2.0,2.0), def), DecoratedInterval(interval(0.0,2.0), dac)) === Overlap.finishes
    @test overlap(DecoratedInterval(interval(1.0,2.0), def), DecoratedInterval(interval(1.0,2.0), def)) === Overlap.equals
    @test overlap(DecoratedInterval(interval(1.0,1.0), dac), DecoratedInterval(interval(1.0,1.0), dac)) === Overlap.equals
    @test overlap(DecoratedInterval(interval(3.0,4.0), trv), DecoratedInterval(interval(2.0,2.0), trv)) === Overlap.after
    @test overlap(DecoratedInterval(interval(3.0,4.0), def), DecoratedInterval(interval(1.0,2.0), def)) === Overlap.after
    @test overlap(DecoratedInterval(interval(3.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === Overlap.after
    @test overlap(DecoratedInterval(interval(3.0,3.0), def), DecoratedInterval(interval(2.0,2.0), trv)) === Overlap.after
    @test overlap(DecoratedInterval(interval(2.0,3.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === Overlap.met_by
    @test overlap(DecoratedInterval(interval(1.5,2.5), com), DecoratedInterval(interval(1.0,2.0), com)) === Overlap.overlapped_by
    @test overlap(DecoratedInterval(interval(1.0,3.0), dac), DecoratedInterval(interval(1.0,2.0), def)) === Overlap.started_by
    @test overlap(DecoratedInterval(interval(1.0,3.0), com), DecoratedInterval(interval(1.0,1.0), dac)) === Overlap.started_by
    @test overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(1.0,2.0), dac)) === Overlap.contains
    @test overlap(DecoratedInterval(interval(0.0,3.0), com), DecoratedInterval(interval(2.0,2.0), def)) === Overlap.contains
    @test overlap(DecoratedInterval(interval(0.0,2.0), def), DecoratedInterval(interval(1.0,2.0), trv)) === Overlap.finished_by
    @test overlap(DecoratedInterval(interval(0.0,2.0), dac), DecoratedInterval(interval(2.0,2.0), def)) === Overlap.finished_by

end

