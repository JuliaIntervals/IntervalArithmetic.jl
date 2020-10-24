# Functions to parse strings to intervals

"""
    parse{T}(DecoratedInterval{T}, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval`
with decoration `dec`.
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    m = match(r"(\[.*\])(\_.*)?", s)

    if m == nothing  # matched

        m = match(r"(.*\?[a-z0-9]*)(\_.*)?", s)

        if m == nothing
            throw(ArgumentError("Unable to process string $x as decorated interval"))
        end

    end

    if m.captures[1] == "[nai]" || m.captures[1] == "[Nai]"
        return nai(T)
    end

    interval_string, decoration_string = m.captures
    interval = parse(Interval{T}, interval_string)

    # type unstable:
    if decoration_string != nothing
        decoration_string = lowercase(decoration_string)
        decoration_symbol = Symbol(decoration_string[2:end])
        decoration = getfield(IntervalArithmetic, decoration_symbol)
        return DecoratedInterval(interval, decoration)
    else
        DecoratedInterval(interval)
    end

end

"""
    parse{T}(Interval{T}, s::AbstractString)

Parse a string as an interval. Formats allowed include:
- "1"
- "[1]"
- "[3.5, 7.2]"
- "[-0x1.3p-1, 2/3]"  # use numerical expressions
"""
function parse(::Type{F}, s::AbstractString) where {T, F<:AbstractFlavor{T}}
    # Check version!
    if !(occursin("[", s))  # string like "3.1"

        m = match(r"(.*)±(.*)", s)
        if m != nothing
            a = parse(T, strip(m.captures[1]))
            b = parse(T, strip(m.captures[2]))

            return a ± b

        a = parse(T, s, RoundDown)
        b = parse(T, s, RoundUp)

        return F(a, b)

        end

        if m == nothing

            m = match(r"(\-?\d*\.?\d*)\?\?([ud]?)", s)   # match with string of form "34??"

            if m!= nothing
                if m.captures[2] == ""    # strings of the form "10??"
                    return RR(T)
                end
                if m.captures[2] == "u"   # strings of the form "10??u"
                    lo = parse(Float64, m.captures[1])
                    hi = Inf
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end
                if m.captures[2] == "d"   # strings of the form "10??d"
                    lo = -Inf
                    hi = parse(Float64, m.captures[1])
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end
            end

            m = match(r"(\-?\d*)\.?(\d*)\?(\d*)([ud]?)(e-?\d*)?", s) # match with strings like "3.56?1u" or "3.56?1e2"

            if m != nothing  # matched
                if m.captures[3] != "" && m.captures[4] == "" && m.captures[5] == nothing # string of form "3.4?1" or "10?2"
                    d = length(m.captures[2])
                    x = parse(Float64, m.captures[3] * "e-$d")
                    n = parse(Float64, m.captures[1]*"."*m.captures[2])
                    lo = n - x
                    hi = n + x
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "" && m.captures[5] == nothing  # strings of the form "3.46?"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"." * m.captures[2])
                    lo = n - x
                    hi = n + x
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "" && m.captures[5] != nothing  # strings of the form "3.46?e2"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"." * m.captures[2])
                    lo = parse(Float64, string(n-x) * m.captures[5])
                    hi = parse(Float64, string(n+x) * m.captures[5])
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "u" && m.captures[5] == nothing # strings of the form "3.4?u"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"."*m.captures[2])
                    lo = n
                    hi = n+x
                    interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "d" && m.captures[5] == nothing # strings of the form "3.4?d"
                        d = length(m.captures[2])
                        x = parse(Float64, "0.5" * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n - x
                        hi = n
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                end

                if m.captures[3] != ""
                    if m.captures[4] == "u" && m.captures[5] != nothing    #strings of the form "3.46?1u"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n) * m.captures[5])
                        hi = parse(Float64, string(n+x) * m.captures[5])
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "u" && m.captures[5] == nothing    #strings of the form "3.46?1u"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n
                        hi = n+x
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "d" && m.captures[5] != nothing  #strings of the form "3.46?1d"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n-x) * m.captures[5])
                        hi = parse(Float64, string(n) * m.captures[5])
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "d" && m.captures[5] == nothing  #strings of the form "3.46?1d"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n-x
                        hi = n
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "" && m.captures[5] != nothing    # strings of the form "3.56?1e2"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n-x)*m.captures[5])
                        hi = parse(Float64, string(n+x)*m.captures[5])
                        interval = eval(wrap_literals(Interval{T}, lo, [hi]))
                        return interval
                    end
                end
            end

            m = match(r"(-?\d*\.?\d*)", s)  # match strings of form "1" and "2.4"

            if m != nothing
                lo = parse(Float64, m.captures[1])
                hi = lo
            end

            if m == nothing
                throw(ArgumentError("Unable to process string $s as interval"))
            end

            interval = eval(wrap_literals(Interval{T}, lo, [hi]))
            return interval
        end
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

        if m.captures[1] == "Empty" || m.captures[1] == "" || m.captures[1] == "empty"
            return emptyinterval(T)
        end
        if m.captures[1] == "entire"
            return RR(T)
        end

        lo = m.captures[1]
        hi = lo

    end

    expr1 = Meta.parse(lo)
    expr2 = Meta.parse(hi)
    if lo == "-Inf"
        expr1 = parse(Float64, lo)
    end
    if hi == "Inf"
        expr2 = parse(Float64, hi)
    end

    return eval(wrap_literals(F, expr1, [expr2]))
end
