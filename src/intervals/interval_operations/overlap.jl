# This file contains the `overlap` function required for set-based flavor in
# Section 10.6.4 of the IEEE Standard 1788-2015

"""
    Overlap

Module containing the enumeration constant `State` described in Section 10.6.4
of the IEEE Standard 1788-2015.
"""
module Overlap
    @enum State begin
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
end

"""
    overlap(x::BareInterval, y::BareInterval)
    overlap(x::Interval, y::Interval)

Implement the `overlap` function of the IEEE Standard 1788-2015 (Table 10.7).
"""
function overlap(x::BareInterval, y::BareInterval)
    # at least one interval is empty
    isempty_interval(x) & isempty_interval(y) && return Overlap.both_empty
    isempty_interval(x) && return Overlap.first_empty
    isempty_interval(y) && return Overlap.second_empty

    # states with both intervals non-empty
    sup(x) < inf(y) && return Overlap.before
    (inf(x) != sup(x)) & (inf(y) != sup(y)) & (sup(x) == inf(y)) && return Overlap.meets
    (inf(x) < inf(y)) & (sup(x) < sup(y)) & (sup(x) > inf(y)) && return Overlap.overlaps
    (inf(x) == inf(y)) & (sup(x) < sup(y)) && return Overlap.starts
    (inf(y) < inf(x)) & (sup(x) < sup(y)) && return Overlap.contained_by
    (inf(y) < inf(x)) & (sup(x) == sup(y)) && return Overlap.finishes
    isequal_interval(x, y) && return Overlap.equals
    (inf(x) < inf(y)) & (sup(x) == sup(y)) && return Overlap.finished_by
    (inf(y) > inf(x)) & (sup(x) > sup(y)) && return Overlap.contains
    (inf(x) == inf(y)) & (sup(x) > sup(y)) && return Overlap.started_by
    (inf(x) > inf(y)) & (sup(x) > sup(y)) & (inf(x) < sup(y)) && return Overlap.overlapped_by
    (inf(x) != sup(x)) & (inf(y) != sup(y)) & (inf(x) == sup(y)) && return Overlap.met_by
    (sup(y) < sup(x)) && return Overlap.after
end

function overlap(x::Interval, y::Interval)
    isnai(x) | isnai(y) && return throw(ArgumentError("overlap is not defined for NaI"))
    return overlap(bareinterval(x), bareinterval(y))
end
