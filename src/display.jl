mutable struct DisplayOptions
    format      :: Symbol
    decorations :: Bool
    ng_flag     :: Bool
    sigdigits   :: Int
end

function Base.show(io::IO, ::MIME"text/plain", params::DisplayOptions)
    println(io, "Display options:")
    println(io, "  - format: ", params.format)
    println(io, "  - decorations: ", params.decorations)
    println(io, "  - NG flag: ", params.ng_flag)
    if params.format === :full
        print(io, "  - significant digits: ", params.sigdigits, " (ignored)")
    else
        print(io, "  - significant digits: ", params.sigdigits)
    end
end

const display_options = DisplayOptions(:infsup, true, true, 6) # default

"""
    setdisplay(format::Symbol; decorations::Bool, ng_flag::Bool, sigdigits::Int)

Change the format used by `show` to display intervals.

Possible options:
- `format` can be:
    - `:infsup`: display intervals as `[a, b]`.
    - `:midpoint`: display intervals as `m ± r`.
    - `:full`: display interval bounds entirely, ignoring `sigdigits`.
- `decorations`: display the decorations or not.
- `ng_flag`: display the NG flag or not.
- `sigdigits`: number (greater or equal to 1) of significant digits to display.

Initially, the display options are set to
`setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6)`. If any
of `format`, `decorations`, `ng_flag` and `sigdigits` is omitted, then their
value is left unchanged.

# Examples

```jldoctest
julia> setdisplay(:infsup; decorations = true, sigdigits = 6) # default display options
Display options:
  - format: infsup
  - decorations: true
  - NG flag: true
  - significant digits: 6

julia> x = interval(0.1, 0.3)
[0.0999999, 0.300001]_com

julia> setdisplay(:full)
Display options:
  - format: full
  - decorations: true
  - NG flag: true
  - significant digits: 6 (ignored)

julia> x
Interval{Float64}(0.1, 0.3, com)

julia> setdisplay(:infsup; sigdigits = 3)
Display options:
  - format: infsup
  - decorations: true
  - NG flag: true
  - significant digits: 3

julia> x
[0.0999, 0.301]_com

julia> setdisplay(; decorations = false)
Display options:
  - format: infsup
  - decorations: false
  - NG flag: true
  - significant digits: 3

julia> x
[0.0999, 0.301]
```
"""
function setdisplay(format::Symbol = display_options.format;
        decorations::Bool = display_options.decorations,
        ng_flag::Bool = display_options.ng_flag,
        sigdigits::Int = display_options.sigdigits)

    format ∉ (:infsup, :midpoint, :full) && return throw(ArgumentError("`format` must be `:infsup`, `:midpoint` or `:full`"))
    sigdigits < 1 && return throw(ArgumentError("`sigdigits` must be `≥ 1`"))

    display_options.format = format
    display_options.decorations = decorations
    display_options.ng_flag = ng_flag
    display_options.sigdigits = sigdigits

    return display_options
end

# printing mechanism

Base.show(io::IO, a::Union{BareInterval,Interval,Complex{<:Interval}}) =
    print(io, _str_repr(a, display_options.format))

Base.show(io::IO, ::MIME"text/plain", a::Union{BareInterval,Interval,Complex{<:Interval}}) =
    print(io, _str_repr(a, display_options.format))

# `String` representation

function _str_repr(a::BareInterval{T}, format::Symbol) where {T<:NumTypes}
    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_interval = _str_basic_repr(a, format)
    format === :full && return string("BareInterval{", T, "}(", str_interval, ')')
    return str_interval
end

