# Newton method

function guarded_mid(x::Interval)
    m = mid(x)
    if m == zero(x.lo)  # midpoint exactly 0
        alpha = 0.45
        m = alpha*x.lo + (1-alpha)*x.hi   # displace to another point in the interval
    end

    m
end

function N(f::Function, f_prime::Function, x::Interval, deriv=None)

    if deriv==None
        deriv = f_prime(x)
    end

    m = guarded_mid(x)
    m = Interval(m)

    Nx = m - ( f(m) / deriv )

end



function newton_refine(f::Function, f_prime::Function, x::Interval, tolerance=1e-16)
    #print("Entering newton_refine:")
    #@show x

    while diam(x) > tolerance  # avoid problem with tiny floating-point numbers if 0 is a root
        Nx = N(f, f_prime, x)
        Nx = Nx ∩ x

        if Nx == x
            return Any[(x, :unique)]
        end
        x = Nx

    end

    Any[(x, :unique)]
end

#newton(f::Function, x::Nothing) = []


newton(f::Function, x::Interval, tolerance=1e-16) = newton(f, D(f), x, 0, tolerance)
 # use automatic differentiation if no derivative function given

function newton(f::Function, f_prime::Function, x::Interval, level::Int=0, tolerance=1e-16)

    if isempty(x)
#        if level==0
#            return [(∅, :none)]
 #       else
            return []
  #      end
    end

    #print("Entering Newton: ")
    #@show(x, level)

    if diam(x) < tolerance
        return Any[(x, :unknown)]
    end


    #deriv = differentiate(f, x)
    deriv = f_prime(x)

    if !(0 in deriv)
        Nx = N(f, f_prime, x, deriv)

        if isempty(Nx ∩ x)
         #   if level==0
         #       return [(∅, :none)]
         #   else
                return []
          #  end
        end

        if Nx ⊆ x
            return newton_refine(f, f_prime, Nx)
        end


        if isthin(x)
            return (x, :unknown)
        end

        # bisect:

        #println("Bisecting...")

        m = mid(x)

        roots = vcat(newton(f, f_prime, Interval(x.lo, m), level+1),  # must be careful with rounding of m ?
                    newton(f, f_prime, Interval(m, x.hi), level+1)
                    )

        # if length(roots) == 0 && level==0
        #    return [(∅, :none)]
        #else
            return sort!(roots)
        #end

    else  # 0 in deriv; this does extended interval division by hand
        y1 = Interval(deriv.lo, -zero(deriv.lo))
        y2 = Interval(zero(deriv.lo), deriv.hi)

        y1 = N(f, f_prime, x, y1) ∩ x
        y2 = N(f, f_prime, x, y2) ∩ x

        roots = vcat(
                         newton(f, f_prime, y1, level+1),
                         newton(f, f_prime, y2, level+1)
                         )

        #@show roots

      #  if length(roots) == 0 && level==0
      #      return [(∅, :none)]
      #  else
            return sort!(roots)
       # end

#         return sort!(vcat(
#                          newton(f, f_prime, y1),
#                          newton(f, f_prime, y2)
#                          )
#                      )
    end
end

# function process_newton(f::Function, x::Interval)

#     roots = newton(f, x)

#     unique_roots = Interval[]
#     unknown_roots = Interval[]

#     for root in roots
#         @show root
#         if root[2] == :unique
#             push!(unique_roots, root[1])
#         else
#             push!(unknown_roots, root[1])
#         end
#     end

#     sort!(unique_roots)
#     sort!(unknown_roots)

#     unique_roots, unknown_roots
# end

#import Base.show
#show(io::IO, x::Interval) = print(io, "[$(round(float(x.lo), 5)), $(round(float(x.hi), 5))]")
