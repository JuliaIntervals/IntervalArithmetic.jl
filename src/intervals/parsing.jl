# Parsing follows Sections 9.7 and 12.11 of the IEEE Standard 1788-2015, in three steps:
#   1. the string is matched against the grammar of the standard (`_bounds`, `_number`);
#   2. the bounds it denotes are computed exactly, as `Rational{BigInt}`, where `±1//0` stand
#      for `±∞`, and their order is checked;
#   3. each bound is rounded outward to the bound type by `_round`, as in the constructors.
# An invalid literal throws an `ArgumentError`, which `parse` turns into a warning. So does a
# literal with a written exponent larger than `10^6` in absolute value, whose exact value is
# too costly to compute; the other powers computed are bounded by the length of the literal.

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
    return parse(Interval{default_numtype()}, str)
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
- `I"6.42?2e2"`: the interval ``[640, 644]``.
- `I"3??u"`: the interval ``[3, \\infty]``.
- `I"3??d"`: the interval ``[-\\infty, 3]``.
- `I"3??"`: the interval ``[-\\infty, \\infty]``.

For more details, see sections 9.7 and 12.11 of the IEEE Standard 1788-2015.

As extensions of the standard, a number without brackets (e.g. `I"1.33"`) and
the rational syntax of Julia (e.g. `I"[1//3, 2//3]"`) are accepted. A literal with
a written exponent larger than `10^6` in absolute value (e.g. `I"1e2000000"`) is not
supported: a warning is printed and NaI is returned (an empty interval for a `BareInterval`).

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
    try
        s = _normalize(str)
        if '_' ∈ s
            @warn "failed to parse a decorated interval as a `BareInterval`, empty interval is returned"
        elseif occursin(_NAI, s)
            @warn "parsed NaI, empty interval is returned"
        else
            return first(_parse(T, s)).bareinterval
        end
    catch e
        e isa ArgumentError || rethrow()
        @warn "parsing error, empty interval is returned: $(e.msg)"
    end
    return emptyinterval(BareInterval{T})
end

function Base.parse(::Type{Interval{T}}, str::AbstractString) where {T<:NumTypes}
    try
        s = _normalize(str)
        occursin(_NAI, s) && return nai(T)
        literal, dec = '_' ∈ s ? split(s, '_'; limit = 2) : (s, nothing)
        x, overflow = _parse(T, literal)
        isnothing(dec) && return x
        if !haskey(_DECORATIONS, dec)
            @warn "failed to parse the decoration, NaI is returned"
        elseif (_DECORATIONS[dec] > decoration(x)) & !overflow # e.g. "[1, inf]_com"
            @warn "parsed interval $x is incompatible with parsed decoration $(_DECORATIONS[dec]), NaI is returned"
        else
            return interval(T, x, _DECORATIONS[dec]) # warning is printed if the decoration is `ill`
        end
    catch e
        e isa ArgumentError || rethrow()
        @warn "parsing error, NaI is returned: $(e.msg)"
    end
    return nai(T)
end

# the case of letters is ignored, as well as the whitespace around the literal
_normalize(str::AbstractString) =
    isvalid(str) ? lowercase(strip(str)) : throw(ArgumentError("the string is not valid UTF-8"))

const _DECORATIONS = Dict("ill" => ill, "trv" => trv, "def" => def, "dac" => dac, "com" => com)

# grammar of Tables 9.5 and 12.2; the string is lowercase, and space characters (space or
# TAB) are only allowed inside brackets. The quantifiers are possessive (`*+`, `++`) so that
# matching a long string does not backtrack
const _SPACE = (' ', '\t')
const _NAI = r"^\[[ \t]*nai[ \t]*\]\z"
const _DECIMAL = r"^([+-]?)(?=\.?[0-9])([0-9]*+)(?:\.([0-9]*+))?(?:e([+-]?[0-9]++))?\z"
const _HEXADECIMAL = r"^([+-]?)0x(?=\.?[0-9a-f])([0-9a-f]*+)(?:\.([0-9a-f]*+))?p([+-]?[0-9]++)\z"
const _RATIONAL = r"^([+-]?[0-9]++)//?(0*+[1-9][0-9]*+)\z" # `p/q`, and `p//q` as in Julia
const _INFINITY = r"^([+-]?)inf(?:inity)?\z"
const _UNCERTAIN = r"^([+-]?)(?=\.?[0-9])([0-9]*+)(?:\.([0-9]*+))?\?(\?|[0-9]*+)([du]?)(?:e([+-]?[0-9]++))?\z"

