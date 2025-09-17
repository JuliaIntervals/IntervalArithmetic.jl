"""
    I"str"

Create an interval by parsing the string `"str"`; this is semantically
equivalent to `parse(Interval{default_numtype()}, "str")`.

# Examples

```jldoctest
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> I"[3, 4]"
Interval{Float64}(3.0, 4.0, com, true)

julia> I"0.1"
Interval{Float64}(0.09999999999999999, 0.1, com, true)

julia> in_interval(1//10, I"0.1")
true
```
"""
macro I_str(str)
    return _parse(str)
end

"""
    parse(T<:BareInterval, str)
    parse(T<:Interval, str)

Create an interval according to the IEEE Standard 1788-2015. In contrast with
constructors that do not use strings, this constructor guarantees that the
returned interval tightly encloses the values described by the string, including
numbers that have no exact float representation (e.g. 0.1).

Parse a string of the form `"[a, b]_dec"` as an `Interval` with decoration `dec`.
If the decoration is not specified, it is computed based on the parsed interval.
If the input is an invalid string, a warning is printed and NaI is returned. The
parser is case unsensitive.

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
julia> using IntervalArithmetic

julia> setdisplay(:full);

julia> parse(BareInterval{Float64}, "[1, 2]")
BareInterval{Float64}(1.0, 2.0)

julia> parse(BareInterval{Float64}, "[1,]")
BareInterval{Float64}(1.0, Inf)

julia> parse(BareInterval{Float64}, "[,]")
BareInterval{Float64}(-Inf, Inf)

julia> parse(BareInterval{Float64}, "6.42?2e2")
BareInterval{Float64}(640.0, 644.0)

julia> parse(Interval{Float64}, "[1, 2]")
Interval{Float64}(1.0, 2.0, com, true)

julia> parse(Interval{Float64}, "[1, 2]_def")
Interval{Float64}(1.0, 2.0, def, true)

julia> parse(Interval{Float64}, "[1, 1e400]_com")
Interval{Float64}(1.0, Inf, dac, true)
```
"""
function Base.parse(::Type{BareInterval{T}}, str::AbstractString) where {T<:NumTypes}
    if '_' ∈ str
        @warn "failed to parse a decorated interval as a `BareInterval`, empty interval is returned"
        return emptyinterval(BareInterval{T})
    else
        str = lowercase(strip(str))
        x, _, isexactnai, iserror = _parse(T, str) # `isexactnai == true` for string of the form [ nai ]
        iserror && @warn "parsing error, empty interval is returned"
        isexactnai && @warn "parsed NaI, empty interval is returned"
        return x.bareinterval # use `x.bareinterval` to not print a warning if `x` is an NaI
    end
end

function Base.parse(::Type{Interval{T}}, str::AbstractString) where {T<:NumTypes}
    str = lowercase(strip(str))
    if '_' ∉ str
        x, _, _, iserror = _parse(T, str)
        iserror && @warn "parsing error, NaI is returned"
        return x
    else
        bx_str, d_str = split(str, '_'; keepempty = true, limit = 2)
        decorations = Dict{String,Decoration}("ill" => ill, "trv" => trv, "def" => def, "dac" => dac, "com" => com)
        if haskey(decorations, d_str)
            d_given = decorations[d_str]
            x, flag, _, iserror = _parse(T, bx_str) # `flag == true` if the parse interval is unbounded due to the precision
            if iserror
                @warn "parsing error, NaI is returned"
                return x
            else
                d = decoration(x)
                if d_given > d && flag
                    @warn "parsed interval $x is incompatible with parsed decoration $d_given, NaI is returned"
                    return nai(T)
                else
                    return interval(T, x, d_given) # warning is printed if `d_given == ill`
                end
            end
        else
            @warn "failed to parse the decoration, NaI is returned"
            return nai(T)
        end
    end
end

_parse(str::AbstractString) = parse(Interval{default_numtype()}, str)

