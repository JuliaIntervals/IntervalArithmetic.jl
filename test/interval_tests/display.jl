setprecision(BigFloat, 256) do
    @testset "Ill-formed interval" begin
       @test sprint(show, MIME("text/plain"), interval(1, -1)) == "NaI"
    end

    @testset "BareInterval" begin
        a = bareinterval(-floatmin(Float64), 1.3)
        large_expo = bareinterval(0, big"1e123456789") # use "small" exponent, cf. JuliaLang/julia#48678


        @testset "Standard format" begin
            setdisplay(:infsup)

            @testset "6 significant digits" begin
                # `decorations` keyword has no impact for `BareInterval`
                setdisplay(; sigdigits = 6, decorations = true)

                @test sprint(show, MIME("text/plain"), emptyinterval(BareInterval{Float64})) == "∅"

                @test sprint(show, MIME("text/plain"), a) == "[-2.22507e-308, 1.3]"
                @test sprint(show, MIME("text/plain"), large_expo) ==
                    "[0.0, 1.0e+123456789]₂₅₆"
            end

            @testset "20 significant digits" begin
                # `decorations` keyword has no impact for `BareInterval`
                setdisplay(; sigdigits = 20, decorations = true)

                @test sprint(show, MIME("text/plain"), a) == "[-2.2250738585072014e-308, 1.3]"
                @test sprint(show, MIME("text/plain"), large_expo) ==
                    "[0.0, 1.0e+123456789]₂₅₆"
            end
        end

        @testset "Full format" begin
            # `decorations` keyword has no impact for `BareInterval`
            # `sigdigits` is not taken into account for format `:full`
            setdisplay(:full; sigdigits = 100, decorations = true)

            @test sprint(show, MIME("text/plain"), emptyinterval(BareInterval{Float64})) == "∅"

            @test sprint(show, MIME("text/plain"), a) == "BareInterval{Float64}(-2.2250738585072014e-308, 1.3)"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "BareInterval{BigFloat}(0.0, $(sup(large_expo)))"
        end

        @testset "Midpoint format" begin
            # `decorations` keyword has no impact for `BareInterval`
            setdisplay(:midpoint; sigdigits = 6, decorations = true)

            @test sprint(show, MIME("text/plain"), emptyinterval(BareInterval{Float64})) == "∅"

            @test sprint(show, MIME("text/plain"), a) == "0.65 ± 0.65"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "(5.0e+123456788 ± 5.0e+123456788)₂₅₆"
        end
    end

    @testset "Interval" begin
        a = interval(1, 2)
        a_NG = a/1
        b = interval(-floatmin(Float64), 1.3)
        b32 = interval(-floatmin(Float32), parse(Float32, "1.3"))
        b16 = interval(-floatmin(Float16), parse(Float16, "1.3"))
        br = interval(Rational{Int64}, -11//10, 13//10)
        c = interval(-1, Inf)
        cr = interval(Rational{Int64}, -1//1, 1//0)
        large_expo = interval(0, big"1e123456789") # use "small" exponent, cf. JuliaLang/julia#48678

        @testset "Standard format" begin
            setdisplay(:infsup)

            @testset "6 significant digits" begin
                setdisplay(; sigdigits = 6)

                @testset "Decorations" begin
                    setdisplay(; decorations = true)

                    @test sprint(show, MIME("text/plain"), emptyinterval()) == "∅_trv"
                    @test sprint(show, MIME("text/plain"), emptyinterval()/1) == "∅_trv_NG"

                    @test sprint(show, MIME("text/plain"), a)    == "[1.0, 2.0]_com"
                    @test sprint(show, MIME("text/plain"), a_NG) == "[1.0, 2.0]_com_NG"
                    @test sprint(show, MIME("text/plain"), b)    == "[-2.22507e-308, 1.3]_com"
                    @test sprint(show, MIME("text/plain"), b32)  == "[-1.17549f-38, 1.3f0]_com"
                    @test sprint(show, MIME("text/plain"), b16)  == "[Float16(-6.104e-5), Float16(1.3)]_com"
                    @test sprint(show, MIME("text/plain"), br)   == "[-11//10, 13//10]_com"
                    @test sprint(show, MIME("text/plain"), c)    == "[-1.0, ∞)_dac"
                    @test sprint(show, MIME("text/plain"), cr)    == "[-1//1, ∞)_dac"
                    @test sprint(show, MIME("text/plain"), large_expo) ==
                        "[0.0, 1.0e+123456789]₂₅₆_com"
                end

                @testset "No decorations" begin
                    setdisplay(; decorations = false)

                    @test sprint(show, MIME("text/plain"), emptyinterval()) == "∅"
                    @test sprint(show, MIME("text/plain"), emptyinterval()/1) == "∅_NG"

                    @test sprint(show, MIME("text/plain"), a)    == "[1.0, 2.0]"
                    @test sprint(show, MIME("text/plain"), a_NG) == "[1.0, 2.0]_NG"
                    @test sprint(show, MIME("text/plain"), b)    == "[-2.22507e-308, 1.3]"
                    @test sprint(show, MIME("text/plain"), b32)  == "[-1.17549f-38, 1.3f0]"
                    @test sprint(show, MIME("text/plain"), b16)  == "[Float16(-6.104e-5), Float16(1.3)]"
                    @test sprint(show, MIME("text/plain"), br)   == "[-11//10, 13//10]"
                    @test sprint(show, MIME("text/plain"), c)    == "[-1.0, ∞)"
                    @test sprint(show, MIME("text/plain"), cr)   == "[-1//1, ∞)"
                    @test sprint(show, MIME("text/plain"), large_expo) ==
                        "[0.0, 1.0e+123456789]₂₅₆"
                end
            end

            @testset "20 significant digits" begin
                setdisplay(; sigdigits = 20, decorations = true)

                @test sprint(show, MIME("text/plain"), a)    == "[1.0, 2.0]_com"
                @test sprint(show, MIME("text/plain"), a_NG) == "[1.0, 2.0]_com_NG"
                @test sprint(show, MIME("text/plain"), b)    == "[-2.2250738585072014e-308, 1.3]_com"
                @test sprint(show, MIME("text/plain"), b32)  == "[-1.1754944f-38, 1.3f0]_com"
                @test sprint(show, MIME("text/plain"), b16)  == "[Float16(-6.104e-5), Float16(1.3)]_com"
                @test sprint(show, MIME("text/plain"), br)   == "[-11//10, 13//10]_com"
                @test sprint(show, MIME("text/plain"), c)    == "[-1.0, ∞)_dac"
                @test sprint(show, MIME("text/plain"), cr)   == "[-1//1, ∞)_dac"
                @test sprint(show, MIME("text/plain"), large_expo) ==
                    "[0.0, 1.0e+123456789]₂₅₆_com"
            end
        end

        @testset "Full format" begin
            # `sigdigits` and `decorations` keywords are not taken into account for format `:full`
            setdisplay(:full; sigdigits = 100, decorations = false)

            @test sprint(show, MIME("text/plain"), emptyinterval()) == "∅"
            @test sprint(show, MIME("text/plain"), emptyinterval()/1) == "∅_NG"

            @test sprint(show, MIME("text/plain"), a)    == "Interval{Float64}(1.0, 2.0, com, true)"
            @test sprint(show, MIME("text/plain"), a_NG) == "Interval{Float64}(1.0, 2.0, com, false)"
            @test sprint(show, MIME("text/plain"), b)    == "Interval{Float64}(-2.2250738585072014e-308, 1.3, com, true)"
            @test sprint(show, MIME("text/plain"), b32)  == "Interval{Float32}(-1.1754944f-38, 1.3f0, com, true)"
            @test sprint(show, MIME("text/plain"), b16)  == "Interval{Float16}(Float16(-6.104e-5), Float16(1.3), com, true)"
            @test sprint(show, MIME("text/plain"), br)   == "Interval{Rational{Int64}}(-11//10, 13//10, com, true)"
            @test sprint(show, MIME("text/plain"), c)    == "Interval{Float64}(-1.0, Inf, dac, true)"
            @test sprint(show, MIME("text/plain"), cr)   == "Interval{Rational{Int64}}(-1//1, 1//0, dac, true)"
            @test sprint(show, MIME("text/plain"), large_expo) ==
                "Interval{BigFloat}(0.0, $(sup(large_expo)), com, true)"
        end

        @testset "Midpoint format" begin
            setdisplay(:midpoint; sigdigits = 6)

            @testset "Decorations" begin
                setdisplay(; decorations = true)

                @test sprint(show, MIME("text/plain"), emptyinterval()) == "∅_trv"
                @test sprint(show, MIME("text/plain"), emptyinterval()/1) == "∅_trv_NG"

                @test sprint(show, MIME("text/plain"), a)    == "(1.5 ± 0.5)_com"
                @test sprint(show, MIME("text/plain"), a_NG) == "(1.5 ± 0.5)_com_NG"
                @test sprint(show, MIME("text/plain"), b)    == "(0.65 ± 0.65)_com"
                @test sprint(show, MIME("text/plain"), b32)  == "(0.65f0 ± 0.65f0)_com"
                @test sprint(show, MIME("text/plain"), b16)  == "(Float16(0.65) ± Float16(0.65))_com"
                @test sprint(show, MIME("text/plain"), br)   == "(1//10 ± 6//5)_com"
                @test sprint(show, MIME("text/plain"), c)    == "(1.79769e+308 ± ∞)_dac"
                @test sprint(show, MIME("text/plain"), cr)   == "(9223372036854775807//1 ± ∞)_dac"
                @test sprint(show, MIME("text/plain"), large_expo) ==
                    "(5.0e+123456788 ± 5.0e+123456788)₂₅₆_com"
            end

            @testset "No decorations" begin
                setdisplay(; decorations = false)

                @test sprint(show, MIME("text/plain"), emptyinterval()) == "∅"
                @test sprint(show, MIME("text/plain"), emptyinterval()/1) == "∅_NG"

                @test sprint(show, MIME("text/plain"), a)    == "1.5 ± 0.5"
                @test sprint(show, MIME("text/plain"), a_NG) == "(1.5 ± 0.5)_NG"
                @test sprint(show, MIME("text/plain"), b)    == "0.65 ± 0.65"
                @test sprint(show, MIME("text/plain"), b32)  == "0.65f0 ± 0.65f0"
                @test sprint(show, MIME("text/plain"), b16)  == "Float16(0.65) ± Float16(0.65)"
                @test sprint(show, MIME("text/plain"), br)   == "1//10 ± 6//5"
                @test sprint(show, MIME("text/plain"), c)    == "1.79769e+308 ± ∞"
                @test sprint(show, MIME("text/plain"), cr)   == "9223372036854775807//1 ± ∞"
                @test sprint(show, MIME("text/plain"), large_expo) ==
                    "(5.0e+123456788 ± 5.0e+123456788)₂₅₆"
            end
        end
    end

    @testset "Complex{<:Interval}" begin
        a = complex(interval(0, 2), interval(1))
        b = complex(interval(0, 2), interval(-1))
        c = complex(interval(0, 1e-70), interval(-1e-70))

        @testset "Standard format" begin
            setdisplay(:infsup)

            @testset "6 significant digits" begin
                setdisplay(; sigdigits = 6)

                @testset "Decorations" begin
                    setdisplay(; decorations = true)

                    @test sprint(show, MIME("text/plain"), a) == "[0.0, 2.0]_com + im*[1.0, 1.0]_com"
                    @test sprint(show, MIME("text/plain"), b) == "[0.0, 2.0]_com - im*[1.0, 1.0]_com"
                    @test sprint(show, MIME("text/plain"), c) == "[0.0, 1.0e-70]_com - im*[1.0e-70, 1.0e-70]_com"
                end

                @testset "No decorations" begin
                    setdisplay(; decorations = false)

                    @test sprint(show, MIME("text/plain"), a) == "[0.0, 2.0] + im*[1.0, 1.0]"
                    @test sprint(show, MIME("text/plain"), b) == "[0.0, 2.0] - im*[1.0, 1.0]"
                    @test sprint(show, MIME("text/plain"), c) == "[0.0, 1.0e-70] - im*[1.0e-70, 1.0e-70]"
                end
            end
        end

        @testset "Full format" begin
            # `sigdigits` and `decorations` keywords are not taken into account for format `:full`
            setdisplay(:full; sigdigits = 100, decorations = false)

            @test sprint(show, MIME("text/plain"), a) == "Interval{Float64}(0.0, 2.0, com, true) + im*Interval{Float64}(1.0, 1.0, com, true)"
            @test sprint(show, MIME("text/plain"), b) == "Interval{Float64}(0.0, 2.0, com, true) - im*Interval{Float64}(1.0, 1.0, com, true)"
            @test sprint(show, MIME("text/plain"), c) == "Interval{Float64}(0.0, 1.0e-70, com, true) - im*Interval{Float64}(1.0e-70, 1.0e-70, com, true)"
        end

        @testset "Midpoint format" begin
            setdisplay(:midpoint; sigdigits = 6)

            @testset "Decorations" begin
                setdisplay(; decorations = true)

                @test sprint(show, MIME("text/plain"), a) == "(1.0 ± 1.0)_com + im*(1.0 ± 0.0)_com"
                @test sprint(show, MIME("text/plain"), b) == "(1.0 ± 1.0)_com - im*(1.0 ± 0.0)_com"
                @test sprint(show, MIME("text/plain"), c) == "(5.0e-71 ± 5.0e-71)_com - im*(1.0e-70 ± 0.0)_com"
            end

            @testset "No decorations" begin
                setdisplay(; decorations = false)

                @test sprint(show, MIME("text/plain"), a) == "(1.0 ± 1.0) + im*(1.0 ± 0.0)"
                @test sprint(show, MIME("text/plain"), b) == "(1.0 ± 1.0) - im*(1.0 ± 0.0)"
                @test sprint(show, MIME("text/plain"), c) == "(5.0e-71 ± 5.0e-71) - im*(1.0e-70 ± 0.0)"
            end
        end
    end

    setdisplay(:infsup; sigdigits = 6, decorations = true) # reset to default display options
end
