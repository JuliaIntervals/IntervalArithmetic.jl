"""
    I"str"

Create an interval according to the IEEE Standard 1788-2015. This is
semantically equivalent to `parse(Interval{default_numtype()}, str)`.

# Examples
```jldoctest
julia> setdisplay(:full);

julia> I"[3, 4]"
Interval{Float64}(3.0, 4.0, com)

julia> I"0.1"
Interval{Float64}(0.09999999999999999, 0.1, com)
```
"""
macro I_str(str)
    return parse(Interval{default_numtype()}, str)
end

#

"""
    parse(BareInterval, s::AbstractString)

Create an interval according to the IEEE Standard 1788-2015. In contrast with
constructors that do not use strings, this constructor guarantees that the
returned interval tightly encloses the values described by the string, including
numbers that have no exact float representation (e.g. 0.1).

Examples of allowed string formats:
- `I"[1.33]"` or `I"1.33"`: the interval containing ``1.33``.
- `I"[1.44, 2.78]"`: the interval ``[1.44, 2.78]``.
- `I"[empty]"`: the empty interval.
- `I"[entire]"` or `I"[,]"`: the interval ``[-\\infty, \\infty]``.
- `I"[3,]"`: the interval ``[3, \\infty]``.
- `I"6.42?2"`: the interval ``[6.4,  6.44]``. The number after `?` represents the
    uncertainty in the last digit; by default this value is `0.5`. The direction
    of the uncertainty can be given by adding `u` or `d` at the end for the error
    to only go up or down respectively (e.g. `I"4.5?5u"` represents ``[4.5, 5]``).
- `I"6.42?2e2"`: the interval ``[642, 644]``.
- `I"3??u"`: the interval ``[3, \\infty]``.
- `I"3??u"`: the interval ``[3, \\infty]``.
- `I"3??"`: the interval ``[-\\infty, \\infty]``.

For more details, see sections 9.7 and 12.11 of the IEEE Standard 1788-2015.

# Examples
```jldoctest
julia> setdisplay(:full);

julia> parse(BareInterval{Float64}, "[1, 2]")
BareInterval{Float64}(1.0, 2.0)

julia> parse(BareInterval{Float64}, "[1, 2]")
BareInterval{Float64}(1.0, 2.0)

julia> parse(BareInterval{Float64}, "[1,]")
BareInterval{Float64}(1.0, Inf)

julia> parse(BareInterval{Float64}, "[,]")
BareInterval{Float64}(-Inf, Inf)

julia> parse(BareInterval{Float64}, "6.42?2e2")
BareInterval{Float64}(640.0, 644.0)
```
"""
function parse(::Type{BareInterval{T}}, str::AbstractString) where {T<:NumTypes}
    str = lowercase(strip(str))
    try
        ival, _ = _parse(BareInterval{T}, str)
        return ival
    catch e
        if e isa ArgumentError
            @warn "invalid input, empty bare interval is returned"
            return emptyinterval(BareInterval{T})
        else
            rethrow(e)
        end
    end
end

"""
    parse(Interval, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as an `Interval` with decoration `dec`.
If the decoration is not specified, it is computed based on the parsed interval.
If the input is an invalid string, a warning is printed and NaI is returned. The parser is
case unsensitive.

# Examples
```jldoctest
julia> setdisplay(:full);

julia> parse(Interval{Float64}, "[1, 2]")
Interval{Float64}(1.0, 2.0, com)

julia> parse(Interval{Float64}, "[1, 2]_def")
Interval{Float64}(1.0, 2.0, def)
```
"""
function parse(::Type{Interval{T}}, s::AbstractString) where {T<:NumTypes}
    s = lowercase(strip(s))
    s == "[nai]" && return nai(T)
    try
        if '_' ∉ s
            ival, _ = _parse(BareInterval{T}, s)
            return interval(T, ival)
        end

        decorations = Dict{String,Decoration}(
            "ill" => ill,
            "trv" => trv,
            "def" => def,
            "dac" => dac,
            "com" => com)

        interval_string, dec = split(s, "_")

        ival, isnotcom = _parse(BareInterval{T}, interval_string)
        dec_calc = decoration(ival)

        haskey(decorations, dec) || return throw(ArgumentError("invalid decoration $dec"))
        dec_given = decorations[dec]

        #=
            If I try to give a decoration that is too high, e.g. [1, Inf]_com, then it
            should error and return NaI. Exception to this is if the interval would be com
            but becomes dac because of finite precision, e.g. "[1e403]_com" when parse to
            Interval{Float64} is allowed to become [prevfloat(Inf), Inf]_dac without erroring.
            The isnotcom flag returned by _parse is used to track if the interval was originally
            smaller than com or became dac because of overflow.
        =#
        dec_given > dec_calc && isnotcom && return throw(ArgumentError("invalid decoration $dec for $ival"))

        return interval(T, ival, min(dec_given, dec_calc))
    catch e
        if e isa ArgumentError
            @warn "invalid input, NaI is returned"
            return nai(T)
        else
            rethrow(e)
        end
    end
