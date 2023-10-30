# This file contains the `overlap` function required for set-based flavor in
# Section 10.6.4 of the IEEE Standard 1788-2015.

"""
    Overlap <: EnumX{Int32}

Struct containing the `overlap` instances included in the IEEE Standard 1788-2015.
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



# bare intervals

"""
    overlap(a, b)

Implement the `overlap` function according to the IEEE Standard 1788-2015
(Section 10.6.4 and Table 10.7).
"""
function overlap(a::BareInterval, b::BareInterval)
    # At least one interval is empty
    isempty_interval(a) && isempty_interval(b) && return Overlap.both_empty
    isempty_interval(a) && return Overlap.first_empty
    isempty_interval(b) && return Overlap.second_empty

    # States with both intervals nonempty
    sup(a) < inf(b) && return Overlap.before
    inf(a) != sup(a) && inf(b) != sup(b) && sup(a) == inf(b) && return Overlap.meets
    inf(a) < inf(b) && sup(a) < sup(b) && sup(a) > inf(b) && return Overlap.overlaps
    inf(a) == inf(b) && sup(a) < sup(b) && return Overlap.starts
    inf(b) < inf(a) && sup(a) < sup(b) && return Overlap.contained_by
    inf(b) < inf(a) && sup(a) == sup(b) && return Overlap.finishes
    isequal_interval(a, b) && return Overlap.equals
    inf(a) < inf(b) && sup(a) == sup(b) && return Overlap.finished_by
    inf(b) > inf(a) && sup(a) > sup(b) && return Overlap.contains
    inf(a) == inf(b) && sup(a) > sup(b) && return Overlap.started_by
    inf(a) > inf(b) && sup(a) > sup(b) && inf(a) < sup(b) && return Overlap.overlapped_by
    inf(a) != sup(a) && inf(b) != sup(b) && inf(a) == sup(b) && return Overlap.met_by
    sup(b) < sup(a) && return Overlap.after
end



# decorated intervals
# TODO: handle NaI differently

overlap(x::Interval, y::Interval) = overlap(bareinterval(x), bareinterval(y))
