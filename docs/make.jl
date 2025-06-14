using Documenter, IntervalArithmetic

DocMeta.setdocmeta!(IntervalArithmetic, :DocTestSetup, :(using IntervalArithmetic))

makedocs(;
    modules = [IntervalArithmetic],
    authors = "David P. Sanders and Luis Benet",
    sitename = "IntervalArithmetic.jl",
    format = Documenter.HTML(;
        assets = ["assets/intervalarithmetic.css"],
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://juliaintervals.github.io/IntervalArithmetic.jl",
        mathengine = KaTeX(Dict(
            :macros => Dict(
                "\\bydef" => "\\stackrel{\\tiny\\text{def}}{=}"
            )
        ))
    ),
    pages = [
        "Home" => "index.md",
        "Overview" => "intro.md",
        "Manual" => [
            "Constructing intervals" => "manual/construction.md",
            "Usage" => "manual/usage.md",
            "Symbols" => "manual/symbols.jl",
            "Interfaces" => [
              "Arblib.jl" => "manual/interfaces/Arblib.md"
            ],
            "API" => "manual/api.md"
        ],
        "Examples" => ["Rigorous computation of ``\\pi``" => "examples/pi.md"],
    ],
    warnonly = true
)

deploydocs(;
    repo = "github.com/JuliaIntervals/IntervalArithmetic.jl",
    devbranch = "master"
)
