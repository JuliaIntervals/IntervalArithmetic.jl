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

const configuration = Dict(:directed_rounding => :tight,
                           :powers => :fast)

const allowed_values = Dict(:directed_rounding => (:tight, :fast, :none),
                            :powers => (:tight, :fast))

function configure!(; directed_rounding=nothing, powers=nothing)
    if directed_rounding != nothing
        if directed_rounding ∉ allowed_values[:directed_rounding]
            throw(ArgumentError("directed_rounding must be one of $(allowed_values[:directed_rounding])"))
        end

        configuration[:directed_rounding] = directed_rounding

        # name mismatch
        if directed_rounding == :fast
            directed_rounding = :accurate
        end

        set_directed_rounding(directed_rounding)
    end

    if powers != nothing
        if powers ∉ allowed_values[:powers]
            throw(ArgumentError("powers must be one of $(allowed_values[:powers])"))
        end

        configuration[:powers] = powers

        set_power_type(powers)
    end

    return configuration

end


configure!(directed_rounding=:tight, powers=:fast)
