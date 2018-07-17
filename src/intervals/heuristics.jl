
struct UndecidableError <: Exception
    msg
end

function isfinite(x::Interval)
    isbounded(x) && return true
    throw(UndecidableError("may represent a finite number (or not)"))
end
isinf(x::Interval) = !isfinite(x)

isnan(x::Interval) = isnai(x)

function iszero(x::Interval)
    if contains_zero(x)
        if isthin(x)
            return true
        else
            throw(UndecidableError("may represent zero (or not)"))
        end
    end
    return false
end

function ==(a::Interval, b::Interval)
    isthin(a) && isequal(a, b) && return true
    isempty(a ∩ b) && return false
    throw(UndecidableError("may represent equal numbers (or not)"))
end
!=(a::Interval, b::Interval) = !(a == b)

function <(a::Interval, b::Interval)
    strictprecedes(a, b) && return true
    precedes(b, a) && return false
    throw(UndecidableError("cannot compare represented numbers"))
end
>(a::Interval, b::Interval) = b < a
<=(a::Interval, b::Interval) = !(b < a)
#>=(a::Interval, b::Interval) = b <= a
