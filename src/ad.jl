function _abs_deriv(x::Interval{T}) where T 
    if inf(x) == zero(T)
        return Interval(one(T))
    elseif sup(x) == zero(T)
        return -one(T) .. one(T)
    else
        return sign(x)
    end
end