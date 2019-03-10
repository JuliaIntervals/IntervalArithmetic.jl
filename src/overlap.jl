function overlap(a::Interval, b::Interval)
    isempty(a) && isempty(b) && return "bothEmpty"
    isempty(a) && !isempty(b) && return "firstEmpty"
    !isempty(a) && isempty(b) && return "secondEmpty"
    a.hi < b.lo && return "before"
    a.lo < a.hi && a.hi == b.lo && b.lo < b.hi && return "meets"
    a.lo < b.lo && b.lo < a.hi && a.hi < b.hi && return "overlaps"
    a.lo == b.lo && a.hi < b.hi && return "starts"
    b.lo < a.lo && a.hi < b.hi && return "containedBy"
    b.lo < a.lo && a.hi == b.hi && return "finishes"
    a.lo == b.lo && a.hi == b.hi && return "equals"
    a.lo < b.lo && b.hi == a.hi && return "finishedBy"
    a.lo < b.lo && b.hi < a.hi && return "contains"
    b.lo == a.lo && b.hi < a.hi && return "startedBy"
    b.lo < a.lo && a.lo < b.hi && b.hi < a.hi && return "overlappedBy"
    b.lo < b.hi && b.hi == a.lo && a.lo < a.hi && return "metBy"
    b.hi < a.lo && return "after"
end

function overlap_dec(xx::DecoratedInterval , yy::DecoratedInterval)
    return overlap(interval_part(xx) , interval_part(yy))
end
