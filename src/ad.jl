function _abs_deriv(x::Interval{T}) where T 
    if inf(x) == 0
        return Interval{T}(1)
    elseif sup(x) == 0
        return Interval{T}(-1, 1)
    else
        return sign(x)
    end
end