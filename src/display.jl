mutable struct DisplayParameters
    format::Symbol
    decorations::Bool
    sigfigs::Int
end

const display_params = DisplayParameters(:standard, false, 6)


doc"""
    setformat(;kw)

`setformat` changes how intervals are displayed using keyword arguments.
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
```
"""
function setformat(format = display_params.format;
                    decorations = display_params.decorations, sigfigs::Integer = display_params.sigfigs)

    if format ∉ (:standard, :full, :midpoint)
        throw(ArgumentError("Allowed format option is one of  $display_options."))
    end

    if decorations ∉ (true, false)
        throw(ArgumentError("`decorations` must be `true` or `false`"))
    end

    if sigfigs < 1
        throw(ArgumentError("`sigfigs` must be `>= 1`"))
    end

    # update values in display_params:
    display_params.format = format
    display_params.decorations = decorations
    display_params.sigfigs = sigfigs
end

doc"""
    @format [style::Symbol] [decorations::Bool] [sigfigs::Integer]

The `@format` macro provides a simple interface to control the output format
for intervals. These options are passed to the `setformat` function.

The arguments may be in any order and of type:

- `Symbol`: the output format (`:full`, `:standard` or `:midpoint`)
- `Bool`: whether to display decorations
- `Integer`: the number of significant figures

E.g.
```
julia> x = 0.1..0.3
@[0.0999999, 0.300001]

julia> @format full

julia> x
Interval(0.09999999999999999, 0.30000000000000004)

julia> @format standard 3

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

        elseif isa(ex, Integer)
            sigfigs = ex

        elseif isa(ex, Bool)
            decorations = ex
        end
    end

    format_code = :(setformat($format, decorations=$decorations, sigfigs=$sigfigs))

    return format_code
end


## Output

# round to given number of signficant digits
# basic structure taken from string(x::BigFloat) in base/mpfr.jl
function round_string(x::BigFloat, digits::Int, r::RoundingMode)

    lng = digits + Int32(8)
    buf = Array{UInt8}(lng + 1)

    lng = ccall((:mpfr_snprintf,:libmpfr), Int32,
    (Ptr{UInt8}, Culong,  Ptr{UInt8}, Int32, Ref{BigFloat}...),
    buf, lng + 1, "%.$(digits)R*g", Base.MPFR.to_mpfr(r), x)

    repr = unsafe_string(pointer(buf))

    repr = replace(repr, "nan", "NaN")

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
        output = replace(output, "inf", "∞")
        output = replace(output, "Inf", "∞")

    elseif format == :full
        output = "Interval($(a.lo), $(a.hi))"

    elseif format == :midpoint
        m = round_string(mid(a), sigfigs, RoundNearest)
        r = round_string(radius(a), sigfigs, RoundUp)
        output = "$m ± $r"
    end

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

function subscriptify(n::Int)
    dig = reverse(digits(n))
    subscript_0 = Int('₀')    # 0x2080
    join( [Char(subscript_0 + i) for i in dig])
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
        return "DecoratedInterval($(representation(interval_part(a), format)), $(decoration(a)))"
    end

    interval = representation(interval_part(a), format)

    if display_params.decorations
        string(interval, "_", decoration(a))
    else
        interval
    end

end


function representation(X::IntervalBox, format=nothing)

    if format == nothing
        format = display_params.format  # default
    end

    if display_params.format == :full
        return string("IntervalBox(", join(X, ", "), ")")

    else
        return join(X, " × ")
    end

end


for T in (Interval, DecoratedInterval)
    @eval show(io::IO, a::$T{S}) where S = print(io, representation(a))
    @eval showall(io::IO, a::$T{S}) where S = print(io, representation(a, :full))
end

T = IntervalBox
@eval show(io::IO, a::$T) = print(io, representation(a))
@eval show(io::IO, ::MIME"text/plain", a::$T) = print(io, representation(a))
@eval showall(io::IO, a::$T) = print(io, representation(a, :full))
