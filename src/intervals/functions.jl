# This file is part of the IntervalArithmetic.jl package; MIT licensed

## Powers

# CRlibm does not contain a correctly-rounded ^ function for Float64
# Use the BigFloat version from MPFR instead, which is correctly-rounded:

# Write explicitly like this to avoid ambiguity warnings:
for T in (:Integer, :Float64, :BigFloat, :Interval)
    @eval ^(a::Interval{Float64}, x::$T) = atomic(Interval{Float64}, big53(a)^x)
end


# Integer power:

# overwrite new behaviour for small integer powers from
# https://github.com/JuliaLang/julia/pull/24240:

Base.literal_pow(::typeof(^), x::Interval{T}, ::Val{p}) where {T,p} = x^p


function ^(a::Interval{BigFloat}, n::Integer)
    isempty(a) && return a
    n == 0 && return one(a)
    n == 1 && return a
    # n == 2 && return sqr(a)
    n < 0 && a == zero(a) && return emptyinterval(a)

    T = BigFloat

    if isodd(n) # odd power
        isentire(a) && return a
        if n > 0
            a.lo == 0 && return @round(0, a.hi^n)
            a.hi == 0 && return @round(a.lo^n, 0)
            return @round(a.lo^n, a.hi^n)
        else
            if a.lo ≥ 0
                a.lo == 0 && return @round(a.hi^n, Inf)
                return @round(a.hi^n, a.lo^n)

            elseif a.hi ≤ 0
                a.hi == 0 && return @round(-Inf, a.lo^n)
                return @round(a.hi^n, a.lo^n)
            else
                return entireinterval(a)
            end
        end

    else # even power
        if n > 0
            if a.lo ≥ 0
                return @round(a.lo^n, a.hi^n)
            elseif a.hi ≤ 0
                return @round(a.hi^n, a.lo^n)
            else
                return @round(mig(a)^n, mag(a)^n)
            end

        else
            if a.lo ≥ 0
                return @round(a.hi^n, a.lo^n)
            elseif a.hi ≤ 0
                return @round(a.lo^n, a.hi^n)
            else
                return @round(mag(a)^n, mig(a)^n)
            end
        end
    end
end

function sqr(a::Interval{T}) where T<:Real
    return a^2
    # isempty(a) && return a
    # if a.lo ≥ zero(T)
    #     return @round(a.lo^2, a.hi^2)
    #
    # elseif a.hi ≤ zero(T)
    #     return @round(a.hi^2, a.lo^2)
    # end
    #
    # return @round(mig(a)^2, mag(a)^2)
end

^(a::Interval{BigFloat}, x::AbstractFloat) = a^big(x)

# Floating-point power of a BigFloat interval:
function ^(a::Interval{BigFloat}, x::BigFloat)

    domain = Interval{BigFloat}(0, Inf)

    if a == zero(a)
        a = a ∩ domain
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    isinteger(x) && return a^(round(Int, x))
    x == 0.5 && return sqrt(a)

    a = a ∩ domain
    (isempty(x) || isempty(a)) && return emptyinterval(a)

    xx = atomic(Interval{BigFloat}, x)

    # @round() can't be used directly, because both arguments may
    # Inf or -Inf, which throws an error
    # lo = @round(a.lo^xx.lo, a.lo^xx.lo)
    lolod = @round_down(a.lo^xx.lo)
    lolou = @round_up(a.lo^xx.lo)
    lo = (lolod == Inf || lolou == -Inf) ?
        wideinterval(lolod) : Interval(lolod, lolou)

    # lo1 = @round(a.lo^xx.hi, a.lo^xx.hi)
    lohid = @round_down(a.lo^xx.hi)
    lohiu = @round_up(a.lo^xx.hi)
    lo1 = (lohid == Inf || lohiu == -Inf) ?
        wideinterval(lohid) : Interval(lohid, lohiu)

    # hi = @round(a.hi^xx.lo, a.hi^xx.lo)
    hilod = @round_down(a.hi^xx.lo)
    hilou = @round_up(a.hi^xx.lo)
    hi = (hilod == Inf || hilou == -Inf) ?
        wideinterval(hilod) : Interval(hilod, hilou)

    # hi1 = @round(a.hi^xx.hi, a.hi^xx.hi)
    hihid = @round_down(a.hi^xx.hi)
    hihiu = @round_up(a.hi^xx.hi)
    hi1 = (hihid == Inf || hihiu == -Inf) ?
        wideinterval(hihid) : Interval(hihid, hihiu)

    lo = hull(lo, lo1)
    hi = hull(hi, hi1)

    return hull(lo, hi)
