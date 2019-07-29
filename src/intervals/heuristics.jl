
struct UndecidableError <: Exception
    msg
end

function isfinite(x::NumberInterval)
    isbounded(x) && return true
    throw(UndecidableError("may represent a finite number (or not)"))
end
isinf(x::NumberInterval) = !isfinite(x)

function iszero(x::NumberInterval)
    if contains_zero(x)
        if isthin(x)
            return true
        else
            throw(UndecidableError("may represent zero (or not)"))
        end
    end
    return false
end

#isequal(a::NumberInterval{T}, b::NumberInterval{S}) where {T, S} =
#    SetInterval{T}(a) == SetInterval{S}(b)
isequal(a::NumberInterval, b::NumberInterval) =
    SetInterval(a) == SetInterval(b)

function ==(a::NumberInterval, b::NumberInterval)
    isthin(a) && isequal(a, b) && return true
    isempty(a ∩ b) && return false
    throw(UndecidableError("may represent equal numbers (or not)"))
end
!=(a::NumberInterval, b::NumberInterval) = !(a == b)

function <(a::NumberInterval, b::NumberInterval)
    strictprecedes(a, b) && return true
    precedes(b, a) && return false
    throw(UndecidableError("cannot compare represented numbers"))
end
>(a::NumberInterval, b::NumberInterval) = b < a
<=(a::NumberInterval, b::NumberInterval) = !(b < a)
#>=(a::NumberInterval, b::NumberInterval) = b <= a
