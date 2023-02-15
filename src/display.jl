mutable struct DisplayParameters
    format::Symbol
    decorations::Bool
    sigdigits::Int
end

function Base.show(io::IO, ::MIME"text/plain", params::DisplayParameters)
    println(io, "Display options:")
    println(io, "  - format: ", params.format)
    println(io, "  - decorations: ", params.decorations)
    print(io, "  - significant digits: ", params.sigdigits)
end

const display_params = DisplayParameters(:standard, true, 6)  # Default

"""
    setformat(format::Symbol; decorations::Bool, sigdigits::Int)
    setformat()

Change the format used by `show` to display intervals.

Initially, the display options are `format = :standard`, `decorations = false`
and `sigdigits = 6`.

If any of the three argument `format`, `decorations` and `sigdigits` is omitted,
then their value is left unchanged.

If the three arguments are omitted, i.e. calling `setformat()`, then the values
are reset to the default display options.

Possible options:
- `format` can be:
  - `:standard`: `[1, 2]`
  - `:midpoint`: display `x::Interval` in the form "mid(x) ± radius(x)"
  - `:full`: display the entire bounds regardless of `sigdigits`.
- `sigdigits`: number (greater or equal to 1) of significant digits to display.
- `decorations`: display the decorations or not.

See also: `@format`.

# Example
```
julia> x = interval(0.1, 0.3)  # Default display options
[0.0999999, 0.300001]

julia> setformat(:full)  # Equivalent to `@format full`
Display parameters:
  - format: full
  - decorations: true
  - significant digits: 6

julia> x
Interval(0.09999999999999999, 0.30000000000000004)

julia> setformat(:standard; sigdigits = 3)  # Equivalent to `@format standard 3`
Display parameters:
  - format: standard
  - decorations: true
  - significant digits: 3

julia> x
[0.0999, 0.301]
```
"""
function setformat(format::Symbol = display_params.format;
        decorations::Bool = display_params.decorations,
        sigdigits::Int = display_params.sigdigits)

    format ∉ (:standard, :midpoint, :full) && return throw(ArgumentError("`format` must be `:standard`, `:midpoint` or `:full`."))
    sigdigits < 1 && return throw(ArgumentError("`sigdigits` must be `≥ 1`."))

    display_params.format = format
    display_params.decorations = decorations
    display_params.sigdigits = sigdigits

    return display_params
end

"""
    @format [format::Symbol] [decorations::Bool] [sigdigits::Integer]

Change the format used by `show` to display intervals. These options are passed
to the `setformat` function.

Possible options:
- `format` can be:
    - `:standard`: `[1, 2]`
    - `:midpoint`: display `x::Interval` in the form "mid(x) ± radius(x)"
    - `:full`: display the entire bounds regardless of `sigdigits`.
- `sigdigits`: number (greater or equal to 1) of significant digits to display.
- `decorations`: display the decorations or not.

See also: `setformat`.

# Example
```
julia> x = interval(0.1, 0.3)  # Default display options
[0.0999999, 0.300001]

julia> @format full  # Equivalent to `setformat(:full)``
Display parameters:
  - format: full
  - decorations: true
  - significant digits: 6

julia> x
Interval(0.09999999999999999, 0.30000000000000004)

julia> @format standard true 3  # Equivalent to `setformat(:standard; decorations = true, sigdigits = 3)`
Display parameters:
  - format: standard
  - decorations: true
  - significant digits: 3

julia> x
[0.0999, 0.301]
```
"""
macro format(expr...)
    format = Meta.quot(display_params.format)
    decorations = display_params.decorations
    sigdigits = display_params.sigdigits
    for ex in expr
        if isa(ex, Symbol)
            format = Meta.quot(ex)
        elseif isa(ex, Bool)
            decorations = ex
        elseif isa(ex, Integer)
            sigdigits = ex
        else
            return :(throw(ArgumentError("Only accept arguments of type `Symbol`, `Bool` or `Int` but received $($ex)")))
        end
    end
    return :(setformat($format; decorations = $decorations, sigdigits = $sigdigits))
end

# Printing mechanism for various types of intervals

show(io::IO, ::MIME"text/plain", a::Union{Interval,Complex{<:Interval},DecoratedInterval,IntervalBox}) =
    print(io, representation(a, display_params.format))

function show(io::IO, a::Union{Interval,Complex{<:Interval},DecoratedInterval,IntervalBox})
    get(io, :compact, false) && return print(io, representation(a, display_params.format))
    return print(io, representation(a, :full))
end

# `String` representation of various types of intervals

representation(a::Interval, format::Symbol) = basic_representation(a, format)

function representation(a::Interval{T}, format::Symbol) where {T<:BigFloat}
    # `format` is either :standard, :midpoint or :full
    format === :standard && return string(basic_representation(a, format), subscriptify(precision(T)))
    return basic_representation(a, format)
