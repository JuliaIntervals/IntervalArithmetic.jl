type DisplayParameters
    format::Symbol
    decorations::Bool
    sigfigs::Int
end

const display_params = DisplayParameters(:standard, false, 6)

const display_options = [:standard, :full, :midpoint]

doc"""
    displaymode(;kw)

`displaymode` changes how intervals are displayed using keyword arguments.
The following options are available:

- `format`: interval output format

    - `:standard`: `[1, 2]`
    - `:full`: `Interval(1, 2)`
    - `:midpoint`: 1.5 ± 0.5

- `sigfigs`: number of significant figures to show in `standard` mode

- `decorations` (boolean):  show decorations or not
"""
function displaymode(;decorations=nothing, format=nothing, sigfigs=-1)
    if format != nothing

        if format in display_options
            display_params.format = format
        else
            throw(ArgumentError("Allowed format option is one of  $display_options."))
        end

    end

    if decorations != nothing
        display_params.decorations = decorations
    end

    if sigfigs >= 0
        display_params.sigfigs = sigfigs
    end
end


## Output

# round to given number of signficant digits
# basic structure taken from base/mpfr.jl
function round_string(x::BigFloat, digits::Int, r::RoundingMode)

    lng = digits + Int32(8)
    buf = Array(UInt8, lng + 1)

    lng = ccall((:mpfr_snprintf,:libmpfr), Int32,
    (Ptr{UInt8}, Culong,  Ptr{UInt8}, Int32, Ptr{BigFloat}...),
    buf, lng + 1, "%.$(digits)R*g", Base.MPFR.to_mpfr(r), &x)

    return unsafe_string(pointer(buf))
end

round_string(x::Real, digits::Int, r::RoundingMode) = round_string(big(x), digits, r)


function representation(a::Interval, format=nothing)
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



function subscriptify(n::Int)
    dig = reverse(digits(n))
    subscript_0 = Int('₀')    # 0x2080
    join( [Char(subscript_0 + i) for i in dig])
end


function representation(a::Interval{BigFloat}, format=nothing)

    if format == nothing
        format = display_params.format  # default
    end


    if format == :standard
        string( invoke(representation, (Interval, Symbol), a, format),
                    subscriptify(precision(a.lo)) )

    elseif format == :full
        invoke(representation, (Interval, Symbol), a, format)
    end
end


function representation(a::DecoratedInterval, format=nothing)

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

    buffer = IOBuffer()

    if display_params.format==:full
        print(buffer, "IntervalBox(")

        for i in 1:length(X)-1
            print(buffer, X[i], ", ")
        end
        print(buffer, X[end], ")")


    else

        for i in 1:length(X)-1
            print(buffer, X[i], " × ")
        end
        print(buffer, X[end])

    end

    return takebuf_string(buffer)
end


for T in (Interval, DecoratedInterval, IntervalBox)
    @eval show(io::IO, a::$T) = print(io, representation(a))
    @eval showall(io::IO, a::$T) = print(io, representation(a, :full))
end
