# power_by_squaring adapted from Base Julia

function power_by_squaring(x::AbstractFloat, p::Integer, r::RoundingMode)

    if p == 1
        return x
    elseif p == 0
        return one(x)
    elseif p == 2
        return *(x, x, r)  # multiplication with directed rounding
    elseif p < 0
        isone(x) && return copy(x)
        isone(-x) && return iseven(p) ? one(x) : copy(x)
        Base.throw_domerr_powbysq(x, p)
    end
    t = trailing_zeros(p) + 1
    p >>= t
    while (t -= 1) > 0
        x = *(x, x, r)
    end
    y = x
    while p > 0
        t = trailing_zeros(p) + 1
        p >>= t
        while (t -= 1) >= 0
            x = *(x, x, r)
        end
        y = *(y, x, r)
    end
    return y
end


function fast_sqrt(x::AbstractFloat, ::RoundingMode{:Down})
    y = sqrt(x)

    while *(y, y, RoundUp) > x
        y = prevfloat(y)
    end

    return y
end

function fast_sqrt(x::AbstractFloat, ::RoundingMode{:Up})
    y = sqrt(x)

    while *(y, y, RoundDown) > x
        y = nextfloat(y)
    end

    return y
end