end

function representation(x::Complex{<:Interval}, format::Symbol)
    # `format` is either :standard, :midpoint or :full
    format === :midpoint && return string("(", basic_representation(real(x), format), ") + (", basic_representation(imag(x), format), ")im")
    return string(basic_representation(real(x), format), " + ", basic_representation(imag(x), format), "im")
end

function representation(a::DecoratedInterval, format::Symbol)
    # `format` is either :standard, :midpoint or :full
    var_interval = representation(interval(a), format)
    format === :full && return string("DecoratedInterval(", var_interval, ", ", decoration(a), ")")
    display_params.decorations && return string(var_interval, "_", decoration(a))
    return var_interval
end

function representation(X::IntervalBox{N}, format::Symbol) where {N}
    # `format` is either :standard, :midpoint or :full
    if format === :full
        isempty(X) && return string("IntervalBox(∅, ", N, ")")
        x = first(X)
        all(y -> x ≛ y, X) && return string("IntervalBox(", representation(x, format), ", ", N, ")")
        str = representation.(X.v, format)
        return string("IntervalBox(", join(str, ", "), ")")
    elseif format === :midpoint
        isempty(X) && return string("∅", supscriptify(N))
        x = first(X)
        all(y -> x ≛ y, X) && return string("(", representation(x, format), ")", supscriptify(N))
        str = representation.(X.v, format)
        return string("(", join(str, ") × ("), ")")
    else  # format === :standard
        isempty(X) && return string("∅", supscriptify(N))
        x = first(X)
        all(y -> x ≛ y, X) && return string(representation(x, format), supscriptify(N))
        str = representation.(X.v, format)
        return join(str, " × ")
    end
end

# `String` representation of an `Interval`

function basic_representation(a::Interval, format::Symbol)
    isempty(a) && return "∅"
    sigdigits = display_params.sigdigits
    if format === :full
        # Do not use `inf(a)` to avoid -0.0
        return string("Interval(", a.lo, ", ", sup(a), ")")
    elseif format === :midpoint
        m = round_string(mid(a), sigdigits, RoundNearest)
        r = round_string(radius(a), sigdigits, RoundUp)
        output = string(m, " ± ", r)
        return replace(output, "Inf" => '∞')
    else  # format === :standard
        # Do not use `inf(a)` to avoid -0.0
        lo = round_string(a.lo, sigdigits, RoundDown)
        hi = round_string(sup(a), sigdigits, RoundUp)
        output = string("[", lo, ", ", hi, "]")
        return replace(output, "Inf" => '∞')
    end
end

function basic_representation(a::Interval{Float32}, format::Symbol)
    isempty(a) && return "∅"
    sigdigits = display_params.sigdigits
    if format === :full
        # Do not use `inf(a)` to avoid -0.0
        output = string("Interval(", a.lo, "f0, ", sup(a), "f0)")
        return replace(replace(output, "NaNf0" => "NaN32"), "Inff0" => '∞')
    elseif format === :midpoint
        m = round_string(mid(a), sigdigits, RoundNearest)
        r = round_string(radius(a), sigdigits, RoundUp)
        output = string(m, "f0 ± ", r, "f0")
        return replace(replace(output, "NaNf0" => "NaN32"), "Inff0" => '∞')
    else  # format === :standard
        # Do not use `inf(a)` to avoid -0.0
        lo = round_string(a.lo, sigdigits, RoundDown)
        hi = round_string(sup(a), sigdigits, RoundUp)
        output = string("[", lo, "f0, ", hi, "f0]")
        return replace(replace(output, "NaNf0" => "NaN32"), "Inff0" => '∞')
    end
end

function basic_representation(a::Interval{<:Rational}, format::Symbol)
    isempty(a) && return "∅"
    if format === :full
        # Do not use `inf(a)` to avoid -0.0
        return string("Interval(", a.lo, ", ", sup(a), ")")
    elseif format === :midpoint
        return string(mid(a), " ± ", radius(a))
    else  # format === :standard
        # Do not use `inf(a)` to avoid -0.0
        return string("[", a.lo, ", ", sup(a), "]")
    end
end

# Round to the prescribed significant digits
# Code inspired by `_string(x::BigFloat, k::Integer)` in base/mpfr.jl

function round_string(x::AbstractFloat, sigdigits::Int, r::RoundingMode)
    str_digits = replace(replace(string(x), '.' => ""), '-' => "")
    if (isinteger(x) || ispow2(x)) && sigdigits ≥ length(str_digits) # `x` is exactly representable
        return round_string(big(x), sigdigits, RoundNearest)
    else
        return round_string(big(x), sigdigits, r)
    end
end

round_string(x::BigFloat, sigdigits::Int, ::RoundingMode{:Nearest}) =
    Base.MPFR._string(x, sigdigits-1)  # `sigdigits-1` digits after the decimal