end

function ^(a::Interval{Rational{T}}, x::AbstractFloat) where T<:Integer
    a = Interval(a.lo.num/a.lo.den, a.hi.num/a.hi.den)
    a = a^x
    atomic(Interval{Rational{T}}, a)
end

# Rational power
function ^(a::Interval{T}, x::Rational) where T
    domain = Interval{T}(0, Inf)

    p = x.num
    q = x.den

    isempty(a) && return emptyinterval(a)
    x == 0 && return one(a)

    if a == zero(a)
        x > zero(x) && return zero(a)
        return emptyinterval(a)
    end

    x == (1//2) && return sqrt(a)

    if x >= 0
        if a.lo ≥ 0
            isinteger(x) && return a ^ Int64(x)
            a = @biginterval(a)
            ui = convert(Culong, q)
            low = BigFloat()
            high = BigFloat()
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , a.lo , ui, MPFRRoundDown)
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , a.hi , ui, MPFRRoundUp)
            b = interval(low, high)
            b = convert(Interval{T}, b)
            return b^p
        end

        if a.lo < 0 && a.hi ≥ 0
            isinteger(x) && return a ^ Int64(x)
            a = a ∩ Interval{T}(0, Inf)
            a = @biginterval(a)
            ui = convert(Culong, q)
            low = BigFloat()
            high = BigFloat()
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , low , a.lo , ui, MPFRRoundDown)
            ccall((:mpfr_rootn_ui, :libmpfr) , Int32 , (Ref{BigFloat}, Ref{BigFloat}, Culong, MPFRRoundingMode) , high , a.hi , ui, MPFRRoundUp)
            b = interval(low, high)
            b = convert(Interval{T}, b)
            return b^p
        end

        if a.hi < 0
            isinteger(x) && return a ^ Int64(x)
            return emptyinterval(a)
        end

    end

    if x < 0
        return inv(a^(-x))
    end

end

# Interval power of an interval:
function ^(a::Interval{BigFloat}, x::Interval)
    T = BigFloat
    domain = Interval{T}(0, Inf)

    a = a ∩ domain

    (isempty(x) || isempty(a)) && return emptyinterval(a)

    lo1 = a^x.lo
    lo2 = a^x.hi
    lo1 = hull(lo1, lo2)

    hi1 = a^x.lo
    hi2 = a^x.hi
    hi1 = hull(hi1, hi2)

    hull(lo1, hi1)
end


function sqrt(a::Interval{T}) where T
    domain = Interval{T}(0, Inf)
    a = a ∩ domain

    isempty(a) && return a

    @round(sqrt(a.lo), sqrt(a.hi))  # `sqrt` is correctly-rounded
end

"""
    pow(x::Interval, n::Integer)

A faster implementation of `x^n`, currently using `power_by_squaring`.
`pow(x, n)` will usually return an interval that is slightly larger than that calculated by `x^n`, but is guaranteed to be a correct
enclosure when using multiplication with correct rounding.
"""
function pow(x::Interval, n::Integer)  # fast integer power

    isempty(x) && return x

    if iseven(n) && 0 ∈ x

        return hull(zero(x),
                    hull(Base.power_by_squaring(Interval(mig(x)), n),
                        Base.power_by_squaring(Interval(mag(x)), n))
            )

    else

      return hull( Base.power_by_squaring(Interval(x.lo), n),
                    Base.power_by_squaring(Interval(x.hi), n) )

    end

