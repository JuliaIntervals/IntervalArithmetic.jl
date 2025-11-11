mutable struct DisplayOptions
    format      :: Symbol
    decorations :: Bool
    ng_flag     :: Bool
    sigdigits   :: Int
end

function Base.show(io::IO, ::MIME"text/plain", params::DisplayOptions)
    println(io, "Display options:")
    println(io, "  - format: ", params.format)
    if params.format === :full
        println(io, "  - decorations: ", params.decorations, " (ignored)")
        println(io, "  - NG flag: ", params.ng_flag, " (ignored)")
        print(io, "  - significant digits: ", params.sigdigits, " (ignored)")
    else
        println(io, "  - decorations: ", params.decorations)
        println(io, "  - NG flag: ", params.ng_flag)
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
julia> using IntervalArithmetic

julia> setdisplay(:full)
Display options:
  - format: full
  - decorations: true (ignored)
  - NG flag: true (ignored)
  - significant digits: 6 (ignored)

julia> x = interval(0.1, 0.3)
Interval{Float64}(0.1, 0.3, com, true)

julia> setdisplay(:infsup; sigdigits = 3)
Display options:
  - format: infsup
  - decorations: true
  - NG flag: true
  - significant digits: 3

julia> x
[0.1, 0.3]_com

julia> setdisplay(; decorations = false)
Display options:
  - format: infsup
  - decorations: false
  - NG flag: true
  - significant digits: 3

julia> x
[0.1, 0.3]

julia> setdisplay(:infsup; decorations = true, ng_flag = true, sigdigits = 6) # default display options
Display options:
  - format: infsup
  - decorations: true
  - NG flag: true
  - significant digits: 6

julia> x
[0.1, 0.3]_com
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
    ((format === :full) & (str_interval != "∅")) && return string("BareInterval{", T, "}(", str_interval, ')')
    return _str_precision(str_interval, a, format)
end

function _str_repr(a::Interval{T}, format::Symbol) where {T<:NumTypes}
    isnai(a) && return "NaI"

    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_interval = _str_basic_repr(a.bareinterval, format) # use `a.bareinterval` to not print a warning if `a` is an NaI
    if format === :full && str_interval != "∅"
        return string("Interval{", T, "}(", str_interval, ", ", decoration(a), ", ", isguaranteed(a), ')')
    else
        str_interval = _str_precision(str_interval, a, format)
        if format === :midpoint && str_interval != "∅" && T !== BigFloat && (display_options.decorations | (display_options.ng_flag & !isguaranteed(a)))
            str_interval = string('(', str_interval, ')')
        end
        str_interval = ifelse(display_options.decorations, string(str_interval, '_', decoration(a)), str_interval)
        return ifelse(display_options.ng_flag & !isguaranteed(a), string(str_interval, "_NG"), str_interval)
    end
end

function _str_repr(x::Complex{Interval{T}}, format::Symbol) where {T<:NumTypes}
    # `format` is either `:infsup`, `:midpoint` or `:full`
    str_imag = _str_repr(imag(x), format)
    if format === :full
        if !isthinzero(imag(x)) && sup(imag(x)) ≤ 0 && !isempty_interval(imag(x))
            c1, c2 = split(str_imag, ", "; limit = 2)
            l = findfirst('-', c1)
            ll = ifelse(occursin(',', c2), findfirst(',', c2), findfirst(')', c2))
            return string(_str_repr(real(x), format), " - im*", view(c1, 1:l-1), view(c2, 1+!iszero(sup(imag(x))):ll-1), ", ", view(c1, l+1:lastindex(c1)), view(c2, ll:lastindex(c2)))
        else
            return string(_str_repr(real(x), format), " + im*", str_imag)
        end
    elseif format === :midpoint
        str_real = _str_repr(real(x), format)
        if !startswith(str_real, '(')
            str_real = string('(', str_real, ')')
        end
        if !startswith(str_imag, '(')
            str_imag = string('(', str_imag, ')')
        end
        startswith(str_imag, "(-") && return string(str_real, " - im*(", view(str_imag, 3:lastindex(str_imag)))
        return string(str_real, " + im*", str_imag)
    else
        if !isthinzero(imag(x)) && sup(imag(x)) ≤ 0 && !isempty_interval(imag(x))
            c1, c2 = split(str_imag, ", ")
            l = findfirst(t -> (t == ']') | (t == ')'), c2)
            return string(_str_repr(real(x), format), " - im*", _flipl(c2[l]), view(c2, 1+!iszero(sup(imag(x))):l-1), ", ", view(c1, 3:lastindex(c1)), _flipr(c1[1]), view(c2, l+1:lastindex(c2)))
        else
            return string(_str_repr(real(x), format), " + im*", str_imag)
        end
    end
end

_flipl(char) = ifelse(char == ']', '[', '(')
_flipr(char) = ifelse(char == '[', ']', ')')

#

_str_precision(str_interval, x, format) = str_interval

function _str_precision(str_interval, x::Union{BareInterval{BigFloat},Interval{BigFloat}}, format)
    plo = precision(inf(x))
    phi = precision(sup(x))
    pstr = _subscriptify(plo)
    if format === :midpoint && str_interval != "∅"
        str_interval = string('(', str_interval, ')')
    end
    str_interval = string(str_interval, pstr)
    return ifelse(plo == phi, str_interval, string(str_interval, '_', _subscriptify(phi)))
end

#

