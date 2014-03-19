import Base.show
import Base.exp, Base.log


set_bigfloat_precision(53)


macro rounding(expr1, expr2)
    quote
        set_rounding(BigFloat, RoundDown)
        c = $expr1
        set_rounding(BigFloat, RoundUp)
        d = $expr2  
        (c,d)
    end
end

macro rounded_interval(expr1, expr2)
    quote
        Interval( @rounding($expr1, $expr2) )
    end
end


type Interval
    lo
    hi
    
    function Interval(a, b)
    	if a > b
    		a, b = b, a
    	end

        (lo, hi) = @rounding(BigFloat("$a"), BigFloat("$b"))

    	new(lo, hi)

    end
end

I = Interval  # convenience!


Interval(a::Tuple) = Interval(a[1], a[2])
Interval(a) = Interval(a, a)  # constructor

function +(a::Interval, b::Interval)

    #(c, d) = Interval( @rounding(a.lo+b.lo, a.hi+b.hi) )
    @rounded_interval(a.lo+b.lo, a.hi+b.hi)
    #Interval(c, d)
    
    # can replace by:
    # Interval(@rounding(a.lo+b.lo, a.hi+b.hi)...)  # using splat operator
end

+(a, b::Interval) = Interval(a) + b
+(a::Interval, b) = a + Interval(b)

-(a::Interval) = Interval(-a.hi, -a.lo)  # unary minus
-(a::Interval, b::Interval) = a + (-b)
-(a, b::Interval) = Interval(a) - b
-(a::Interval, b) = a - Interval(b)

function *(a::Interval, b::Interval)
 
    # (c, d) = @rounding( minimum( (a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi) ), 
    #     maximum( (a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi) ) )

    # Interval(c, d)

    @rounded_interval(minimum( (a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi) ), 
        maximum( (a.lo*b.lo, a.lo*b.hi, a.hi*b.lo, a.hi*b.hi) )  )
end


*(a::Interval, b) = a * Interval(b)
*(a, b::Interval) = Interval(a) * b

in(x, a::Interval) = a.lo <= x <= a.hi
    
function reciprocal(a::Interval)
	if zero(a.lo) in a  
		error("Dividing by interval containing 0")
	else
        @rounded_interval( one(a.hi)/a.hi, one(a.lo)/a.lo )
       
	end
end

/(a::Interval, b::Interval) = a * reciprocal(b)
/(a::Interval, b) = a / Interval(b)
/(a, b::Interval) = Interval(a) / b

intersection(a::Interval, b::Interval) = a.hi < b.lo ? None : @rounded_interval(b.lo, a.hi) 

#repr(x::Interval) = "[$(repr(x.lo)), $(repr(x.hi))]"
show(io::IO, x::Interval) = print(io, "[$(x.lo), $(x.hi)]")


i = Interval(0.1)
j = Interval(2, 3)

sqrt(a::BigFloat) = a^0.5
sqrt(a::Interval) = @rounded_interval( maximum( (0, sqrt(a.lo) ) ), sqrt(a.hi) )

width(i::Interval) = i.hi - i.lo

#exp(i::Interval) = @rounded_interval(exp(i.lo), exp(i.hi))

# macro monotone(f)
#         @eval ($f)(i::Interval) = @rounded_interval($f(i.lo), $f(i.hi))
# end

# monotone functions:
for f in (:exp, :log)
    @eval ($f)(i::Interval) = @rounded_interval($f(i.lo), $f(i.hi))
end

