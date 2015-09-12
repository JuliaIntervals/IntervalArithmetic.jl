# This file is part of the ValidatedNumerics.jl package; MIT licensed

## Output

function basic_show(io::IO, a::Interval)
    if isempty(a)
        output = "∅"
    else
        output = "[$(a.lo), $(a.hi)]"
        output = replace(output, "inf", "∞")
        output = replace(output, "Inf", "∞")

        output
    end

    print(io, output)
end

show(io::IO, a::Interval) = basic_show(io, a)
show(io::IO, a::Interval{BigFloat}) = ( basic_show(io, a); print(io, subscriptify(precision(a.lo))) )

function subscriptify(n::Int)
    subscript_digits = [c for c in "₀₁₂₃₄₅₆₇₈₉"]
    dig = reverse(digits(n))
    join([subscript_digits[i+1] for i in dig])
end
