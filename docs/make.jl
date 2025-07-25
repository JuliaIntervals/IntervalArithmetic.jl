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
        "Philosophy" => "philosophy.md",
        "Manual" => [
            "Constructing intervals" => "manual/construction.md",
            "Guarantee and `ExactReal`" => "manual/guarantee.md",
            "Usage" => "manual/usage.md",
            "Configuration" => "manual/configuration.md",
            "Symbols" => "manual/symbols.md",
            "API" => "manual/api.md"
        ],
        "Interfaces" => [
            "Arblib.jl" => "interfaces/arblib.md"
        ],
        "Examples" => ["Rigorous computation of ``\\pi``" => "examples/pi.md"],
    ],
    warnonly = true
)

deploydocs(;
    repo = "github.com/JuliaIntervals/IntervalArithmetic.jl",
    devbranch = "master"
)
