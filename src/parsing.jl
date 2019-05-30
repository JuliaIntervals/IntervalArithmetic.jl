# Functions to parse strings to intervals

"""
    parse{T}(DecoratedInterval{T}, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval`
with decoration `dec`.
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    m = match(r"(\[.*\])(\_.*)?", s)

    if m == nothing  # matched
        throw(ArgumentError("Unable to process string $x as decorated interval"))

    end

    interval_string, decoration_string = m.captures
    interval = parse(Interval{T}, interval_string)

    # type unstable:
    if decoration_string == nothing
        decoration_string = "_com"
    end

    decoration_symbol = Symbol(decoration_string[2:end])
    decoration = getfield(IntervalArithmetic, decoration_symbol)

    return DecoratedInterval(interval, decoration)

end

"""
    parse{T}(Interval{T}, s::AbstractString)

Parse a string as an interval. Formats allowed include:
- "1"
- "[1]"
- "[3.5, 7.2]"
- "[-0x1.3p-1, 2/3]"  # use numerical expressions
"""
function parse(::Type{Interval{T}}, s::AbstractString) where T

    # Check version!
    if !(occursin("[", s))  # string like "3.1"

        m = match(r"(.*)±(.*)", s)
        if m != nothing
            a = parse(T, strip(m.captures[1]))
            b = parse(T, strip(m.captures[2]))

            return a ± b
        end

        a = parse(T, s, RoundDown)
        b = parse(T, s, RoundUp)

        return Interval(a, b)

    end

    # match string of form [a, b]_dec:
    m = match(r"\[(.*),(.*)\]", s)

    if m != nothing  # matched

        m.captures[1] = strip(m.captures[1], [' '])
        m.captures[2] = strip(m.captures[2], [' '])
        lo, hi = m.captures

        if m.captures[2] == "+infinity" || m.captures[2] == ""
            hi = "Inf"
        end

        if m.captures[1] == "-infinity" || m.captures[1] == ""
            lo = "-Inf"
        end

    end

    if m == nothing

        m = match(r"\[(.*)\]", s)  # string like "[1]"

        if m == nothing
            throw(ArgumentError("Unable to process string $s as interval"))
        end

        m.captures[1] = strip(m.captures[1], [' '])

        if m.captures[1] == "Empty" || m.captures[1] == ""
            return emptyinterval(T)
        end
        if m.captures[1] == "entire"
            return entireinterval(T)
        end

        lo = m.captures[1]
        hi = lo

    end

    expr1 = Meta.parse(lo)
    expr2 = Meta.parse(hi)
    if lo == "-Inf"
        expr1 = Base.parse(Float64, lo)
    end
    if hi == "Inf"
        expr2 = Base.parse(Float64, hi)
    end

    interval = eval(make_interval(T, expr1, [expr2]))

    return interval

end
