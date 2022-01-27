# This file is part of the IntervalArithmetic.jl package; MIT licensed

#=  This file contains the `overlap` function required for set-based flavor
    by the IEEE Std 1788-2015 (section 10.6.4).
=#

"""
    overlap(a::Interval, b::Interval)

Implement the `overlap` function of the IEEE Std 1788-2015 (section 10.6.4
and Table 10.7).
"""
function overlap(a::Interval, b::Interval)
    # At least one interval is empty
    isempty(a) && isempty(b) && return :both_empty
    isempty(a) && return :first_empty
    isempty(b) && return :second_empty

    # States with both intervals nonempty
    strictprecedes(a, b) && return :before
    !isthin(a) && !isthin(b) && a.hi == b.lo && return :meets
    a.lo < b.lo && a.hi < b.hi && a.hi > b.lo && return :overlaps
    a.lo == b.lo && a.hi < b.hi && return :starts
    b.lo < a.lo && a.hi < b.hi && return :contained_by
    b.lo < a.lo && a.hi == b.hi && return :finishes
    a ≛ b && return :equals
    a.lo < b.lo && a.hi == b.hi && return :finished_by
    b.lo > a.lo && a.hi > b.hi && return :contains
    a.lo == b.lo && a.hi > b.hi && return :started_by
    a.lo > b.lo && a.hi > b.hi && a.lo < b.hi && return :overlapped_by
    !isthin(a) && !isthin(b) && a.lo == b.hi && return :met_by
    strictprecedes(b, a) && return :after
end
