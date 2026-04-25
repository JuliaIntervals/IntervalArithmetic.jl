import IrrationalConstants

@testset "IrrationalConstants.jl" begin
    # Get all exported constants from IrrationalConstants
    irr_names = names(IrrationalConstants; all=false, imported=false)
    
    for irr_name ∈ irr_names
        irr = getproperty(IrrationalConstants, irr_name)
        # Skip non-irrational types
        if !isa(irr, IrrationalConstants.IrrationalConstant)
            continue
        end
        
        for T ∈ (Float16, Float32, Float64, BigFloat)
            @test in_interval(irr, interval(T, irr))
            if T !== BigFloat
                @test nextfloat(inf(interval(T, irr))) == sup(interval(T, irr))
            end
        end

        for T ∈ InteractiveUtils.subtypes(Signed)
            @test in_interval(irr, interval(Rational{T}, irr)) broken=(irr == IrrationalConstants.invsqrt2π && T == Int8 && VERSION ≤ v"13")
        end

        # Negative irrationals obviously lack unsigned representations
        irr < 0 && continue

        for T ∈ InteractiveUtils.subtypes(Unsigned)
            @test in_interval(irr, interval(Rational{T}, irr))
        end
    end
end
