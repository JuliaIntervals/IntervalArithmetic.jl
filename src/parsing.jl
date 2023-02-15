"""
    parse(DecoratedInterval, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval` with decoration `dec`.
If the decoration is not specified, it is computed based on the parsed interval.
If the input is an invalid string, a warning is printed and [NaI] is returned. The parser is
case unsensitive.

### Examples

```jldoctest
julia> @format true
Display parameters:
- format: standard
- decorations: true
- significant figures: 6

julia> parse(DecoratedInterval{Float64}, "[1, 2]")
[1, 2]_com

julia> parse(DecoratedInterval{Float64}, "[1, 2]_def")
[1, 2]_def

julia> parse(DecoratedInterval{Float64}, "foobar")
┌ Warning: invalid input, returning [NaI]
└ @ IntervalArithmetic ~/.julia/dev/IntervalArithmetic/src/parsing.jl:44
[NaN, NaN]_ill
```
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    s = lowercase(strip(s))
    s == "[nai]" && return nai(T)
    try
        if '_' ∉ s
            ival, _ = _parse(Interval{T}, s)
            return DecoratedInterval{T}(ival)
        end

        decorations = Dict(
            "ill" => ill,
            "trv" => trv,
            "def" => def,
            "dac" => dac,
            "com" => com)

        interval_string, dec = split(s, "_")

        ival, isnotcom = _parse(Interval{T}, interval_string)
        dec_calc = decoration(ival)

        haskey(decorations, dec) || throw(ArgumentError("invalid decoration $dec"))
        dec_given = decorations[dec]

        #=
            If I try to give a decoration that is too high, e.g. [1, Inf]_com, then it
            should error and return [NaI]. Exception to this is if the interval would be com
            but becomes dac because of finite precision, e.g. "[1e403]_com" when parse to
            Interval{Float64} is allowed to become [prevfloat(Inf), Inf]_dac without erroring.
            The isnotcom flag returned by _parse is used to track if the interval was originally
            smaller than com or became dac because of overflow.
        =#
        dec_given > dec_calc && isnotcom && throw(ArgumentError("invalid decoration $dec for $ival"))

        return DecoratedInterval{T}(ival, min(dec_given, dec_calc))
    catch e
        if e isa ArgumentError
            @warn "invalid input, returning [NaI]"
            return nai(T)
        else
            rethrow(e)
        end
    end
end

"""
    parse(Interval, s::AbstractString)

Parse a string as an `Interval`, according to the grammar specified
in Section 9.7 of the IEEE Std 1788-2015.

The created interval is tight around the value described by the string,
including for number that have no exact float representation like "0.1". If the input is
an invalid string, a warning is printed and an empty interval is returned. The parser is
case unsensitive.

### Allowed format

Here are some examples of allowed formats, for more details see sections 9.7 and 12.11 of
the standard

- `[ 1.33 ]` or simply `1.33` : The interval containing only `1.33``.
- `[ 1.44, 2.78 ]` : The interval `[1.44, 2.78]`.
- `[empty]` : the empty interval
- `[entire]` or `[,]`: the interval `[-∞, ∞]`
- `[3,]`: The interval `[3, ∞]`
- `6.42?2` : The interval `6.42 ± 0.02`. The number after `?` represent the uncertainty in
  the last digit. The default value is `0.5` (e.g. `2.3? == 2.3 ± 0.05`). The direction of
  the uncertainty can be given by adding 'u' or 'd' at the end for the error going only up
  or down respectively (e.g. `4.5?5u == [4.5, 5]`).
- `6.42?2e2` : The interval `(6.42 ± 0.02)⋅10³ == 642 ± 2`
- `3??u` : the interval `[3, ∞]`
- `3??u` : the interval `[3, ∞]`
- `3??` : the interval `[-∞, ∞]`

### Examples

```julia
julia> parse(Interval{Float64}, "[1, 2]")
[1, 2]

julia> parse(Interval{Float64}, "[1,]")
[1, ∞]

julia> parse(Interval{Float64}, "[,]")
[-∞, ∞]

julia> parse(Interval{Float64}, "6.42?2e2")
[640, 644]

julia> parse(Interval{Float64}, "foobar")
┌ Warning: invalid input, empty interval returned
└ @ IntervalArithmetic ~/.julia/dev/IntervalArithmetic/src/parsing.jl:68
∅
```
"""
function parse(::Type{Interval{T}}, s::AbstractString) where T
    s = lowercase(strip(s))
    try
        ival, _ = _parse(Interval{T}, s)
        return ival
    catch e
        if e isa ArgumentError
            @warn "invalid input, empty interval returned"
            return emptyinterval(T)
        else
            rethrow(e)
        end
    end
end

"""
    _parse(::Type{Interval{T}}, s::AbstractString) where T

tries to parse the string `s` to an interval of type `Interval{T}` and throws an argument
error if an invalid string is given.

### Output

- the parsed interval
- a flag `isnotcom`, which is set to true if the input interval is not `com` and to false
  otherwise. This is used to distinguish the case when an interval is supposed to be
  unbounded (e.g. input `"[3, infinity]"`) or becomes unbounded because of overflow
  (e.g. the input `"[3, 1e400]", which is parse to `[3, ∞]` when using `Float64`).
"""
function _parse(::Type{Interval{T}}, s::AbstractString) where T
    isnotcom = occursin("inf", s)
    if startswith(s, '[') && endswith(s, ']') # parse as interval
        s = strip(s[2:end-1])
        if ',' in s # infsupinterval
            lo, hi = strip.(split(s, ','))
            isempty(lo) && (lo = "-inf"; isnotcom = true)
            isempty(hi) && (hi = "inf"; isnotcom = true)
            lo = parse_num(T, lo, RoundDown)
            hi = parse_num(T, hi, RoundUp)
        else # point interval

            (s == "empty" || isempty(s)) && return emptyinterval(T), true # emptyinterval
            s == "entire" && return entireinterval(T), true # entireinterval
            lo = parse_num(T, s, RoundDown)
            hi = parse_num(T, s, RoundUp)
        end
    elseif '?' in s # uncertainty interval
        if occursin("??", s) # unbounded interval
            isnotcom = true
            m, _ = split(s, "??")
            if 'u' in s # interval in the form [m, Inf]
                lo = parse(T, m, RoundDown)
                hi = T(Inf)
            elseif 'd' in s # interval in the form [-Inf, m]
                lo = T(-Inf)
                hi = parse(T, m, RoundUp)
            else
                return entireinterval(T), true
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
    is_valid_interval(lo, hi) && return Interval{T}(lo, hi), isnotcom
    throw(ArgumentError("input $s can not be parsed as an interval."))
end

"""
Same as `parse(T, s, rounding_mode)`, but also accept string representing rational numbers.
"""
function parse_num(T, s, rounding_mode)
    if '/' in s
        num, denum = parse.(BigInt, split(s, '/'))
        return T(num//denum, rounding_mode)
    end
    return T(parse(BigFloat, s), rounding_mode)
end
