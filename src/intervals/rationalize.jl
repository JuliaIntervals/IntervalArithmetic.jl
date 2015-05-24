#=
This provides a version of `rationalize` (renamed `old_rationalize`
so as not to interfere with the version from `Base`) taken from v0.3 of Julia, since
that version works correctly with rounding modes other than RoundNearest
(which version v0.4 does not: https://github.com/JuliaLang/julia/issues/10872)

According to `git blame`, this version is due to Stefan Karpinski and Mike Nolta

Slightly adapted for v0.4 by replacing itrunc(x) with @compat trunc(Int, x))
=#

# Subject to the standard Julia MIT license:

#=
The Julia language is licensed under the MIT License. The "language" consists
of the compiler (the contents of src/), most of the standard library (base/),
and some utilities (most of the rest of the files in this repository). See below
for exceptions.

> Copyright (c) 2009-2014: Jeff Bezanson, Stefan Karpinski, Viral B. Shah,
> and other contributors:
>
> https://github.com/JuliaLang/julia/contributors
=#

function old_rationalize{T<:Integer}(::Type{T}, x::FloatingPoint; tol::Real=eps(x))
    if isnan(x);       return zero(T)//zero(T); end
    if x < typemin(T); return -one(T)//zero(T); end
    if typemax(T) < x; return  one(T)//zero(T); end
    tm = x < 0 ? typemin(T) : typemax(T)
    z = x*tm
    if z <= 0.5 return zero(T)//one(T) end
    if z <= 1.0 return one(T)//tm end
    y = x
    a = d = 1
    b = c = 0
    while true
        f = @compat trunc(Int, y); y -= f
        p, q = f*a+c, f*b+d
        typemin(T) <= p <= typemax(T) &&
        typemin(T) <= q <= typemax(T) || break
        0 != sign(a)*sign(b) != sign(p)*sign(q) && break
        a, b, c, d = p, q, a, b
        if y == 0 || abs(a/b-x) <= tol
            break
        end
        y = inv(y)
    end
    return convert(T,a)//convert(T,b)
end

old_rationalize(x::Union(Float64,Float32); tol::Real=eps(x)) = old_rationalize(Int, x, tol=tol)
