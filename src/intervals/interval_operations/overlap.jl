# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the `overlap` function required for set-based flavor
    by the IEEE Std 1788-2015 (section 10.6.4).
=#

# Define the OverlapType <: Enum{Int32} instances. They are numerated starting on 1.
@enum OverlapType begin
    _both_empty=1
    _first_empty
    _second_empty
    _before
    _meets
    _overlaps
    _starts
    _contained_by
    _finishes
    _equals
    _finished_by
    _contains
    _started_by
    _overlapped_by
    _met_by
    _after
end

"""
    overlap(a::Interval, b::Interval)

Implement the `overlap` function of the IEEE Std 1788-2015 (section 10.6.4
and Table 10.7).
"""
function overlap(a::Interval, b::Interval)
    # At least one interval is empty
    isempty(a) && isempty(b) && return _both_empty
    isempty(a) && return _first_empty
    isempty(b) && return _second_empty

    # States with both intervals nonempty
    strictprecedes(a, b) && return _before
    !isthin(a) && !isthin(b) && a.hi == b.lo && return _meets
    a.lo < b.lo && a.hi < b.hi && a.hi > b.lo && return _overlaps
    a.lo == b.lo && a.hi < b.hi && return _starts
    b.lo < a.lo && a.hi < b.hi && return _contained_by
    b.lo < a.lo && a.hi == b.hi && return _finishes
    a ≛ b && return _equals
    a.lo < b.lo && a.hi == b.hi && return _finished_by
    b.lo > a.lo && a.hi > b.hi && return _contains
    a.lo == b.lo && a.hi > b.hi && return _started_by
    a.lo > b.lo && a.hi > b.hi && a.lo < b.hi && return _overlapped_by
    !isthin(a) && !isthin(b) && a.lo == b.hi && return _met_by
    strictprecedes(b, a) && return _after
end
