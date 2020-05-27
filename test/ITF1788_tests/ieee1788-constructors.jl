#=
 
 Test Cases for interval constructors from IEEE Std 1788-2015
 
 Copyright 2016 Oliver Heimlich
 
 Copying and distribution of this file, with or without modification,
 are permitted in any medium without royalty provided the copyright
 notice and this notice are preserved.  This file is offered as-is,
 without any warranty.
 
=#
#Language imports

#Test library imports
using Test

#Arithmetic library imports
using ValidatedNumerics

#Preamble
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)

# According to the examples in Section 7.4.2, unbounded intervals can be constructed with non-common inputs.
@testset "IEEE1788.a" begin
    @test Interval(-Inf, Inf) == entireinterval(Float64)
end

# Examples from Sections 9.7.1 and 9.8
@testset "IEEE1788.b" begin
    @test @interval("[1.2345]") == Interval(0x1.3c083126e978dp+0, 0x1.3c083126e978ep+0)
    @test @interval("[1,+infinity]") == Interval(1.0, Inf)
    @test @decorated("[1,1e3]_com") == DecoratedInterval(Interval(1.0, 1000.0), com)
    @test decoration(@decorated("[1,1e3]_com")) == decoration(DecoratedInterval(Interval(1.0, 1000.0), com))
    @test @decorated("[1,1E3]_COM") == DecoratedInterval(Interval(1.0, 1000.0), com)
    @test decoration(@decorated("[1,1E3]_COM")) == decoration(DecoratedInterval(Interval(1.0, 1000.0), com))
end

# Examples from Table 9.4
@testset "IEEE1788.c" begin
    @test @interval("[1.e-3, 1.1e-3]") == Interval(0x4.189374bc6a7ecp-12, 0x4.816f0068db8bcp-12)
    @test @interval("[-0x1.3p-1, 2/3]") == Interval(-0x9.8000000000000p-4, +0xa.aaaaaaaaaaab0p-4)
    @test @interval("[3.56]") == Interval(0x3.8f5c28f5c28f4p+0, 0x3.8f5c28f5c28f6p+0)
    @test @interval("3.56?1") == Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0)
    @test @interval("3.56?1e2") == Interval(355.0, 357.0)
    @test @interval("3.560?2") == Interval(0x3.8ed916872b020p+0, 0x3.8fdf3b645a1ccp+0)
    @test @interval("3.56?") == Interval(0x3.8e147ae147ae0p+0, 0x3.90a3d70a3d70cp+0)
    @test @interval("3.560?2u") == Interval(0x3.8f5c28f5c28f4p+0, 0x3.8fdf3b645a1ccp+0)
    @test @interval("-10?") == Interval(-10.5, -9.5)
    @test @interval("-10?u") == Interval(-10.0, -9.5)
    @test @interval("-10?12") == Interval(-22.0, 2.0)
end

# Examples from Section 10.5.1
@testset "IEEE1788.d" begin
    @test @interval("[1.234e5,Inf]") == Interval(123400.0, Inf)
    @test @interval("3.1416?1") == Interval(0x3.24395810624dcp+0, 0x3.24467381d7dc0p+0)
    @test @interval("[Empty]") == ∅
end

# Example from Section 11.3
@testset "IEEE1788.e" begin
    @test DecoratedInterval(2, 1) == nai()
end