const _INF = big(1) // big(0)
const _MAX_EXPONENT = 1_000_000 # largest written exponent, in absolute value, see `_exponent`

# interval denoted by the bare interval literal `s`, and whether an overflow occurred, that
# is the literal is bounded and the interval is not (Section 12.12.7)
function _parse(::Type{T}, s::AbstractString) where {T<:NumTypes}
    b = _bounds(s)
    isnothing(b) && return emptyinterval(Interval{T}), false
    l, u = b
    # the bounds satisfy `l ≤ u`, `l < +∞` and `u > -∞` (Section 12.12.7)
    (l > u) | (l == _INF) | (u == -_INF) &&
        throw(ArgumentError("the bounds of $s are in the wrong order, or infinite on the wrong side"))
    lo, hi = _round(T, l, RoundDown), _round(T, u, RoundUp)
    return interval(T, lo, hi), !((l == -_INF) | (u == _INF)) & (isinf(lo) | isinf(hi))
end

# exact bounds of a bare interval literal, `nothing` for the empty interval
function _bounds(s::AbstractString)
    if startswith(s, '[') && endswith(s, ']')
        body = strip(chop(s; head = 1, tail = 1), _SPACE)
        body ∈ ("", "empty") && return nothing
        body == "entire" && return -_INF, _INF
        if ',' ∈ body # inf-sup form, a missing bound is infinite
            l, u = strip.(split(body, ','; limit = 2), Ref(_SPACE))
            return isempty(l) ? -_INF : _number(l), isempty(u) ? _INF : _number(u)
        end
        x = _number(body)
        return x, x
    end
    m = match(_UNCERTAIN, s)
    if !isnothing(m) # uncertain form `m?ruE`, the radius `r` counts units in the last place of `m`
        sgn, int, frac, rad, dir, ex = m.captures
        frac = something(frac, "")
        # counted in halves of a unit in the last place, the bounds are integers
        mid = 2 * parse(BigInt, sgn * int * frac)
        r = rad == "?" ? nothing : isempty(rad) ? big(1) : 2 * parse(BigInt, rad)
        e = _exponent(ex) - length(frac) - 1
        p = big(10)^abs(e) # half a unit is `5 * 10^e`
        half_ulps(n) = e ≥ 0 ? 5n * p // 1 : 5n // p
        lo = dir == "u" ? half_ulps(mid) : isnothing(r) ? -_INF : half_ulps(mid - r)
        hi = dir == "d" ? half_ulps(mid) : isnothing(r) ? _INF : half_ulps(mid + r)
        return lo, hi
    end
    x = _number(s) # not in the standard: a number literal without brackets
    return x, x
end

# exact value of a number literal
function _number(s::AbstractString)
    m = match(_DECIMAL, s)
    isnothing(m) || return _scaled(m[1], m[2], something(m[3], ""), m[4], 10, 10, 1)
    m = match(_HEXADECIMAL, s)
    isnothing(m) || return _scaled(m[1], m[2], something(m[3], ""), m[4], 16, 2, 4)
    m = match(_RATIONAL, s)
    isnothing(m) || return parse(BigInt, m[1]) // parse(BigInt, m[2])
    m = match(_INFINITY, s)
    isnothing(m) || return ifelse(m[1] == "-", -_INF, _INF)
    return throw(ArgumentError("invalid number literal $s"))
end

# `± int.frac * base^ex`, where a digit in the given radix is worth `base^k`
_scaled(sgn, int, frac, ex, radix, base, k) =
    _scale(parse(BigInt, sgn * int * frac; base = radix), base, _exponent(ex) - k * length(frac))

# the written exponent; a larger one would make the exact value too costly to compute
function _exponent(ex)
    e = parse(BigInt, something(ex, "0"))
    abs(e) ≤ _MAX_EXPONENT || throw(ArgumentError("an exponent larger than 10^6 in absolute value is not supported"))
    return e
end

# `n * base^e`, exactly
_scale(n::BigInt, base::Int, e::BigInt) = e ≥ 0 ? n * big(base)^e // 1 : n // big(base)^(-e)
