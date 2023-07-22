# Input

`IntervalArtihmetic` allows to construct intervals using a string as input. The function `parse` converts the input string into an interval.

- parse(::Interval{Type}, ::String)

  The various string formats are as follows:
  - No string parameter or `Empty` string ("[Empty]") returns an empty interval.
  - `entire` ("[entire]") and "[,]" string returns entireinterval
  - "[nai]" returns `Nai{Type}`
  - "[m]" returns `Interval(m,m)`
  - "[l, r]" returns `Interval(l, r)`
  - "m?r" returns `Interval(m-r, m+r)`
  - "m?ren" returns `Interval((m-r)en, (m+r)en)`
  - "m?ru" or "m?rd" returns `Interval(m, m+r)` or `Interval(m-r, m)` respectively
  - "m?" returns `Interval(m + 5 precision units, m - 5 precision units)`
  - "m??" returns `Interval(-Inf, +Inf)`
  - "m??u" or "m??d" returns `Interval(m, +Inf)` or `Interval(-Inf, m) respectively`
  Similarly, for decorated interval add `_dec` at the end of the string otherwise decoration is determined using `decoration` function.

  ```jl

  julia> parse(Interval{Float64}, "[1, 2]")
  [1, 2]

  julia> parse(Interval{Float64}, "3.56?1")
  [3.54999, 3.57001]

  julia> parse(Interval{Float64}, "-10?")
  [-10.5, -9.5]

  julia> parse(DecoratedInterval{Float64}, "[3, 4]")
  [3, 4]

  julia> parse(DecoratedInterval{Float64}, "[3, 4]_dac")
  [3, 4]

  julia> decoration(parse(DecoratedInterval{Float64}, "[3, 4]_dac"))
  dac::DECORATION = 3

  ```

# Output

`IntervalArtihmetic` converts an interval and returns string which contains the input interval. The function `intervaltotext` takes a string conversion specifier `cs` as parameter and converts the interval to string accordingly.

-intervaltotext(::Interval)

  Without conversion specifier, the `intervaltotext` function returns the input interval as string with maximum 5 digits of precision.

-intervaltotext(::Interval, ::string)

  The format for default(infsup) string output is
  `"overall_width : [ flags width . precision conversion]"`

  - overall_width, if specified denotes the length of the string. It must be followed by colon sign.
  - The following flags specify different format to output the string.
    'C'   Returns upper case for Empty, Entire and Nai
    'c'   Returns lower case for Empty, Entire and Nai
    '<'   Returns Entire as [-Inf, +Inf] instead of [Entire]
    '0'   Left-pads the numbers with zeros instead of spaces within the field width

  - The width specifies the length of lower and upper bound.
  - The precision for upper and lower bound denotes the number of digits after decimal.
  - conversion determines the format of output interval string. 'e' of 'E' as conversion returns the interval in scientific notation. No conversion or any other letter returns default floating point representation.

  The format of `cs` for uncertain string output is
  `"overall_width : flags width . precision ? radius_width conversion"`

  - overall_width, if specified denotes the length of the string. It must be followed by colon sign.
  - The following flags specify different format to output the string.
    'd'   Returns the interval with midpoint as upper bound and radius taken in downward direction.
    'u'   Returns the interval with midpoint as lower bound and radius taken in upward direction.
    'C'   Returns upper case for Empty, Entire and Nai
    'c'   Returns lower case for Empty, Entire and Nai
    '+'   Returns positive numbers with '+' sign before the number
    '0'   Left-pads the numbers with zeros instead of spaces within the field width

  - The field width specifies the length of midpoint string.
  - The precision denotes the number of digits after decimal in the midpoint.
  - The radius_width specify the width of the radius. The radius is padded with zeroes.
  - conversion determines the format of output interval string. 'e' or 'E' as conversion returns the interval in scientific notation. No conversion or any other letter returns default floating point representation.

```jl

julia> interval_to_string(Interval(1, 4))
"[1, 4]"

julia> interval_to_string(Interval(1.123423423, 4.1334224))
"[1.12342, 4.13343]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), "8 : [c  .  ]")
"[2.3, 4]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), " : [ 3 .  ]")
"[2.3, 3.6]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), " : [ . 3 ]")
"[2.353, 3.565]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), " : [ 4 . 2 ]")
"[2.35, 3.57]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), "14 : [ . 3 ]")
"[2.353, 3.565]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), "12 : [ 3 . 1]")
"  [2.3, 3.6]"

julia> interval_to_string(Interval(23.534534644, 100.64537887687), "12 : [ .  e]")
"[2.3e1, 2e2]"

julia> interval_to_string(Interval(23.534534644, 100.64537887687), "14 : [ .  e]")
"[2.3e1, 1.1e2]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), " : [ 5 .  e]")
"[2.3e0, 3.6e0]"

julia> interval_to_string(Interval(2.3534534644, 30.564537887687), " : [ . 2 e]")
"[2.35e0, 3.06e1]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), " : [ 6 . 1 e]")
"[ 2.3e0,  3.6e0]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), "18 : [ . 3 e]")
"[2.353e0, 3.565e0]"

julia> interval_to_string(Interval(2.3534534644, 3.564537887687), "16 : [ 5 . 1 e]")
"  [2.3e0, 3.6e0]"

julia> interval_to_string(3.55 .. 3.578, "6 :  4 . 2 ?")
"3.56?2"

julia> interval_to_string(3.55 .. 3.578, "8 :u 4 . 2 ?")
" 3.55?3u"

julia> interval_to_string(3.55 .. 3.578, "8 :d 4 . 2 ?")
" 3.58?3d"

julia> interval_to_string(Interval(3.555, 3.565), "7 : . 3 ?")
"3.560?5"

julia> interval_to_string(Interval(3.555, 3.565), "8 :0 6 . 3 ?")
"03.560?5"

julia> interval_to_string(35.5 .. 36.78, "8 :  4 . 2 ? 1 e")
"3.61?7e1"

julia> interval_to_string(35.55 .. 35.65, "9 : . 3 ? 1 e")
"3.560?6e1"

julia> interval_to_string(3.55 .. 3.578, "6 :  4 .  ?")
"3.56?2"

julia> interval_to_string(3.55 .. 3.578, " :u 4 .  ?")
"3.55?3u"

julia> interval_to_string(Interval(3.555, 3.565), "7 : .  ?")
"3.560?6"

julia> interval_to_string(35.5 .. 35.78, "8 :  4 .  ? e")
"3.56?2e1"

julia> interval_to_string(Interval(35.55, 35.65), "9 : .  ? e")
"3.560?6e1"  

```