# Examples from Table 12.1
@testset "IEEE1788.e" begin
    @test @decorated("[ ]") == DecoratedInterval(∅, trv)
    @test decoration(@decorated("[ ]")) == decoration(DecoratedInterval(∅, trv))
    @test @decorated("[entire]") == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test decoration(@decorated("[entire]")) == decoration(DecoratedInterval(Interval(-Inf, Inf), dac))
    @test @decorated("[1.e-3, 1.1e-3]") == DecoratedInterval(Interval(0x4.189374bc6a7ecp-12, 0x4.816f0068db8bcp-12), com)
    @test decoration(@decorated("[1.e-3, 1.1e-3]")) == decoration(DecoratedInterval(Interval(0x4.189374bc6a7ecp-12, 0x4.816f0068db8bcp-12), com))
    @test @decorated("[-Inf, 2/3]") == DecoratedInterval(Interval(-Inf, +0xa.aaaaaaaaaaab0p-4), dac)
    @test decoration(@decorated("[-Inf, 2/3]")) == decoration(DecoratedInterval(Interval(-Inf, +0xa.aaaaaaaaaaab0p-4), dac))
    @test @decorated("[0x1.3p-1,]") == DecoratedInterval(Interval(0x1.3p-1, Inf), dac)
    @test decoration(@decorated("[0x1.3p-1,]")) == decoration(DecoratedInterval(Interval(0x1.3p-1, Inf), dac))
    @test @decorated("[,]") == DecoratedInterval(entireinterval(Float64), dac)
    @test decoration(@decorated("[,]")) == decoration(DecoratedInterval(entireinterval(Float64), dac))
    @test @decorated("3.56?1") == DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), com)
    @test decoration(@decorated("3.56?1")) == decoration(DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), com))
    @test @decorated("3.56?1e2") == DecoratedInterval(Interval(355.0, 357.0), com)
    @test decoration(@decorated("3.56?1e2")) == decoration(DecoratedInterval(Interval(355.0, 357.0), com))
    @test @decorated("3.560?2") == DecoratedInterval(Interval(0x3.8ed916872b020p+0, 0x3.8fdf3b645a1ccp+0), com)
    @test decoration(@decorated("3.560?2")) == decoration(DecoratedInterval(Interval(0x3.8ed916872b020p+0, 0x3.8fdf3b645a1ccp+0), com))
    @test @decorated("3.56?") == DecoratedInterval(Interval(0x3.8e147ae147ae0p+0, 0x3.90a3d70a3d70cp+0), com)
    @test decoration(@decorated("3.56?")) == decoration(DecoratedInterval(Interval(0x3.8e147ae147ae0p+0, 0x3.90a3d70a3d70cp+0), com))
    @test @decorated("3.560?2u") == DecoratedInterval(Interval(0x3.8f5c28f5c28f4p+0, 0x3.8fdf3b645a1ccp+0), com)
    @test decoration(@decorated("3.560?2u")) == decoration(DecoratedInterval(Interval(0x3.8f5c28f5c28f4p+0, 0x3.8fdf3b645a1ccp+0), com))
    @test @decorated("-10?") == DecoratedInterval(Interval(-10.5, -9.5), com)
    @test decoration(@decorated("-10?")) == decoration(DecoratedInterval(Interval(-10.5, -9.5), com))
    @test @decorated("-10?u") == DecoratedInterval(Interval(-10.0, -9.5), com)
    @test decoration(@decorated("-10?u")) == decoration(DecoratedInterval(Interval(-10.0, -9.5), com))
    @test @decorated("-10?12") == DecoratedInterval(Interval(-22.0, 2.0), com)
    @test decoration(@decorated("-10?12")) == decoration(DecoratedInterval(Interval(-22.0, 2.0), com))
    @test @decorated("-10??u") == DecoratedInterval(Interval(-10.0, Inf), dac)
    @test decoration(@decorated("-10??u")) == decoration(DecoratedInterval(Interval(-10.0, Inf), dac))
    @test @decorated("-10??") == DecoratedInterval(Interval(-Inf, Inf), dac)
    @test decoration(@decorated("-10??")) == decoration(DecoratedInterval(Interval(-Inf, Inf), dac))
    @test @decorated("[nai]") == nai()
    @test @decorated("3.56?1_def") == DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), def)
    @test decoration(@decorated("3.56?1_def")) == decoration(DecoratedInterval(Interval(0x3.8ccccccccccccp+0, 0x3.91eb851eb8520p+0), def))
end

# Examples from Section 12.11.3
@testset "IEEE1788.f" begin
    @test @interval("[]") == ∅
    @test @interval("[empty]") == ∅
    @test @interval("[ empty ]") == ∅
    @test @interval("[,]") == entireinterval(Float64)
    @test @interval("[ entire ]") == entireinterval(Float64)
end
# FactCheck.exitstatus()
