## Newton's method (interval) code

module NewtonMethod
export newton, differentiate, Interval, rad, diam, mid, mig, mag, belong, hd, hull, isect, isectext

using AutoDiff

println("Syntax: newton(function, Interval(lo, hi), precision [default is 64])")

function newton(f::Function, a::Interval, bigprec::Integer=64)

	set_bigfloat_precision(bigprec)

	center(x) = Interval(mid(x))
	N(x) = center(x) - f(center(x))//differentiate(f, x)
	do_isect(x, y) = isectext(arr_a[x], arr_b[y])

	# If a is symmetric, i.e., mid(a) = 0, the process may stall. The initial interval should be slightly asymmetrized then
	if mid(a) == 0
		a = Interval(a.lo, a.hi + 0.0001*mag(a))
	end

	x = Ad(a, Interval(1.))

	arr_a = Interval[]
	arr_b = Interval[]

	push!(arr_a, a)

	k = 0
	while true
		
		#println(k)
		#@show((arr_a, arr_b))
		
		arr_b = Interval[]

		for i = 1:length(arr_a)
			push!(arr_b, N(arr_a[i]))
		end
		
		#@show arr_b

		arr_a_new = Interval[]

		for i = 1:length(arr_b)
			do_isect(i, i)
			if do_isect(i, i) != false
				arr_a_new = vcat(arr_a_new, do_isect(i, i))
			end
		end

		if arr_a_new == arr_a 
			break
		end
		
		arr_a = arr_a_new
		k += 1
	end

	println("Function calls: ", k)
	return arr_a
end

# end of module
end
