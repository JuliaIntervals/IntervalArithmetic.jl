# Functions to parse strings to intervals

"""
    parse(DecoratedInterval, s::AbstractString)

Parse a string of the form `"[a, b]_dec"` as a `DecoratedInterval`
with decoration `dec`.
"""
function parse(::Type{DecoratedInterval{T}}, s::AbstractString) where T
    "_" ∉ s && throw(ArgumentError("no decoration given in the string \"$s\"."))

    interval_string, decoration_string = split(s, "_")
    interval = parse(Type{Interval{T}}, interval_string)
    decoration = Symbol(decoration_string)
    return DecoratedInterval(interval, decoration)
end

"""
    parse(DecoratedInterval, s::AbstractString)

Parse a string of as an `Interval`, according to the grammar specified
in Section 9.7 of the IEEE Std 1788-2015, with some extensions.

The created interval is tight around the value described by the string,
including for number that have no exact float representation like "0.1".

Roughly speaking, the valid forms are
    - `[ 1.33 ]` or simply `1.33` : The interval containing only `1.33``.
    - `[ 1.44, 2.78 ]` : The interval `[1.44, 2.78]`.
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

    point_interval = Either(
        Sequence(seq -> seq[2], "[", trim(any_number), "]"),
        trim(any_number)
    ) do x
            lo = parse(T, join(x), RoundDown)
            hi = parse(T, join(x), RoundUp)
        return checked_interval(lo, hi)
    end
    infsup_interval = Sequence(
            "[",
            trim(any_number),
            ",",
            trim(any_number),
            "]") do seq
        lo = parse(T, join(seq[2]), RoundDown)
        hi = parse(T, join(seq[4]), RoundUp)
        return checked_interval(lo, hi)
    end
    uncert_interval = Sequence(
        any_number,
        "?",
        Optional(any_number, default="0.5"),  # The radius
        Optional(CharIn("ud")),
        Optional(Sequence("e", any_number), default=("e", "0"))
    ) do seq
        x = join(seq[1])
        radius = parse(Float64, join(seq[3]))
        dir = seq[4]
        scale = 10^parse(Int, join(seq[5][2]))

        # TODO The ulp calculation is wrong when x has an exponent
        # e.g. 1.33e6?1
        # This is in principle not allowed by the standard but I see no reason
        # to disallow it
        if !('.' in x)
            ulp = 1
        else
            _, decimals = split(x, '.')
            ulp = 10.0^(-length(decimals))
        end

        rlo = rhi = *(radius, ulp, RoundUp)

        lo = parse(T, x, RoundDown)
        hi = parse(T, x, RoundUp)

        if !(ismissing(dir))
            if dir == 'd'
                rhi = 0.0
            else
                rlo = 0.0
            end
        end

        return @round(Interval{T}, lo - rlo, hi + rhi) * scale
    end
    
    return Sequence(
        first,
        Either(uncert_interval, infsup_interval, point_interval),
        AtEnd()
    )
end