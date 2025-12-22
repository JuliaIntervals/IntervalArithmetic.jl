using BenchmarkTools
using CairoMakie
using DataFrames

include("benchmarks.jl")

results = run(SUITE ; verbose = true)

df = DataFrame(; constructor = String[], suite = String[], f = String[], trial = BenchmarkTools.Trial[])

for (name, T) in interval_constructors
    for suite in suites
        suite_df = DataFrame(results[name][suite], [:f, :trial])
        suite_df[:, :constructor] .= name
        suite_df[:, :suite] .= suite
        df = vcat(df, suite_df)
    end
end

transform!(df,
    :trial => ByRow(trial -> minimum(trial.times)) => :minimum,
    :trial => ByRow(trial -> mean(trial.times)) => :mean,
    :trial => ByRow(trial -> median(trial.times)) => :median
)

df[:, :relative] .= 0.0

for group in groupby(df, :f)
    group[:, :relative] .= group[:, :minimum] ./ only(group[group.constructor .== "bareinterval", :minimum])
end

begin
    fig = Figure(size = (800, 500))
    
    data = df[df.suite .== "basics", :]

    fs = vcat(string.(basic_arithmetic), string.(basic_functions))
    to_x = Dict(f => k for (k, f) in enumerate(fs))
    xx = [to_x[f] for f in data.f]
    
    constructors = ["bareinterval", "interval", "BigFloat bareinterval", "BigFloat interval", "BigFloat MPFI"]
    to_dodge = Dict(constructor => k for (k, constructor) in enumerate(constructors))
    dodge = [to_dodge[constructor] for constructor in data.constructor]

    ax = Axis(fig[1, 1] ;
        xlabel = "Benchmarked function",
        xticks = (1:length(fs), fs),
        ylabel = "Relative execution time (log scale)",
        yscale = log10,
    )

    barplot!(ax, xx, data.relative ;
        dodge,
        color = dodge,
        colormap = :mpetroff_10,
        colorrange = (1, 10),
    )

    Legend(fig[0, 1],
        [LineElement(linewidth = 20, color = to_colormap(:mpetroff_10)[k]) for k in eachindex(constructors)],
        constructors ;
        tellwidth = false,
        orientation = :horizontal
    )

    fig
end