end

function pow(x::Interval, y::Real)  # fast real power, including for y an Interval

    isempty(x) && return x

    return exp(y * log(x))

end




for f in (:exp, :expm1)
    @eval begin
        function ($f)(a::Interval{T}) where T
            isempty(a) && return a
            @round( ($f)(a.lo), ($f)(a.hi) )
        end
    end
end

for f in (:exp2, :exp10)

    @eval function ($f)(x::BigFloat, r::RoundingMode)  # add BigFloat functions with rounding:
            setrounding(BigFloat, r) do
                ($f)(x)
            end
        end

    @eval ($f)(a::Interval{Float64}) = atomic(Interval{Float64}, $f(big53(a)))  # no CRlibm version

    @eval function ($f)(a::Interval{BigFloat})
            isempty(a) && return a
            @round( ($f)(a.lo), ($f)(a.hi) )
        end
end


for f in (:log, :log2, :log10, :log1p)

    @eval function ($f)(a::Interval{T}) where T
            domain = Interval{T}(0, Inf)
            a = a ∩ domain

            (isempty(a) || a.hi ≤ zero(T)) && return emptyinterval(a)

            @round( ($f)(a.lo), ($f)(a.hi) )

        end
end

function interval_to_string(x :: Interval{T}) where T
    x == ∅ && return "[Empty]"
    x == entireinterval(T) && return "Entire"
    isnai(x) && return "[Nai]"
    low = round(floor(x.lo * 100000) / 100000, digits = 5)
    high = round(ceil(x.hi * 100000) / 100000, digits = 5)
    if isinteger(low)
        low = Int64(low)
    end
    if isinteger(high)
        high = Int64(high)
    end
    return "[$low, $high]"
end

function interval_to_string(x :: Interval{T}, cs :: AbstractString) where T
    m = match(r"(\d*)\s?\:\s?\[(.?)\s?(\d*)\s?\.\s?(\d*)\s?(.?)\s?\]", cs)
    if m != nothing
        return infsup_string(x, m)
    end
    if m == nothing
        m = match(r"(\d*)\s?\:(.?)\s?(\d*)\s?\.\s?(\d*)\s?\?\s?(\d*)\s?(.?)\s?", cs)
        if m == nothing
            throw(ArgumentError("Unable to process string $x as an interval"))
        end
        return uncertain_string(x, m)
    end
end

