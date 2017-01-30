# Define rounded versions of elementary functions
# E.g.  +(a, b, RoundDown)
# Some, like sin(a, RoundDown)  are already defined in CRlibm


import Base: +, -, *, /, sin, sqrt, inv, ^, zero, convert, parse

# unary minus:
-{T<:AbstractFloat}(a::T, ::RoundingMode) = -a  # ignore rounding

# zero:
zero{T<:AbstractFloat}(a::Interval{T}, ::RoundingMode) = zero(T)
zero{T<:AbstractFloat}(::Type{T}, ::RoundingMode) = zero(T)

convert(::Type{BigFloat}, x, rounding_mode::RoundingMode) = setrounding(BigFloat, rounding_mode) do
    convert(BigFloat, x)
end

parse{T}(::Type{T}, x, rounding_mode::RoundingMode) = setrounding(T, rounding_mode) do
    parse(T, x)
end


# no-ops for rational rounding:
for f in (:+, :-, :*, :/)
    @eval $f{T<:Rational}(a::T, b::T, ::RoundingMode) = $f(a, b)
end

sqrt{T<:Rational}(a::T, rounding_mode::RoundingMode) = setrounding(float(T), rounding_mode) do
    sqrt(float(a))
end



for mode in (:Down, :Up)

    mode1 = Expr(:quote, mode)
    mode1 = :(::RoundingMode{$mode1})

    mode2 = Symbol("Round", mode)


    for f in (:+, :-, :*, :/,
                :atan2)

        @eval begin
            function $f{T<:AbstractFloat}(a::T, b::T, $mode1)
                setrounding(T, $mode2) do
                    $f(a, b)
                end
            end
        end
    end

    @eval begin
        function ^{T<:AbstractFloat,S}(a::T, b::S, $mode1)
            setrounding(T, $mode2) do
                ^(a, b)
            end
        end
    end


    for f in (:sqrt, :inv,
            :tanh, :asinh, :acosh, :atanh)   # these functions not in CRlibm
        @eval begin
            function $f{T<:AbstractFloat}(a::T, $mode1)
                setrounding(T, $mode2) do
                    $f(a)
                end
            end
        end
    end

end
