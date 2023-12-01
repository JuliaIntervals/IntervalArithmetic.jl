"""
    generate(filename; ofolder="", failure=false)

Generates the julia tests from the file filename. The tests in filename must be written
using the ITL domain specific language. The tests are written in a .jl file with the same
name of filename. The folder where to save the output file is specifified

If failure=true, than each test is also executed before printing to the target file. If the
test fails, then the test is generated as ´@test_broken`.
"""
function generate(filename)

    # read file
    src = joinpath(@__DIR__, "itl", filename)
    f = open(src)
    lines = readlines(f)
    close(f)

    # file where to Write
    dest = joinpath("ITF1788_tests", filename[1:end-4]*".jl")
    mkpath("ITF1788_tests")
    f = open(dest; write=true)

    # where testcase blocks start
    rx_start = r"^\s*testcase\s+\S+\s+\{\s*$"
    rx_end = r"^\s*\}\s*$"
    block_start = findall(x -> occursin(rx_start, x), lines)
    block_end = findall(x -> occursin(rx_end, x), lines)

    # check opening and closing blocks match
    length(block_start) == length(block_end) || throw(ArgumentError("opening and closing braces not not much in $filename"))

    for (bstart, bend) in zip(block_start, block_end)
        testset = parse_block(lines[bstart:bend])
        write(f, testset)
    end

    close(f)
    nothing
end

#

functions = Dict(
    "atan2" => x -> "atan($x)",
    "add" => x -> "+($x)",
    "sub" => x -> "-($x)",
    "pos" => x -> "+($x)",
    "neg" => x -> "-($x)",
    "mul" => x -> "*($x)",
    "div" => x -> "/($x)",
    "convexHull" => x -> "hull($x)",
    "intersection" => x -> "intersect_interval($x)",
    "interior" => x -> "isinterior($x)",
    "subset" => x -> "issubset_interval($x)",
    "equal" => x -> "isequal_interval($x)",
    "sqr" => x -> "pown($x, 2)",
    "pow" => x -> "^($x)",
    "rootn" => x -> "rootn($x)",
    "sqrt" => x -> "sqrt($x)",
    "exp" => x -> "exp($x)",
    "exp2" => x -> "exp2($x)",
    "exp10" => x -> "exp10($x)",
    "log" => x -> "log($x)",
    "log2" => x -> "log2($x)",
    "log10" => x -> "log10($x)",
    "sin" => x -> "sin($x)",
    "cos" => x -> "cos($x)",
    "tan" => x -> "tan($x)",
    "cot" => x -> "cot($x)",
    "asin" => x -> "asin($x)",
    "acos" => x -> "acos($x)",
    "atan" => x -> "atan($x)",
    "acot" => x -> "acot($x)",
    "sinh" => x -> "sinh($x)",
    "cosh" => x -> "cosh($x)",
    "tanh" => x -> "tanh($x)",
    "coth" => x -> "coth($x)",
    "asinh" => x -> "asinh($x)",
    "acosh" => x -> "acosh($x)",
    "atanh" => x -> "atanh($x)",
    "acoth" => x -> "acoth($x)",
    "expm1" => x -> "expm1($x)",
    "logp1" => x -> "log1p($x)",
    "cbrt" => x -> "cbrt($x)",
    "csc" => x -> "csc($x)",
    "csch" => x -> "csch($x)",
    "hypot" => x -> "hypot($x)",
    "sec" => x -> "sec($x)",
    "sech" => x -> "sech($x)",
    "intervalPart" => x -> "bareinterval($x)",
    "isEmpty" => x -> "isempty_interval($x)",
    "isEntire" => x -> "isentire_interval($x)",
    "isNaI" => x -> "isnai($x)",
    "less" => x -> "isweakless($x)",
    "strictLess" => x -> "isstrictless($x)",
    "precedes" => x -> "precedes($x)",
    "strictPrecedes" => x -> "strictprecedes($x)",
    "disjoint" => x -> "isdisjoint_interval($x)",
    "newDec" => x -> "interval($x)",
    "setDec" => x -> "interval($x)",
    "decorationPart" => x -> "decoration($x)",
    "recip" => x -> "inv($x)",
    "fma" => x -> "fma($x)",
    "pown" => x -> "pown($x)",
    "sign" => x -> "sign($x)",
    "ceil" => x -> "ceil($x)",
    "floor" => x -> "floor($x)",
    "trunc" => x -> "trunc($x)",
    "roundTiesToEven" => x -> "round($x)",
    "roundTiesToAway" => x -> "round($x, RoundNearestTiesAway)",
    "abs" => x -> "abs($x)",
    "min" => x -> "min($x)",
    "max" => x -> "max($x)",
    "inf" => x -> "inf($x)",
    "sup" => x -> "sup($x)",
    "mid" => x -> "mid($x)",
    "rad" => x -> "radius($x)",
    "midRad" => x -> "midradius($x)",
    "wid" => x -> "diam($x)",
    "mag" => x -> "mag($x)",
    "mig" => x -> "mig($x)",
    "overlap" => x -> "overlap($x)",
    "isCommonInterval" => x -> "iscommon($x)",
    "isSingleton" => x -> "isthin($x)",
    "isMember" => x -> "in_interval($x)",
    "cancelPlus" => x -> "cancelplus($x)",
    "cancelMinus" => x -> "cancelminus($x)",
    "sum_nearest" => x -> "sum($x)",
    "dot_nearest" => x -> "sum(.*($x))",
    "sum_abs_nearest" => x -> "sum(abs.($x))",
    "sum_sqr_nearest" => x -> "sum($x.^2)"
)

