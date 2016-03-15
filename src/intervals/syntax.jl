# Syntax for intervals

a..b = @interval(a, b)

macro I_str(ex)  # I"[3,4]"
    @interval(ex)
end
