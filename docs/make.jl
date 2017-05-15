using Documenter, IntervalArithmetic

makedocs(
    modules = [IntervalArithmetic],
    format = :html,
    sitename = "IntervalArithmetic",
    pages = [
        "Package" => "index.md",
        "Basic usage" => "usage.md",
        "Decorations" => "decorations.md",
        "Multi-dimensional boxes" => "multidim.md",
        "Rounding" => "rounding.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo   = "github.com/JuliaIntervals/IntervalArithmetic.jl.git",
    target = "build",
    julia = "0.5",
    osname = "linux",
    deps   = nothing,
    make   = nothing
)
