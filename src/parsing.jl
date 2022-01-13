# Functions to parse strings to intervals

"""
    parse(DecoratedInterval, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval`
with decoration `dec`.
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    if '_' ∉ s
        x = parse(Interval{T}, s)
        return DecoratedInterval(x.lo, x.hi)
    end

    decorations = Dict(
        "ill" => ill,
        "trv" => trv,
        "def" => def,
        "dac" => dac,
        "com" => com)

    interval_string, dec = split(s, "_")
    interval = parse(Interval{T}, interval_string)
    return DecoratedInterval(interval, decorations[dec])
end

"""
    parse(Interval, s::AbstractString)

Parse a string as an `Interval`, according to the grammar specified
in Section 9.7 of the IEEE Std 1788-2015, with some extensions.

The created interval is tight around the value described by the string,
including for number that have no exact float representation like "0.1".

Roughly speaking, the valid forms are
    - `[ 1.33 ]` or simply `1.33` : The interval containing only `1.33``.
    - `[ 1.44, 2.78 ]` : The interval `[1.44, 2.78]`.
    - `7.88 ± 0.03`: The interval `[7.85, 7.91]`.j
    - `6.42?2` : The interval `6.42 ± 0.02`. The number after `?` represent
        the uncertainty in the last digit.
        Physicists would write it as `6.42(2)`.
        Strangely enough, according to the standard, the default
        value is `0.5` (e.g. `2.3? == 2.3 ± 0.05`).
        The direction of the uncertainty can be given by adding 'u' or 'd' at
        the end for the error going only up or down respectively (e.g. 
        `4.5?5u == [4.5, 5]`).
"""
function parse(::Type{Interval{T}}, s::AbstractString) where T
    p = interval_parser(Interval{T})
    try
        return parse(p, s)
    catch e
        # We avoid CombinedParsers stacktraces because they are hard to read.
        if !(e isa ArgumentError)
            rethrow()
        end
    end

    throw(ArgumentError("string \"$s\" can not be parsed to an interval."))
end

"""
Same as `parse(T, s, rounding_mode)`, but also accept string representing rational numbers.
"""
function extended_parse(T, s, rounding_mode)
    if '/' in s
        num, denum = parse.(Int, split(s, '/'))
        return T(num//denum, rounding_mode)
    end

    return parse(T, s, rounding_mode)
end

"""
    interval_parser(::Type{Interval})

Return a parser that processes a string according to Section 9.7 of
the IEEE Std 1788-2015 and return an interval of the given type.

It is an extension of the specification in the standard, more lenient
on what is allowed.
"""
function interval_parser(::Type{Interval{T}}) where T
    # Exclude a minimal number of Char and let Julia parse the number
    # when needed
    any_number = Lazy(Repeat1(CharNotIn("[]?ud")))
    integer = Lazy(Repeat1(CharIn("0123456789")))

    point_interval = Either(
        Sequence(seq -> seq[2], "[", trim(any_number), "]"),
        trim(any_number)
    ) do x
            lo = extended_parse(T, join(x), RoundDown)
            hi = extended_parse(T, join(x), RoundUp)
        return checked_interval(lo, hi)
    end
    infsup_interval = Sequence(
            "[",
            trim(any_number),
            ",",
            trim(any_number),
            "]") do seq
        lo = extended_parse(T, join(seq[2]), RoundDown)
        hi = extended_parse(T, join(seq[4]), RoundUp)
        return checked_interval(lo, hi)
    end
    uncert_interval = Sequence(
        any_number,
        "?",
        Optional(integer, default=missing),  # The radius
        Optional(CharIn("ud"), default='?'),
        Optional(Sequence("e", any_number), default=("e", "0"))
    ) do seq
        x = join(seq[1])
        radius = ismissing(seq[3]) ? 1//2 : Rational(parse(Int, join(seq[3])))
        dir = seq[4]
        exponent = parse(Int, join(seq[5][2]))

        # TODO The ulp calculation is wrong when x has an exponent
        # e.g. 1.33e6?1
        # This is in principle not allowed by the standard but I see no reason
        # to disallow it
        # Remove the decimal point, scaling accordingly
        if '.' in x
            core, decimals = split(x, '.')
            exponent -= length(decimals)
            x = join([core, decimals])
        end

        rhi = dir == 'd' ? Rational(0) : radius
        rlo = dir == 'u' ? Rational(0) : radius
        scale = exponent >= 0 ? 10^exponent : 1//10^-exponent
        x = parse(Int, x)
        lo = T((x - rlo)*scale, RoundDown)
        hi = T((x + rhi)*scale, RoundUp)
        return Interval(lo, hi)
    end

    # Not in the standard
    pm_interval = Sequence(
        any_number,
        trim("±"),
        any_number
    ) do seq
        a = parse(T, join(seq[1]))
        b = parse(T, join(seq[3]))
        return a ± b
    end
    
    return Sequence(
        first,
        Either(pm_interval, uncert_interval, infsup_interval, point_interval),
        AtEnd()
    )
end