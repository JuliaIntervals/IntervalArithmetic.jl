@testset "minimal_overlap_test" begin
    @test overlap(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === Overlap.both_empty
    @test overlap(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === Overlap.first_empty
    @test overlap(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === Overlap.second_empty
    @test overlap(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)) === Overlap.before
    @test overlap(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)) === Overlap.before
    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,4.0)) === Overlap.before
    @test overlap(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === Overlap.before
    @test overlap(bareinterval(1.0,2.0), bareinterval(3.0,3.0)) === Overlap.before
    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,3.0)) === Overlap.before
    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,Inf)) === Overlap.before
    @test overlap(bareinterval(-Inf,2.0), bareinterval(2.0,3.0)) === Overlap.meets
    @test overlap(bareinterval(1.0,2.0), bareinterval(2.0,3.0)) === Overlap.meets
    @test overlap(bareinterval(1.0,2.0), bareinterval(2.0,Inf)) === Overlap.meets
    @test overlap(bareinterval(1.0,2.0), bareinterval(1.5,2.5)) === Overlap.overlaps
    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === Overlap.starts
    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,3.0)) === Overlap.starts
    @test overlap(bareinterval(1.0,1.0), bareinterval(1.0,3.0)) === Overlap.starts
    @test overlap(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === Overlap.contained_by
    @test overlap(bareinterval(1.0,2.0), bareinterval(-Inf,3.0)) === Overlap.contained_by
    @test overlap(bareinterval(1.0,2.0), bareinterval(0.0,3.0)) === Overlap.contained_by
    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,3.0)) === Overlap.contained_by
    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,Inf)) === Overlap.contained_by
    @test overlap(bareinterval(1.0,2.0), bareinterval(-Inf,2.0)) === Overlap.finishes
    @test overlap(bareinterval(1.0,2.0), bareinterval(0.0,2.0)) === Overlap.finishes
    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,2.0)) === Overlap.finishes
    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === Overlap.equals
    @test overlap(bareinterval(1.0,1.0), bareinterval(1.0,1.0)) === Overlap.equals
    @test overlap(bareinterval(-Inf,1.0), bareinterval(-Inf,1.0)) === Overlap.equals
    @test overlap(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === Overlap.equals
    @test overlap(bareinterval(3.0,4.0), bareinterval(2.0,2.0)) === Overlap.after
    @test overlap(bareinterval(3.0,4.0), bareinterval(1.0,2.0)) === Overlap.after
    @test overlap(bareinterval(3.0,3.0), bareinterval(1.0,2.0)) === Overlap.after
    @test overlap(bareinterval(3.0,3.0), bareinterval(2.0,2.0)) === Overlap.after
    @test overlap(bareinterval(3.0,Inf), bareinterval(2.0,2.0)) === Overlap.after
    @test overlap(bareinterval(2.0,3.0), bareinterval(1.0,2.0)) === Overlap.met_by
    @test overlap(bareinterval(2.0,3.0), bareinterval(-Inf,2.0)) === Overlap.met_by
    @test overlap(bareinterval(1.5,2.5), bareinterval(1.0,2.0)) === Overlap.overlapped_by
    @test overlap(bareinterval(1.5,2.5), bareinterval(-Inf,2.0)) === Overlap.overlapped_by
    @test overlap(bareinterval(1.0,Inf), bareinterval(1.0,2.0)) === Overlap.started_by
    @test overlap(bareinterval(1.0,3.0), bareinterval(1.0,2.0)) === Overlap.started_by
    @test overlap(bareinterval(1.0,3.0), bareinterval(1.0,1.0)) === Overlap.started_by
    @test overlap(bareinterval(-Inf,3.0), bareinterval(1.0,2.0)) === Overlap.contains
    @test overlap(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === Overlap.contains
    @test overlap(bareinterval(0.0,3.0), bareinterval(1.0,2.0)) === Overlap.contains
    @test overlap(bareinterval(0.0,3.0), bareinterval(2.0,2.0)) === Overlap.contains
    @test overlap(bareinterval(-Inf,2.0), bareinterval(1.0,2.0)) === Overlap.finished_by
    @test overlap(bareinterval(0.0,2.0), bareinterval(1.0,2.0)) === Overlap.finished_by
    @test overlap(bareinterval(0.0,2.0), bareinterval(2.0,2.0)) === Overlap.finished_by

end

@testset "minimal_overlap_dec_test" begin
    @test overlap(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) === Overlap.both_empty
    @test overlap(Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv), Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)) === Overlap.first_empty
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(emptyinterval(BareInterval{Float64}), IntervalArithmetic.trv)) === Overlap.second_empty
    @test overlap(Interval(bareinterval(2.0,2.0), IntervalArithmetic.def), Interval(bareinterval(3.0,4.0), IntervalArithmetic.def)) === Overlap.before
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.dac), Interval(bareinterval(3.0,4.0), IntervalArithmetic.com)) === Overlap.before
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.com), Interval(bareinterval(3.0,3.0), IntervalArithmetic.trv)) === Overlap.before
    @test overlap(Interval(bareinterval(2.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(3.0,3.0), IntervalArithmetic.def)) === Overlap.before
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(2.0,3.0), IntervalArithmetic.def)) === Overlap.meets
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.dac), Interval(bareinterval(1.5,2.5), IntervalArithmetic.def)) === Overlap.overlaps
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(1.0,3.0), IntervalArithmetic.com)) === Overlap.starts
    @test overlap(Interval(bareinterval(1.0,1.0), IntervalArithmetic.trv), Interval(bareinterval(1.0,3.0), IntervalArithmetic.def)) === Overlap.starts
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(0.0,3.0), IntervalArithmetic.dac)) === Overlap.contained_by
    @test overlap(Interval(bareinterval(2.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,3.0), IntervalArithmetic.def)) === Overlap.contained_by
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv), Interval(bareinterval(0.0,2.0), IntervalArithmetic.com)) === Overlap.finishes
    @test overlap(Interval(bareinterval(2.0,2.0), IntervalArithmetic.def), Interval(bareinterval(0.0,2.0), IntervalArithmetic.dac)) === Overlap.finishes
    @test overlap(Interval(bareinterval(1.0,2.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) === Overlap.equals
    @test overlap(Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac), Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac)) === Overlap.equals
    @test overlap(Interval(bareinterval(3.0,4.0), IntervalArithmetic.trv), Interval(bareinterval(2.0,2.0), IntervalArithmetic.trv)) === Overlap.after
    @test overlap(Interval(bareinterval(3.0,4.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) === Overlap.after
    @test overlap(Interval(bareinterval(3.0,3.0), IntervalArithmetic.com), Interval(bareinterval(1.0,2.0), IntervalArithmetic.dac)) === Overlap.after
    @test overlap(Interval(bareinterval(3.0,3.0), IntervalArithmetic.def), Interval(bareinterval(2.0,2.0), IntervalArithmetic.trv)) === Overlap.after
    @test overlap(Interval(bareinterval(2.0,3.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) === Overlap.met_by
    @test overlap(Interval(bareinterval(1.5,2.5), IntervalArithmetic.com), Interval(bareinterval(1.0,2.0), IntervalArithmetic.com)) === Overlap.overlapped_by
    @test overlap(Interval(bareinterval(1.0,3.0), IntervalArithmetic.dac), Interval(bareinterval(1.0,2.0), IntervalArithmetic.def)) === Overlap.started_by
    @test overlap(Interval(bareinterval(1.0,3.0), IntervalArithmetic.com), Interval(bareinterval(1.0,1.0), IntervalArithmetic.dac)) === Overlap.started_by
    @test overlap(Interval(bareinterval(0.0,3.0), IntervalArithmetic.com), Interval(bareinterval(1.0,2.0), IntervalArithmetic.dac)) === Overlap.contains
    @test overlap(Interval(bareinterval(0.0,3.0), IntervalArithmetic.com), Interval(bareinterval(2.0,2.0), IntervalArithmetic.def)) === Overlap.contains
    @test overlap(Interval(bareinterval(0.0,2.0), IntervalArithmetic.def), Interval(bareinterval(1.0,2.0), IntervalArithmetic.trv)) === Overlap.finished_by
    @test overlap(Interval(bareinterval(0.0,2.0), IntervalArithmetic.dac), Interval(bareinterval(2.0,2.0), IntervalArithmetic.def)) === Overlap.finished_by

end