end

"""
    _parse(::Type{Interval{T}}, s::AbstractString) where T

Try to parse the string `s` to an interval of type `Interval{T}` and throws an argument
error if an invalid string is given.

### Output

- the parsed interval
- a flag `isnotcom`, which is set to true if the input interval is not `com` and to false
  otherwise. This is used to distinguish the case when an interval is supposed to be
  unbounded (e.g. input `"[3, infinity]"`) or becomes unbounded because of overflow
  (e.g. the input `"[3, 1e400]", which is parse to `[3, ∞]` when using `Float64`).
"""
function _parse(::Type{BareInterval{T}}, s::AbstractString) where {T<:NumTypes}
    isnotcom = occursin("inf", s)
    if startswith(s, '[') && endswith(s, ']') # parse as interval
        s = strip(s[2:end-1])
        if ',' in s # inf-sup interval
            lo, hi = strip.(split(s, ','))
            isempty(lo) && (lo = "-inf"; isnotcom = true)
            isempty(hi) && (hi = "inf"; isnotcom = true)
            lo = _parse_num(T, lo, RoundDown)
            hi = _parse_num(T, hi, RoundUp)
        else # point interval

            (s == "empty" || isempty(s)) && return emptyinterval(BareInterval{T}), true
            s == "entire" && return entireinterval(BareInterval{T}), true
            lo = _parse_num(T, s, RoundDown)
            hi = _parse_num(T, s, RoundUp)
        end
    elseif '?' in s # uncertainty interval
        if occursin("??", s) # unbounded interval
            isnotcom = true
            m, _ = split(s, "??")
            if 'u' in s # interval in the form [m, Inf]
                lo = parse(T, m, RoundDown)
                hi = typemax(T)
            elseif 'd' in s # interval in the form [-Inf, m]
                lo = typemin(T)
                hi = parse(T, m, RoundUp)
            else
                return entireinterval(BareInterval{T}), true
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
        lo = _parse_num(T, s, RoundDown)
        hi = _parse_num(T, s, RoundUp)
    end
    is_valid_interval(lo, hi) && return _unsafe_bareinterval(T, lo, hi), isnotcom
    return throw(ArgumentError("input $s can not be parsed as an interval."))
end

"""
Same as `parse(T, s, rounding_mode)`, but also accept string representing rational numbers.
"""
function _parse_num(::Type{T}, str::AbstractString, ::RoundingMode{:Down}) where {S<:Integer,T<:Rational{S}}
    '/' ∈ str && return parse(T, str)
    x = parse(BigFloat, str)
    y = prevfloat(x)
    z = rationalize(S, y)
    z < x && return z
    return rationalize(S, prevfloat(y))
end
function _parse_num(::Type{T}, str::AbstractString, ::RoundingMode{:Up}) where {S<:Integer,T<:Rational{S}}
    '/' ∈ str && return parse(T, str)
    x = parse(BigFloat, str)
    y = nextfloat(x)
    z = rationalize(S, y)
    z > x && return z
    return rationalize(S, nextfloat(y))
end
function _parse_num(::Type{T}, str::AbstractString, rounding_mode::RoundingMode) where {T<:AbstractFloat}
    if '/' ∈ str
        num, denum = parse.(BigInt, split(str, '/'; keepempty = false))
        return T(num//denum, rounding_mode)
    end
    return T(parse(BigFloat, str), rounding_mode)
end