function _str_repr(a::BareInterval{BigFloat}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_interval = _str_basic_repr(a, format)
    format === :full && return string("BareInterval{BigFloat}(", str_interval, ')')
    if format === :midpoint && str_interval != "∅"
        str_interval = string('(', str_interval, ')')
    end
    return string(str_interval, _str_precision(a))
end

function _str_repr(a::Interval{T}, format::Symbol) where {T<:NumTypes}
    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_interval = _str_basic_repr(a.bareinterval, format) # use `a.bareinterval` to not print a warning if `a` is an NaI
    if isguaranteed(a) || !display_options.ng_flag
        format === :full && return string("Interval{", T, "}(", str_interval, ", ", decoration(a), ')')
        display_options.decorations || return str_interval
        if format === :midpoint && str_interval != "∅"
            str_interval = string('(', str_interval, ')')
        end
        return string(str_interval, '_', decoration(a))
    else
        format === :full && return string("Interval{", T, "}(", str_interval, ", ", decoration(a), ", NG)")
        if format === :midpoint && str_interval != "∅"
            str_interval = string('(', str_interval, ')')
        end
        display_options.decorations || return string(str_interval, "_NG")
        return string(str_interval, '_', decoration(a), "_NG")
    end
end

function _str_repr(a::Interval{BigFloat}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_interval = _str_basic_repr(a.bareinterval, format) # use `a.bareinterval` to not print a warning if `a` is an NaI
    if isguaranteed(a) || !display_options.ng_flag
        format === :full && return string("Interval{BigFloat}(", str_interval, ", ", decoration(a), ')')
        if format === :midpoint && str_interval != "∅"
            str_interval = string('(', str_interval, ')')
        end
        display_options.decorations || return string(str_interval, _str_precision(a))
        return string(str_interval, _str_precision(a), '_', decoration(a))
    else
        format === :full && return string("Interval{", BigFloat, "}(", str_interval, ", ", decoration(a), ", NG)")
        if format === :midpoint && str_interval != "∅"
            str_interval = string('(', str_interval, ')')
        end
        display_options.decorations || return string(str_interval, _str_precision(a), "_NG")
        return string(str_interval, _str_precision(a), '_', decoration(a), "_NG")
    end
end

function _str_repr(x::Complex{<:Interval}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    if format === :full
        return string(_str_repr(real(x), format), " + ", _str_repr(imag(x), format), "im")
    elseif format === :infsup
        ((!isguaranteed(x) & display_options.ng_flag) | display_options.decorations) && return string(_str_repr(real(x), format), " + (", _str_repr(imag(x), format), ")im")
        return string(_str_repr(real(x), format), " + ", _str_repr(imag(x), format), "im")
    else
        ((!isguaranteed(x) & display_options.ng_flag) | display_options.decorations) && return string(_str_repr(real(x), format), " + (", _str_repr(imag(x), format), ")im")
        return string('(', _str_repr(real(x), format), ") + (", _str_repr(imag(x), format), ")im")
    end
end

function _str_repr(x::Complex{Interval{BigFloat}}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    ((!isguaranteed(x) & display_options.ng_flag) | display_options.decorations) && return string(_str_repr(real(x), format), " + (", _str_repr(imag(x), format), ")im")
    return string(_str_repr(real(x), format), " + ", _str_repr(imag(x), format), "im")
end

#

function _str_precision(x)
    plo = precision(inf(x))
    phi = precision(sup(x))
    pstr = _subscriptify(plo)
    plo == phi && return pstr
    return string(pstr, "_", _subscriptify(phi))
end

#

function _str_basic_repr(a::BareInterval{<:AbstractFloat}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    # do not use `inf(a)` to avoid `-0.0`
    isempty_interval(a) && return "∅"
    sigdigits = display_options.sigdigits
    if format === :full
        return string(a.lo, ", ", sup(a))
    elseif format === :midpoint
        m = _round_string(mid(a), sigdigits, RoundNearest)
        r = _round_string(radius(a), sigdigits, RoundUp)
        output = string(m, " ± ", r)
        return replace(output, "Inf" => '∞')
    else
        lo = _round_string(a.lo, sigdigits, RoundDown)
        hi = _round_string(sup(a), sigdigits, RoundUp)
        output = string('[', lo, ", ", hi, ']')
        return replace(output, "Inf]" => "∞)", "[-Inf" => "(-∞")
    end
end

function _str_basic_repr(a::BareInterval{Float32}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    # do not use `inf(a)` to avoid `-0.0`
    isempty_interval(a) && return "∅"
    sigdigits = display_options.sigdigits
    if format === :full
        lo = replace(string(a.lo, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(lo, 'e')
            lo = replace(lo, 'e' => 'f', "f0" => "")
        end
        hi = replace(string(sup(a), "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(hi, 'e')
            hi = replace(hi, 'e' => 'f', "f0" => "")
        end
        return string(lo, ", ", hi)
    elseif format === :midpoint
        m = _round_string(mid(a), sigdigits, RoundNearest)
        m = replace(string(m, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(m, 'e')
            m = replace(m, 'e' => 'f', "f0" => "")
        end
        r = _round_string(radius(a), sigdigits, RoundUp)
        r = replace(string(r, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(r, 'e')
            r = replace(r, 'e' => 'f', "f0" => "")
        end
        return string(m, " ± ", r)
    else
        lo = _round_string(a.lo, sigdigits, RoundDown)
        lo = replace(string('[', lo, "f0"), "NaNf0" => "NaN32", "[-Inff0" => "(-∞")
        if contains(lo, 'e')
            lo = replace(lo, 'e' => 'f', "f0" => "")
        end
        hi = _round_string(sup(a), sigdigits, RoundUp)
        hi = replace(string(hi, "f0]"), "NaNf0" => "NaN32", "Inff0]" => "∞)")
        if contains(hi, 'e')
            hi = replace(hi, 'e' => 'f', "f0" => "")
        end
        return string(lo, ", ", hi)
    end
end

function _str_basic_repr(a::BareInterval{Float16}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    # do not use `inf(a)` to avoid `-0.0`
    isempty_interval(a) && return "∅"
    sigdigits = display_options.sigdigits
    if format === :full
        output = string("Float16(", a.lo, "), Float16(", sup(a), ')')
        return replace(output, "Float16(NaN)" => "NaN16", "Float16(-Inf)" => "-Inf16", "Float16(Inf)" => "Inf16")
    elseif format === :midpoint
        m = _round_string(mid(a), sigdigits, RoundNearest)
        r = _round_string(radius(a), sigdigits, RoundUp)
        output = string("Float16(", m, ") ± Float16(", r, ')')
        return replace(output, "Float16(NaN)" => "NaN16", "Float16(Inf)" => '∞')
    else
        lo = _round_string(a.lo, sigdigits, RoundDown)
        hi = _round_string(sup(a), sigdigits, RoundUp)
        output = string("[Float16(", lo, "), Float16(", hi, ")]")
        return replace(output, "Float16(NaN)" => "NaN16", "[Float16(-Inf)" => "(-∞", "Float16(Inf)]" => "∞)")
    end
end

function _str_basic_repr(a::BareInterval{<:Rational}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    # do not use `inf(a)` to avoid `-0.0`
    isempty_interval(a) && return "∅"
    format === :full && return string(a.lo, ", ", sup(a))
    format === :midpoint && return string(mid(a), " ± ", radius(a))
    return string('[', a.lo, ", ", sup(a), ']')
end

# round to the prescribed significant digits
# code inspired by `_string(x::BigFloat, k::Integer)` in base/mpfr.jl

function _round_string(x::T, sigdigits::Int, r::RoundingMode) where {T<:AbstractFloat}
    str_x = string(x)
    str_digits = split(contains(str_x, '.') ? split(str_x, '.'; limit = 2)[2] : str_x, 'e'; limit = 2)[1]
    len = length(str_digits)
    if isinteger(x) && sigdigits ≥ len # `x` is exactly representable
        return replace(_round_string(big(x), length(str_x), RoundNearest), "e-0" => "e-")
    elseif ispow2(abs(x)) && sigdigits ≥ len # `x` is exactly representable
        return replace(_round_string(big(x), len + 1, RoundNearest), "e-0" => "e-")
    else
        return _round_string(big(x), sigdigits, r)
    end
end

_round_string(x::BigFloat, sigdigits::Int, ::RoundingMode{:Nearest}) =
    Base.MPFR._string(x, sigdigits-1) # `sigdigits-1` digits after the decimal

function _round_string(x::BigFloat, sigdigits::Int, r::RoundingMode)
    if !isfinite(x)
        return string(Float64(x))
    else
        str_x = string(x)
        str_digits = split(split(str_x, '.'; limit = 2)[2], 'e'; limit = 2)[1]
        len = length(str_digits)
        if isinteger(x) && sigdigits ≥ len # `x` is exactly representable
            return _round_string(big(x), length(str_x), RoundNearest)
        elseif ispow2(abs(x)) && sigdigits ≥ len # `x` is exactly representable
            return _round_string(big(x), len + 1, RoundNearest)
        else
            # `sigdigits` digits after the decimal
            str = Base.MPFR.string_mpfr(x, "%.$(sigdigits)Re")
            rounded_str = _round_string(str, r)
            return Base.MPFR._prettify_bigfloat(rounded_str)
        end
    end
end

_round_string(s::String, ::RoundingMode{:Up}) =
    startswith(s, '-') ? string('-', _round_string_down(s[2:end])) : _round_string_up(s)

_round_string(s::String, ::RoundingMode{:Down}) =
    startswith(s, '-') ? string('-', _round_string_up(s[2:end])) : _round_string_down(s)

function _round_string_up(s::String)
    # `s` has one extra significant digit to control the rounding
    mantissa, exponent = eachsplit(s, 'e')
    mantissa = mantissa[1:end-1]
    len = length(mantissa)
    idx = findlast(d -> (d !== '9') & (d !== '.'), mantissa)
    if idx == len # last significant digit is not `9`
        d = parse(Int, mantissa[len]) + 1 # increase the last significant digit
        return string(view(mantissa, 1:len-1), d, 'e', exponent)
    else
        if isnothing(idx) # all significant digits are `9`
            expo = parse(Int, exponent) + 1 # increase the exponent by `1`
            expo_str = string(expo; pad = 2)
            exponent = expo < 0 ? expo_str : string('+', expo_str)
            return string("1.", '0'^(len - 2), 'e', exponent)
        else
            new_mantissa = string(
                view(mantissa, 1:idx-1),
                parse(Int, mantissa[idx]) + 1,
                # add `"."` if the last significant digit not equal to `9` is before the decimal point
                idx == 1 ? "." : "",
                '0'^(len - idx))
            return string(new_mantissa, 'e', exponent)
        end
    end
end

function _round_string_down(s::String)
    # `s` has one extra significant digit to control the rounding
    mantissa, exponent = eachsplit(s, 'e')
    len = length(mantissa)
    idx = findlast(d -> (d !== '0') & (d !== '.'), mantissa)
    if idx == len # last significant digit is not `0`
        return string(view(mantissa, 1:len-1), 'e', exponent) # truncate
    else
        if isnothing(idx) # all significant digits are `0`
            expo = parse(Int, exponent) - 1 # decrease the exponent by `1`
            expo_str = string(expo; pad = 2)
            exponent = expo < 0 ? expo_str : string('+', expo_str)
            return string("9.", '9'^(len - 3), 'e', exponent)
        else
            new_mantissa = string(
                    view(mantissa, 1:idx-1),
                    parse(Int, mantissa[idx]) - 1,
                    # add `"."` if the last significant digit not equal to `0` is before the decimal point
                    idx == 1 ? "." : "",
                    '9'^(len - (idx + 1)))
            return string(new_mantissa, 'e', exponent)
        end
    end
end

#

function _subscriptify(n::Integer)
    if 0 ≤ n ≤ 9
        return _subscript_digit(n)
    else
        len = ndigits(n)
        x = Vector{Char}(undef, len)
        i = 0
        while n > 0
            n, d = divrem(n, 10)
            x[len-i] = _subscript_digit(d)
            i += 1
        end
        return join(x)
    end
end

function _subscript_digit(i::Integer)
    i == 0 && return '₀'
    i == 1 && return '₁'
    i == 2 && return '₂'
    i == 3 && return '₃'
    i == 4 && return '₄'
    i == 5 && return '₅'
    i == 6 && return '₆'
    i == 7 && return '₇'
    i == 8 && return '₈'
    return '₉'
end
