@testset "minimal_overlap_test" begin

    @test overlap(emptyinterval(BareInterval{Float64}), emptyinterval(BareInterval{Float64})) === IntervalArithmetic.Overlap.both_empty

    @test overlap(emptyinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.first_empty

    @test overlap(bareinterval(1.0,2.0), emptyinterval(BareInterval{Float64})) === IntervalArithmetic.Overlap.second_empty

    @test overlap(bareinterval(-Inf,2.0), bareinterval(3.0,Inf)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(-Inf,2.0), bareinterval(3.0,4.0)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,4.0)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(1.0,2.0), bareinterval(3.0,4.0)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(1.0,2.0), bareinterval(3.0,3.0)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,3.0)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(2.0,2.0), bareinterval(3.0,Inf)) === IntervalArithmetic.Overlap.before

    @test overlap(bareinterval(-Inf,2.0), bareinterval(2.0,3.0)) === IntervalArithmetic.Overlap.meets

    @test overlap(bareinterval(1.0,2.0), bareinterval(2.0,3.0)) === IntervalArithmetic.Overlap.meets

    @test overlap(bareinterval(1.0,2.0), bareinterval(2.0,Inf)) === IntervalArithmetic.Overlap.meets

    @test overlap(bareinterval(1.0,2.0), bareinterval(1.5,2.5)) === IntervalArithmetic.Overlap.overlaps

    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,Inf)) === IntervalArithmetic.Overlap.starts

    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,3.0)) === IntervalArithmetic.Overlap.starts

    @test overlap(bareinterval(1.0,1.0), bareinterval(1.0,3.0)) === IntervalArithmetic.Overlap.starts

    @test overlap(bareinterval(1.0,2.0), entireinterval(BareInterval{Float64})) === IntervalArithmetic.Overlap.contained_by

    @test overlap(bareinterval(1.0,2.0), bareinterval(-Inf,3.0)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(bareinterval(1.0,2.0), bareinterval(0.0,3.0)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,3.0)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,Inf)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(bareinterval(1.0,2.0), bareinterval(-Inf,2.0)) === IntervalArithmetic.Overlap.finishes

    @test overlap(bareinterval(1.0,2.0), bareinterval(0.0,2.0)) === IntervalArithmetic.Overlap.finishes

    @test overlap(bareinterval(2.0,2.0), bareinterval(0.0,2.0)) === IntervalArithmetic.Overlap.finishes

    @test overlap(bareinterval(1.0,2.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.equals

    @test overlap(bareinterval(1.0,1.0), bareinterval(1.0,1.0)) === IntervalArithmetic.Overlap.equals

    @test overlap(bareinterval(-Inf,1.0), bareinterval(-Inf,1.0)) === IntervalArithmetic.Overlap.equals

    @test overlap(entireinterval(BareInterval{Float64}), entireinterval(BareInterval{Float64})) === IntervalArithmetic.Overlap.equals

    @test overlap(bareinterval(3.0,4.0), bareinterval(2.0,2.0)) === IntervalArithmetic.Overlap.after

    @test overlap(bareinterval(3.0,4.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.after

    @test overlap(bareinterval(3.0,3.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.after

    @test overlap(bareinterval(3.0,3.0), bareinterval(2.0,2.0)) === IntervalArithmetic.Overlap.after

    @test overlap(bareinterval(3.0,Inf), bareinterval(2.0,2.0)) === IntervalArithmetic.Overlap.after

    @test overlap(bareinterval(2.0,3.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.met_by

    @test overlap(bareinterval(2.0,3.0), bareinterval(-Inf,2.0)) === IntervalArithmetic.Overlap.met_by

    @test overlap(bareinterval(1.5,2.5), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.overlapped_by

    @test overlap(bareinterval(1.5,2.5), bareinterval(-Inf,2.0)) === IntervalArithmetic.Overlap.overlapped_by

    @test overlap(bareinterval(1.0,Inf), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.started_by

    @test overlap(bareinterval(1.0,3.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.started_by

    @test overlap(bareinterval(1.0,3.0), bareinterval(1.0,1.0)) === IntervalArithmetic.Overlap.started_by

    @test overlap(bareinterval(-Inf,3.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.contains

    @test overlap(entireinterval(BareInterval{Float64}), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.contains

    @test overlap(bareinterval(0.0,3.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.contains

    @test overlap(bareinterval(0.0,3.0), bareinterval(2.0,2.0)) === IntervalArithmetic.Overlap.contains

    @test overlap(bareinterval(-Inf,2.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.finished_by

    @test overlap(bareinterval(0.0,2.0), bareinterval(1.0,2.0)) === IntervalArithmetic.Overlap.finished_by

    @test overlap(bareinterval(0.0,2.0), bareinterval(2.0,2.0)) === IntervalArithmetic.Overlap.finished_by

end

@testset "minimal_overlap_dec_test" begin

    @test overlap(interval(emptyinterval(BareInterval{Float64}), trv), interval(emptyinterval(BareInterval{Float64}), trv)) === IntervalArithmetic.Overlap.both_empty

    @test overlap(interval(emptyinterval(BareInterval{Float64}), trv), interval(bareinterval(1.0,2.0), com)) === IntervalArithmetic.Overlap.first_empty

    @test overlap(interval(bareinterval(1.0,2.0), def), interval(emptyinterval(BareInterval{Float64}), trv)) === IntervalArithmetic.Overlap.second_empty

    @test overlap(interval(bareinterval(2.0,2.0), def), interval(bareinterval(3.0,4.0), def)) === IntervalArithmetic.Overlap.before

    @test overlap(interval(bareinterval(1.0,2.0), dac), interval(bareinterval(3.0,4.0), com)) === IntervalArithmetic.Overlap.before

    @test overlap(interval(bareinterval(1.0,2.0), com), interval(bareinterval(3.0,3.0), trv)) === IntervalArithmetic.Overlap.before

    @test overlap(interval(bareinterval(2.0,2.0), trv), interval(bareinterval(3.0,3.0), def)) === IntervalArithmetic.Overlap.before

    @test overlap(interval(bareinterval(1.0,2.0), def), interval(bareinterval(2.0,3.0), def)) === IntervalArithmetic.Overlap.meets

    @test overlap(interval(bareinterval(1.0,2.0), dac), interval(bareinterval(1.5,2.5), def)) === IntervalArithmetic.Overlap.overlaps

    @test overlap(interval(bareinterval(1.0,2.0), def), interval(bareinterval(1.0,3.0), com)) === IntervalArithmetic.Overlap.starts

    @test overlap(interval(bareinterval(1.0,1.0), trv), interval(bareinterval(1.0,3.0), def)) === IntervalArithmetic.Overlap.starts

    @test overlap(interval(bareinterval(1.0,2.0), def), interval(bareinterval(0.0,3.0), dac)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(interval(bareinterval(2.0,2.0), trv), interval(bareinterval(0.0,3.0), def)) === IntervalArithmetic.Overlap.contained_by

    @test overlap(interval(bareinterval(1.0,2.0), trv), interval(bareinterval(0.0,2.0), com)) === IntervalArithmetic.Overlap.finishes

    @test overlap(interval(bareinterval(2.0,2.0), def), interval(bareinterval(0.0,2.0), dac)) === IntervalArithmetic.Overlap.finishes

    @test overlap(interval(bareinterval(1.0,2.0), def), interval(bareinterval(1.0,2.0), def)) === IntervalArithmetic.Overlap.equals

    @test overlap(interval(bareinterval(1.0,1.0), dac), interval(bareinterval(1.0,1.0), dac)) === IntervalArithmetic.Overlap.equals

    @test overlap(interval(bareinterval(3.0,4.0), trv), interval(bareinterval(2.0,2.0), trv)) === IntervalArithmetic.Overlap.after

    @test overlap(interval(bareinterval(3.0,4.0), def), interval(bareinterval(1.0,2.0), def)) === IntervalArithmetic.Overlap.after

    @test overlap(interval(bareinterval(3.0,3.0), com), interval(bareinterval(1.0,2.0), dac)) === IntervalArithmetic.Overlap.after

    @test overlap(interval(bareinterval(3.0,3.0), def), interval(bareinterval(2.0,2.0), trv)) === IntervalArithmetic.Overlap.after

    @test overlap(interval(bareinterval(2.0,3.0), def), interval(bareinterval(1.0,2.0), trv)) === IntervalArithmetic.Overlap.met_by

    @test overlap(interval(bareinterval(1.5,2.5), com), interval(bareinterval(1.0,2.0), com)) === IntervalArithmetic.Overlap.overlapped_by

    @test overlap(interval(bareinterval(1.0,3.0), dac), interval(bareinterval(1.0,2.0), def)) === IntervalArithmetic.Overlap.started_by

    @test overlap(interval(bareinterval(1.0,3.0), com), interval(bareinterval(1.0,1.0), dac)) === IntervalArithmetic.Overlap.started_by

    @test overlap(interval(bareinterval(0.0,3.0), com), interval(bareinterval(1.0,2.0), dac)) === IntervalArithmetic.Overlap.contains

    @test overlap(interval(bareinterval(0.0,3.0), com), interval(bareinterval(2.0,2.0), def)) === IntervalArithmetic.Overlap.contains

    @test overlap(interval(bareinterval(0.0,2.0), def), interval(bareinterval(1.0,2.0), trv)) === IntervalArithmetic.Overlap.finished_by

    @test overlap(interval(bareinterval(0.0,2.0), dac), interval(bareinterval(2.0,2.0), def)) === IntervalArithmetic.Overlap.finished_by

end