function _parse(::Type{T}, str::AbstractString) where {T<:NumTypes}
    if startswith(str, '[') && endswith(str, ']')
        s = strip(view(str, 2:length(str)-1))
        if ',' ∈ s # inf-sup interval
            lo_str, hi_str = strip.(split(s, ','; keepempty = true, limit = 2))
            if isempty(lo_str)
                lo_str = "-inf"
            end
            if isempty(hi_str)
                hi_str = "inf"
            end
            try
                lo = _parse_num(T, lo_str, RoundDown)
                hi = _parse_num(T, hi_str, RoundUp)
                flag = !((isinf(lo) & !occursin("inf", lo_str)) | (isinf(hi) & !occursin("inf", hi_str)))
                x = interval(T, lo, hi)
                isatomic(x) & !isempty_interval(x) & !isthin(x) && @warn "$str is parsed as an atomic interval, something wrong may have happened"
                return x, flag, false, false
            catch
                return nai(T), false, false, true
            end
        else # point interval
            s == "nai" && return nai(T), true, true, false # no warning is printed
            (s == "empty") | isempty(s) && return emptyinterval(T), true, false, false # no warning is printed
            s == "entire" && return entireinterval(T), true, false, false # no warning is printed
            try
                lo = _parse_num(T, s, RoundDown)
                hi = _parse_num(T, s, RoundUp)
                flag = !((isinf(lo) & !occursin("inf", s)) | (isinf(hi) & !occursin("inf", s)))
                return interval(T, lo, hi), flag, false, false
            catch
                return nai(T), false, false, true
            end
        end
    elseif '?' ∈ str # uncertainty interval
        if occursin("??", str) # unbounded interval
            m, vde = split(str, "??"; keepempty = true, limit = 2)
            if vde == "d" # [-inf, m]
                lo_str = "-inf"
                hi_str = m
            elseif vde == "u" # [m, inf]
                lo_str = m
                hi_str = "inf"
            elseif isempty(vde) # [-inf, inf]
                return entireinterval(T), true, false, false # no warning is printed
            end
            try
                lo = _parse_num(T, lo_str, RoundDown)
                hi = _parse_num(T, hi_str, RoundUp)
                flag = !((isinf(lo) & !occursin("inf", lo_str)) | (isinf(hi) & !occursin("inf", hi_str)))
                return interval(T, lo, hi), flag, false, false
            catch
                return nai(T), false, false, true
            end
        else
            m, vde = split(str, '?'; keepempty = true, limit = 2)

            # ulp computation
            if '.' ∈ m # ulp is last decimal position
                ulp = inv(big(10.0) ^ length(split(m, '.')[2]))
            else # no decimal, hence ulp is unit
                ulp = big(1.0)
            end
            m = parse(BigFloat, m)

            if 'e' ∈ vde
                vd, e = split(vde, 'e')
                e = big(10.0) ^ parse(BigInt, e)
            else
                vd = vde
                e = big(1.0)
            end

            if 'u' ∈ vd || 'd' ∈ vd
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

            flag = !(isinf(lo) | isinf(hi))
            return interval(T, lo, hi), flag, false, false
        end
    else # number
        try
            lo = _parse_num(T, str, RoundDown)
            hi = _parse_num(T, str, RoundUp)
            flag = !((isinf(lo) & !occursin("inf", str)) | (isinf(hi) & !occursin("inf", str)))
            return interval(T, lo, hi), flag, false, false
        catch
            return nai(T), false, false, true
        end
    end
end

function _parse_num(::Type{T}, str::AbstractString, r::RoundingMode) where {T<:AbstractFloat}
    if '/' ∈ str
        num, denum = map(s -> parse(BigInt, s), eachsplit(str, '/'; keepempty = false))
        return T(num//denum, r)
    else
        return T(BigFloat(str, r), r)
    end
end

function _parse_num(::Type{T}, str::AbstractString, ::RoundingMode{:Down}) where {S<:Integer,T<:Rational{S}}
    '/' ∈ str && return parse(T, str)
    x = BigFloat(str, RoundDown)
    z = rationalize(S, x)
    z ≤ x && return z
    return rationalize(S, prevfloat(x))
end

function _parse_num(::Type{T}, str::AbstractString, ::RoundingMode{:Up}) where {S<:Integer,T<:Rational{S}}
    '/' ∈ str && return parse(T, str)
    x = BigFloat(str, RoundUp)
    z = rationalize(S, x)
    z ≥ x && return z
    return rationalize(S, nextfloat(x))
end