function infsup_string(x :: Interval{T}, m :: RegexMatch) where T
    overall_width = m.captures[1]
    flag = m.captures[2]
    width = m.captures[3]
    prec = m.captures[4]
    conversion = m.captures[5]
    x == ∅ && flag == "C" && return "[Empty]"
    x == ∅ && flag == "c" && return "[empty]"
    x == entireinterval(T) && flag == "C" && return "Entire"
    x == entireinterval(T) && flag == "c" && return "Entire"
    isnai(x) && flag == "C" && return "[Nai]"
    isnai(x) && flag == "c" && return "[nai]"
    x == entireinterval(T) && flag == "<" && return "[-Inf, Inf]"
    if prec != ""
        prec = parse(Int64, prec)
        low_prec = prec
        high_prec = prec
        low = x.lo
        high = x.hi
        if conversion == "e" || conversion == "E"
            low = x.lo
            s = @sprintf("%.1E", low)
            low_exp = parse(Int64, s[5:end])
            low = low / 10^low_exp
            high = x.hi
            s = @sprintf("%.1E", high)
            high_exp = parse(Int64, s[5:end])
            high = high / 10^high_exp
        end
        low1 = floor(low, digits = low_prec)
        if length(string(low)) <= length(string(low1)) && low1 < low
            low = round(low, digits = low_prec)
        end
        if length(string(low)) > length(string(low1)) || low1 >= low
            low = low1
        end
        high = ceil(high, digits = high_prec)
        if prec > 0
            low = string(low) * "0"^(low_prec - (length(string(low)) - length(string(trunc(low))) + 1))
            high = string(high) * "0"^(high_prec - (length(string(high)) - length(string(trunc(high))) + 1))
        end
        if prec == 0
            low = string(Int64(low))
            high = string(Int64(high))
        end
        if conversion == "e" || conversion == "E"
            low = low * "e"* "$low_exp"
            high = high * "e" * "$high_exp"
        end
        if width != ""
            if length(high) < parse(Int64, width)
                if flag == "0"
                    low = "0"^(parse(Int64, width) - length(low)) * low
                    high = "0"^(parse(Int64, width) - length(high)) * high
                end
                if flag != "0"
                    low = " "^(parse(Int64, width) - length(low)) * low
                    high = " "^(parse(Int64, width) - length(high)) * high
                end
            end
            if length(high) > parse(Int64, width)
                throw(ArgumentError("Cannot output the interval as a string"))
            end
        end
        s = "[" * low * ", " * high * "]"
        if overall_width != "" && parse(Int64, overall_width) >= length(s)
            s = " "^(parse(Int64, overall_width) - length(s)) * s
        end
        if overall_width != "" && parse(Int64, overall_width) < length(s)
            throw(ArgumentError("Cannot output the interval as a string"))
        end
        return s
    end
    if prec == ""
        if width != ""
            low = x.lo
            high = x.hi
            if conversion == "e" || conversion == "E"
                low = x.lo
                s = @sprintf("%.1E", low)
                low_exp = parse(Int64, s[5:end])
                low = low / 10^low_exp
                high = x.hi
                s = @sprintf("%.1E", high)
                high_exp = parse(Int64, s[5:end])
                high = high / 10^high_exp
                low_min = length(string(Int64(trunc(low)))) + length(string(low_exp)) + 1
                high_min = length(string(Int64(trunc(high)))) + length(string(high_exp)) + 1
            end
            width = parse(Int64, width)
            if conversion != "e" && conversion != "E"
                low_min = length(string(Int64(trunc(low))))
                high_min = length(string(Int64(trunc(high))))
            end
            if width <= low_min + 1
                low = Int64(trunc(low))
            end
            if width <= high_min + 1
                high = Int64(trunc(high + 1))
             end
            if width >= low_min + 2 && width <= low_min + 6
                low_prec = width - low_min - 1
                low = floor(low * 10^low_prec) / 10^low_prec
            end
            if width >= high_min + 2 && width <= high_min + 6
                high_prec = width - high_min - 1
                high = trunc(high * 10^high_prec + 1) / 10^high_prec
            end
            if width > low_min + 6
                low_prec = 5
                low = floor(low * 10^low_prec) / 10^low_prec
            end
            if width > high_min + 6
                high_prec = 5
                high = floor(high * 10^high_prec) / 10^high_prec
            end
            if conversion != "e" && conversion != "E"
                low = string(low)
                high = string(high)
            end
            if conversion == "e" || conversion == "E"
                low = string(low) * "e" * "$low_exp"
                high = string(high) * "e" * "$high_exp"
            end
            low = " " ^ (width - length(low)) * low
            high = " " ^ (width - length(high)) * high
            s = "[$low, $high]"
            if overall_width != ""
                overall_width = parse(Int64, overall_width)
                s = " " ^ (overall_width - length(s)) * s
            end
            return s
        end
        if width == "" && overall_width != ""
            string_len = parse(Int64, overall_width)
            if conversion == "e" || conversion == "E"
                low = x.lo
                s = @sprintf("%.1E", low)
                low_exp = parse(Int64, s[5:end])
                low = low / 10^low_exp
                high = x.hi
                s = @sprintf("%.1E", high)
                high_exp = parse(Int64, s[5:end])
                high = high / 10^high_exp
                min_len = length(string(Int64(trunc(low)))) + length(string(Int64(ceil(high)))) + length(string(low_exp)) + length(string(high_exp)) + 6
            end
            if conversion != "e" && conversion != "E"
                low = x.lo
                high = x.hi
                min_len = length(string(trunc(low))) + length(string(ceil(high)))
            end
            if string_len < min_len
                throw(ArgumentError("Cannot output the interval as a string"))
            end
            if string_len == min_len
                low = Int64(trunc(low))
                high = Int64(ceil(high))
            end
            if string_len == min_len + 1
                low = Int64(trunc(low))
                high = Int64(ceil(high))
                if conversion == "e" || conversion =="E"
                    return " [$low" * "e" * "$low_exp" * ", $high" * "e" * "$high_exp" * "]"
                end
                if conversion != "e" && conversion != "E"
                    s = " [$low, $high]"
                end
            end
            if string_len == min_len + 2
                low_prec = 1
                low = floor(low * 10^low_prec) / 10^low_prec
                high = Int64(ceil(high))
            end
            if string_len == min_len + 3
                low_prec = 2
                low = floor(low * 10^low_prec) / 10^low_prec
                high = Int64(ceil(high))
            end
            if string_len >= min_len + 4 && string_len <= min_len + 12
                high_prec = trunc((string_len - min_len - 2) / 2)
                low_prec = string_len - min_len - high_prec - 2
                low = floor(low * 10^low_prec) / 10^low_prec
                high = trunc(high * 10^high_prec + 1) / 10^high_prec
            end
            if string_len > min_len + 12
                high_prec = 5
                low_prec = 5
                low = floor(low * 10^low_prec) / 10^low_prec
                high = trunc(high * 10^high_prec + 1) / 10^high_prec
            end
            if conversion == "e" || conversion == "E"
                s = "[$low" * "e" * "$low_exp" * ", $high" * "e" * "$high_exp]"
            end
            if conversion != "e" && conversion != "E"
                s = "[$low, $high]"
            end
            return " "^(string_len - length(s)) * s
        end
        if width == "" && overall_width == ""
            return string(x)
        end
    end
