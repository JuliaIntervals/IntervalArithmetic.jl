"""
Holds configuration information for the package:

- `directed_rounding`:

    Which method to use to implement **directed rounding**.
    Possible values are:

    - `:tight`: correct rounding using error-free arithmetic and CRlibm. Gives
        the tightest resulting intervals, with a width of 1 ulp for each basic operation
    - `:fast`: uses `prevfloat` and `nextfloat` to give a faster result, with width 2 ulps
    - `:none`: no rounding; does *not* guarantee that the results are correct.

- `powers`:
    Method to implement powers. Possible values are
    - `:tight`: gives tightest possible result by using `BigFloat` internally, and hence is slow
    - `:fast`: uses repeated multiplication based on `Base.power_by_squaring`, and hence is faster but gives slightly looser results
"""
mutable struct Configuration
    directed_rounding::Symbol
    powers::Symbol
end

function Base.show(io::IO, config::Configuration)
    println(io, "IntervalArithmetic.Configuration:")
    println(io, "- directed_rounding: $(config.directed_rounding)")
    println(io, "- powers: $(config.powers)")
end


const configuration = Configuration(:tight, :fast)

const directed_rounding_values = (:tight, :fast, :none)
const power_values = (:tight, :fast)

function configure!(; directed_rounding=nothing, powers=nothing)
    if directed_rounding != nothing
        if directed_rounding ∉ directed_rounding_values
            throw(ArgumentError("directed_rounding must be one of $directed_rounding_values"))
        end

        configuration.directed_rounding = directed_rounding

        # TODO: Implement!
    end

    if powers != nothing
        if powers ∉ power_values
            throw(ArgumentError("powers must be one of $directed_rounding_values"))
        end

        configuration.powers = powers

        # TODO: Implement!
    end

    return configuration

end

configuration

configure!(powers=:tight)


ulp(f::F, x::T) where {F, T<:AbstractFloat} = 1
