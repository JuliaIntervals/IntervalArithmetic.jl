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
    "pow" => x -> "pow($x)",
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

"""
    generate(filename::AbstractString)

Generate the julia tests from the file `filename` contained in a folder named
`itl` located in the current directory. The file must have the extension `.itl`.
The output is a Julia file with the same name, with the extension `.jl`, located
in the folder named `ITF1788_tests`. Return the path of the output file.
"""
function generate(filename::AbstractString)
    src = joinpath(@__DIR__, "itl", filename)
    lines = readlines(src)

    rx_start = r"^\s*testcase\s+\S+\s+\{\s*$" # where testcase blocks start
    rx_end = r"^\s*\}\s*$" # where testcase blocks end
    block_start = findall(line -> occursin(rx_start, line), lines)
    block_end = findall(line -> occursin(rx_end, line), lines)

    len = length(block_start)
    len == length(block_end) || return throw(ArgumentError("opening and closing braces do not match in $filename"))

    mkpath("ITF1788_tests")
    dest = joinpath("ITF1788_tests", replace(filename, ".itl" => ".jl"))

    open(dest, "w") do io
        i = 1
        for (bstart, bend) ∈ zip(block_start, block_end)
            testset = parse_block(view(lines, bstart:bend))
            i < len ? write(io, testset * "\n") : write(io, testset)
            i += 1
        end
    end

    return dest
end

function parse_block(block)
    blockname = match(r"^\s*testcase\s+(\S+)\s+\{\s*$", block[1])[1]

    testset = """@testset "$blockname" begin
            """
    indentation = "    "
    for i ∈ 2:length(block)-1
        line = strip(block[i])
        isempty(line) | startswith(line, "//") && continue
        command = parse_command(line)
        testset = """$testset
        $indentation$command
        """
    end
    testset = """$testset
            end
            """

    return testset
end

# e.g. `add [1, 2] [1, 2] = [2, 4]` is parsed as `@test +(interval(1, 2), interval(1, 2)) === interval(2, 4)`
function parse_command(line)
    # extract parts in line
    m = match(r"^(.+)=(.+);$", line)
    lhs = m[1]
    vrhs = split(m[2], "signal")
    haswarning = length(vrhs) > 1
    rhs = vrhs[1]

    lhs = parse_lhs(lhs)
    rhs = parse_rhs(rhs)

    expr = build_expression(lhs, rhs)
    command = "@test $expr"

    if occursin("dot_nearest {0x10000000000001p0, 0x1p104} {0x0fffffffffffffp0, -1.0} = -1.0", line)
        # broken test unrelated to interval airthmetic
        command = "@test_broken $expr"
    elseif occursin("atan2 [-0.0, 1.0]_com [-2.0, -0.1]_com = [0X1.ABA397C7259DDP+0, 0X1.921FB54442D19P+1]_dac", line)
        # erroneous test: the decoration of the result should be `com`
        command =
            """
            @warn "The original test `atan2 [-0.0, 1.0]_com [-2.0, -0.1]_com = [0X1.ABA397C7259DDP+0, 0X1.921FB54442D19P+1]_dac` is wrong and has been modified. The result should have the decoration `com`"
                @test atan(interval(bareinterval(-0.0, 1.0), com), interval(bareinterval(-2.0, -0.1), com)) === interval(bareinterval(0x1.ABA397C7259DDP+0, 0x1.921FB54442D19P+1), com)"""
    end

    command = haswarning ? "@test_logs (:warn,) $command" : command

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
    args = replace(args, "infinity" => "Inf", "X" => "x")
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
    for m ∈ eachmatch(rx, args)
        args = replace(args, m.match => parse_interval(m[1], m[2]))
    end

    args = replace(args, " " => ", ")
    args = replace(args, ",," => ",")
    args = replace(args, "{" => "[")
    args = replace(args, "}" => "]")
    args = replace(args, "[Float64]" => "{Float64}")
    return functions[fname](args)
end

int_to_float(x) = x * ifelse(isnothing(tryparse(Int64, x)), "", ".0")

function parse_rhs(rhs)
    rhs = replace(strip(rhs),
        "infinity"     => "Inf",
        "X"            => "x",
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
    if occursin('[', rhs) # one or more intervals
        rx = r"\[([^\]]+)\](?:_(\w+))?"
        ivals = [parse_interval(m[1], m[2]) for m ∈ eachmatch(rx, rhs)]
        return ivals
    else # one or more scalar/boolean values separated by space
        return map(int_to_float, split(rhs))
    end
end

function parse_interval(ival::AbstractString, dec::Union{Nothing,AbstractString})
    ival == "nai" && return "nai(Interval{Float64})"
    if ival == "entire"
        ival = "entireinterval(BareInterval{Float64})"
    elseif ival == "empty"
        ival = "emptyinterval(BareInterval{Float64})"
    else
        ival = "bareinterval($ival)"
    end
    isnothing(dec) && return ival
    return "interval($ival, $dec)"
end

function build_expression(lhs::AbstractString, rhs::Vector)
    length(rhs) == 1 && return build_expression(lhs, rhs[1])
    expr = [build_expression(lhs * "[$i]", r) for (i, r) ∈ enumerate(rhs)]
    return join(expr, " && ")
end

function build_expression(lhs::AbstractString, rhs::AbstractString)
    rhs == "nai()" && return "isnai($lhs)"
    rhs == "NaN" && return "isnan($lhs)"
    return "$lhs === $rhs"
end