end

function uncertain_string(x :: Interval{T}, m :: RegexMatch) where T
    overall_width = m.captures[1]
    flag = m.captures[2]
    width = m.captures[3]
    prec = m.captures[4]
    rad_width = m.captures[5]
    conversion = m.captures[6]
    x == ∅ && flag == "C" && return "[Empty]"
    x == ∅ && flag == "c" && return "[empty]"
    x == entireinterval(T) && flag == "C" && return "Entire"
    x == entireinterval(T) && flag == "c" && return "Entire"
    isnai(x) && flag == "C" && return "[Nai]"
    isnai(x) && flag == "c" && return "[nai]"
    if (conversion == "e" || conversion == "E") && (flag == "u" || flag == "d")
        throw(ArgumentError("Cannot output the interval as a string"))
    end
    if prec != ""
        prec = parse(Int64, prec)
        if conversion == "E" || conversion == "e"
            mid = (x.lo + x.hi) / 2
            s = @sprintf("%.1E", mid)
            exp = parse(Int64, s[5:end])
            prec = prec - exp
        end
        if flag != "u" && flag != "d"
            r = Int32(trunc(((x.hi - x.lo) / 2) * 10^prec + 1))
            mid = round(((x.hi + x.lo) / 2) * 10^prec) / 10^prec
        end
        if flag == "u"
            mid = round(x.lo * 10^prec) / 10^prec
            r = Int32(trunc((x.hi - x.lo) * 10^prec + 1))
        end
        if flag == "d"
            mid = round(x.hi * 10^prec) / 10^prec
            r = Int32(trunc((x.hi - x.lo) * 10^prec + 1))
        end
        if r > 9
            throw(ArgumentError("Cannot output the interval as a string with given precision"))
        end
        if prec > 0
            mid = string(mid) * "0"^(prec - (length(string(mid)) - length(string(trunc(mid))) + 1))
        end
        if prec == 0
            mid = string(Int64(mid))
        end
        if conversion == "E" || conversion == "e"
            mid = parse(Float64, mid)
            s = @sprintf("%.1E", mid)
            exp = parse(Int64, s[5:end])
            mid = mid / 10^exp
            prec = prec + exp
            mid = round(mid * 10^prec) / 10^prec
            if prec > 0
                mid = string(mid) * "0"^(prec - (length(string(mid)) - length(string(trunc(mid))) + 1))
            end
            mid = string(mid)
        end
        if flag == "+"
            if parse(Float64, mid) > 0
                mid = "+" * mid
            end
        end
        if width != ""
            if length(mid) < parse(Int64, width)
                if flag == "0"
                    mid = "0"^(parse(Int64, width) - length(mid)) * mid
                end
                if flag != "0"
                    mid = " "^(parse(Int64, width) - length(mid)) * mid
                end
            end
        end
        r = string(r)
        if rad_width != ""
            r = "0"^(parse(Int64, rad_width) - length(r)) * r
        end
        if flag != "u" && flag != "d"
            s = mid*"?"*r
        end
        if flag == "u" || flag == "d"
            s = mid*"?"*r*"$flag"
        end
        if conversion == "E" || conversion == "e"
            s = mid*"?"*r*"e"*"$exp"
        end
        if overall_width != ""
            s = " "^(parse(Int64, overall_width) - length(s)) * s
        end
        return s
    end
    if prec == ""
        if flag != "u" && flag != "d"
            w = @sprintf("%.1E", (x.hi - x.lo) / 2)
            r = parse(Float64, w[1:3])
            r = Int32(trunc(r + 1))
            prec = -(parse(Int64, w[5 : end]))
            if prec > 0
                mid = round(((x.hi + x.lo) / 2) * 10^prec) / 10^prec
            end
            if prec <= 0
                mid = Int64(round((x.hi + x.lo) / 2))
            end
        end
        if flag == "u"
            w = @sprintf("%.1E", x.hi - x.lo)
            r = parse(Float64, w[1:3])
            r = Int32(trunc(r + 1))
            prec = -(parse(Int64, w[5 : end]))
            if prec > 0
                mid = round(x.lo * 10^prec) / 10^prec
            end
            if prec <= 0
                mid = Int64(round(x.lo))
            end
        end
        if flag == "d"
            w = @sprintf("%.1E", x.hi - x.lo)
            r = parse(Float64, w[1:3])
            r = Int32(trunc(r + 1))
            prec = -(parse(Int64, w[5 : end]))
            if prec > 0
                mid = round(x.hi * 10^prec) / 10^prec
            end
            if prec <= 0
                mid = Int64(round(x.hi))
            end
        end
        if r > 9
            throw(ArgumentError("Cannot output the interval as a string"))
        end
        if prec > 0
            mid = string(mid) * "0"^(prec - (length(string(mid)) - length(string(trunc(mid))) + 1))
        end
        if conversion == "E" || conversion == "e"
            mid = parse(Float64, mid)
            s = @sprintf("%.1E", mid)
            exp = parse(Int64, s[5:end])
            mid = Float64(mid / 10^exp)
            prec = prec + exp
            mid = round(mid * 10^prec) / 10^prec
            if prec > 0
                mid = string(mid) * "0"^(prec - (length(string(mid)) - length(string(trunc(mid))) + 1))
            end
        end
        mid = string(mid)
        if width != ""
            if length(mid) < parse(Int64, width)
                if flag == "0"
                    mid = "0"^(parse(Int64, width) - length(mid)) * mid
                end
                if flag != "0"
                    mid = " "^(parse(Int64, width) - length(mid)) * mid
                end
            end
        end
        r = string(r)
        if rad_width != ""
            r = "0"^(parse(Int64, rad_width) - length(r)) * r
        end
        if flag != "u" && flag != "d"
            s = mid*"?"*"$r"
        end
        if flag == "u" || flag == "d"
            s = mid*"?"*"$r"*"$flag"
        end
        if conversion == "E" || conversion == "e"
            s = mid*"?"*"$r"*"e"*"$exp"
        end
        if overall_width != ""
            s = " "^(parse(Int64, overall_width) - length(s)) * s
        end
        return s
    end
end