function round_string(x::BigFloat, sigdigits::Int, r::RoundingMode)
    if !isfinite(x)
        return string(Float64(x))
    else
        str_digits = replace(replace(string(x), '.' => ""), '-' => "")
        if (isinteger(x) || ispow2(x)) && sigdigits ≥ length(str_digits) # `x` is exactly representable
            return round_string(x, sigdigits, RoundNearest)
        else
            # `sigdigits` digits after the decimal
            str = Base.MPFR.string_mpfr(x, "%.$(sigdigits)Re")
            rounded_str = round_string(str, r)
            return Base.MPFR._prettify_bigfloat(rounded_str)
        end
    end
end

round_string(s::String, ::RoundingMode{:Up}) =
    startswith(s, '-') ? string('-', round_string_down(s[2:end])) : round_string_up(s)

round_string(s::String, ::RoundingMode{:Down}) =
    startswith(s, '-') ? string('-', round_string_up(s[2:end])) : round_string_down(s)

function round_string_up(s::String)
    # NOTE: `s` has 1 extra significant digit to control the rounding
    mantissa, exponent = eachsplit(s, 'e')
    mantissa = mantissa[1:end-1]
    len = length(mantissa)
    idx = findlast(d -> (d !== '9') & (d !== '.'), mantissa)
    if idx == len  # Last significant digit is not 9
        d = parse(Int, mantissa[len]) + 1  # Increase the last significant digit
        return string(view(mantissa, 1:len-1), d, 'e', exponent)

    else
        if isnothing(idx)  # All significant digits are 9
            expo = parse(Int, exponent) + 1  # Increase the exponent by 1
            expo_str = string(expo; pad = 2)
            exponent = expo < 0 ? expo_str : string('+', expo_str)
            return string("1.", '0'^(len - 2), 'e', exponent)

        else
            new_mantissa = string(
                view(mantissa, 1:idx-1),
                parse(Int, mantissa[idx]) + 1,
                # Add "." if the last significant digit not equal to 9 is before the decimal point
                idx == 1 ? "." : "",
                '0'^(len - idx))
            return string(new_mantissa, 'e', exponent)

        end
    end
end

function round_string_down(s::String)
    # NOTE: `s` has 1 extra significant digit to control the rounding
    mantissa, exponent = eachsplit(s, 'e')
    len = length(mantissa)
    idx = findlast(d -> (d !== '0') & (d !== '.'), mantissa)
    if idx == len  # The extra significant digit is not 0
        return string(view(mantissa, 1:len-1), 'e', exponent)  # Truncate

    else
        if isnothing(idx)  # All significant digits are 0
            expo = parse(Int, exponent) - 1  # Decrease the exponent by 1
            expo_str = string(expo; pad = 2)
            exponent = expo < 0 ? expo_str : string('+', expo_str)
            return string("9.", '9'^(len - 3), 'e', exponent)

        else
            new_mantissa = string(
                    view(mantissa, 1:idx-1),
                    parse(Int, mantissa[idx]) - 1,
                    # Add '.' if the last significant digit not equal to 0 is before the decimal point
                    idx == 1 ? "." : "",
                    '9'^(len - (idx + 1)))
            return string(new_mantissa, 'e', exponent)

        end
    end
end

# Utilities

function subscriptify(n::Integer)
    if 0 ≤ n ≤ 9
        return subscript_digit(n)
    else
        len = ndigits(n)
        x = Vector{String}(undef, len)
        i = 0
        while n > 0
            n, d = divrem(n, 10)
            x[len-i] = subscript_digit(d)
            i += 1
        end
        return join(x)
    end
end

function supscriptify(n::Integer)
    if 0 ≤ n ≤ 9
        return supscript_digit(n)
    else
        len = ndigits(n)
        x = Vector{String}(undef, len)
        i = 0
        while n > 0
            n, d = divrem(n, 10)
            x[len-i] = supscript_digit(d)
            i += 1
        end
        return join(x)
    end
end

function supscript_digit(i::Integer)
    i == 0 && return "⁰"
    i == 1 && return "¹"
    i == 2 && return "²"
    i == 3 && return "³"
    i == 4 && return "⁴"
    i == 5 && return "⁵"
    i == 6 && return "⁶"
    i == 7 && return "⁷"
    i == 8 && return "⁸"
    i == 9 && return "⁹"
    return throw(DomainError(i, "supscript_digit only accept integers between 0 and 9 (included)"))
end

function subscript_digit(i::Integer)
    i == 0 && return "₀"
    i == 1 && return "₁"
    i == 2 && return "₂"
    i == 3 && return "₃"
    i == 4 && return "₄"
    i == 5 && return "₅"
    i == 6 && return "₆"
    i == 7 && return "₇"
    i == 8 && return "₈"
    i == 9 && return "₉"
    return throw(DomainError(i, "subscript_digit only accept integers between 0 and 9 (included)"))
end