#

function parse_block(block)
    bname = match(r"^\s*testcase\s+(\S+)\s+\{\s*$", block[1])[1]

    testset = """@testset "$bname" begin
            """
    ind = "    "
    for i in 2:length(block)-1
        line = strip(block[i])
        (isempty(line) || startswith(line, "//")) && continue
        command = parse_command(line)
        testset = """$testset
        $ind$command
        """
    end
    testset = """$testset
            end
            """
end

"""

This function parses a line into julia code, e.g.

```
add [1, 2] [1, 2] = [2, 4]
```

is parsed into
```
@test +(Interval(1, 2), Interval(1, 2)) === Interval(2, 4)
```
"""
function parse_command(line)
    # extract parts in line
    m = match(r"^(.+)=(.+);$", line)
    lhs = m[1]
    rhs = m[2]
    rhs = split(rhs, "signal")
    warn = length(rhs) > 1 ? rhs[2] : ""
    rhs = rhs[1]

    lhs = parse_lhs(lhs)
    rhs = parse_rhs(rhs)

    expr = build_expression(lhs, rhs)

    # known broken test, unrelated to interval airthmetic
    command  = occursin("dot_nearest {0x10000000000001p0, 0x1p104} {0x0fffffffffffffp0, -1.0} = -1.0", line) ?
        "@test_broken $expr" : "@test $expr"

    # try
    #     res = eval(Meta.parse(expr))
    #     command = res ? "@test $expr" : "@test_broken $expr"
    # catch
    #     command = "@test_broken $expr"
    # end

    command = isempty(warn) ? command : "@test_logs (:warn,) $command"

    return command
end

function parse_lhs(lhs)
    lhs = strip(lhs)
    m =  match(r"^(\S+) (.+)$", lhs)
    fname = m[1]
    args = m[2]

    #special case, input text
    fname == "b-textToInterval" && return "parse(BareInterval{Float64}, $args)"
    fname == "d-textToInterval" && return "parse(Interval{Float64}, $args)"

    # input numbers
    args = replace(args, "infinity" => "Inf")
    args = replace(args, "X" => "x")
    if fname == "b-numsToInterval"
        args = join(split(args), ',')
        return "bareinterval($args)"
    end

    if fname == "d-numsToInterval"
        args = join(split(args), ',')
        return "interval($args)"
    end

    # input intervals
    rx = r"\[([^\]]+)\](?:_(\w+))?"
    for m in eachmatch(rx, args)
        args = replace(args, m.match => parse_interval(m[1], m[2]))
    end
    args = replace(args, " " => ", ")
    args = replace(args, ",," => ",")
    args = replace(args, "{" => "[")
    args = replace(args, "}" => "]")
    args = replace(args, "[Float64]" => "{Float64}")
    return functions[fname](args)
end

function int_to_float(x)
    if isnothing(tryparse(Int, x))
        return x
    else
        return x * ".0"
    end
end

function parse_rhs(rhs)
    rhs = strip(rhs)
    rhs = replace(rhs, "infinity" => "Inf")
    rhs = replace(rhs, "X" => "x")
    rhs = replace(rhs,
        "bothEmpty"    => "IntervalArithmetic.Overlap.both_empty",
        "firstEmpty"   => "IntervalArithmetic.Overlap.first_empty",
        "secondEmpty"  => "IntervalArithmetic.Overlap.second_empty",
        "before"       => "IntervalArithmetic.Overlap.before",
        "meets"        => "IntervalArithmetic.Overlap.meets",
        "overlaps"     => "IntervalArithmetic.Overlap.overlaps",
        "starts"       => "IntervalArithmetic.Overlap.starts",
        "containedBy"  => "IntervalArithmetic.Overlap.contained_by",
        "finishes"     => "IntervalArithmetic.Overlap.finishes",
        "equals"       => "IntervalArithmetic.Overlap.equals",
        "finishedBy"   => "IntervalArithmetic.Overlap.finished_by",
        "contains"     => "IntervalArithmetic.Overlap.contains",
        "startedBy"    => "IntervalArithmetic.Overlap.started_by",
        "overlappedBy" => "IntervalArithmetic.Overlap.overlapped_by",
        "metBy"        => "IntervalArithmetic.Overlap.met_by",
        "after"        => "IntervalArithmetic.Overlap.after")
    if '[' ∉ rhs # one or more scalar/bolean values separated by space
        return map(int_to_float, split(rhs))
    else # one or more intervals
        rx = r"\[([^\]]+)\](?:_(\w+))?"
        ivals = [parse_interval(m[1], m[2]; check=false) for m in eachmatch(rx, rhs)]
        return ivals
    end
end

function parse_interval(ival, dec; check=true)
    ival == "nai" && return "nai()"
    if ival == "entire"
        ival =  "entireinterval(BareInterval{Float64})"
    elseif ival == "empty"
        ival = "emptyinterval(BareInterval{Float64})"
    else
        ival = check ? "bareinterval($ival)" : "bareinterval($ival)"
    end
    isnothing(dec) || (ival = "interval($ival, $dec)")
    return ival
end

function build_expression(lhs, rhs::AbstractString)
    rhs == "nai()" && return "isnai($lhs)"
    rhs == "NaN" && return "isnan($lhs)"
    return "$lhs === $rhs"
end

function build_expression(lhs, rhs::Vector)
    length(rhs) == 1 && return build_expression(lhs, rhs[1])
    expr = [build_expression(lhs*"[$i]", r) for (i, r) in enumerate(rhs)]
    return join(expr, " && ")
end
