module IntervalArithmeticMakieExt

using IntervalArithmetic, Makie
import Makie.GeometryBasics as GeometryBasics

# a vector of 2 (resp. 3) intervals is interpreted as a rectangle (resp. a cuboid)

function _rect(v::AbstractVector{<:Interval})
    if length(v) == 2
        x, y = v
        return GeometryBasics.Rect2{Float64}(
            GeometryBasics.Vec2(inf(x), inf(y)),
            GeometryBasics.Vec2(sup(x) - inf(x), sup(y) - inf(y)))
    elseif length(v) == 3
        x, y, z = v
        return GeometryBasics.Rect3{Float64}(
            GeometryBasics.Vec3(inf(x), inf(y), inf(z)),
            GeometryBasics.Vec3(sup(x) - inf(x), sup(y) - inf(y), sup(z) - inf(z)))
    else
        return throw(ArgumentError("boxes must have length 2 or 3"))
    end
end

function _rect2(v::AbstractVector{<:Interval})
    length(v) == 2 || return throw(ArgumentError("`poly` only supports boxes of length 2; use `mesh` or `wireframe` for boxes of length 3"))
    return _rect(v)
end

# separate vertices are needed for each face of a cuboid, so that the shading
# of `mesh` uses the face normals; `Makie.Wireframe` keeps the quadrilateral
# faces to only draw the edges of the cuboid
_mesh(v::AbstractVector{<:Interval}) =
    length(v) == 3 ? GeometryBasics.normal_mesh(_rect(v)) : GeometryBasics.mesh(_rect(v))

_quad_mesh(v::AbstractVector{<:Interval}) =
    GeometryBasics.mesh(_rect(v); facetype = GeometryBasics.QuadFace{Int})

Makie.plottype(v::AbstractVector{<:Interval}) =
    length(v) == 3 ? Makie.Mesh : Makie.Poly

Makie.plottype(v::AbstractVector{<:AbstractVector{<:Interval}}) =
    all(vᵢ -> length(vᵢ) == 3, v) ? Makie.Mesh : Makie.Poly

Makie.convert_arguments(P::Type{<:Makie.Poly}, v::AbstractVector{<:Interval}) =
    Makie.convert_arguments(P, _rect2(v))

Makie.convert_arguments(P::Type{<:Makie.Poly}, v::AbstractVector{<:AbstractVector{<:Interval}}) =
    Makie.convert_arguments(P, map(_rect2, v))

Makie.convert_arguments(P::Type{<:Makie.Mesh}, v::AbstractVector{<:Interval}) =
    Makie.convert_arguments(P, _mesh(v))

Makie.convert_arguments(P::Type{<:Makie.Mesh}, v::AbstractVector{<:AbstractVector{<:Interval}}) =
    Makie.convert_arguments(P, merge(map(_mesh, v)))

Makie.convert_arguments(P::Type{<:Makie.Wireframe}, v::AbstractVector{<:Interval}) =
    Makie.convert_arguments(P, _quad_mesh(v))

Makie.convert_arguments(P::Type{<:Makie.Wireframe}, v::AbstractVector{<:AbstractVector{<:Interval}}) =
    Makie.convert_arguments(P, merge(map(_quad_mesh, v)))

# enclosure of a function over a grid

Makie.convert_arguments(P::Type{<:Makie.Band}, x::AbstractVector{<:Real}, y::AbstractVector{<:Interval}) =
    Makie.convert_arguments(P, x, inf.(y), sup.(y))

Makie.convert_arguments(::Type{<:Makie.Band}, ::AbstractVector{<:Interval}, ::AbstractVector{<:Interval}) =
    throw(ArgumentError("`band` requires the x values to be real numbers; use `plot` to display a vector of boxes"))

end
