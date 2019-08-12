using Documenter, IntervalArithmetic

makedocs(
    modules = [IntervalArithmetic],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    sitename = "IntervalArithmetic",
    authors = "David P. Sanders and Luis Benet",
    pages = [
        "Package" => "index.md",
        "Interval Arithmetic" => "intro.md",
        "Constructing intervals" => "construction.md",
        "Basic usage" => "usage.md",
        "Decorations" => "decorations.md",
        "Multi-dimensional boxes" => "multidim.md",
        "Rounding" => "rounding.md",
        "API" => "api.md",
        "Input&Output" => "input_output.md"
    ]
)

deploydocs(
    repo   = "github.com/JuliaIntervals/IntervalArithmetic.jl.git",
    target = "build",
    deps   = nothing,
    make   = nothing
)
