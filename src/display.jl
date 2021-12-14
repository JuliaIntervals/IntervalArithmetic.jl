mutable struct DisplayParameters
    format::Symbol
    decorations::Bool
    sigfigs::Int
end

function Base.show(io::IO, params::DisplayParameters)
    println(io, "Display parameters:")
    println(io, "- format: $(params.format)")
    println(io, "- decorations: $(params.decorations)")
    print(io, "- significant figures: $(params.sigfigs)")
end

const display_params = DisplayParameters(:standard, false, 6)

const display_options = (:standard, :full, :midpoint)

"""
    setformat(format=none; decorations=none, sigfigs=none)

`setformat` changes how intervals are displayed.
It returns the new `DisplayParameters` object.

Note that The `@format` macro is more user-friendly.

The following options are available:

- `format`: interval output format

    - `:standard`: `[1, 2]`
    - `:full`: `Interval(1, 2)`
    - `:midpoint`: 1.5 ± 0.5

- `sigfigs`: number of significant figures to show in `standard` mode; the default is 6

- `decorations` (boolean):  show decorations or not

Example:
```
julia> setformat(:full, decorations=true)
Display parameters:
- format: full
- decorations: true
- significant figures: 6
```
"""
function setformat(format = nothing;
                    decorations = nothing,
                    sigfigs = nothing)


    if format != nothing
        if format ∉ display_options
            throw(ArgumentError("Allowed format option is one of  $display_options."))
        else
            display_params.format = format
        end
    end

    if decorations !=  nothing
        if decorations ∉ (true, false)
            throw(ArgumentError("`decorations` must be `true` or `false`"))
        end

        display_params.decorations = decorations

    end

    if sigfigs != nothing
        if sigfigs < 1
            throw(ArgumentError("`sigfigs` must be `>= 1`"))
        end

        display_params.sigfigs = sigfigs

    end

    return display_params
end

"""
    @format [style::Symbol] [decorations::Bool] [sigfigs::Integer]

The `@format` macro provides a simple interface to control the output format
for intervals. These options are passed to the `setformat` function.
It returns the new `DisplayParameters` object.

The arguments may be in any order and of type:

- `Symbol`: the output format (`:full`, `:standard` or `:midpoint`)
- `Bool`: whether to display decorations
- `Integer`: the number of significant figures

E.g.
```
julia> x = 0.1..0.3
@[0.0999999, 0.300001]

julia> @format full
Display parameters:
- format: full
- decorations: false
- significant figures: 6

julia> x
Interval(0.09999999999999999, 0.30000000000000004)

julia> @format standard 3
Display parameters:
- format: standard
- decorations: false
- significant figures: 3

julia> x
[0.0999, 0.301]
```
"""
macro format(expr...)

    format = Meta.quot(display_params.format)
    decorations = display_params.decorations
    sigfigs = display_params.sigfigs

    for ex in expr

        if isa(ex, Symbol)
            format = Meta.quot(ex)

        elseif isa(ex, Bool)
            decorations = ex

        elseif isa(ex, Integer)
            sigfigs = ex
        end

    end

    format_code = :(setformat($format, decorations=$decorations, sigfigs=$sigfigs))

    return format_code
end


if VERSION < v"1.1.0-DEV.683"
    to_mpfr(r) = Base.MPFR.to_mpfr(r)
else
    to_mpfr(r) = convert(Base.MPFR.MPFRRoundingMode, r)
end

## Output

# round to given number of significant digits
# basic structure taken from string(x::BigFloat) in base/mpfr.jl
function round_string(x::BigFloat, digits::Int, r::RoundingMode)

    lng = digits + Int32(8)
    buf = Array{UInt8}(undef, lng + 1)

    lng = @ccall "libmpfr".mpfr_snprintf(buf::Ptr{UInt8},
                                         (lng + 1)::Csize_t,
                                         "%.$(digits)R*g"::Ptr{UInt8};
                                         to_mpfr(r)::Cint,
                                         x::Ref{BigFloat})::Cint

    repr = unsafe_string(pointer(buf))

    repr = replace(repr, "nan" => "NaN")

    return repr
end

round_string(x::Real, digits::Int, r::RoundingMode) = round_string(big(x), digits, r)


function basic_representation(a::Interval, format=nothing)
    if isempty(a)
        return "∅"
    end

    if format == nothing
        format = display_params.format  # default
    end

    sigfigs = display_params.sigfigs

    local output

    if format == :standard

        aa = round_string(a.lo, sigfigs, RoundDown)
        bb = round_string(a.hi, sigfigs, RoundUp)

        output = "[$aa, $bb]"
        output = replace(output, "inf" => "∞")
        output = replace(output, "Inf" => "∞")

    elseif format == :full
        output = "Interval($(a.lo), $(a.hi))"

    elseif format == :midpoint
        m = round_string(mid(a), sigfigs, RoundNearest)
        r = round_string(radius(a), sigfigs, RoundUp)
        output = "$m ± $r"
    end

    output
