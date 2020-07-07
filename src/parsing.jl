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
            throw(ArgumentError("Unable to process string $s as decorated interval"))
        end
        
        
    end

    if m.captures[2] == "_ill"
        return nai()
    end

    m.captures[1] = lowercase(m.captures[1])
    #@show m.captures[1]
    if m != nothing
        m2 = match(r"\[(.*)\]", m.captures[1])
        
        if m2 != nothing
            m2.captures[1] = strip(m2.captures[1], [' '])

            if m2.captures[1] == "nai" 
                return nai(T)
            end
        end
    end
    interval_string, decoration_string = m.captures
    
    interval = parse(Interval{T}, interval_string)

    # type unstable:
    if decoration_string != nothing
        decoration_string = lowercase(decoration_string[2:end])
        if(decoration_string != "com" && decoration_string != "def" && decoration_string != "dac" && decoration_string != "trv" && decoration_string != nothing)
            throw(ArgumentError("Cannot process $decoration_string as decoration"))
        end
        decoration_symbol = Symbol(decoration_string)
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
function parse(::Type{Interval{T}}, s::AbstractString) where T

    # Check version!
    if !(occursin("[", s))  # string like "3.1"
        
        m = match(r"(.*)±(.*)", s)
        if m != nothing
            a = parse(T, strip(m.captures[1]))
            b = parse(T, strip(m.captures[2]))

            return a ± b

        a = parse(T, s, RoundDown)
        b = parse(T, s, RoundUp)

        return Interval(a, b)

        end

        if m == nothing
            m = match(r"(.*\?[a-z0-9]*)(\_.*)?", s)

            if(m!=nothing && m.captures[2] != nothing)
                throw(ArgumentError("Unable to process string $s as interval"))
            end

            m = match(r"(\-?\d*\.?\d*)\?\?([ud]?)", s)   # match with string of form "34??"

            if m!= nothing
                if m.captures[2] == ""    # strings of the form "10??"
                    return entireinterval(T)
                end
                if m.captures[2] == "u"   # strings of the form "10??u"
                    lo = parse(Float64, m.captures[1])
                    hi = Inf
                    interval = eval(make_interval(T, lo, [hi]))
                    return interval
                end
                if m.captures[2] == "d"   # strings of the form "10??d"
                    lo = -Inf
                    hi = parse(Float64, m.captures[1])
                    interval = eval(make_interval(T, lo, [hi]))
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
                    interval = eval(make_interval(T, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "" && m.captures[5] == nothing  # strings of the form "3.46?"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"." * m.captures[2])
                    lo = n - x
                    hi = n + x
                    interval = eval(make_interval(T, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "" && m.captures[5] != nothing  # strings of the form "3.46?e2"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"." * m.captures[2])
                    lo = parse(Float64, string(n-x) * m.captures[5])
                    hi = parse(Float64, string(n+x) * m.captures[5])
                    interval = eval(make_interval(T, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "u" && m.captures[5] == nothing # strings of the form "3.4?u"
                    d = length(m.captures[2])
                    x = parse(Float64, "0.5" * "e-$d")
                    n = parse(Float64, m.captures[1]*"."*m.captures[2])
                    lo = n
                    hi = n+x
                    interval = eval(make_interval(T, lo, [hi]))
                    return interval
                end

                if m.captures[3] == "" && m.captures[4] == "d" && m.captures[5] == nothing # strings of the form "3.4?d"
                        d = length(m.captures[2])
                        x = parse(Float64, "0.5" * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n - x
                        hi = n
                        interval = eval(make_interval(T, lo, [hi]))
                        return interval
                end

                if m.captures[3] != ""
                    if m.captures[4] == "u" && m.captures[5] != nothing    #strings of the form "3.46?1u"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n) * m.captures[5])
                        hi = parse(Float64, string(n+x) * m.captures[5])
                        interval = eval(make_interval(T, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "u" && m.captures[5] == nothing    #strings of the form "3.46?1u"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n
                        hi = n+x
                        interval = eval(make_interval(T, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "d" && m.captures[5] != nothing  #strings of the form "3.46?1d"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n-x) * m.captures[5])
                        hi = parse(Float64, string(n) * m.captures[5])
                        interval = eval(make_interval(T, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "d" && m.captures[5] == nothing  #strings of the form "3.46?1d"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = n-x
                        hi = n
                        interval = eval(make_interval(T, lo, [hi]))
                        return interval
                    end

                    if m.captures[4] == "" && m.captures[5] != nothing    # strings of the form "3.56?1e2"
                        d = length(m.captures[2])
                        x = parse(Float64, m.captures[3] * "e-$d")
                        n = parse(Float64, m.captures[1]*"."*m.captures[2])
                        lo = parse(Float64, string(n-x)*m.captures[5])
                        hi = parse(Float64, string(n+x)*m.captures[5])
                        interval = eval(make_interval(T, lo, [hi]))
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

            interval = eval(make_interval(T, lo, [hi]))
            return interval
        end
    end

    # match string of form [a, b]_dec:
    m1 = match(r"(\[.*\])(\_.*)?", s)

    if(m1 != nothing) 

        if(m1.captures[2] != nothing)
            throw(ArgumentError("Unable to process string $s as an interval"))
        end

        m = match(r"\[(.*),(.*)\]", m1.captures[1])

        if m != nothing  # matched
            #@show m.captures[1], m.captures[2]
            m.captures[1] = strip(m.captures[1], [' '])
            m.captures[2] = strip(m.captures[2], [' '])
            lo, hi = m.captures

            m.captures[1] = lowercase(m.captures[1])
            m.captures[2] = lowercase(m.captures[2])

            if m.captures[2] == "+infinity" || m.captures[2] == "" || m.captures[2] == "inf" || m.captures[2] == "+inf" || m.captures[2] == "infinity"
                hi = "Inf"
            elseif m.captures[2] == "-infinity" || m.captures[2] == "" || m.captures[2] == "-inf"
                hi = "-Inf"
            end
            #@show m.captures[1], m.captures[2]
            if m.captures[1] == "-infinity" || m.captures[1] == "" || m.captures[1] == "-inf"
                lo = "-Inf"
            elseif m.captures[1] == "+infinity" || m.captures[1] == "" || m.captures[1] == "inf" || m.captures[1] == "+inf" || m.captures[1] == "infinity"
                lo = "Inf"
            end
        end

        if m == nothing

            m = match(r"\[(.*)\]", s)  # string like "[1]"

            if m == nothing
                throw(ArgumentError("Unable to process string $s as interval"))
            end

            m.captures[1] = strip(m.captures[1], [' '])
            m.captures[1] = lowercase(m.captures[1])

            if m.captures[1] == "" || m.captures[1] == "empty"
                return emptyinterval(T)
            end
            if m.captures[1] == "entire"
                return entireinterval(T)
            end

            lo = m.captures[1]
            hi = lo

        end
    end
    
    try
        expr1 = Meta.parse(lo)
        expr2 = Meta.parse(hi)
    catch
        throw(ArgumentError("Unable to process string $s as interval"))
    end
    #@show lo, hi
    if lo == "-Inf" || lo =="Inf"
        expr1 = parse(Float64, lo)
    end
    if hi == "Inf" || hi == "-Inf"
        expr2 = parse(Float64, hi)
    end

    try
        interval = eval(make_interval(T, expr1, [expr2]))
    catch
        throw(ArgumentError("Unable to process string $s as interval"))
    end

    return interval

end