function _str_basic_repr(a::BareInterval{<:AbstractFloat}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    isempty_interval(a) && return "∅"
    lo, hi = bounds(a) # do not use `inf(a)` to avoid `-0.0`
    sigdigits = display_options.sigdigits
    if format === :full
        str_lo = string(lo)
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = string(hi)
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        return string(str_lo, ", ", str_hi)
    elseif format === :midpoint
        m = mid(a)
        str_m = _round_string(m, sigdigits)
        # str_m = ifelse(m ≥ 0, string('+', str_m), str_m)
        output = string(str_m, " ± ", _round_string(radius(a), sigdigits))
        return replace(output, "Inf" => '∞')
    else
        str_lo = _round_string(lo, sigdigits)
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = _round_string(hi, sigdigits)
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        output = string('[', str_lo, ", ", str_hi, ']')
        return replace(output, "Inf]" => "∞)", "[-Inf" => "(-∞")
    end
end

function _str_basic_repr(a::BareInterval{Float32}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    isempty_interval(a) && return "∅"
    lo, hi = bounds(a) # do not use `inf(a)` to avoid `-0.0`
    sigdigits = display_options.sigdigits
    if format === :full
        str_lo = string(lo)
        str_lo = replace(string(str_lo, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(str_lo, 'e')
            str_lo = replace(str_lo, 'e' => 'f', "f0" => "")
        end
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = string(hi)
        str_hi = replace(string(str_hi, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(str_hi, 'e')
            str_hi = replace(str_hi, 'e' => 'f', "f0" => "")
        end
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        return string(str_lo, ", ", str_hi)
    elseif format === :midpoint
        m = mid(a)
        str_m = _round_string(m, sigdigits)
        str_m = replace(string(str_m, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(str_m, 'e')
            str_m = replace(str_m, 'e' => 'f', "f0" => "")
        end
        # str_m = ifelse(m ≥ 0, string('+', str_m), str_m)
        str_r = _round_string(radius(a), sigdigits)
        str_r = replace(string(str_r, "f0"), "NaNf0" => "NaN32", "Inff0" => "Inf32")
        if contains(str_r, 'e')
            str_r = replace(str_r, 'e' => 'f', "f0" => "")
        end
        return string(str_m, " ± ", str_r)
    else
        str_lo = _round_string(lo, sigdigits)
        str_lo = replace(string('[', str_lo, "f0"), "NaNf0" => "NaN32", "[-Inff0" => "(-∞")
        if contains(str_lo, 'e')
            str_lo = replace(str_lo, 'e' => 'f', "f0" => "")
        end
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = _round_string(hi, sigdigits)
        str_hi = replace(string(str_hi, "f0]"), "NaNf0" => "NaN32", "Inff0]" => "∞)")
        if contains(str_hi, 'e')
            str_hi = replace(str_hi, 'e' => 'f', "f0" => "")
        end
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        return string(str_lo, ", ", str_hi)
    end
end

function _str_basic_repr(a::BareInterval{Float16}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    isempty_interval(a) && return "∅"
    lo, hi = bounds(a) # do not use `inf(a)` to avoid `-0.0`
    sigdigits = display_options.sigdigits
    if format === :full
        str_lo = string(lo)
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = string(hi)
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        output = string("Float16(", str_lo, "), Float16(", str_hi, ')')
        return replace(output, "Float16(NaN)" => "NaN16", "Float16(-Inf)" => "-Inf16", "Float16(Inf)" => "Inf16")
    elseif format === :midpoint
        m = mid(a)
        str_m = _round_string(m, sigdigits)
        # str_m = ifelse(m ≥ 0, string('+', str_m), str_m)
        output = string("Float16(", str_m, ") ± Float16(", _round_string(radius(a), sigdigits), ')')
        return replace(output, "Float16(NaN)" => "NaN16", "Float16(Inf)" => '∞')
    else
        str_lo = _round_string(lo, sigdigits)
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = _round_string(sup(a), sigdigits)
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        output = string("[Float16(", str_lo, "), Float16(", str_hi, ")]")
        return replace(output, "Float16(NaN)" => "NaN16", "[Float16(-Inf)" => "(-∞", "Float16(Inf)]" => "∞)")
    end
end

function _str_basic_repr(a::BareInterval{<:Rational}, format::Symbol)
    # `format` is either `:infsup`, `:midpoint` or `:full`
    isempty_interval(a) && return "∅"
    if format === :midpoint
        m = mid(a)
        str_m = string(m)
        # str_m = ifelse(m ≥ 0, string('+', str_m), str_m)
        output = string(str_m, " ± ", radius(a))
        return replace(output, "1//0" => '∞')
    else
        lo, hi = bounds(a) # do not use `inf(a)` to avoid `-0.0`
        str_lo = string(lo)
        # str_lo = ifelse(lo ≥ 0, string('+', str_lo), str_lo)
        str_hi = string(hi)
        # str_hi = ifelse(hi ≥ 0, string('+', str_hi), str_hi)
        output = string(str_lo, ", ", str_hi)
        format === :full && return output
        output = string('[', output, ']')
        return replace(output, "1//0]" => "∞)", "[-1//0" => "(-∞")
    end
end

# truncate to the prescribed significant digits

function _round_string(x::AbstractFloat, sigdigits::Int)
    !isfinite(x) && return string(x)
    max_sig_digits = _count_sigdigits(string(x))
    ndigits = min(sigdigits, max_sig_digits)
    str = Printf.@sprintf("%.*g", ndigits, x)
    occursin(r"[eE]", str) && return replace(str, r"^([+-]?\d+)(?=[eE])" => s"\1.0", r"([eE][+-])0+(\d+)" => s"\1\2")
    !occursin(r"\.", str) && return str * ".0"
    return str
end

_count_sigdigits(s::AbstractString) = length(replace(split(s, r"[eE]")[1], '-' => "", '.' => "", r"^0+" => ""))

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
