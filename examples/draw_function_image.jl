using IntervalArithmetic

using PyCall
using PyPlot

@pyimport matplotlib.patches as patches
@pyimport matplotlib.collections as collections


const rectangle = patches.Rectangle

function make_rectangle(x, y, xwidth, ywidth, color="grey", alpha=0.5)
    patches.Rectangle(
        (x, y), xwidth, ywidth, facecolor=color, alpha=alpha
    )
end

import PyPlot.draw
function draw(box_list::Vector{T}, color="grey", alpha=0.5) where T<:IntervalBox
    patch_list = []
    for box in box_list
        x, y = box
        push!(patch_list,
            make_rectangle(x.lo, y.lo, x.hi-x.lo, y.hi-y.lo, color, alpha))
    end

    ax = gca()
    ax[:add_collection](collections.PatchCollection(patch_list, color=color, alpha=alpha,
    edgecolor="black"))
end
