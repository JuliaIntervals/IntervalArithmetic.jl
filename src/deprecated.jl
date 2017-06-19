# deprecated in 0.7:

export displaymode

function displaymode(; format = display_params.format,
                    decorations = display_params.decorations,
                    sigfigs::Integer = display_params.sigfigs)
    Base.depwarn("`displaymode(format=f)` is deprecated. Use `setformat(f)` instead.", :setformat)

    setformat(format; decorations=decorations, sigfigs=sigfigs)
end

@deprecate infimum inf
@deprecate supremum sup 