end

function basic_representation(a::Interval{Float32}, format=nothing)
    if isempty(a)
        return "∅"
    end

    if format == nothing
        format = display_params.format  # default
    end

    sigfigs = display_params.sigfigs

    local output

    if format == :standard

        aa = round_string(a.lo, sigfigs, RoundDown)
        bb = round_string(a.hi, sigfigs, RoundUp)

        output = "[$(aa)f0, $(bb)f0]"

    elseif format == :full
        output = "Interval($(a.lo)f0, $(a.hi)f0)"

    elseif format == :midpoint
        m = round_string(mid(a), sigfigs, RoundNearest)
        r = round_string(radius(a), sigfigs, RoundUp)
        output = "$(m)f0 ± $(r)f0"
    end
    output = replace(output, "inff0" => "∞")
    output = replace(output, "Inff0" => "∞")
    output = replace(output, "Inf32f0" => "∞")
    output
end

function basic_representation(a::Interval{Rational{T}}, format=nothing) where
        T<:Integer

    if isempty(a)
        return "∅"
    end

    if format == nothing
        format = display_params.format  # default
    end

    local output

    if format == :standard
        output = "[$(a.lo), $(a.hi)]"

    elseif format == :full
        output = "Interval($(a.lo), $(a.hi))"

    elseif format == :midpoint
        m = mid(a)
        r = radius(a)
        output = "$m ± $r"
    end

    output
end

function subscriptify(n::Integer)
    dig = reverse(digits(n))
    subscript_0 = Int('₀')    # 0x2080
    join( [Char(subscript_0 + i) for i in dig])
end

function superscriptify(n::Integer)
    exps = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']
    dig = reverse(digits(n))
    return join([exps[d+1] for d in dig])
end

# fall-back:
representation(a::Interval{T}, format=nothing) where T =
    basic_representation(a, format)

function representation(a::Interval{BigFloat}, format=nothing)

    if format == nothing
        format = display_params.format  # default
    end


    if format == :standard

        return string(basic_representation(a, format), subscriptify(precision(a.lo)))

    else

        return basic_representation(a, format)

    end
end


function representation(a::DecoratedInterval{T}, format=nothing) where T

    if format == nothing
        format = display_params.format  # default
    end

    if format==:full
        return "DecoratedInterval($(representation(interval(a), format)), $(decoration(a)))"
    end

    var_interval = representation(interval(a), format)

    if display_params.decorations
        string(var_interval, "_", decoration(a))
    else
        var_interval
    end

end


function representation(X::IntervalBox{N, T}, format=nothing) where {N, T}

    if format == nothing
        format = display_params.format  # default
    end

    n = format == :full ? N : superscriptify(N)

    if isempty(X)
        format == :full && return string("IntervalBox(∅, ", n, ")")
        return string("∅", n)
    end

    x = first(X)
    if all(==(x), X)
        if format == :full
            return string("IntervalBox(", representation(x, format), ", ", n, ")")
        elseif format == :midpoint
            return string("(", representation(x, format), ")", n)
        else
            return string(representation(x, format), n)
        end
    end

    if format == :full
        full_str = representation.(X.v, :full)
        return string("IntervalBox(", join(full_str, ", "), ")")
    elseif format == :midpoint
        return string("(", join(X.v, ") × ("), ")")
    else
        return join(X.v, " × ")
    end

end

function representation(x::Complex{<:Interval}, format=nothing)

    if format == nothing
        format = display_params.format
    end

    format == :midpoint && return string('(', x.re, ')', " + ", '(', x.im, ')', "im")

    return string(x.re, " + ", x.im, "im")
end

for T in (Interval, DecoratedInterval)
    @eval show(io::IO, a::$T{S}) where S = print(io, representation(a))
    @eval showfull(io::IO, a::$T{S}) where S = print(io, representation(a, :full))
    @eval showfull(a::$T{S}) where S = showfull(stdout, a)
end

for T in (IntervalBox, Complex{<:Interval})
    @eval show(io::IO, a::$T) = print(io, representation(a))
    @eval show(io::IO, ::MIME"text/plain", a::$T) = print(io, representation(a))
    @eval showfull(io::IO, a::$T) = print(io, representation(a, :full))
    @eval showfull(a::$T) = showfull(stdout, a)
end
