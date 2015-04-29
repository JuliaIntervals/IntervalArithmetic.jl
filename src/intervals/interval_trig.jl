
#----- From here on, NEEDS TESTING ------

function sin{T<:Real}(a::Interval{T})
    piHalf = convert(T, pi) / 2
    twoPi = convert(T, pi) * 2
    rangeSin = @round(T, -one(T), one(T))

    # Checking the specific case
    diam(a) >= twoPi && return rangeSin

    # Limits within 1 full period of sin(x)
    # Abbreviations
    loMod2pi = mod(a.lo, twoPi)
    hiMod2pi = mod(a.hi, twoPi)
    loQuartile = floor( loMod2pi / piHalf )
    hiQuartile = floor( hiMod2pi / piHalf )

    # 20 different cases
    if loQuartile == hiQuartile # Interval limits in the same quartile
        loMod2pi > hiMod2pi && return rangeSin
        return @round(T, sin(a.lo), sin(a.hi))

    elseif loQuartile == 3 && hiQuartile==0
        return @round(T, sin(a.lo), sin(a.hi))

    elseif loQuartile == 1 && hiQuartile==2
        return @round(T, sin(a.hi), sin(a.lo))

    elseif ( loQuartile == 0 || loQuartile==3 ) && ( hiQuartile==1 || hiQuartile==2 )
        return @round(T, min(sin(a.lo), sin(a.hi)), one(T))

    elseif ( loQuartile == 1 || loQuartile==2 ) && ( hiQuartile==3 || hiQuartile==0 )
        return @round(T, -one(T), max(sin(a.lo), sin(a.hi)))

    elseif ( loQuartile == 0 && hiQuartile==3 ) || ( loQuartile == 2 && hiQuartile==1 )
        return rangeSin
    else
        # This should be never reached!
        error(string("SOMETHING WENT WRONG in sin.\nThis should have never been reached") )
    end
end


function cos{T<:Real}(a::Interval{T})
    piHalf = convert(T, pi) / 2
    twoPi = convert(T, pi) * 2
    rangeCos = @round(T, -one(T), one(T))

    # Checking the specific case
    diam(a) >= twoPi && return rangeCos

    # Limits within 1 full period of sin(x)
    # Abbreviations
    loMod2pi = mod(a.lo, twoPi)
    hiMod2pi = mod(a.hi, twoPi)
    loQuartile = floor( loMod2pi / piHalf )
    hiQuartile = floor( hiMod2pi / piHalf )

    # 20 different cases
    if loQuartile == hiQuartile # Interval limits in the same quartile
        loMod2pi > hiMod2pi && return rangeCos
        return @round(T, cos(a.hi), cos(a.lo))

    elseif loQuartile == 2 && hiQuartile==3
        return @round(T, cos(a.lo), cos(a.hi))

    elseif loQuartile == 0 && hiQuartile==1
        return @round(T, cos(a.hi), cos(a.lo))

    elseif ( loQuartile == 2 || loQuartile==3 ) && ( hiQuartile==0 || hiQuartile==1 )
        return @round(T, min(cos(a.lo), cos(a.hi)), one(T))

    elseif ( loQuartile == 0 || loQuartile==1 ) && ( hiQuartile==2 || hiQuartile==3 )
        return @round(T, -one(T), max(cos(a.lo), cos(a.hi)))

    elseif ( loQuartile == 3 && hiQuartile==2 ) || ( loQuartile == 1 && hiQuartile==0 )
        return rangeCos
    else
        # This should be never reached!
        error(string("SOMETHING WENT WRONG in cos.\nThis should have never been reached") )
    end
end


function tan{T}(a::Interval{T})
    bigPi = convert(T, pi)
    piHalf = bigPi / 2
    rangeTan = Interval{T}( -Inf, Inf )

    # Checking the specific case
    diam(a) >= bigPi && return rangeTan

    # within 1 full period of tan(x) --> 4 cases
    # some abreviations
    loModpi = mod(a.lo, bigPi)
    hiModpi = mod(a.hi, bigPi)
    loHalf = floor( loModpi / piHalf )
    hiHalf = floor( hiModpi / piHalf )

    I = @round(T, tan(a.lo), tan(a.hi))

    if (loHalf > hiHalf) || ( loHalf == hiHalf && loModpi <= hiModpi)
        return I
    end

    disjoint2 = Interval{T}( I.lo, Inf )
    disjoint1 = Interval{T}( -Inf, I.hi)
    # info(string("The resulting interval is disjoint:\n", disjoint1, "\n", disjoint2,
    #            "\n The hull of the disjoint subintervals is considered:\n", rangeTan))
    return rangeTan
end

