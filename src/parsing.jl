"""
    parse(DecoratedInterval, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval`
with decoration `dec`.
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    s = lowercase(strip(s))
    s == "[nai]" && return nai(T)
    try
        if '_' ∉ s
            ival = _parse(Interval{T}, s)
            return DecoratedInterval(ival)
        end

        decorations = Dict(
            "ill" => ill,
            "trv" => trv,
            "def" => def,
            "dac" => dac,
            "com" => com)

        interval_string, dec = split(s, "_")

        ival = _parse(Interval{T}, interval_string)
        dec_calc = decoration(ival)
        dec_given = decorations[dec]

        dec_given > dec_calc && throw() # by ITF1788, if I try to construct [-Inf, Inf]_com, it should error and return NaI

        return DecoratedInterval(ival, min(dec_given, dec_calc))
    catch
        @warn "invalid input, returning [NaI]"
        return nai(T)
    end
end

"""
    parse(Interval, s::AbstractString)

Parse a string as an `Interval`, according to the grammar specified
in Section 9.7 of the IEEE Std 1788-2015, with some extensions.

The created interval is tight around the value described by the string,
including for number that have no exact float representation like "0.1".
"""
function parse(::Type{Interval{T}}, s::AbstractString) where T
    s = lowercase(strip(s))
    try
        return _parse(Interval{T}, s)
    catch
        @warn "invalid input, empty interval returned"
        return emptyinterval(T)
    end
end

function _parse(::Type{Interval{T}}, s::AbstractString) where T
    if startswith(s, '[') && endswith(s, ']') # parse as interval
        s = strip(s[2:end-1])
        if ',' in s # infsupinterval
            lo, hi = strip.(split(s, ','))
            isempty(lo) && (lo = "-inf")
            isempty(hi) && (hi = "inf")
            lo = parse_num(T, lo, RoundDown)
            hi = parse_num(T, hi, RoundUp)
        else # point interval

            (s == "empty" || isempty(s)) && return emptyinterval(T) # emptyinterval
            s == "entire" && return entireinterval(T) # entireinterval
            lo = parse_num(T, s, RoundDown)
            hi = parse_num(T, s, RoundUp)
        end
    elseif '?' in s # uncertainty interval
        if occursin("??", s) # unbounded interval
            m, _ = split(s, "??")
            if 'u' in s # interval in the form [m, Inf]
                lo = parse(T, m, RoundDown)
                hi = T(Inf)
            elseif 'd' in s # interval in the form [-Inf, m]
                lo = T(-Inf)
                hi = parse(T, m, RoundUp)
            else
                return entireinterval(T)
            end
        else
            m , vde = split(s, '?')

            # ulp computation
            if '.' in m # ulp is last decimal position
                ulp = 1/(big(10.0)^length(split(m, '.')[2]))
            else # no decimal, hence ulp is unit
                ulp = big(1.0)
            end
            m = parse(BigFloat, m)

            if 'e' in vde
                vd, e = split(vde, 'e')
                e = big(10.0) ^ parse(Int, e)
            else
                vd = vde
                e = big(1.0)
            end

            if 'u' in vd || 'd' in vd
                d = last(vd)
                v = vd[1:end-1]
            else
                d = 'b' # both directions
                v = vd
            end

            v = isempty(v) ? 1//2 : parse(BigInt, v)
            if d == 'd'
                lo = T((m - v * ulp) * e, RoundDown)
                hi = T(m * e, RoundUp)
            elseif d == 'u'
                lo = T(m * e, RoundDown)
                hi = T((m + v * ulp) * e, RoundUp)
            else
                lo = T((m - v * ulp) * e, RoundDown)
                hi = T((m + v * ulp) * e, RoundUp)
            end
        end
    else # number
        lo = parse_num(T, s, RoundDown)
        hi = parse_num(T, s, RoundUp)
    end
    is_valid_interval(lo, hi) && return Interval(lo, hi)
    throw()
end

"""
Same as `parse(T, s, rounding_mode)`, but also accept string representing rational numbers.
"""
function parse_num(T, s, rounding_mode)
    if '/' in s
        num, denum = parse.(Int, split(s, '/'))
        return T(num//denum, rounding_mode)
    end
    return T(parse(BigFloat, s), rounding_mode)
end
