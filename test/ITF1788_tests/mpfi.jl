@testset "mpfi_abs" begin

    @test abs(bareinterval(-Inf, -7.0)) === bareinterval(+7.0, +Inf)

    @test abs(bareinterval(-Inf, 0.0)) === bareinterval(0.0, +Inf)

    @test abs(bareinterval(-Inf, 0.0)) === bareinterval(0.0, +Inf)

    @test abs(bareinterval(-Inf, +8.0)) === bareinterval(0.0, +Inf)

    @test abs(entireinterval(BareInterval{Float64})) === bareinterval(0.0, +Inf)

    @test abs(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test abs(bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test abs(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test abs(bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test abs(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test abs(bareinterval(0x123456789p-16, 0x123456799p-16)) === bareinterval(0x123456789p-16, 0x123456799p-16)

    @test abs(bareinterval(-0x123456789p-16, 0x123456799p-16)) === bareinterval(0.0, 0x123456799p-16)

end

@testset "mpfi_acos" begin

    @test acos(bareinterval(-1.0, 0.0)) === bareinterval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-51)

    @test acos(bareinterval(0.0, 0.0)) === bareinterval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-52)

    @test acos(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x1921fb54442d19p-52)

    @test acos(bareinterval(-1.0, -0.5)) === bareinterval(0x10c152382d7365p-51, 0x1921fb54442d19p-51)

    @test acos(bareinterval(-0.75, -0.25)) === bareinterval(0x1d2cf5c7c70f0bp-52, 0x4d6749be4edb1p-49)

    @test acos(bareinterval(-0.5, 0.5)) === bareinterval(0x10c152382d7365p-52, 0x860a91c16b9b3p-50)

    @test acos(bareinterval(0.25, 0.625)) === bareinterval(0x1ca94936b98a21p-53, 0x151700e0c14b25p-52)

    @test acos(bareinterval(-1.0, 1.0)) === bareinterval(0.0, 0x1921fb54442d19p-51)

end

@testset "mpfi_acosh" begin

    @test acosh(bareinterval(+1.0, +Inf)) === bareinterval(0.0, +Inf)

    @test acosh(bareinterval(+1.5, +Inf)) === bareinterval(0x1ecc2caec51609p-53, +Inf)

    @test acosh(bareinterval(1.0, 1.5)) === bareinterval(0.0, 0xf661657628b05p-52)

    @test acosh(bareinterval(1.5, 1.5)) === bareinterval(0x1ecc2caec51609p-53, 0xf661657628b05p-52)

    @test acosh(bareinterval(2.0, 1000.0)) === bareinterval(0x544909c66010dp-50, 0x799d4ba2a13b5p-48)

end

@testset "mpfi_add" begin

    @test +(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === bareinterval(-Inf, +1.0)

    @test +(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(-Inf, +16.0)

    @test +(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(-Inf, -7.0)

    @test +(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(-7.0, +8.0)

    @test +(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test +(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test +(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(+8.0, +Inf)

    @test +(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(0.0, +8.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, +16.0)

    @test +(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test +(bareinterval(0.0, +Inf), bareinterval(-7.0, +8.0)) === bareinterval(-7.0, +Inf)

    @test +(bareinterval(-0.375, -0x10187p-256), bareinterval(-0.125, 0x1p-240)) === bareinterval(-0x1p-1, -0x187p-256)

    @test +(bareinterval(-0x1p-300, 0x123456p+28), bareinterval(-0x10000000000000p-93, 0x789abcdp0)) === bareinterval(-0x10000000000001p-93, 0x123456789abcdp0)

    @test +(bareinterval(-4.0, +7.0), bareinterval(-0x123456789abcdp-17, 3e300)) === bareinterval(-0x123456791abcdp-17, 0x8f596b3002c1bp+947)

    @test +(bareinterval(0x1000100010001p+8, 0x1p+60), bareinterval(0x1000100010001p0, 3.0e300)) === bareinterval(+0x1010101010101p+8, 0x8f596b3002c1bp+947)

    @test +(bareinterval(+4.0, +8.0), bareinterval(-4.0, -2.0)) === bareinterval(0.0, +6.0)

    @test +(bareinterval(+4.0, +8.0), bareinterval(-9.0, -8.0)) === bareinterval(-5.0, 0.0)

end

@testset "mpfi_add_d" begin

    @test +(bareinterval(-Inf, -7.0), bareinterval(-0x170ef54646d497p-107, -0x170ef54646d497p-107)) === bareinterval(-Inf, -7.0)

    @test +(bareinterval(-Inf, -7.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, -7.0)

    @test +(bareinterval(-Inf, -7.0), bareinterval(0x170ef54646d497p-107, 0x170ef54646d497p-107)) === bareinterval(-Inf, -0x1bffffffffffffp-50)

    @test +(bareinterval(-Inf, 0.0), bareinterval(-0x170ef54646d497p-106, -0x170ef54646d497p-106)) === bareinterval(-Inf, -8.0e-17)

    @test +(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, 0.0)

    @test +(bareinterval(-Inf, 0.0), bareinterval(0x170ef54646d497p-106, 0x170ef54646d497p-106)) === bareinterval(-Inf, 0x170ef54646d497p-106)

    @test +(bareinterval(-Inf, 8.0), bareinterval(-0x16345785d8a00000p0, -0x16345785d8a00000p0)) === bareinterval(-Inf, -0x16345785d89fff00p0)

    @test +(bareinterval(-Inf, 8.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, 8.0)

    @test +(bareinterval(-Inf, 8.0), bareinterval(0x16345785d8a00000p0, 0x16345785d8a00000p0)) === bareinterval(-Inf, 0x16345785d8a00100p0)

    @test +(entireinterval(BareInterval{Float64}), bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), bareinterval(0.0e-17, 0.0e-17)) === entireinterval(BareInterval{Float64})

    @test +(entireinterval(BareInterval{Float64}), bareinterval(+0x170ef54646d497p-105, +0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test +(bareinterval(0.0, 0.0), bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)) === bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)

    @test +(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test +(bareinterval(0.0, 0.0), bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)) === bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)

    @test +(bareinterval(0.0, 8.0), bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107)) === bareinterval(-0x114b37f4b51f71p-107, 8.0)

    @test +(bareinterval(0.0, 8.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 8.0)

    @test +(bareinterval(0.0, 8.0), bareinterval(0x114b37f4b51f7p-103, 0x114b37f4b51f7p-103)) === bareinterval(0x114b37f4b51f7p-103, 0x10000000000001p-49)

    @test +(bareinterval(0.0, +Inf), bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104)) === bareinterval(-0x50b45a75f7e81p-104, +Inf)

    @test +(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === bareinterval(0.0, +Inf)

    @test +(bareinterval(0.0, +Inf), bareinterval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106)) === bareinterval(0x142d169d7dfa03p-106, +Inf)

    @test +(bareinterval(-32.0, -17.0), bareinterval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47)) === bareinterval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)

    @test +(bareinterval(-0xfb53d14aa9c2fp-47, -17.0), bareinterval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47)) === bareinterval(0.0, 0x7353d14aa9c2fp-47)

    @test +(bareinterval(-32.0, -0xfb53d14aa9c2fp-48), bareinterval(0xfb53d14aa9c2fp-48, 0xfb53d14aa9c2fp-48)) === bareinterval(-0x104ac2eb5563d1p-48, 0.0)

    @test +(bareinterval(0x123456789abcdfp-48, 0x123456789abcdfp-4), bareinterval(3.5, 3.5)) === bareinterval(0x15b456789abcdfp-48, 0x123456789abd17p-4)

    @test +(bareinterval(0x123456789abcdfp-56, 0x123456789abcdfp-4), bareinterval(3.5, 3.5)) === bareinterval(0x3923456789abcdp-52, 0x123456789abd17p-4)

    @test +(bareinterval(-0xffp0, 0x123456789abcdfp-52), bareinterval(256.5, 256.5)) === bareinterval(0x18p-4, 0x101a3456789abdp-44)

    @test +(bareinterval(-0x1fffffffffffffp-52, -0x1p-550), bareinterval(4097.5, 4097.5)) === bareinterval(0xfff8p-4, 0x10018p-4)

    @test +(bareinterval(0x123456789abcdfp-48, 0x123456789abcdfp-4), bareinterval(-3.5, -3.5)) === bareinterval(0xeb456789abcdfp-48, 0x123456789abca7p-4)

    @test +(bareinterval(0x123456789abcdfp-56, 0x123456789abcdfp-4), bareinterval(-3.5, -3.5)) === bareinterval(-0x36dcba98765434p-52, 0x123456789abca7p-4)

    @test +(bareinterval(-0xffp0, 0x123456789abcdfp-52), bareinterval(-256.5, -256.5)) === bareinterval(-0x1ff8p-4, -0xff5cba9876543p-44)

    @test +(bareinterval(-0x1fffffffffffffp-52, -0x1p-550), bareinterval(-4097.5, -4097.5)) === bareinterval(-0x10038p-4, -0x10018p-4)

end

@testset "mpfi_asin" begin

    @test asin(bareinterval(-1.0, 0.0)) === bareinterval(-0x1921fb54442d19p-52, 0.0)

    @test asin(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test asin(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x1921fb54442d19p-52)

    @test asin(bareinterval(-1.0, -0.5)) === bareinterval(-0x1921fb54442d19p-52, -0x10c152382d7365p-53)

    @test asin(bareinterval(-0.75, -0.25)) === bareinterval(-0x1b235315c680ddp-53, -0x102be9ce0b87cdp-54)

    @test asin(bareinterval(-0.5, 0.5)) === bareinterval(-0x860a91c16b9b3p-52, 0x860a91c16b9b3p-52)

    @test asin(bareinterval(0.25, 0.625)) === bareinterval(0x102be9ce0b87cdp-54, 0x159aad71ced00fp-53)

    @test asin(bareinterval(-1.0, 1.0)) === bareinterval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)

end

@testset "mpfi_asinh" begin

    @test asinh(bareinterval(-Inf, -7.0)) === bareinterval(-Inf, -0x152728c91b5f1dp-51)

    @test asinh(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test asinh(bareinterval(-Inf, +8.0)) === bareinterval(-Inf, 0x58d8dc657eaf5p-49)

    @test asinh(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test asinh(bareinterval(-1.0, 0.0)) === bareinterval(-0x1c34366179d427p-53, 0.0)

    @test asinh(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test asinh(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x1c34366179d427p-53)

    @test asinh(bareinterval(0.0, +8.0)) === bareinterval(0.0, 0x58d8dc657eaf5p-49)

    @test asinh(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test asinh(bareinterval(-6.0, -4.0)) === bareinterval(-0x4fbca919fe219p-49, -0x10c1f8a6e80eebp-51)

    @test asinh(bareinterval(-2.0, -0.5)) === bareinterval(-0x2e32430627a11p-49, -0x1ecc2caec51609p-54)

    @test asinh(bareinterval(-1.0, -0.5)) === bareinterval(-0x1c34366179d427p-53, -0x1ecc2caec51609p-54)

    @test asinh(bareinterval(-0.75, -0.25)) === bareinterval(-0x162e42fefa39fp-49, -0xfd67d91ccf31bp-54)

    @test asinh(bareinterval(-0.5, 0.5)) === bareinterval(-0xf661657628b05p-53, 0xf661657628b05p-53)

    @test asinh(bareinterval(0.25, 0.625)) === bareinterval(0xfd67d91ccf31bp-54, 0x4b89d40b2fecdp-51)

    @test asinh(bareinterval(-1.0, 1.0)) === bareinterval(-0x1c34366179d427p-53, 0x1c34366179d427p-53)

    @test asinh(bareinterval(0.125, 17.0)) === bareinterval(0xff5685b4cb4b9p-55, 0xe1be0ba541ef7p-50)

    @test asinh(bareinterval(17.0, 42.0)) === bareinterval(0x1c37c174a83dedp-51, 0x8dca6976ad6bdp-49)

    @test asinh(bareinterval(-42.0, 17.0)) === bareinterval(-0x8dca6976ad6bdp-49, 0xe1be0ba541ef7p-50)

end

@testset "mpfi_atan" begin

    @test atan(bareinterval(-Inf, -7.0)) === bareinterval(-0x1921fb54442d19p-52, -0x5b7315eed597fp-50)

    @test atan(bareinterval(-Inf, 0.0)) === bareinterval(-0x1921fb54442d19p-52, 0.0)

    @test atan(bareinterval(-Inf, +8.0)) === bareinterval(-0x1921fb54442d19p-52, 0xb924fd54cb511p-51)

    @test atan(entireinterval(BareInterval{Float64})) === bareinterval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)

    @test atan(bareinterval(-1.0, 0.0)) === bareinterval(-0x1921fb54442d19p-53, 0.0)

    @test atan(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test atan(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x1921fb54442d19p-53)

    @test atan(bareinterval(0.0, +8.0)) === bareinterval(0.0, 0xb924fd54cb511p-51)

    @test atan(bareinterval(0.0, +Inf)) === bareinterval(0.0, 0x1921fb54442d19p-52)

    @test atan(bareinterval(-6.0, -4.0)) === bareinterval(-0x167d8863bc99bdp-52, -0x54da32547a73fp-50)

    @test atan(bareinterval(-2.0, -0.5)) === bareinterval(-0x11b6e192ebbe45p-52, -0x1dac670561bb4fp-54)

    @test atan(bareinterval(-1.0, -0.5)) === bareinterval(-0x1921fb54442d19p-53, -0x1dac670561bb4fp-54)

    @test atan(bareinterval(-0.75, -0.25)) === bareinterval(-0xa4bc7d1934f71p-52, -0x1f5b75f92c80ddp-55)

    @test atan(bareinterval(-0.5, 0.5)) === bareinterval(-0x1dac670561bb5p-50, 0x1dac670561bb5p-50)

    @test atan(bareinterval(0.25, 0.625)) === bareinterval(0x1f5b75f92c80ddp-55, 0x47802eaf7bfadp-51)

    @test atan(bareinterval(-1.0, 1.0)) === bareinterval(-0x1921fb54442d19p-53, 0x1921fb54442d19p-53)

    @test atan(bareinterval(0.125, 17.0)) === bareinterval(0x1fd5ba9aac2f6dp-56, 0x1831516233f561p-52)

    @test atan(bareinterval(17.0, 42.0)) === bareinterval(0xc18a8b119fabp-47, 0x18c079f3350d27p-52)

    @test atan(bareinterval(-42.0, 17.0)) === bareinterval(-0x18c079f3350d27p-52, 0x1831516233f561p-52)

end

@testset "mpfi_atan2" begin

    @test atan(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === bareinterval(-0x6d9cc4b34bd0dp-50, -0x1700a7c5784633p-53)

    @test atan(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(-0x1921fb54442d19p-52, 0.0)

    @test atan(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)

    @test atan(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === bareinterval(-0x1921fb54442d19p-52, 0x1921fb54442d19p-52)

    @test atan(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)

    @test atan(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(0x3243f6a8885a3p-49, 0x1921fb54442d19p-51)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0.0)

    @test atan(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0x1921fb54442d19p-52)

    @test atan(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(0.0, 0.0)

    @test atan(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0x1921fb54442d19p-51)

    @test atan(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === bareinterval(0.0, 0x1921fb54442d19p-51)

    @test atan(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test atan(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0x1921fb54442d19p-52)

    @test atan(bareinterval(-17.0, -5.0), bareinterval(-4002.0, -1.0)) === bareinterval(-0x191f6c4c09a81bp-51, -0x1a12a5465464cfp-52)

    @test atan(bareinterval(-17.0, -5.0), bareinterval(1.0, 4002.0)) === bareinterval(-0x1831516233f561p-52, -0xa3c20ea13f5e5p-61)

    @test atan(bareinterval(5.0, 17.0), bareinterval(1.0, 4002.0)) === bareinterval(0xa3c20ea13f5e5p-61, 0x1831516233f561p-52)

    @test atan(bareinterval(5.0, 17.0), bareinterval(-4002.0, -1.0)) === bareinterval(0x1a12a5465464cfp-52, 0x191f6c4c09a81bp-51)

    @test atan(bareinterval(-17.0, 5.0), bareinterval(-4002.0, 1.0)) === bareinterval(-0x1921fb54442d19p-51, 0x1921fb54442d19p-51)

end

@testset "mpfi_atanh" begin

    @test atanh(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, 0.0)

    @test atanh(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test atanh(bareinterval(0.0, +1.0)) === bareinterval(0.0, +Inf)

    @test atanh(bareinterval(-1.0, -0.5)) === bareinterval(-Inf, -0x8c9f53d568185p-52)

    @test atanh(bareinterval(-0.75, -0.25)) === bareinterval(-0x3e44e55c64b4bp-50, -0x1058aefa811451p-54)

    @test atanh(bareinterval(-0.5, 0.5)) === bareinterval(-0x1193ea7aad030bp-53, 0x1193ea7aad030bp-53)

    @test atanh(bareinterval(0.25, 0.625)) === bareinterval(0x1058aefa811451p-54, 0x2eec3bb76c2b3p-50)

    @test atanh(bareinterval(-1.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test atanh(bareinterval(0.125, 1.0)) === bareinterval(0x1015891c9eaef7p-55, +Inf)

end

@testset "mpfi_bounded_p" begin

    @test iscommon(bareinterval(-Inf, -8.0)) === false

    @test iscommon(bareinterval(-Inf, 0.0)) === false

    @test iscommon(bareinterval(-Inf, 5.0)) === false

    @test iscommon(entireinterval(BareInterval{Float64})) === false

    @test iscommon(bareinterval(-8.0, 0.0)) === true

    @test iscommon(bareinterval(0.0, 0.0)) === true

    @test iscommon(bareinterval(0.0, 5.0)) === true

    @test iscommon(bareinterval(0.0, +Inf)) === false

    @test iscommon(bareinterval(5.0, +Inf)) === false

    @test iscommon(bareinterval(-34.0, -17.0)) === true

    @test iscommon(bareinterval(-8.0, -1.0)) === true

    @test iscommon(bareinterval(-34.0, 17.0)) === true

    @test iscommon(bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === true

    @test iscommon(bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === true

    @test iscommon(bareinterval(+8.0, +0x7fffffffffffbp+51)) === true

    @test iscommon(bareinterval(+0x1fffffffffffffp-53, 2.0)) === true

end

@testset "mpfi_cbrt" begin

    @test cbrt(bareinterval(-Inf, -125.0)) === bareinterval(-Inf, -5.0)

    @test cbrt(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test cbrt(bareinterval(-Inf, +64.0)) === bareinterval(-Inf, +4.0)

    @test cbrt(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cbrt(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test cbrt(bareinterval(0.0, +27.0)) === bareinterval(0.0, +3.0)

    @test cbrt(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test cbrt(bareinterval(0x40p0, 0x7dp0)) === bareinterval(4.0, 5.0)

    @test cbrt(bareinterval(-0x1856e4be527197p-354, 0xd8p0)) === bareinterval(-0x2e5e58c0083b7bp-154, 6.0)

    @test cbrt(bareinterval(0x141a9019a2184dp-1047, 0xc29c78c66ac0fp-678)) === bareinterval(0x2b8172e535d44dp-385, 0x24cbd1c55aaa1p-258)

end

@testset "mpfi_cos" begin

    @test cos(bareinterval(-Inf, -7.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-Inf, 0.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-Inf, +8.0)) === bareinterval(-1.0, 1.0)

    @test cos(entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-1.0, 0.0)) === bareinterval(0x114a280fb5068bp-53, 1.0)

    @test cos(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test cos(bareinterval(0.0, +1.0)) === bareinterval(0x114a280fb5068bp-53, 1.0)

    @test cos(bareinterval(0.0, +8.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(0.0, +Inf)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-2.0, -0.5)) === bareinterval(-0x1aa22657537205p-54, 0x1c1528065b7d5p-49)

    @test cos(bareinterval(-1.0, -0.25)) === bareinterval(0x114a280fb5068bp-53, 0xf80aa4fbef751p-52)

    @test cos(bareinterval(-0.5, 0.5)) === bareinterval(0x1c1528065b7d4fp-53, 1.0)

    @test cos(bareinterval(-4.5, 0.625)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(1.0, 0x3243f6a8885a3p-48)) === bareinterval(-1.0, 0x4528a03ed41a3p-51)

    @test cos(bareinterval(0.125, 17.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(17.0, 42.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, -1.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, -2.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, -3.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-7.0, -4.0)) === bareinterval(-0x14eaa606db24c1p-53, 1.0)

    @test cos(bareinterval(-7.0, -5.0)) === bareinterval(0x122785706b4ad9p-54, 1.0)

    @test cos(bareinterval(-7.0, -6.0)) === bareinterval(0x181ff79ed92017p-53, 1.0)

    @test cos(bareinterval(-7.0, -7.0)) === bareinterval(0x181ff79ed92017p-53, 0x181ff79ed92018p-53)

    @test cos(bareinterval(-6.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-6.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-6.0, -1.0)) === bareinterval(-1.0, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-6.0, -2.0)) === bareinterval(-1.0, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-6.0, -3.0)) === bareinterval(-1.0, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-6.0, -4.0)) === bareinterval(-0x14eaa606db24c1p-53, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-6.0, -5.0)) === bareinterval(0x122785706b4ad9p-54, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-6.0, -6.0)) === bareinterval(0x1eb9b7097822f5p-53, 0x1eb9b7097822f6p-53)

    @test cos(bareinterval(-5.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-5.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-5.0, -1.0)) === bareinterval(-1.0, 0x114a280fb5068cp-53)

    @test cos(bareinterval(-5.0, -2.0)) === bareinterval(-1.0, 0x122785706b4adap-54)

    @test cos(bareinterval(-5.0, -3.0)) === bareinterval(-1.0, 0x122785706b4adap-54)

    @test cos(bareinterval(-5.0, -4.0)) === bareinterval(-0x14eaa606db24c1p-53, 0x122785706b4adap-54)

    @test cos(bareinterval(-5.0, -5.0)) === bareinterval(0x122785706b4ad9p-54, 0x122785706b4adap-54)

    @test cos(bareinterval(-4.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-4.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test cos(bareinterval(-4.0, -1.0)) === bareinterval(-1.0, 0x114a280fb5068cp-53)

    @test cos(bareinterval(-4.0, -2.0)) === bareinterval(-1.0, -0x1aa22657537204p-54)

    @test cos(bareinterval(-4.0, -3.0)) === bareinterval(-1.0, -0x14eaa606db24c0p-53)

    @test cos(bareinterval(-4.0, -4.0)) === bareinterval(-0x14eaa606db24c1p-53, -0x14eaa606db24c0p-53)

end

@testset "mpfi_cosh" begin

    @test cosh(bareinterval(-Inf, -7.0)) === bareinterval(0x11228949ba3a8bp-43, +Inf)

    @test cosh(bareinterval(-Inf, 0.0)) === bareinterval(1.0, +Inf)

    @test cosh(bareinterval(-Inf, +8.0)) === bareinterval(1.0, +Inf)

    @test cosh(entireinterval(BareInterval{Float64})) === bareinterval(1.0, +Inf)

    @test cosh(bareinterval(-1.0, 0.0)) === bareinterval(1.0, 0x18b07551d9f551p-52)

    @test cosh(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test cosh(bareinterval(0.0, +1.0)) === bareinterval(1.0, 0x18b07551d9f551p-52)

    @test cosh(bareinterval(0.0, +8.0)) === bareinterval(1.0, 0x1749eaa93f4e77p-42)

    @test cosh(bareinterval(0.0, +Inf)) === bareinterval(1.0, +Inf)

    @test cosh(bareinterval(-0.125, 0.0)) === bareinterval(1.0, 0x10200aac16db6fp-52)

    @test cosh(bareinterval(0.0, 0x10000000000001p-53)) === bareinterval(1.0, 0x120ac1862ae8d1p-52)

    @test cosh(bareinterval(-4.5, -0.625)) === bareinterval(0x99d310a496b6dp-51, 0x1681ceb0641359p-47)

    @test cosh(bareinterval(1.0, 3.0)) === bareinterval(0x18b07551d9f55p-48, 0x1422a497d6185fp-49)

    @test cosh(bareinterval(17.0, 0xb145bb71d3dbp-38)) === bareinterval(0x1709348c0ea503p-29, 0x3ffffffffffa34p+968)

end

@testset "mpfi_cot" begin

    @test cot(bareinterval(-Inf, -7.0)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(-Inf, +8.0)) === entireinterval(BareInterval{Float64})

    @test cot(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(-8.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(-3.0, 0.0)) === bareinterval(-Inf, 0xe07cf2eb32f0bp-49)

    @test cot(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, -0x148c05d04e1cfdp-53)

    @test cot(bareinterval(0.0, +1.0)) === bareinterval(0x148c05d04e1cfdp-53, +Inf)

    @test cot(bareinterval(0.0, +3.0)) === bareinterval(-0xe07cf2eb32f0bp-49, +Inf)

    @test cot(bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(-3.0, -2.0)) === bareinterval(0x1d4a42e92faa4dp-54, 0xe07cf2eb32f0bp-49)

    @test cot(bareinterval(-3.0, -0x1921fb54442d19p-52)) === bareinterval(0x5cb3b399d747fp-103, 0xe07cf2eb32f0bp-49)

    @test cot(bareinterval(-2.0, 0x1921fb54442d19p-52)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(0.125, 0.5)) === bareinterval(0xea4d6bf23e051p-51, 0x1fd549f047f2bbp-50)

    @test cot(bareinterval(0.125, 0x1921fb54442d19p-52)) === bareinterval(-0x172cece675d1fdp-105, 0x1fd549f047f2bbp-50)

    @test cot(bareinterval(0x1921fb54442d19p-52, 4.0)) === entireinterval(BareInterval{Float64})

    @test cot(bareinterval(4.0, 0x3243f6a8885a3p-47)) === bareinterval(-0x1d02967c31cdb5p-1, 0x1ba35ba1c6b75dp-53)

    @test cot(bareinterval(0x13a28c59d5433bp-44, 0x9d9462ceaa19dp-43)) === bareinterval(0x148c05d04e1fb7p-53, 0x1cefdde7c84c27p-4)

end

@testset "mpfi_coth" begin

    @test coth(bareinterval(-Inf, -7.0)) === bareinterval(-0x100001be6c882fp-52, -1.0)

    @test coth(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, -1.0)

    @test coth(bareinterval(-Inf, +8.0)) === entireinterval(BareInterval{Float64})

    @test coth(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test coth(bareinterval(-8.0, 0.0)) === bareinterval(-Inf, -0x1000003c6ab7e7p-52)

    @test coth(bareinterval(-3.0, 0.0)) === bareinterval(-Inf, -0x10145b3cc9964bp-52)

    @test coth(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, -0x150231499b6b1dp-52)

    @test coth(bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test coth(bareinterval(0.0, +1.0)) === bareinterval(0x150231499b6b1dp-52, +Inf)

    @test coth(bareinterval(0.0, +3.0)) === bareinterval(0x10145b3cc9964bp-52, +Inf)

    @test coth(bareinterval(0.0, +8.0)) === bareinterval(0x1000003c6ab7e7p-52, +Inf)

    @test coth(bareinterval(0.0, +Inf)) === bareinterval(1.0, +Inf)

    @test coth(bareinterval(-3.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test coth(bareinterval(-10.0, -8.0)) === bareinterval(-0x1000003c6ab7e8p-52, -0x100000011b4865p-52)

    @test coth(bareinterval(7.0, 17.0)) === bareinterval(0x1000000000000fp-52, 0x100001be6c882fp-52)

    @test coth(bareinterval(0x10000000000001p-58, 0x10000000000001p-53)) === bareinterval(0x114fc6ceb099bdp-51, 0x10005554fa502fp-46)

end

@testset "mpfi_csc" begin

    @test csc(bareinterval(-Inf, -7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-Inf, 8.0)) === entireinterval(BareInterval{Float64})

    @test csc(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-8.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 0.0)) === bareinterval(-Inf, -1.0)

    @test csc(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, -0x1303aa9620b223p-52)

    @test csc(bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test csc(bareinterval(0.0, +1.0)) === bareinterval(0x1303aa9620b223p-52, +Inf)

    @test csc(bareinterval(0.0, 3.0)) === bareinterval(1.0, +Inf)

    @test csc(bareinterval(0.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-6.0, -4.0)) === bareinterval(1.0, 0x1ca19615f903dap-51)

    @test csc(bareinterval(-6.0, -5.0)) === bareinterval(0x10af73f9df86b7p-52, 0x1ca19615f903dap-51)

    @test csc(bareinterval(-6.0, -6.0)) === bareinterval(0x1ca19615f903d9p-51, 0x1ca19615f903dap-51)

    @test csc(bareinterval(-5.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-5.0, -4.0)) === bareinterval(1.0, 0x15243e8b2f4642p-52)

    @test csc(bareinterval(-5.0, -5.0)) === bareinterval(0x10af73f9df86b7p-52, 0x10af73f9df86b8p-52)

    @test csc(bareinterval(-4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-4.0, -4.0)) === bareinterval(0x15243e8b2f4641p-52, 0x15243e8b2f4642p-52)

    @test csc(bareinterval(-3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-3.0, 0.0)) === bareinterval(-Inf, -1.0)

    @test csc(bareinterval(-3.0, -1.0)) === bareinterval(-0x1c583c440ab0dap-50, -1.0)

    @test csc(bareinterval(-3.0, -2.0)) === bareinterval(-0x1c583c440ab0dap-50, -0x119893a272f912p-52)

    @test csc(bareinterval(-3.0, -3.0)) === bareinterval(-0x1c583c440ab0dap-50, -0x1c583c440ab0d9p-50)

    @test csc(bareinterval(-2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-2.0, 0.0)) === bareinterval(-Inf, -1.0)

    @test csc(bareinterval(-2.0, -1.0)) === bareinterval(-0x1303aa9620b224p-52, -1.0)

    @test csc(bareinterval(-2.0, -2.0)) === bareinterval(-0x119893a272f913p-52, -0x119893a272f912p-52)

    @test csc(bareinterval(-1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, -0x1303aa9620b223p-52)

    @test csc(bareinterval(-1.0, -1.0)) === bareinterval(-0x1303aa9620b224p-52, -0x1303aa9620b223p-52)

    @test csc(bareinterval(1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(1.0, 3.0)) === bareinterval(1.0, 0x1c583c440ab0dap-50)

    @test csc(bareinterval(1.0, 2.0)) === bareinterval(1.0, 0x1303aa9620b224p-52)

    @test csc(bareinterval(1.0, 1.0)) === bareinterval(0x1303aa9620b223p-52, 0x1303aa9620b224p-52)

    @test csc(bareinterval(2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(2.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(2.0, 3.0)) === bareinterval(0x119893a272f912p-52, 0x1c583c440ab0dap-50)

    @test csc(bareinterval(2.0, 2.0)) === bareinterval(0x119893a272f912p-52, 0x119893a272f913p-52)

    @test csc(bareinterval(3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(3.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(3.0, 3.0)) === bareinterval(0x1c583c440ab0d9p-50, 0x1c583c440ab0dap-50)

    @test csc(bareinterval(4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(4.0, 6.0)) === bareinterval(-0x1ca19615f903dap-51, -1.0)

    @test csc(bareinterval(4.0, 5.0)) === bareinterval(-0x15243e8b2f4642p-52, -1.0)

    @test csc(bareinterval(4.0, 4.0)) === bareinterval(-0x15243e8b2f4642p-52, -0x15243e8b2f4641p-52)

    @test csc(bareinterval(5.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(5.0, 6.0)) === bareinterval(-0x1ca19615f903dap-51, -0x10af73f9df86b7p-52)

    @test csc(bareinterval(5.0, 5.0)) === bareinterval(-0x10af73f9df86b8p-52, -0x10af73f9df86b7p-52)

    @test csc(bareinterval(6.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test csc(bareinterval(6.0, 6.0)) === bareinterval(-0x1ca19615f903dap-51, -0x1ca19615f903d9p-51)

    @test csc(bareinterval(7.0, 7.0)) === bareinterval(+0x185a86a4ceb06cp-52, +0x185a86a4ceb06dp-52)

end

@testset "mpfi_csch" begin

    @test csch(bareinterval(-Inf, -7.0)) === bareinterval(-0x1de16d3cffcd54p-62, 0.0)

    @test csch(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test csch(bareinterval(-Inf, +8.0)) === entireinterval(BareInterval{Float64})

    @test csch(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test csch(bareinterval(-8.0, 0.0)) === bareinterval(-Inf, -0x15fc212d92371ap-63)

    @test csch(bareinterval(-3.0, 0.0)) === bareinterval(-Inf, -0x198de80929b901p-56)

    @test csch(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, -0x1b3ab8a78b90c0p-53)

    @test csch(bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test csch(bareinterval(0.0, +1.0)) === bareinterval(0x1b3ab8a78b90c0p-53, +Inf)

    @test csch(bareinterval(0.0, +3.0)) === bareinterval(0x198de80929b901p-56, +Inf)

    @test csch(bareinterval(0.0, +8.0)) === bareinterval(0x15fc212d92371ap-63, +Inf)

    @test csch(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test csch(bareinterval(-3.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test csch(bareinterval(-10.0, -8.0)) === bareinterval(-0x15fc212d92371bp-63, -0x17cd79b63733a0p-66)

    @test csch(bareinterval(7.0, 17.0)) === bareinterval(0x1639e3175a68a7p-76, 0x1de16d3cffcd54p-62)

    @test csch(bareinterval(0x10000000000001p-58, 0x10000000000001p-53)) === bareinterval(0x1eb45dc88defeap-52, 0x3fff555693e722p-48)

end

@testset "mpfi_d_div" begin

    @test /(bareinterval(-0x170ef54646d496p-107, -0x170ef54646d496p-107), bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0x1a5a3ce29a1787p-110)

    @test /(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0x170ef54646d496p-107, 0x170ef54646d496p-107), bareinterval(-Inf, -7.0)) === bareinterval(-0x1a5a3ce29a1787p-110, 0.0)

    @test /(bareinterval(-0x170ef54646d497p-106, -0x170ef54646d497p-106), bareinterval(-Inf, 0.0)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0x170ef54646d497p-106, 0x170ef54646d497p-106), bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(-0x16345785d8a00000p0, -0x16345785d8a00000p0), bareinterval(-Inf, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, 0.0), bareinterval(-Inf, 8.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0x16345785d8a00000p0, 0x16345785d8a00000p0), bareinterval(-Inf, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0e-17, 0.0e-17), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test /(bareinterval(+0x170ef54646d497p-105, +0x170ef54646d497p-105), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107), bareinterval(0.0, 7.0)) === bareinterval(-Inf, -0x13c3ada9f391a5p-110)

    @test /(bareinterval(0.0, 0.0), bareinterval(0.0, 7.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107), bareinterval(0.0, 7.0)) === bareinterval(0x13c3ada9f391a5p-110, +Inf)

    @test /(bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104), bareinterval(0.0, +Inf)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(0.0, 0.0), bareinterval(0.0, +Inf)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106), bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(-2.5, -2.5), bareinterval(-8.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-2.5, -2.5), bareinterval(-8.0, -5.0)) === bareinterval(0x5p-4, 0.5)

    @test /(bareinterval(-2.5, -2.5), bareinterval(25.0, 40.0)) === bareinterval(-0x1999999999999ap-56, -0x1p-4)

    @test /(bareinterval(-2.5, -2.5), bareinterval(-16.0, -7.0)) === bareinterval(0x5p-5, 0x16db6db6db6db7p-54)

    @test /(bareinterval(-2.5, -2.5), bareinterval(11.0, 143.0)) === bareinterval(-0x1d1745d1745d18p-55, -0x11e6efe35b4cfap-58)

    @test /(bareinterval(33.125, 33.125), bareinterval(8.28125, 530.0)) === bareinterval(0x1p-4, 4.0)

    @test /(bareinterval(33.125, 33.125), bareinterval(-530.0, -496.875)) === bareinterval(-0x11111111111112p-56, -0x1p-4)

    @test /(bareinterval(33.125, 33.125), bareinterval(54.0, 265.0)) === bareinterval(0.125, 0x13a12f684bda13p-53)

    @test /(bareinterval(33.125, 33.125), bareinterval(52.0, 54.0)) === bareinterval(0x13a12f684bda12p-53, 0x14627627627628p-53)

end

@testset "mpfi_diam_abs" begin

    @test diam(bareinterval(-Inf, -8.0)) === +Inf

    @test diam(bareinterval(-Inf, 0.0)) === +Inf

    @test diam(bareinterval(-Inf, 5.0)) === +Inf

    @test diam(entireinterval(BareInterval{Float64})) === +Inf

    @test diam(bareinterval(-Inf, 0.0)) === +Inf

    @test diam(bareinterval(-8.0, 0.0)) === +8.0

    @test diam(bareinterval(0.0, 0.0)) === 0.0

    @test diam(bareinterval(0.0, 5.0)) === +5.0

    @test diam(bareinterval(0.0, +Inf)) === +Inf

    @test diam(bareinterval(-34.0, -17.0)) === 17.0

end

@testset "mpfi_div" begin

    @test /(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(-0x75bcd15p0, -0x754ep0), bareinterval(-0x11ep0, -0x9p0)) === bareinterval(0x69p0, 0xd14fadp0)

    @test /(bareinterval(-0x75bcd15p0, -0x1.489c07caba163p-4), bareinterval(-0x2.e8e36e560704ap+4, -0x9p0)) === bareinterval(0x7.0ef61537b1704p-12, 0xd14fadp0)

    @test /(bareinterval(-0x1.02f0415f9f596p+0, -0x754ep-16), bareinterval(-0x11ep0, -0x7.62ce64fbacd2cp-8)) === bareinterval(0x69p-16, 0x2.30ee5eef9c36cp+4)

    @test /(bareinterval(-0x1.02f0415f9f596p+0, -0x1.489c07caba163p-4), bareinterval(-0x2.e8e36e560704ap+0, -0x7.62ce64fbacd2cp-8)) === bareinterval(0x7.0ef61537b1704p-8, 0x2.30ee5eef9c36cp+4)

    @test /(bareinterval(-0xacbp+256, -0x6f9p0), bareinterval(-0x7p0, 0.0)) === bareinterval(0xffp0, +Inf)

    @test /(bareinterval(-0x100p0, -0xe.bb80d0a0824ep-4), bareinterval(-0x1.7c6d760a831fap+0, 0.0)) === bareinterval(0x9.e9f24790445fp-4, +Inf)

    @test /(bareinterval(-0x1.25f2d73472753p+0, -0x9.9a19fd3c1fc18p-4), bareinterval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-100.0, -15.0), bareinterval(0.0, +3.0)) === bareinterval(-Inf, -5.0)

    @test /(bareinterval(-2.0, -0x1.25f2d73472753p+0), bareinterval(0.0, +0x9.3b0c8074ccc18p-4)) === bareinterval(-Inf, -0x1.fd8457415f917p+0)

    @test /(bareinterval(-0x123456789p0, -0x754ep+4), bareinterval(0x40bp0, 0x11ep+4)) === bareinterval(-0x480b3bp0, -0x69p0)

    @test /(bareinterval(-0xd.67775e4b8588p-4, -0x754ep-53), bareinterval(0x4.887091874ffc8p+0, 0x11ep+201)) === bareinterval(-0x2.f5008d2df94ccp-4, -0x69p-254)

    @test /(bareinterval(-0x123456789p0, -0x1.b0a62934c76e9p+0), bareinterval(0x40bp-17, 0x2.761ec797697a4p-4)) === bareinterval(-0x480b3bp+17, -0xa.fc5e7338f3e4p+0)

    @test /(bareinterval(-0xd.67775e4b8588p+0, -0x1.b0a62934c76e9p+0), bareinterval(0x4.887091874ffc8p-4, 0x2.761ec797697a4p+4)) === bareinterval(-0x2.f5008d2df94ccp+4, -0xa.fc5e7338f3e4p-8)

    @test /(bareinterval(-0x75bcd15p0, 0.0), bareinterval(-0x90p0, -0x9p0)) === bareinterval(0.0, 0xd14fadp0)

    @test /(bareinterval(-0x1.4298b2138f2a7p-4, 0.0), bareinterval(-0x1p-8, -0xf.5e4900c9c19fp-12)) === bareinterval(0.0, 0x1.4fdb41a33d6cep+4)

    @test /(bareinterval(-0xeeeeeeeeep0, 0.0), bareinterval(-0xaaaaaaaaap0, 0.0)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(-0x1.25f2d73472753p+0, 0.0), bareinterval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0xeeeeeeeeep0, 0.0), bareinterval(0.0, +0x3p0)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(-0x75bcd15p0, 0.0), bareinterval(0x9p0, 0x90p0)) === bareinterval(-0xd14fadp0, 0.0)

    @test /(bareinterval(-0x1.4298b2138f2a7p-4, 0.0), bareinterval(0xf.5e4900c9c19fp-12, 0x9p0)) === bareinterval(-0x1.4fdb41a33d6cep+4, 0.0)

    @test /(bareinterval(-0x75bcd15p0, 0xa680p0), bareinterval(-0xaf6p0, -0x9p0)) === bareinterval(-0x1280p0, 0xd14fadp0)

    @test /(bareinterval(-0x12p0, 0x10p0), bareinterval(-0xbbbbbbbbbbp0, -0x9p0)) === bareinterval(-0x1.c71c71c71c71dp0, 2.0)

    @test /(bareinterval(-0x1p0, 0x754ep-16), bareinterval(-0xccccccccccp0, -0x11ep0)) === bareinterval(-0x69p-16, 0xe.525982af70c9p-12)

    @test /(bareinterval(-0xb.5b90b4d32136p-4, 0x6.e694ac6767394p+0), bareinterval(-0xdddddddddddp0, -0xc.f459be9e80108p-4)) === bareinterval(-0x8.85e40b3c3f63p+0, 0xe.071cbfa1de788p-4)

    @test /(bareinterval(-0xacbp+256, 0x6f9p0), bareinterval(-0x7p0, 0.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0x1.25f2d73472753p+0, +0x9.9a19fd3c1fc18p-4), bareinterval(-0x9.3b0c8074ccc18p-4, +0x4.788df5d72af78p-4)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, +15.0), bareinterval(-3.0, +3.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(-0x754ep0, 0xd0e9dc4p+12), bareinterval(0x11ep0, 0xbbbp0)) === bareinterval(-0x69p0, 0xbaffep+12)

    @test /(bareinterval(-0x10p0, 0xd0e9dc4p+12), bareinterval(0x11ep0, 0xbbbp0)) === bareinterval(-0xe.525982af70c9p-8, 0xbaffep+12)

    @test /(bareinterval(-0x754ep0, 0x1p+10), bareinterval(0x11ep0, 0xbbbp0)) === bareinterval(-0x69p0, 0xe.525982af70c9p-2)

    @test /(bareinterval(-0x1.18333622af827p+0, 0x2.14b836907297p+0), bareinterval(0x1.263147d1f4bcbp+0, 0x111p0)) === bareinterval(-0xf.3d2f5db8ec728p-4, 0x1.cf8fa732de129p+0)

    @test /(bareinterval(0.0, 0x75bcd15p0), bareinterval(-0xap0, -0x9p0)) === bareinterval(-0xd14fadp0, 0.0)

    @test /(bareinterval(0.0, 0x1.acbf1702af6edp+0), bareinterval(-0x0.fp0, -0xe.3d7a59e2bdacp-4)) === bareinterval(-0x1.e1bb896bfda07p+0, 0.0)

    @test /(bareinterval(0.0, 0xap0), bareinterval(-0x9p0, 0.0)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(0.0, 0xap0), bareinterval(-1.0, +1.0)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, 0x75bcd15p0), bareinterval(+0x9p0, +0xap0)) === bareinterval(0.0, 0xd14fadp0)

    @test /(bareinterval(0.0, 0x1.5f6b03dc8c66fp+0), bareinterval(+0x2.39ad24e812dcep+0, 0xap0)) === bareinterval(0.0, 0x9.deb65b02baep-4)

    @test /(bareinterval(0x754ep0, 0x75bcd15p0), bareinterval(-0x11ep0, -0x9p0)) === bareinterval(-0xd14fadp0, -0x69p0)

    @test /(bareinterval(0x754ep-16, 0x1.008a3accc766dp+4), bareinterval(-0x11ep0, -0x2.497403b31d32ap+0)) === bareinterval(-0x7.02d3edfbc8b6p+0, -0x69p-16)

    @test /(bareinterval(0x9.ac412ff1f1478p-4, 0x75bcd15p0), bareinterval(-0x1.5232c83a0e726p+4, -0x9p0)) === bareinterval(-0xd14fadp0, -0x7.52680a49e5d68p-8)

    @test /(bareinterval(0xe.1552a314d629p-4, 0x1.064c5adfd0042p+0), bareinterval(-0x5.0d4d319a50b04p-4, -0x2.d8f51df1e322ep-4)) === bareinterval(-0x5.c1d97d57d81ccp+0, -0x2.c9a600c455f5ap+0)

    @test /(bareinterval(0x754ep0, 0xeeeep0), bareinterval(-0x11ep0, 0.0)) === bareinterval(-Inf, -0x69p0)

    @test /(bareinterval(0x1.a9016514490e6p-4, 0xeeeep0), bareinterval(-0xe.316e87be0b24p-4, 0.0)) === bareinterval(-Inf, -0x1.df1cc82e6a583p-4)

    @test /(bareinterval(5.0, 6.0), bareinterval(-0x5.0d4d319a50b04p-4, 0x2.d8f51df1e322ep-4)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0x754ep0, +0xeeeeep0), bareinterval(0.0, +0x11ep0)) === bareinterval(0x69p0, +Inf)

    @test /(bareinterval(0x1.7f03f2a978865p+0, 0xeeeeep0), bareinterval(0.0, 0x1.48b08624606b9p+0)) === bareinterval(0x1.2a4fcda56843p+0, +Inf)

    @test /(bareinterval(0x5efc1492p0, 0x1ba2dc763p0), bareinterval(0x2fdd1fp0, 0x889b71p0)) === bareinterval(0xb2p0, 0x93dp0)

    @test /(bareinterval(0x1.d7c06f9ff0706p-8, 0x1ba2dc763p0), bareinterval(0x2fdd1fp-20, 0xe.3d7a59e2bdacp+0)) === bareinterval(0x2.120d75be74b54p-12, 0x93dp+20)

    @test /(bareinterval(0x5.efc1492p-4, 0x1.008a3accc766dp+0), bareinterval(0x2.497403b31d32ap+0, 0x8.89b71p+0)) === bareinterval(0xb.2p-8, 0x7.02d3edfbc8b6p-4)

    @test /(bareinterval(0x8.440e7d65be6bp-8, 0x3.99982e9eae09ep+0), bareinterval(0x8.29fa8d0659e48p-4, 0xc.13d2fd762e4a8p-4)) === bareinterval(0xa.f3518768b206p-8, 0x7.0e2acad54859cp+0)

end

@testset "mpfi_div_d" begin

    @test /(bareinterval(-Inf, -7.0), bareinterval(-7.0, -7.0)) === bareinterval(1.0, +Inf)

    @test /(bareinterval(-Inf, -7.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf, -7.0), bareinterval(7.0, 7.0)) === bareinterval(-Inf, -1.0)

    @test /(bareinterval(-Inf, 0.0), bareinterval(-0x170ef54646d497p-106, -0x170ef54646d497p-106)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(-Inf, 0.0), bareinterval(0x170ef54646d497p-106, 0x170ef54646d497p-106)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(-Inf, 8.0), bareinterval(-3.0, -3.0)) === bareinterval(-0x15555555555556p-51, +Inf)

    @test /(bareinterval(-Inf, 8.0), bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test /(bareinterval(-Inf, 8.0), bareinterval(3.0, 3.0)) === bareinterval(-Inf, 0x15555555555556p-51)

    @test /(entireinterval(BareInterval{Float64}), bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(0.0e-17, 0.0e-17)) === emptyinterval(BareInterval{Float64})

    @test /(entireinterval(BareInterval{Float64}), bareinterval(+0x170ef54646d497p-105, +0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test /(bareinterval(0.0, 0.0), bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, 0.0), bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)) === bareinterval(0.0, 0.0)

    @test /(bareinterval(0.0, 8.0), bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107)) === bareinterval(-0x1d9b1f5d20d556p+5, 0.0)

    @test /(bareinterval(0.0, 8.0), bareinterval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107)) === bareinterval(0.0, 0x1d9b1f5d20d556p+5)

    @test /(bareinterval(0.0, +Inf), bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104)) === bareinterval(-Inf, 0.0)

    @test /(bareinterval(0.0, +Inf), bareinterval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106)) === bareinterval(0.0, +Inf)

    @test /(bareinterval(-0x10000000000001p-20, -0x10000000000001p-53), bareinterval(-1.0, -1.0)) === bareinterval(0x10000000000001p-53, 0x10000000000001p-20)

    @test /(bareinterval(-0x10000000000002p-20, -0x10000000000001p-53), bareinterval(0x10000000000001p-53, 0x10000000000001p-53)) === bareinterval(-0x10000000000001p-19, -1.0)

    @test /(bareinterval(-0x10000000000001p-20, -0x10000020000001p-53), bareinterval(0x10000000000001p-53, 0x10000000000001p-53)) === bareinterval(-0x1p+33, -0x1000001fffffffp-52)

    @test /(bareinterval(-0x10000000000002p-20, -0x10000020000001p-53), bareinterval(0x10000000000001p-53, 0x10000000000001p-53)) === bareinterval(-0x10000000000001p-19, -0x1000001fffffffp-52)

    @test /(bareinterval(-0x123456789abcdfp-53, 0x123456789abcdfp-7), bareinterval(-0x123456789abcdfp0, -0x123456789abcdfp0)) === bareinterval(-0x1p-7, 0x1p-53)

    @test /(bareinterval(-0x123456789abcdfp-53, 0x10000000000001p-53), bareinterval(-0x123456789abcdfp0, -0x123456789abcdfp0)) === bareinterval(-0x1c200000000002p-106, 0x1p-53)

    @test /(bareinterval(-1.0, 0x123456789abcdfp-7), bareinterval(-0x123456789abcdfp0, -0x123456789abcdfp0)) === bareinterval(-0x1p-7, 0x1c200000000001p-105)

    @test /(bareinterval(-1.0, 0x10000000000001p-53), bareinterval(-0x123456789abcdfp0, -0x123456789abcdfp0)) === bareinterval(-0x1c200000000002p-106, 0x1c200000000001p-105)

end

@testset "mpfi_d_sub" begin

    @test -(bareinterval(-0x170ef54646d497p-107, -0x170ef54646d497p-107), bareinterval(-Inf, -7.0)) === bareinterval(0x1bffffffffffffp-50, +Inf)

    @test -(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(7.0, +Inf)

    @test -(bareinterval(0x170ef54646d497p-107, 0x170ef54646d497p-107), bareinterval(-Inf, -7.0)) === bareinterval(7.0, +Inf)

    @test -(bareinterval(-0x170ef54646d497p-96, -0x170ef54646d497p-96), bareinterval(-Inf, 0.0)) === bareinterval(-0x170ef54646d497p-96, +Inf)

    @test -(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === bareinterval(0.0, +Inf)

    @test -(bareinterval(0x170ef54646d497p-96, 0x170ef54646d497p-96), bareinterval(-Inf, 0.0)) === bareinterval(0x170ef54646d497p-96, +Inf)

    @test -(bareinterval(-0x16345785d8a00000p0, -0x16345785d8a00000p0), bareinterval(-Inf, 8.0)) === bareinterval(-0x16345785d8a00100p0, +Inf)

    @test -(bareinterval(0.0, 0.0), bareinterval(-Inf, 8.0)) === bareinterval(-8.0, +Inf)

    @test -(bareinterval(0x16345785d8a00000p0, 0x16345785d8a00000p0), bareinterval(-Inf, 8.0)) === bareinterval(0x16345785d89fff00p0, +Inf)

    @test -(bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0.0e-17, 0.0e-17), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0x170ef54646d497p-105, 0x170ef54646d497p-105), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109), bareinterval(0.0, 0.0)) === bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test -(bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109), bareinterval(0.0, 0.0)) === bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)

    @test -(bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107), bareinterval(0.0, 8.0)) === bareinterval(-0x10000000000001p-49, -0x114b37f4b51f71p-107)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, 8.0)) === bareinterval(-8.0, 0.0)

    @test -(bareinterval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107), bareinterval(0.0, 8.0)) === bareinterval(-8.0, 0x114b37f4b51f71p-107)

    @test -(bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104), bareinterval(0.0, +Inf)) === bareinterval(-Inf, -0x50b45a75f7e81p-104)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, +Inf)) === bareinterval(-Inf, 0.0)

    @test -(bareinterval(-0x142d169d7dfa03p-106, -0x142d169d7dfa03p-106), bareinterval(0.0, +Inf)) === bareinterval(-Inf, -0x142d169d7dfa03p-106)

    @test -(bareinterval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47), bareinterval(17.0, 32.0)) === bareinterval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)

    @test -(bareinterval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47), bareinterval(17.0, 0xfb53d14aa9c2fp-47)) === bareinterval(0.0, 0x7353d14aa9c2fp-47)

    @test -(bareinterval(0xfb53d14aa9c2fp-48, 0xfb53d14aa9c2fp-48), bareinterval(0xfb53d14aa9c2fp-48, 32.0)) === bareinterval(-0x104ac2eb5563d1p-48, 0.0)

    @test -(bareinterval(3.5, 3.5), bareinterval(-0x123456789abcdfp-4, -0x123456789abcdfp-48)) === bareinterval(0x15b456789abcdfp-48, 0x123456789abd17p-4)

    @test -(bareinterval(3.5, 3.5), bareinterval(-0x123456789abcdfp-4, -0x123456789abcdfp-56)) === bareinterval(0x3923456789abcdp-52, 0x123456789abd17p-4)

    @test -(bareinterval(256.5, 256.5), bareinterval(-0x123456789abcdfp-52, 0xffp0)) === bareinterval(0x18p-4, 0x101a3456789abdp-44)

    @test -(bareinterval(4097.5, 4097.5), bareinterval(0x1p-550, 0x1fffffffffffffp-52)) === bareinterval(0xfff8p-4, 0x10018p-4)

    @test -(bareinterval(-3.5, -3.5), bareinterval(-0x123456789abcdfp-4, -0x123456789abcdfp-48)) === bareinterval(0xeb456789abcdfp-48, 0x123456789abca7p-4)

    @test -(bareinterval(-3.5, -3.5), bareinterval(-0x123456789abcdfp-4, -0x123456789abcdfp-56)) === bareinterval(-0x36dcba98765434p-52, 0x123456789abca7p-4)

    @test -(bareinterval(-256.5, -256.5), bareinterval(-0x123456789abcdfp-52, 0xffp0)) === bareinterval(-0x1ff8p-4, -0xff5cba9876543p-44)

    @test -(bareinterval(-4097.5, -4097.5), bareinterval(0x1p-550, 0x1fffffffffffffp-52)) === bareinterval(-0x10038p-4, -0x10018p-4)

end

@testset "mpfi_exp" begin

    @test exp(bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0x1de16b9c24a98fp-63)

    @test exp(bareinterval(-Inf, 0.0)) === bareinterval(0.0, 1.0)

    @test exp(bareinterval(-Inf, +1.0)) === bareinterval(0.0, 0x15bf0a8b14576ap-51)

    @test exp(entireinterval(BareInterval{Float64})) === bareinterval(0.0, +Inf)

    @test exp(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test exp(bareinterval(0.0, +1.0)) === bareinterval(1.0, 0x15bf0a8b14576ap-51)

    @test exp(bareinterval(0.0, +Inf)) === bareinterval(1.0, +Inf)

    @test exp(bareinterval(-123.0, -17.0)) === bareinterval(0x1766b45dd84f17p-230, 0x1639e3175a689dp-77)

    @test exp(bareinterval(-0.125, 0.25)) === bareinterval(0x1c3d6a24ed8221p-53, 0x148b5e3c3e8187p-52)

    @test exp(bareinterval(-0.125, 0.0)) === bareinterval(0x1c3d6a24ed8221p-53, 1.0)

    @test exp(bareinterval(0.0, 0.25)) === bareinterval(1.0, 0x148b5e3c3e8187p-52)

    @test exp(bareinterval(0xap-47, 0xbp-47)) === bareinterval(0x10000000000140p-52, 0x10000000000161p-52)

end

@testset "mpfi_exp2" begin

    @test exp2(bareinterval(-Inf, -1.0)) === bareinterval(0.0, 0.5)

    @test exp2(bareinterval(-Inf, 0.0)) === bareinterval(0.0, 1.0)

    @test exp2(bareinterval(-Inf, 1.0)) === bareinterval(0.0, 2.0)

    @test exp2(entireinterval(BareInterval{Float64})) === bareinterval(0.0, +Inf)

    @test exp2(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test exp2(bareinterval(0.0, +1.0)) === bareinterval(1.0, 2.0)

    @test exp2(bareinterval(0.0, +Inf)) === bareinterval(1.0, +Inf)

    @test exp2(bareinterval(-123.0, -17.0)) === bareinterval(0x1p-123, 0x1p-17)

    @test exp2(bareinterval(-7.0, 7.0)) === bareinterval(0x1p-7, 0x1p+7)

    @test exp2(bareinterval(-0.125, 0.25)) === bareinterval(0x1d5818dcfba487p-53, 0x1306fe0a31b716p-52)

    @test exp2(bareinterval(-0.125, 0.0)) === bareinterval(0x1d5818dcfba487p-53, 1.0)

    @test exp2(bareinterval(0.0, 0.25)) === bareinterval(1.0, 0x1306fe0a31b716p-52)

    @test exp2(bareinterval(0xap-47, 0xbp-47)) === bareinterval(0x100000000000ddp-52, 0x100000000000f4p-52)

end

@testset "mpfi_expm1" begin

    @test expm1(bareinterval(-Inf, -7.0)) === bareinterval(-1.0, -0x1ff887a518f6d5p-53)

    @test expm1(bareinterval(-Inf, 0.0)) === bareinterval(-1.0, 0.0)

    @test expm1(bareinterval(-Inf, 1.0)) === bareinterval(-1.0, 0x1b7e151628aed3p-52)

    @test expm1(entireinterval(BareInterval{Float64})) === bareinterval(-1.0, +Inf)

    @test expm1(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test expm1(bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x1b7e151628aed3p-52)

    @test expm1(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test expm1(bareinterval(-36.0, -36.0)) === bareinterval(-0x1ffffffffffffep-53, -0x1ffffffffffffdp-53)

    @test expm1(bareinterval(-0.125, 0.25)) === bareinterval(-0x1e14aed893eef4p-56, 0x122d78f0fa061ap-54)

    @test expm1(bareinterval(-0.125, 0.0)) === bareinterval(-0x1e14aed893eef4p-56, 0.0)

    @test expm1(bareinterval(0.0, 0.25)) === bareinterval(0.0, 0x122d78f0fa061ap-54)

    @test expm1(bareinterval(0xap-47, 0xbp-47)) === bareinterval(0x140000000000c8p-96, 0x160000000000f3p-96)

end

@testset "mpfi_hypot" begin

    @test hypot(bareinterval(-Inf, -7.0), bareinterval(-1.0, 8.0)) === bareinterval(7.0, +Inf)

    @test hypot(bareinterval(-Inf, 0.0), bareinterval(8.0, +Inf)) === bareinterval(8.0, +Inf)

    @test hypot(bareinterval(-Inf, 8.0), bareinterval(0.0, 8.0)) === bareinterval(0.0, +Inf)

    @test hypot(entireinterval(BareInterval{Float64}), bareinterval(0.0, 8.0)) === bareinterval(0.0, +Inf)

    @test hypot(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(7.0, +Inf)

    @test hypot(bareinterval(0.0, 3.0), bareinterval(-4.0, 0.0)) === bareinterval(0.0, 5.0)

    @test hypot(bareinterval(0.0, 0.0), bareinterval(0.0, 8.0)) === bareinterval(0.0, 8.0)

    @test hypot(bareinterval(0.0, +Inf), bareinterval(0.0, 8.0)) === bareinterval(0.0, +Inf)

    @test hypot(bareinterval(0.0, 0.0), bareinterval(8.0, +Inf)) === bareinterval(8.0, +Inf)

    @test hypot(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, +Inf)

    @test hypot(bareinterval(0.0, 5.0), bareinterval(0.0, 12.0)) === bareinterval(0.0, 13.0)

    @test hypot(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test hypot(bareinterval(0.0, +Inf), bareinterval(-7.0, 8.0)) === bareinterval(0.0, +Inf)

    @test hypot(bareinterval(-12.0, -5.0), bareinterval(-35.0, -12.0)) === bareinterval(13.0, 37.0)

    @test hypot(bareinterval(6.0, 7.0), bareinterval(1.0, 24.0)) === bareinterval(0x1854bfb363dc39p-50, 25.0)

    @test hypot(bareinterval(-4.0, +7.0), bareinterval(-25.0, 3.0)) === bareinterval(0.0, 0x19f625847a5899p-48)

    @test hypot(bareinterval(0x1854bfb363dc39p-50, 0x19f625847a5899p-48), bareinterval(0x1854bfb363dc39p-50, 0x19f625847a5899p-48)) === bareinterval(0x113463fa37014dp-49, 0x125b89092b8fc0p-47)

end

@testset "mpfi_intersect" begin

    @test intersect_interval(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test intersect_interval(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test intersect_interval(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(0.0, 0.0)

    @test intersect_interval(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0.0)

    @test intersect_interval(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test intersect_interval(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === emptyinterval(BareInterval{Float64})

    @test intersect_interval(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test intersect_interval(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === bareinterval(0.0, +8.0)

    @test intersect_interval(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test intersect_interval(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test intersect_interval(bareinterval(0x12p0, 0x90p0), bareinterval(-0x0dp0, 0x34p0)) === bareinterval(0x12p0, 0x34p0)

end

@testset "mpfi_inv" begin

    @test inv(bareinterval(-Inf, -.25)) === bareinterval(-4.0, 0.0)

    @test inv(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test inv(bareinterval(-Inf, +4.0)) === entireinterval(BareInterval{Float64})

    @test inv(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test inv(bareinterval(0.0, 0.0)) === emptyinterval(BareInterval{Float64})

    @test inv(bareinterval(0.0, +2.0)) === bareinterval(+.5, +Inf)

    @test inv(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test inv(bareinterval(-8.0, -2.0)) === bareinterval(-.5, -0.125)

    @test inv(bareinterval(0x1p-4, 0x1440c131282cd9p-53)) === bareinterval(0x1947bfce1bc417p-52, 0x10p0)

    @test inv(bareinterval(0x19f1a539c91fddp-55, +64.0)) === bareinterval(0.015625, 0x13bc205a76b3fdp-50)

    @test inv(bareinterval(-0xae83b95effd69p-52, -0x63e3cb4ed72a3p-53)) === bareinterval(-0x1480a9b5772a23p-50, -0x177887d65484c9p-52)

end

@testset "mpfi_is_neg" begin

    @test precedes(bareinterval(-Inf, -8.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(-Inf, 5.0), bareinterval(0.0, 0.0)) === false

    @test precedes(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(-8.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(0.0, 5.0), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(5.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(-34.0, -17.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(-8.0, -1.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(-34.0, 17.0), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(+8.0, +0x7fffffffffffbp+51), bareinterval(0.0, 0.0)) === false

    @test precedes(bareinterval(+0x1fffffffffffffp-53, 2.0), bareinterval(0.0, 0.0)) === false

end

@testset "mpfi_is_nonneg" begin

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-Inf, -8.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-Inf, 5.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-8.0, 0.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(0.0, 5.0)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(0.0, +Inf)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(5.0, +Inf)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-34.0, -17.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-8.0, -1.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-34.0, 17.0)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === false

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(+8.0, +0x7fffffffffffbp+51)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(+0x1fffffffffffffp-53, 2.0)) === true

end

@testset "mpfi_is_nonpos" begin

    @test isweakless(bareinterval(-Inf, -8.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(-Inf, 5.0), bareinterval(0.0, 0.0)) === false

    @test isweakless(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(-8.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(0.0, 5.0), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(5.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(-34.0, -17.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(-8.0, -1.0), bareinterval(0.0, 0.0)) === true

    @test isweakless(bareinterval(-34.0, 17.0), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(8.0, 0x7fffffffffffbp+51), bareinterval(0.0, 0.0)) === false

    @test isweakless(bareinterval(0x1fffffffffffffp-53, 2.0), bareinterval(0.0, 0.0)) === false

end

@testset "mpfi_is_pos" begin

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-Inf, -8.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-Inf, 5.0)) === false

    @test precedes(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-8.0, 0.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(0.0, 5.0)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(0.0, +Inf)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(5.0, +Inf)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-34.0, -17.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-8.0, -1.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-34.0, 17.0)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === false

    @test precedes(bareinterval(0.0, 0.0), bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(+8.0, +0x7fffffffffffbp+51)) === true

    @test precedes(bareinterval(0.0, 0.0), bareinterval(+0x1fffffffffffffp-53, 2.0)) === true

end

@testset "mpfi_is_strictly_neg" begin

    @test strictprecedes(bareinterval(-Inf, -8.0), bareinterval(0.0, 0.0)) === true

    @test strictprecedes(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(-Inf, 5.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(-8.0, 0.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, 5.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(5.0, +Inf), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(-34.0, -17.0), bareinterval(0.0, 0.0)) === true

    @test strictprecedes(bareinterval(-8.0, -1.0), bareinterval(0.0, 0.0)) === true

    @test strictprecedes(bareinterval(-34.0, 17.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(+8.0, +0x7fffffffffffbp+51), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(+0x1fffffffffffffp-53, 2.0), bareinterval(0.0, 0.0)) === false

end

@testset "mpfi_is_strictly_pos" begin

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-Inf, -8.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-Inf, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-Inf, 5.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-8.0, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(0.0, 5.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(0.0, +Inf)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(5.0, +Inf)) === true

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-34.0, -17.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-8.0, -1.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-34.0, 17.0)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(-0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === false

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === true

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(+8.0, +0x7fffffffffffbp+51)) === true

    @test strictprecedes(bareinterval(0.0, 0.0), bareinterval(+0x1fffffffffffffp-53, 2.0)) === true

end

@testset "mpfi_log" begin

    @test log(bareinterval(0.0, +1.0)) === bareinterval(-Inf, 0.0)

    @test log(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test log(bareinterval(+1.0, +1.0)) === bareinterval(0.0, 0.0)

    @test log(bareinterval(0x3a2a08c23afe3p-14, 0x1463ceb440d6bdp-14)) === bareinterval(0xc6dc8a2928579p-47, 0x1a9500bc7ffcc5p-48)

    @test log(bareinterval(0xb616ab8b683b5p-52, +1.0)) === bareinterval(-0x2b9b8b1fb2fb9p-51, 0.0)

    @test log(bareinterval(+1.0, 0x8ac74d932fae3p-21)) === bareinterval(0.0, 0x5380455576989p-46)

    @test log(bareinterval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) === bareinterval(0xbdee7228cfedfp-47, 0x1b3913fc99f555p-48)

end

@testset "mpfi_log1p" begin

    @test log1p(bareinterval(-1.0, 0.0)) === bareinterval(-Inf, 0.0)

    @test log1p(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test log1p(bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x162e42fefa39f0p-53)

    @test log1p(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test log1p(bareinterval(-0xb616ab8b683b5p-52, 0.0)) === bareinterval(-0x13e080325bab7bp-52, 0.0)

    @test log1p(bareinterval(0.0, 0x8ac74d932fae3p-21)) === bareinterval(0.0, 0x14e0115561569cp-48)

    @test log1p(bareinterval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) === bareinterval(0x17bdce451a337fp-48, 0x1b3913fc99f6fcp-48)

end

@testset "mpfi_log2" begin

    @test log2(bareinterval(0.0, +1.0)) === bareinterval(-Inf, 0.0)

    @test log2(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test log2(bareinterval(1.0, 1.0)) === bareinterval(0.0, 0.0)

    @test log2(bareinterval(0xb616ab8b683b5p-52, 1.0)) === bareinterval(-0x1f74cb5d105b3ap-54, 0.0)

    @test log2(bareinterval(1.0, 0x8ac74d932fae3p-21)) === bareinterval(0.0, 0x1e1ddc27c2c70fp-48)

    @test log2(bareinterval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) === bareinterval(0x112035c9390c07p-47, 0x13a3208f61f10cp-47)

end

@testset "mpfi_log10" begin

    @test log10(bareinterval(0.0, 1.0)) === bareinterval(-Inf, 0.0)

    @test log10(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test log10(bareinterval(1.0, 1.0)) === bareinterval(0.0, 0.0)

    @test log10(bareinterval(0x3a2a08c23afe3p-14, 0x1463ceb440d6bdp-14)) === bareinterval(0x159753104a9401p-49, 0x1716c01a04b570p-49)

    @test log10(bareinterval(0xb616ab8b683b5p-52, 1.0)) === bareinterval(-0x12f043ec00f8d6p-55, 0.0)

    @test log10(bareinterval(100.0, 0x8ac74d932fae3p-21)) === bareinterval(2.0, 0x1221cc590b9946p-49)

    @test log10(bareinterval(0x4c322657ec89bp-16, 0x4d68ba5f26bf1p-11)) === bareinterval(0x149f1d70168f49p-49, 0x17a543a94fb65ep-49)

end

@testset "mpfi_mag" begin

    @test mag(bareinterval(-Inf, -8.0)) === +Inf

    @test mag(bareinterval(-Inf, 0.0)) === +Inf

    @test mag(bareinterval(-Inf, 5.0)) === +Inf

    @test mag(entireinterval(BareInterval{Float64})) === +Inf

    @test mag(bareinterval(-Inf, 0.0)) === +Inf

    @test mag(bareinterval(-8.0, 0.0)) === +8.0

    @test mag(bareinterval(0.0, 0.0)) === +0.0

    @test mag(bareinterval(0.0, 5.0)) === +5.0

    @test mag(bareinterval(0.0, +Inf)) === +Inf

    @test mag(bareinterval(-34.0, -17.0)) === 34.0

end

@testset "mpfi_mid" begin

    @test mid(bareinterval(-8.0, 0.0)) === -4.0

    @test mid(bareinterval(0.0, 0.0)) === +0.0

    @test mid(bareinterval(0.0, 5.0)) === +2.5

    @test mid(bareinterval(-34.0, -17.0)) === -0x33p-1

    @test mid(bareinterval(-34.0, 17.0)) === -8.5

    @test mid(bareinterval(0.0, +0x123456789abcdp-2)) === +0x123456789abcdp-3

    @test mid(bareinterval(0x1921fb54442d18p-51, 0x1921fb54442d19p-51)) === 0x1921fb54442d18p-51

    @test mid(bareinterval(-0x1921fb54442d19p-51, -0x1921fb54442d18p-51)) === -0x1921fb54442d18p-51

    @test mid(bareinterval(-4.0, -0x7fffffffffffdp-51)) === -0x27fffffffffffbp-52

    @test mid(bareinterval(-8.0, -0x7fffffffffffbp-51)) === -0x47fffffffffffbp-52

    @test mid(bareinterval(-0x1fffffffffffffp-53, 2.0)) === 0.5

end

@testset "mpfi_mig" begin

    @test mig(bareinterval(-Inf, -8.0)) === 8.0

    @test mig(bareinterval(-Inf, 0.0)) === +0.0

    @test mig(bareinterval(-Inf, 5.0)) === +0.0

    @test mig(entireinterval(BareInterval{Float64})) === +0.0

    @test mig(bareinterval(-Inf, 0.0)) === +0.0

    @test mig(bareinterval(-8.0, 0.0)) === +0.0

    @test mig(bareinterval(0.0, 0.0)) === +0.0

    @test mig(bareinterval(0.0, 5.0)) === +0.0

    @test mig(bareinterval(0.0, +Inf)) === +0.0

    @test mig(bareinterval(-34.0, -17.0)) === 17.0

end

@testset "mpfi_mul" begin

    @test *(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(-Inf, 0.0)

    @test *(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(-Inf, +64.0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(-56.0, 0.0)

    @test *(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test *(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === bareinterval(-56.0, +64.0)

    @test *(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test *(bareinterval(-3.0, +7.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(-0x0dp0, -0x09p0), bareinterval(-0x04p0, -0x02p0)) === bareinterval(0x12p0, 0x34p0)

    @test *(bareinterval(-0x0dp0, -0xd.f0e7927d247cp-4), bareinterval(-0x04p0, -0xa.41084aff48f8p-8)) === bareinterval(0x8.ef3aa21dba748p-8, 0x34p0)

    @test *(bareinterval(-0xe.26c9e9eb67b48p-4, -0x8.237d2eb8b1178p-4), bareinterval(-0x5.8c899a0706d5p-4, -0x3.344e57a37b5e8p-4)) === bareinterval(0x1.a142a930de328p-4, 0x4.e86c3434cd924p-4)

    @test *(bareinterval(-0x37p0, -0x07p0), bareinterval(-0x01p0, 0x22p0)) === bareinterval(-0x74ep0, 0x37p0)

    @test *(bareinterval(-0xe.063f267ed51ap-4, -0x0.33p0), bareinterval(-0x01p0, 0x1.777ab178b4a1ep+0)) === bareinterval(-0x1.491df346a9f15p+0, 0xe.063f267ed51ap-4)

    @test *(bareinterval(-0x1.cb540b71699a8p+4, -0x0.33p0), bareinterval(-0x1.64dcaaa101f18p+0, 0x01p0)) === bareinterval(-0x1.cb540b71699a8p+4, 0x2.804cce4a3f42ep+4)

    @test *(bareinterval(-0x1.cb540b71699a8p+4, -0x0.33p0), bareinterval(-0x1.64dcaaa101f18p+0, 0x1.eb67a1a6ef725p+4)) === bareinterval(-0x3.71b422ce817f4p+8, 0x2.804cce4a3f42ep+4)

    @test *(bareinterval(-0x123456789ap0, -0x01p0), bareinterval(0x01p0, 0x10p0)) === bareinterval(-0x123456789a0p0, -0x01p0)

    @test *(bareinterval(-0xb.6c67d3a37d54p-4, -0x0.8p0), bareinterval(0x02p0, 0x2.0bee4e8bb3dfp+0)) === bareinterval(-0x1.7611a672948a5p+0, -0x01p0)

    @test *(bareinterval(-0x04p0, -0xa.497d533c3b2ep-8), bareinterval(0xb.d248df3373e68p-4, 0x04p0)) === bareinterval(-0x10p0, -0x7.99b990532d434p-8)

    @test *(bareinterval(-0xb.6c67d3a37d54p-4, -0xa.497d533c3b2ep-8), bareinterval(0xb.d248df3373e68p-4, 0x2.0bee4e8bb3dfp+0)) === bareinterval(-0x1.7611a672948a5p+0, -0x7.99b990532d434p-8)

    @test *(bareinterval(-0x01p0, 0x11p0), bareinterval(-0x07p0, -0x04p0)) === bareinterval(-0x77p0, 0x07p0)

    @test *(bareinterval(-0x01p0, 0xe.ca7ddfdb8572p-4), bareinterval(-0x2.3b46226145234p+0, -0x0.1p0)) === bareinterval(-0x2.101b41d3d48b8p+0, 0x2.3b46226145234p+0)

    @test *(bareinterval(-0x1.1d069e75e8741p+8, 0x01p0), bareinterval(-0x2.3b46226145234p+0, -0x0.1p0)) === bareinterval(-0x2.3b46226145234p+0, 0x2.7c0bd9877f404p+8)

    @test *(bareinterval(-0xe.ca7ddfdb8572p-4, 0x1.1d069e75e8741p+8), bareinterval(-0x2.3b46226145234p+0, -0x0.1p0)) === bareinterval(-0x2.7c0bd9877f404p+8, 0x2.101b41d3d48b8p+0)

    @test *(bareinterval(-0x01p0, 0x10p0), bareinterval(-0x02p0, 0x03p0)) === bareinterval(-0x20p0, 0x30p0)

    @test *(bareinterval(-0x01p0, 0x2.db091cea593fap-4), bareinterval(-0x2.6bff2625fb71cp-4, 0x1p-8)) === bareinterval(-0x6.ea77a3ee43de8p-8, 0x2.6bff2625fb71cp-4)

    @test *(bareinterval(-0x01p0, 0x6.e211fefc216ap-4), bareinterval(-0x1p-4, 0x1.8e3fe93a4ea52p+0)) === bareinterval(-0x1.8e3fe93a4ea52p+0, 0xa.b52fe22d72788p-4)

    @test *(bareinterval(-0x1.15e079e49a0ddp+0, 0x1p-8), bareinterval(-0x2.77fc84629a602p+0, 0x8.3885932f13fp-4)) === bareinterval(-0x8.ec5de73125be8p-4, 0x2.adfe651d3b19ap+0)

    @test *(bareinterval(-0x07p0, 0x07p0), bareinterval(0x13p0, 0x24p0)) === bareinterval(-0xfcp0, 0xfcp0)

    @test *(bareinterval(-0xa.8071f870126cp-4, 0x10p0), bareinterval(0x02p0, 0x2.3381083e7d3b4p+0)) === bareinterval(-0x1.71dc5b5607781p+0, 0x2.3381083e7d3b4p+4)

    @test *(bareinterval(-0x01p0, 0x1.90aa487ecf153p+0), bareinterval(0x01p-53, 0x1.442e2695ac81ap+0)) === bareinterval(-0x1.442e2695ac81ap+0, 0x1.fb5fbebd0cbc6p+0)

    @test *(bareinterval(-0x1.c40db77f2f6fcp+0, 0x1.8eb70bbd94478p+0), bareinterval(0x02p0, 0x3.45118635235c6p+0)) === bareinterval(-0x5.c61fcad908df4p+0, 0x5.17b7c49130824p+0)

    @test *(bareinterval(0xcp0, 0x2dp0), bareinterval(-0x679p0, -0xe5p0)) === bareinterval(-0x12345p0, -0xabcp0)

    @test *(bareinterval(0xcp0, 0x1.1833fdcab4c4ap+10), bareinterval(-0x2.4c0afc50522ccp+40, -0xe5p0)) === bareinterval(-0x2.83a3712099234p+50, -0xabcp0)

    @test *(bareinterval(0xb.38f1fb0ef4308p+0, 0x2dp0), bareinterval(-0x679p0, -0xa.4771d7d0c604p+0)) === bareinterval(-0x12345p0, -0x7.35b3c8400ade4p+4)

    @test *(bareinterval(0xf.08367984ca1cp-4, 0xa.bcf6c6cbe341p+0), bareinterval(-0x5.cbc445e9952c4p+0, -0x2.8ad05a7b988fep-8)) === bareinterval(-0x3.e3ce52d4a139cp+4, -0x2.637164cf2f346p-8)

    @test *(bareinterval(0x01p0, 0xcp0), bareinterval(-0xe5p0, 0x01p0)) === bareinterval(-0xabcp0, 0xcp0)

    @test *(bareinterval(0x123p-52, 0x1.ec24910ac6aecp+0), bareinterval(-0xa.a97267f56a9b8p-4, 0x1p+32)) === bareinterval(-0x1.47f2dbe4ef916p+0, 0x1.ec24910ac6aecp+32)

    @test *(bareinterval(0x03p0, 0x7.2bea531ef4098p+0), bareinterval(-0x01p0, 0xa.a97267f56a9b8p-4)) === bareinterval(-0x7.2bea531ef4098p+0, 0x4.c765967f9468p+0)

    @test *(bareinterval(0x0.3p0, 0xa.a97267f56a9b8p-4), bareinterval(-0x1.ec24910ac6aecp+0, 0x7.2bea531ef4098p+0)) === bareinterval(-0x1.47f2dbe4ef916p+0, 0x4.c765967f9468p+0)

    @test *(bareinterval(0x3p0, 0x7p0), bareinterval(0x5p0, 0xbp0)) === bareinterval(0xfp0, 0x4dp0)

    @test *(bareinterval(0x2.48380232f6c16p+0, 0x7p0), bareinterval(0x3.71cb6c53e68eep+0, 0xbp0)) === bareinterval(0x7.dc58fb323ad78p+0, 0x4dp0)

    @test *(bareinterval(0x3p0, 0x3.71cb6c53e68eep+0), bareinterval(0x5p-25, 0x2.48380232f6c16p+0)) === bareinterval(0xfp-25, 0x7.dc58fb323ad7cp+0)

    @test *(bareinterval(0x3.10e8a605572p-4, 0x2.48380232f6c16p+0), bareinterval(0xc.3d8e305214ecp-4, 0x2.9e7db05203c88p+0)) === bareinterval(0x2.587a32d02bc04p-4, 0x5.fa216b7c20c6cp+0)

end

@testset "mpfi_mul_d" begin

    @test *(bareinterval(-Inf, -7.0), bareinterval(-0x17p0, -0x17p0)) === bareinterval(+0xa1p0, +Inf)

    @test *(bareinterval(-Inf, -7.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(-Inf, -7.0), bareinterval(0x170ef54646d497p-107, 0x170ef54646d497p-107)) === bareinterval(-Inf, -0xa168b4ebefd020p-107)

    @test *(bareinterval(-Inf, 0.0), bareinterval(-0x170ef54646d497p-106, -0x170ef54646d497p-106)) === bareinterval(0.0, +Inf)

    @test *(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(-Inf, 0.0), bareinterval(0x170ef54646d497p-106, 0x170ef54646d497p-106)) === bareinterval(-Inf, 0.0)

    @test *(bareinterval(-Inf, 8.0), bareinterval(-0x16345785d8a00000p0, -0x16345785d8a00000p0)) === bareinterval(-0xb1a2bc2ec5000000p0, +Inf)

    @test *(bareinterval(-Inf, 8.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(-Inf, 8.0), bareinterval(0x16345785d8a00000p0, 0x16345785d8a00000p0)) === bareinterval(-Inf, 0xb1a2bc2ec5000000p0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test *(entireinterval(BareInterval{Float64}), bareinterval(0.0e-17, 0.0e-17)) === bareinterval(0.0, 0.0)

    @test *(entireinterval(BareInterval{Float64}), bareinterval(+0x170ef54646d497p-105, +0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test *(bareinterval(0.0, 0.0), bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, 0.0), bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, 7.0), bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107)) === bareinterval(-0x790e87b0f3dc18p-107, 0.0)

    @test *(bareinterval(0.0, 8.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, 9.0), bareinterval(0x114b37f4b51f71p-103, 0x114b37f4b51f71p-103)) === bareinterval(0.0, 0x9ba4f79a5e1b00p-103)

    @test *(bareinterval(0.0, +Inf), bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104)) === bareinterval(-Inf, 0.0)

    @test *(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test *(bareinterval(0.0, +Inf), bareinterval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106)) === bareinterval(0.0, +Inf)

    @test *(bareinterval(-0x1717170p0, -0xaaaaaaaaaaaaap-123), bareinterval(-1.5, -1.5)) === bareinterval(0xfffffffffffffp-123, 0x22a2a28p0)

    @test *(bareinterval(-0xaaaaaaaaaaaaap0, 0x1717170p+401), bareinterval(-1.5, -1.5)) === bareinterval(-0x22a2a28p+401, 0xfffffffffffffp0)

    @test *(bareinterval(0x10000000000010p0, 0x888888888888p+654), bareinterval(-2.125, -2.125)) === bareinterval(-0x1222222222221p+654, -0x22000000000022p0)

    @test *(bareinterval(-0x1717170p0, -0xaaaaaaaaaaaaap-123), bareinterval(1.5, 1.5)) === bareinterval(-0x22a2a28p0, -0xfffffffffffffp-123)

    @test *(bareinterval(-0xaaaaaaaaaaaaap0, 0x1717170p+401), bareinterval(1.5, 1.5)) === bareinterval(-0xfffffffffffffp0, 0x22a2a28p+401)

    @test *(bareinterval(0x10000000000010p0, 0x888888888888p+654), bareinterval(2.125, 2.125)) === bareinterval(0x22000000000022p0, 0x1222222222221p+654)

    @test *(bareinterval(-0x1717170p+36, -0x10000000000001p0), bareinterval(-1.5, -1.5)) === bareinterval(0x18000000000001p0, 0x22a2a28p+36)

    @test *(bareinterval(-0xaaaaaaaaaaaaap0, 0x10000000000001p0), bareinterval(-1.5, -1.5)) === bareinterval(-0x18000000000002p0, 0xfffffffffffffp0)

    @test *(bareinterval(0x10000000000010p0, 0x11111111111111p0), bareinterval(-2.125, -2.125)) === bareinterval(-0x12222222222223p+1, -0x22000000000022p0)

    @test *(bareinterval(-0x10000000000001p0, -0xaaaaaaaaaaaaap-123), bareinterval(1.5, 1.5)) === bareinterval(-0x18000000000002p0, -0xfffffffffffffp-123)

    @test *(bareinterval(-0xaaaaaaaaaaaabp0, 0x1717170p+401), bareinterval(1.5, 1.5)) === bareinterval(-0x10000000000001p0, 0x22a2a28p+401)

    @test *(bareinterval(0x10000000000001p0, 0x888888888888p+654), bareinterval(2.125, 2.125)) === bareinterval(0x22000000000002p0, 0x1222222222221p+654)

    @test *(bareinterval(-0x11717171717171p0, -0xaaaaaaaaaaaaap-123), bareinterval(-1.5, -1.5)) === bareinterval(0xfffffffffffffp-123, 0x1a2a2a2a2a2a2ap0)

    @test *(bareinterval(-0x10000000000001p0, 0x1717170p+401), bareinterval(-1.5, -1.5)) === bareinterval(-0x22a2a28p+401, 0x18000000000002p0)

    @test *(bareinterval(0x10000000000001p0, 0x888888888888p+654), bareinterval(-2.125, -2.125)) === bareinterval(-0x1222222222221p+654, -0x22000000000002p0)

    @test *(bareinterval(-0x1717170p0, -0x1aaaaaaaaaaaaap-123), bareinterval(1.5, 1.5)) === bareinterval(-0x22a2a28p0, -0x27fffffffffffep-123)

    @test *(bareinterval(-0xaaaaaaaaaaaaap0, 0x11717171717171p0), bareinterval(1.5, 1.5)) === bareinterval(-0xfffffffffffffp0, 0x1a2a2a2a2a2a2ap0)

    @test *(bareinterval(0x10000000000010p0, 0x18888888888889p0), bareinterval(2.125, 2.125)) === bareinterval(0x22000000000022p0, 0x34222222222224p0)

    @test *(bareinterval(-0x11717171717171p0, -0x10000000000001p0), bareinterval(-1.5, -1.5)) === bareinterval(0x18000000000001p0, 0x1a2a2a2a2a2a2ap0)

    @test *(bareinterval(-0x10000000000001p0, 0x10000000000001p0), bareinterval(-1.5, -1.5)) === bareinterval(-0x18000000000002p0, 0x18000000000002p0)

    @test *(bareinterval(0x10000000000001p0, 0x11111111111111p0), bareinterval(-2.125, -2.125)) === bareinterval(-0x12222222222223p+1, -0x22000000000002p0)

    @test *(bareinterval(-0x10000000000001p0, -0x1aaaaaaaaaaaaap-123), bareinterval(1.5, 1.5)) === bareinterval(-0x18000000000002p0, -0x27fffffffffffep-123)

    @test *(bareinterval(-0xaaaaaaaaaaaabp0, 0x11717171717171p0), bareinterval(1.5, 1.5)) === bareinterval(-0x10000000000001p0, 0x1a2a2a2a2a2a2ap0)

    @test *(bareinterval(0x10000000000001p0, 0x18888888888889p0), bareinterval(2.125, 2.125)) === bareinterval(0x22000000000002p0, 0x34222222222224p0)

end

@testset "mpfi_neg" begin

    @test -(bareinterval(-Inf, -7.0)) === bareinterval(+7.0, +Inf)

    @test -(bareinterval(-Inf, 0.0)) === bareinterval(0.0, +Inf)

    @test -(bareinterval(-Inf, +8.0)) === bareinterval(-8.0, +Inf)

    @test -(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test -(bareinterval(0.0, +8.0)) === bareinterval(-8.0, 0.0)

    @test -(bareinterval(0.0, +Inf)) === bareinterval(-Inf, 0.0)

    @test -(bareinterval(0x123456789p-16, 0x123456799p-16)) === bareinterval(-0x123456799p-16, -0x123456789p-16)

end

@testset "mpfi_put_d" begin

    @test hull(bareinterval(0.0, 0.0), bareinterval(-8.0, -8.0)) === bareinterval(-8.0, 0.0)

    @test hull(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test hull(bareinterval(+5.0, +5.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, +5.0)

end

@testset "mpfi_sec" begin

    @test sec(bareinterval(-Inf, -7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-Inf, 8.0)) === entireinterval(BareInterval{Float64})

    @test sec(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-8.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 0.0)) === bareinterval(1.0, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test sec(bareinterval(0.0, +1.0)) === bareinterval(1.0, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(0.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(0.0, 8.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, -4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-6.0, -5.0)) === bareinterval(0x10a9e8f3e19df1p-52, 0x1c33db0464189bp-51)

    @test sec(bareinterval(-6.0, -6.0)) === bareinterval(0x10a9e8f3e19df1p-52, 0x10a9e8f3e19df2p-52)

    @test sec(bareinterval(-5.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, -4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-5.0, -5.0)) === bareinterval(0x1c33db0464189ap-51, 0x1c33db0464189bp-51)

    @test sec(bareinterval(-4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-4.0, -2.0)) === bareinterval(-0x133956fecf9e49p-51, -1.0)

    @test sec(bareinterval(-4.0, -3.0)) === bareinterval(-0x187a6961d2485fp-52, -1.0)

    @test sec(bareinterval(-4.0, -4.0)) === bareinterval(-0x187a6961d2485fp-52, -0x187a6961d2485ep-52)

    @test sec(bareinterval(-3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-3.0, -2.0)) === bareinterval(-0x133956fecf9e49p-51, -0x102967b457b245p-52)

    @test sec(bareinterval(-3.0, -3.0)) === bareinterval(-0x102967b457b246p-52, -0x102967b457b245p-52)

    @test sec(bareinterval(-2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-2.0, -2.0)) === bareinterval(-0x133956fecf9e49p-51, -0x133956fecf9e48p-51)

    @test sec(bareinterval(-1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(-1.0, 1.0)) === bareinterval(1.0, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(-1.0, 0.0)) === bareinterval(1.0, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(-1.0, -1.0)) === bareinterval(0x1d9cf0f125cc29p-52, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(1.0, 1.0)) === bareinterval(0x1d9cf0f125cc29p-52, 0x1d9cf0f125cc2ap-52)

    @test sec(bareinterval(2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(2.0, 4.0)) === bareinterval(-0x133956fecf9e49p-51, -1.0)

    @test sec(bareinterval(2.0, 3.0)) === bareinterval(-0x133956fecf9e49p-51, -0x102967b457b245p-52)

    @test sec(bareinterval(2.0, 2.0)) === bareinterval(-0x133956fecf9e49p-51, -0x133956fecf9e48p-51)

    @test sec(bareinterval(3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(3.0, 4.0)) === bareinterval(-0x187a6961d2485fp-52, -1.0)

    @test sec(bareinterval(3.0, 3.0)) === bareinterval(-0x102967b457b246p-52, -0x102967b457b245p-52)

    @test sec(bareinterval(4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(4.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(4.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test sec(bareinterval(4.0, 4.0)) === bareinterval(-0x187a6961d2485fp-52, -0x187a6961d2485ep-52)

    @test sec(bareinterval(5.0, 7.0)) === bareinterval(1.0, 0x1c33db0464189bp-51)

    @test sec(bareinterval(5.0, 6.0)) === bareinterval(0x10a9e8f3e19df1p-52, 0x1c33db0464189bp-51)

    @test sec(bareinterval(5.0, 5.0)) === bareinterval(0x1c33db0464189ap-51, 0x1c33db0464189bp-51)

    @test sec(bareinterval(6.0, 7.0)) === bareinterval(1.0, 0x153910a80e7db5p-52)

    @test sec(bareinterval(6.0, 6.0)) === bareinterval(0x10a9e8f3e19df1p-52, 0x10a9e8f3e19df2p-52)

    @test sec(bareinterval(7.0, 7.0)) === bareinterval(0x153910a80e7db4p-52, 0x153910a80e7db5p-52)

end

@testset "mpfi_sech" begin

    @test sech(bareinterval(-Inf, -7.0)) === bareinterval(0.0, 0x1de169fb49b339p-62)

    @test sech(bareinterval(-Inf, 0.0)) === bareinterval(0.0, 1.0)

    @test sech(bareinterval(-Inf, +8.0)) === bareinterval(0.0, 1.0)

    @test sech(entireinterval(BareInterval{Float64})) === bareinterval(0.0, 1.0)

    @test sech(bareinterval(-1.0, 0.0)) === bareinterval(0x14bcdc50ed6be7p-53, 1.0)

    @test sech(bareinterval(0.0, 0.0)) === bareinterval(1.0, 1.0)

    @test sech(bareinterval(0.0, +1.0)) === bareinterval(0x14bcdc50ed6be7p-53, 1.0)

    @test sech(bareinterval(0.0, +8.0)) === bareinterval(0x15fc20da8e18dbp-63, 1.0)

    @test sech(bareinterval(0.0, +Inf)) === bareinterval(0.0, 1.0)

    @test sech(bareinterval(-0.125, 0.0)) === bareinterval(0x1fc069fe3f72bep-53, 1.0)

    @test sech(bareinterval(0.0, 0x10000000000001p-53)) === bareinterval(0x1c60d1ff040dcfp-53, 1.0)

    @test sech(bareinterval(-4.5, -0.625)) === bareinterval(0x16bf984a9a2355p-58, 0x1aa0b464a5e24ap-53)

    @test sech(bareinterval(1.0, 3.0)) === bareinterval(0x196d8e17d88eb1p-56, 0x14bcdc50ed6be8p-53)

    @test sech(bareinterval(17.0, 0xb145bb71d3dbp-38)) === bareinterval(0x10000000000173p-1074, 0x1639e3175a6893p-76)

end

@testset "mpfi_sin" begin

    @test sin(bareinterval(-Inf, -7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-Inf, 0.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-Inf, +8.0)) === bareinterval(-1.0, 1.0)

    @test sin(entireinterval(BareInterval{Float64})) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-1.0, 0.0)) === bareinterval(-0x1aed548f090cefp-53, 0.0)

    @test sin(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test sin(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x1aed548f090cefp-53)

    @test sin(bareinterval(0.0, +8.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(0.0, +Inf)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(0.125, 17.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(0x1921fb54442d18p-52, 0x1921fb54442d19p-52)) === bareinterval(0x1fffffffffffffp-53, 1.0)

    @test sin(bareinterval(-2.0, -0.5)) === bareinterval(-1.0, -0x1eaee8744b05efp-54)

    @test sin(bareinterval(-4.5, 0.625)) === bareinterval(-1.0, 0x1f47ed3dc74081p-53)

    @test sin(bareinterval(-1.0, -0.25)) === bareinterval(-0x1aed548f090cefp-53, -0x1faaeed4f31576p-55)

    @test sin(bareinterval(-0.5, 0.5)) === bareinterval(-0x1eaee8744b05f0p-54, 0x1eaee8744b05f0p-54)

    @test sin(bareinterval(0x71p+76, 0x71p+76)) === bareinterval(0x1bde6c11cbfc46p-55, 0x1bde6c11cbfc47p-55)

    @test sin(bareinterval(-7.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, -1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-7.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, 1.0)

    @test sin(bareinterval(-7.0, -3.0)) === bareinterval(-0x150608c26d0a09p-53, 1.0)

    @test sin(bareinterval(-7.0, -4.0)) === bareinterval(-0x150608c26d0a09p-53, 1.0)

    @test sin(bareinterval(-7.0, -5.0)) === bareinterval(-0x150608c26d0a09p-53, 0x1eaf81f5e09934p-53)

    @test sin(bareinterval(-7.0, -6.0)) === bareinterval(-0x150608c26d0a09p-53, 0x11e1f18ab0a2c1p-54)

    @test sin(bareinterval(-7.0, -7.0)) === bareinterval(-0x150608c26d0a09p-53, -0x150608c26d0a08p-53)

    @test sin(bareinterval(-6.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, -1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-6.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, 1.0)

    @test sin(bareinterval(-6.0, -3.0)) === bareinterval(-0x1210386db6d55cp-55, 1.0)

    @test sin(bareinterval(-6.0, -4.0)) === bareinterval(0x11e1f18ab0a2c0p-54, 1.0)

    @test sin(bareinterval(-6.0, -5.0)) === bareinterval(0x11e1f18ab0a2c0p-54, 0x1eaf81f5e09934p-53)

    @test sin(bareinterval(-6.0, -6.0)) === bareinterval(0x11e1f18ab0a2c0p-54, 0x11e1f18ab0a2c1p-54)

    @test sin(bareinterval(-5.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, 0.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, -1.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-5.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, 1.0)

    @test sin(bareinterval(-5.0, -3.0)) === bareinterval(-0x1210386db6d55cp-55, 1.0)

    @test sin(bareinterval(-5.0, -4.0)) === bareinterval(0x1837b9dddc1eaep-53, 1.0)

    @test sin(bareinterval(-5.0, -5.0)) === bareinterval(0x1eaf81f5e09933p-53, 0x1eaf81f5e09934p-53)

    @test sin(bareinterval(-4.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-4.0, 1.0)) === bareinterval(-1.0, 0x1aed548f090cefp-53)

    @test sin(bareinterval(-4.0, 0.0)) === bareinterval(-1.0, 0x1837b9dddc1eafp-53)

    @test sin(bareinterval(-4.0, -1.0)) === bareinterval(-1.0, 0x1837b9dddc1eafp-53)

    @test sin(bareinterval(-4.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, 0x1837b9dddc1eafp-53)

    @test sin(bareinterval(-4.0, -3.0)) === bareinterval(-0x1210386db6d55cp-55, 0x1837b9dddc1eafp-53)

    @test sin(bareinterval(-4.0, -4.0)) === bareinterval(0x1837b9dddc1eaep-53, 0x1837b9dddc1eafp-53)

    @test sin(bareinterval(-3.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-3.0, 1.0)) === bareinterval(-1.0, 0x1aed548f090cefp-53)

    @test sin(bareinterval(-3.0, 0.0)) === bareinterval(-1.0, 0.0)

    @test sin(bareinterval(-3.0, -1.0)) === bareinterval(-1.0, -0x1210386db6d55bp-55)

    @test sin(bareinterval(-3.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, -0x1210386db6d55bp-55)

    @test sin(bareinterval(-3.0, -3.0)) === bareinterval(-0x1210386db6d55cp-55, -0x1210386db6d55bp-55)

    @test sin(bareinterval(-2.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 4.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 3.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 2.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-2.0, 1.0)) === bareinterval(-1.0, 0x1aed548f090cefp-53)

    @test sin(bareinterval(-2.0, 0.0)) === bareinterval(-1.0, 0.0)

    @test sin(bareinterval(-2.0, -1.0)) === bareinterval(-1.0, -0x1aed548f090ceep-53)

    @test sin(bareinterval(-2.0, -2.0)) === bareinterval(-0x1d18f6ead1b446p-53, -0x1d18f6ead1b445p-53)

    @test sin(bareinterval(-1.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-1.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-1.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(-1.0, 4.0)) === bareinterval(-0x1aed548f090cefp-53, 1.0)

    @test sin(bareinterval(-1.0, 3.0)) === bareinterval(-0x1aed548f090cefp-53, 1.0)

    @test sin(bareinterval(-1.0, 2.0)) === bareinterval(-0x1aed548f090cefp-53, 1.0)

    @test sin(bareinterval(-1.0, 1.0)) === bareinterval(-0x1aed548f090cefp-53, 0x1aed548f090cefp-53)

    @test sin(bareinterval(-1.0, 0.0)) === bareinterval(-0x1aed548f090cefp-53, 0.0)

    @test sin(bareinterval(-1.0, -1.0)) === bareinterval(-0x1aed548f090cefp-53, -0x1aed548f090ceep-53)

    @test sin(bareinterval(1.0, 7.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(1.0, 6.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(1.0, 5.0)) === bareinterval(-1.0, 1.0)

    @test sin(bareinterval(1.0, 4.0)) === bareinterval(-0x1837b9dddc1eafp-53, 1.0)

    @test sin(bareinterval(1.0, 3.0)) === bareinterval(0x1210386db6d55bp-55, 1.0)

    @test sin(bareinterval(1.0, 2.0)) === bareinterval(0x1aed548f090ceep-53, 1.0)

    @test sin(bareinterval(1.0, 1.0)) === bareinterval(0x1aed548f090ceep-53, 0x1aed548f090cefp-53)

    @test sin(bareinterval(2.0, 7.0)) === bareinterval(-1.0, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(2.0, 6.0)) === bareinterval(-1.0, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(2.0, 5.0)) === bareinterval(-1.0, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(2.0, 4.0)) === bareinterval(-0x1837b9dddc1eafp-53, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(2.0, 3.0)) === bareinterval(0x1210386db6d55bp-55, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(2.0, 2.0)) === bareinterval(0x1d18f6ead1b445p-53, 0x1d18f6ead1b446p-53)

    @test sin(bareinterval(3.0, 7.0)) === bareinterval(-1.0, 0x150608c26d0a09p-53)

    @test sin(bareinterval(3.0, 6.0)) === bareinterval(-1.0, 0x1210386db6d55cp-55)

    @test sin(bareinterval(3.0, 5.0)) === bareinterval(-1.0, 0x1210386db6d55cp-55)

    @test sin(bareinterval(3.0, 4.0)) === bareinterval(-0x1837b9dddc1eafp-53, 0x1210386db6d55cp-55)

    @test sin(bareinterval(3.0, 3.0)) === bareinterval(0x1210386db6d55bp-55, 0x1210386db6d55cp-55)

    @test sin(bareinterval(4.0, 7.0)) === bareinterval(-1.0, 0x150608c26d0a09p-53)

    @test sin(bareinterval(4.0, 6.0)) === bareinterval(-1.0, -0x11e1f18ab0a2c0p-54)

    @test sin(bareinterval(4.0, 5.0)) === bareinterval(-1.0, -0x1837b9dddc1eaep-53)

    @test sin(bareinterval(4.0, 4.0)) === bareinterval(-0x1837b9dddc1eafp-53, -0x1837b9dddc1eaep-53)

    @test sin(bareinterval(5.0, 7.0)) === bareinterval(-0x1eaf81f5e09934p-53, 0x150608c26d0a09p-53)

    @test sin(bareinterval(5.0, 6.0)) === bareinterval(-0x1eaf81f5e09934p-53, -0x11e1f18ab0a2c0p-54)

    @test sin(bareinterval(5.0, 5.0)) === bareinterval(-0x1eaf81f5e09934p-53, -0x1eaf81f5e09933p-53)

    @test sin(bareinterval(6.0, 7.0)) === bareinterval(-0x11e1f18ab0a2c1p-54, 0x150608c26d0a09p-53)

    @test sin(bareinterval(6.0, 6.0)) === bareinterval(-0x11e1f18ab0a2c1p-54, -0x11e1f18ab0a2c0p-54)

    @test sin(bareinterval(7.0, 7.0)) === bareinterval(0x150608c26d0a08p-53, 0x150608c26d0a09p-53)

end

@testset "mpfi_sinh" begin

    @test sinh(bareinterval(-Inf, -7.0)) === bareinterval(-Inf, -0x1122876ba380c9p-43)

    @test sinh(bareinterval(-Inf, 0.0)) === bareinterval(-Inf, 0.0)

    @test sinh(bareinterval(-Inf, +8.0)) === bareinterval(-Inf, 0x1749ea514eca66p-42)

    @test sinh(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test sinh(bareinterval(-1.0, 0.0)) === bareinterval(-0x12cd9fc44eb983p-52, 0.0)

    @test sinh(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test sinh(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x12cd9fc44eb983p-52)

    @test sinh(bareinterval(0.0, +8.0)) === bareinterval(0.0, 0x1749ea514eca66p-42)

    @test sinh(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test sinh(bareinterval(-0.125, 0.0)) === bareinterval(-0x100aaccd00d2f1p-55, 0.0)

    @test sinh(bareinterval(0.0, 0x10000000000001p-53)) === bareinterval(0.0, 0x10acd00fe63b98p-53)

    @test sinh(bareinterval(-4.5, -0.625)) === bareinterval(-0x168062ab5fa9fdp-47, -0x1553e795dc19ccp-53)

    @test sinh(bareinterval(1.0, 3.0)) === bareinterval(0x12cd9fc44eb982p-52, 0x140926e70949aep-49)

end

@testset "mpfi_sqr" begin

    @test pown(bareinterval(-Inf, -7.0), 2) === bareinterval(+49.0, +Inf)

    @test pown(bareinterval(-Inf, 0.0), 2) === bareinterval(0.0, +Inf)

    @test pown(bareinterval(-Inf, +8.0), 2) === bareinterval(0.0, +Inf)

    @test pown(entireinterval(BareInterval{Float64}), 2) === bareinterval(0.0, +Inf)

    @test pown(bareinterval(0.0, 0.0), 2) === bareinterval(0.0, 0.0)

    @test pown(bareinterval(0.0, +8.0), 2) === bareinterval(0.0, +64.0)

    @test pown(bareinterval(0.0, +Inf), 2) === bareinterval(0.0, +Inf)

    @test pown(bareinterval(0x8.6374d8p-4, 0x3.f1d929p+8), 2) === bareinterval(0x4.65df11464764p-4, 0xf.8f918d688891p+16)

    @test pown(bareinterval(0x6.61485c33c0b14p+4, 0x123456p0), 2) === bareinterval(0x2.8b45c3cc03ea6p+12, 0x14b66cb0ce4p0)

    @test pown(bareinterval(-0x1.64722ad2480c9p+0, 0x1p0), 2) === bareinterval(0.0, 0x1.f04dba0302d4dp+0)

    @test pown(bareinterval(0x1.6b079248747a2p+0, 0x2.b041176d263f6p+0), 2) === bareinterval(0x2.02ce7912cddf6p+0, 0x7.3a5dee779527p+0)

end

@testset "mpfi_sqrt" begin

    @test sqrt(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test sqrt(bareinterval(0.0, +9.0)) === bareinterval(0.0, +3.0)

    @test sqrt(bareinterval(0.0, +Inf)) === bareinterval(0.0, +Inf)

    @test sqrt(bareinterval(0xaaa1p0, 0x14b66cb0ce4p0)) === bareinterval(0xd1p0, 0x123456p0)

    @test sqrt(bareinterval(0xe.49ae7969e41bp-4, 0xaaa1p0)) === bareinterval(0xf.1ea42821b27a8p-4, 0xd1p0)

    @test sqrt(bareinterval(0xa.aa1p-4, 0x1.0c348f804c7a9p+0)) === bareinterval(0xd.1p-4, 0x1.06081714eef1dp+0)

    @test sqrt(bareinterval(0xe.49ae7969e41bp-4, 0x1.0c348f804c7a9p+0)) === bareinterval(0xf.1ea42821b27a8p-4, 0x1.06081714eef1dp+0)

end

@testset "mpfi_sub" begin

    @test -(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === bareinterval(-Inf, -6.0)

    @test -(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(-Inf, -8.0)

    @test -(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(-Inf, +8.0)

    @test -(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(+7.0, +Inf)

    @test -(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(0.0, +15.0)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(-8.0, 0.0)

    @test -(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(-8.0, +Inf)

    @test -(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(-Inf, -8.0)

    @test -(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === bareinterval(-8.0, +15.0)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test -(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(-8.0, +Inf)

    @test -(bareinterval(-5.0, 59.0), bareinterval(17.0, 81.0)) === bareinterval(-86.0, 42.0)

    @test -(bareinterval(-0x1p-300, 0x123456p+28), bareinterval(-0x789abcdp0, 0x10000000000000p-93)) === bareinterval(-0x10000000000001p-93, 0x123456789abcdp0)

    @test -(bareinterval(-4.0, 7.0), bareinterval(-3e300, 0x123456789abcdp-17)) === bareinterval(-0x123456791abcdp-17, 0x8f596b3002c1bp+947)

    @test -(bareinterval(-0x1000100010001p+8, 0x1p+60), bareinterval(-3e300, 0x1000100010001p0)) === bareinterval(-0x10101010101011p+4, 0x8f596b3002c1bp+947)

    @test -(bareinterval(-5.0, 1.0), bareinterval(1.0, 0x1p+70)) === bareinterval(-0x10000000000001p+18, 0.0)

    @test -(bareinterval(5.0, 0x1p+70), bareinterval(3.0, 5.0)) === bareinterval(0.0, 0x1p+70)

end

@testset "mpfi_sub_d" begin

    @test -(bareinterval(-Inf, -7.0), bareinterval(-0x170ef54646d497p-107, -0x170ef54646d497p-107)) === bareinterval(-Inf, -0x1bffffffffffffp-50)

    @test -(bareinterval(-Inf, -7.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, -7.0)

    @test -(bareinterval(-Inf, -7.0), bareinterval(0x170ef54646d497p-107, 0x170ef54646d497p-107)) === bareinterval(-Inf, -7.0)

    @test -(bareinterval(-Inf, 0.0), bareinterval(-0x170ef54646d497p-106, -0x170ef54646d497p-106)) === bareinterval(-Inf, 0x170ef54646d497p-106)

    @test -(bareinterval(-Inf, 0.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, 0.0)

    @test -(bareinterval(-Inf, 0.0), bareinterval(0x170ef54646d497p-106, 0x170ef54646d497p-106)) === bareinterval(-Inf, -8.0e-17)

    @test -(bareinterval(-Inf, 8.0), bareinterval(-0x16345785d8a00000p0, -0x16345785d8a00000p0)) === bareinterval(-Inf, 0x16345785d8a00100p0)

    @test -(bareinterval(-Inf, 8.0), bareinterval(0.0, 0.0)) === bareinterval(-Inf, 8.0)

    @test -(bareinterval(-Inf, 8.0), bareinterval(0x16345785d8a00000p0, 0x16345785d8a00000p0)) === bareinterval(-Inf, -0x16345785d89fff00p0)

    @test -(entireinterval(BareInterval{Float64}), bareinterval(-0x170ef54646d497p-105, -0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), bareinterval(0.0e-17, 0.0e-17)) === entireinterval(BareInterval{Float64})

    @test -(entireinterval(BareInterval{Float64}), bareinterval(+0x170ef54646d497p-105, +0x170ef54646d497p-105)) === entireinterval(BareInterval{Float64})

    @test -(bareinterval(0.0, 0.0), bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)) === bareinterval(+0x170ef54646d497p-109, +0x170ef54646d497p-109)

    @test -(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test -(bareinterval(0.0, 0.0), bareinterval(0x170ef54646d497p-109, 0x170ef54646d497p-109)) === bareinterval(-0x170ef54646d497p-109, -0x170ef54646d497p-109)

    @test -(bareinterval(0.0, 8.0), bareinterval(-0x114b37f4b51f71p-107, -0x114b37f4b51f71p-107)) === bareinterval(0x114b37f4b51f71p-107, 0x10000000000001p-49)

    @test -(bareinterval(0.0, 8.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 8.0)

    @test -(bareinterval(0.0, 8.0), bareinterval(0x114b37f4b51f71p-107, 0x114b37f4b51f71p-107)) === bareinterval(-0x114b37f4b51f71p-107, 8.0)

    @test -(bareinterval(0.0, +Inf), bareinterval(-0x50b45a75f7e81p-104, -0x50b45a75f7e81p-104)) === bareinterval(0x50b45a75f7e81p-104, +Inf)

    @test -(bareinterval(0.0, +Inf), bareinterval(0.0, 0.0)) === bareinterval(0.0, +Inf)

    @test -(bareinterval(0.0, +Inf), bareinterval(0x142d169d7dfa03p-106, 0x142d169d7dfa03p-106)) === bareinterval(-0x142d169d7dfa03p-106, +Inf)

    @test -(bareinterval(-32.0, -17.0), bareinterval(0xfb53d14aa9c2fp-47, 0xfb53d14aa9c2fp-47)) === bareinterval(-0x1fb53d14aa9c2fp-47, -0x18353d14aa9c2fp-47)

    @test -(bareinterval(-0xfb53d14aa9c2fp-47, -17.0), bareinterval(-0xfb53d14aa9c2fp-47, -0xfb53d14aa9c2fp-47)) === bareinterval(0.0, 0x7353d14aa9c2fp-47)

    @test -(bareinterval(-32.0, -0xfb53d14aa9c2fp-48), bareinterval(-0xfb53d14aa9c2fp-48, -0xfb53d14aa9c2fp-48)) === bareinterval(-0x104ac2eb5563d1p-48, 0.0)

    @test -(bareinterval(0x123456789abcdfp-48, 0x123456789abcdfp-4), bareinterval(-3.5, -3.5)) === bareinterval(0x15b456789abcdfp-48, 0x123456789abd17p-4)

    @test -(bareinterval(0x123456789abcdfp-56, 0x123456789abcdfp-4), bareinterval(-3.5, -3.5)) === bareinterval(0x3923456789abcdp-52, 0x123456789abd17p-4)

    @test -(bareinterval(-0xffp0, 0x123456789abcdfp-52), bareinterval(-256.5, -256.5)) === bareinterval(0x18p-4, 0x101a3456789abdp-44)

    @test -(bareinterval(-0x1fffffffffffffp-52, -0x1p-550), bareinterval(-4097.5, -4097.5)) === bareinterval(0xfff8p-4, 0x10018p-4)

    @test -(bareinterval(0x123456789abcdfp-48, 0x123456789abcdfp-4), bareinterval(3.5, 3.5)) === bareinterval(0xeb456789abcdfp-48, 0x123456789abca7p-4)

    @test -(bareinterval(0x123456789abcdfp-56, 0x123456789abcdfp-4), bareinterval(3.5, 3.5)) === bareinterval(-0x36dcba98765434p-52, 0x123456789abca7p-4)

    @test -(bareinterval(-0xffp0, 0x123456789abcdfp-52), bareinterval(256.5, 256.5)) === bareinterval(-0x1ff8p-4, -0xff5cba9876543p-44)

    @test -(bareinterval(-0x1fffffffffffffp-52, -0x1p-550), bareinterval(4097.5, 4097.5)) === bareinterval(-0x10038p-4, -0x10018p-4)

end

@testset "mpfi_tan" begin

    @test tan(bareinterval(-Inf, -7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-Inf, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-Inf, +8.0)) === entireinterval(BareInterval{Float64})

    @test tan(entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 0.0)) === bareinterval(-0x18eb245cbee3a6p-52, 0.0)

    @test tan(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test tan(bareinterval(0.0, +1.0)) === bareinterval(0.0, 0x18eb245cbee3a6p-52)

    @test tan(bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0.125, 17.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(0x1921fb54442d18p-52, 0x1921fb54442d19p-52)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, -0.5)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.5, 0.625)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, -0.25)) === bareinterval(-0x18eb245cbee3a6p-52, -0x105785a43c4c55p-54)

    @test tan(bareinterval(-0.5, 0.5)) === bareinterval(-0x117b4f5bf3474bp-53, 0x117b4f5bf3474bp-53)

    @test tan(bareinterval(0x71p+76, 0x71p+76)) === bareinterval(-0x1c8dc87ddcc134p-55, -0x1c8dc87ddcc133p-55)

    @test tan(bareinterval(-7.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, -4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-7.0, -5.0)) === bareinterval(-0x1be2e6e13eea79p-53, 0x1b0b4b739bbb07p-51)

    @test tan(bareinterval(-7.0, -6.0)) === bareinterval(-0x1be2e6e13eea79p-53, 0x129fd86ebb95bfp-54)

    @test tan(bareinterval(-7.0, -7.0)) === bareinterval(-0x1be2e6e13eea79p-53, -0x1be2e6e13eea78p-53)

    @test tan(bareinterval(-6.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, -4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-6.0, -5.0)) === bareinterval(0x129fd86ebb95bep-54, 0x1b0b4b739bbb07p-51)

    @test tan(bareinterval(-6.0, -6.0)) === bareinterval(0x129fd86ebb95bep-54, 0x129fd86ebb95bfp-54)

    @test tan(bareinterval(-5.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, -2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, -3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, -4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-5.0, -5.0)) === bareinterval(0x1b0b4b739bbb06p-51, 0x1b0b4b739bbb07p-51)

    @test tan(bareinterval(-4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-4.0, -2.0)) === bareinterval(-0x12866f9be4de14p-52, 0x117af62e0950f9p-51)

    @test tan(bareinterval(-4.0, -3.0)) === bareinterval(-0x12866f9be4de14p-52, 0x123ef71254b870p-55)

    @test tan(bareinterval(-4.0, -4.0)) === bareinterval(-0x12866f9be4de14p-52, -0x12866f9be4de13p-52)

    @test tan(bareinterval(-3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-3.0, -2.0)) === bareinterval(0x123ef71254b86fp-55, 0x117af62e0950f9p-51)

    @test tan(bareinterval(-3.0, -3.0)) === bareinterval(0x123ef71254b86fp-55, 0x123ef71254b870p-55)

    @test tan(bareinterval(-2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, 0.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, -1.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-2.0, -2.0)) === bareinterval(0x117af62e0950f8p-51, 0x117af62e0950f9p-51)

    @test tan(bareinterval(-1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(-1.0, 1.0)) === bareinterval(-0x18eb245cbee3a6p-52, 0x18eb245cbee3a6p-52)

    @test tan(bareinterval(-1.0, 0.0)) === bareinterval(-0x18eb245cbee3a6p-52, 0.0)

    @test tan(bareinterval(-1.0, -1.0)) === bareinterval(-0x18eb245cbee3a6p-52, -0x18eb245cbee3a5p-52)

    @test tan(bareinterval(1.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 4.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 3.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 2.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(1.0, 1.0)) === bareinterval(0x18eb245cbee3a5p-52, 0x18eb245cbee3a6p-52)

    @test tan(bareinterval(2.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(2.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(2.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(2.0, 4.0)) === bareinterval(-0x117af62e0950f9p-51, 0x12866f9be4de14p-52)

    @test tan(bareinterval(2.0, 3.0)) === bareinterval(-0x117af62e0950f9p-51, -0x123ef71254b86fp-55)

    @test tan(bareinterval(2.0, 2.0)) === bareinterval(-0x117af62e0950f9p-51, -0x117af62e0950f8p-51)

    @test tan(bareinterval(3.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(3.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(3.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(3.0, 4.0)) === bareinterval(-0x123ef71254b870p-55, 0x12866f9be4de14p-52)

    @test tan(bareinterval(3.0, 3.0)) === bareinterval(-0x123ef71254b870p-55, -0x123ef71254b86fp-55)

    @test tan(bareinterval(4.0, 7.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(4.0, 6.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(4.0, 5.0)) === entireinterval(BareInterval{Float64})

    @test tan(bareinterval(4.0, 4.0)) === bareinterval(0x12866f9be4de13p-52, 0x12866f9be4de14p-52)

    @test tan(bareinterval(5.0, 7.0)) === bareinterval(-0x1b0b4b739bbb07p-51, 0x1be2e6e13eea79p-53)

    @test tan(bareinterval(5.0, 6.0)) === bareinterval(-0x1b0b4b739bbb07p-51, -0x129fd86ebb95bep-54)

    @test tan(bareinterval(5.0, 5.0)) === bareinterval(-0x1b0b4b739bbb07p-51, -0x1b0b4b739bbb06p-51)

    @test tan(bareinterval(6.0, 7.0)) === bareinterval(-0x129fd86ebb95bfp-54, 0x1be2e6e13eea79p-53)

    @test tan(bareinterval(6.0, 6.0)) === bareinterval(-0x129fd86ebb95bfp-54, -0x129fd86ebb95bep-54)

    @test tan(bareinterval(7.0, 7.0)) === bareinterval(0x1be2e6e13eea78p-53, 0x1be2e6e13eea79p-53)

end

@testset "mpfi_tanh" begin

    @test tanh(bareinterval(-Inf, -7.0)) === bareinterval(-1.0, -0x1ffffc832750f1p-53)

    @test tanh(bareinterval(-Inf, 0.0)) === bareinterval(-1.0, 0.0)

    @test tanh(bareinterval(-Inf, 8.0)) === bareinterval(-1.0, 0x1fffff872a91f9p-53)

    @test tanh(entireinterval(BareInterval{Float64})) === bareinterval(-1.0, +1.0)

    @test tanh(bareinterval(-1.0, 0.0)) === bareinterval(-0x185efab514f395p-53, 0.0)

    @test tanh(bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test tanh(bareinterval(0.0, 1.0)) === bareinterval(0.0, 0x185efab514f395p-53)

    @test tanh(bareinterval(0.0, 8.0)) === bareinterval(0.0, 0x1fffff872a91f9p-53)

    @test tanh(bareinterval(0.0, +Inf)) === bareinterval(0.0, +1.0)

    @test tanh(bareinterval(-0.125, 0.0)) === bareinterval(-0x1fd5992bc4b835p-56, 0.0)

    @test tanh(bareinterval(0.0, 0x10000000000001p-53)) === bareinterval(0.0, 0x1d9353d7568af5p-54)

    @test tanh(bareinterval(-4.5, -0.625)) === bareinterval(-0x1ffdfa72153984p-53, -0x11bf47eabb8f95p-53)

    @test tanh(bareinterval(1.0, 3.0)) === bareinterval(0x185efab514f394p-53, 0x1fd77d111a0b00p-53)

    @test tanh(bareinterval(17.0, 18.0)) === bareinterval(0x1fffffffffffe1p-53, 0x1ffffffffffffcp-53)

end

@testset "mpfi_union" begin

    @test hull(bareinterval(-Inf, -7.0), bareinterval(-1.0, +8.0)) === bareinterval(-Inf, +8.0)

    @test hull(bareinterval(-Inf, 0.0), bareinterval(+8.0, +Inf)) === entireinterval(BareInterval{Float64})

    @test hull(bareinterval(-Inf, +8.0), bareinterval(0.0, +8.0)) === bareinterval(-Inf, +8.0)

    @test hull(entireinterval(BareInterval{Float64}), bareinterval(0.0, +8.0)) === entireinterval(BareInterval{Float64})

    @test hull(bareinterval(0.0, 0.0), bareinterval(-Inf, -7.0)) === bareinterval(-Inf, 0.0)

    @test hull(bareinterval(0.0, +8.0), bareinterval(-7.0, 0.0)) === bareinterval(-7.0, +8.0)

    @test hull(bareinterval(0.0, 0.0), bareinterval(0.0, +8.0)) === bareinterval(0.0, +8.0)

    @test hull(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test hull(bareinterval(0.0, 0.0), bareinterval(+8.0, +Inf)) === bareinterval(0.0, +Inf)

    @test hull(bareinterval(0.0, 0.0), entireinterval(BareInterval{Float64})) === entireinterval(BareInterval{Float64})

    @test hull(bareinterval(0.0, +8.0), bareinterval(-7.0, +8.0)) === bareinterval(-7.0, +8.0)

    @test hull(bareinterval(0.0, 0.0), bareinterval(0.0, 0.0)) === bareinterval(0.0, 0.0)

    @test hull(bareinterval(0.0, +Inf), bareinterval(0.0, +8.0)) === bareinterval(0.0, +Inf)

    @test hull(bareinterval(0x12p0, 0x90p0), bareinterval(-0x0dp0, 0x34p0)) === bareinterval(-0x0dp0, 0x90p0)

end
