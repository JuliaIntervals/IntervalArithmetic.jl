# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the `overlap` function required for set-based flavor
    by the IEEE Std 1788-2015 (section 10.6.4).
=#

"""
    Overlap <: EnumX{Int32}

Struct containing the `overlap` instances included in the IEEE Std 1788-2015.
They are numerated starting on 1. To see the distinct instances, type
`IntervalArithmetic.Overlap.T`.

"""
@enumx Overlap begin
    both_empty = 1
    first_empty
    second_empty
    before
    meets
    overlaps
    starts
    contained_by
    finishes
    equals
    finished_by
    contains
    started_by
    overlapped_by
    met_by
    after
end

"""
    overlap(a::Interval, b::Interval)

Implement the `overlap` function according to the IEEE Std 1788-2015 (section 10.6.4
and Table 10.7).
"""
function overlap(a::Interval, b::Interval)
    # At least one interval is empty
    isempty(a) && isempty(b) && return Overlap.both_empty
    isempty(a) && return Overlap.first_empty
    isempty(b) && return Overlap.second_empty

    # States with both intervals nonempty
    strictprecedes(a, b) && return Overlap.before
    !isthin(a) && !isthin(b) && sup(a) == inf(b) && return Overlap.meets
    inf(a) < inf(b) && sup(a) < sup(b) && sup(a) > inf(b) && return Overlap.overlaps
    inf(a) == inf(b) && sup(a) < sup(b) && return Overlap.starts
    inf(b) < inf(a) && sup(a) < sup(b) && return Overlap.contained_by
    inf(b) < inf(a) && sup(a) == sup(b) && return Overlap.finishes
    a ≛ b && return Overlap.equals
    inf(a) < inf(b) && sup(a) == sup(b) && return Overlap.finished_by
    inf(b) > inf(a) && sup(a) > sup(b) && return Overlap.contains
    inf(a) == inf(b) && sup(a) > sup(b) && return Overlap.started_by
    inf(a) > inf(b) && sup(a) > sup(b) && inf(a) < sup(b) && return Overlap.overlapped_by
    !isthin(a) && !isthin(b) && inf(a) == sup(b) && return Overlap.met_by
    strictprecedes(b, a) && return Overlap.after
end
