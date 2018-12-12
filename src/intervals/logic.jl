import Base: !, &, |, convert
import Base: show

# TODO: Check that both are not false
struct IntervalBool
    can_be_true::Bool
    can_be_false::Bool
end

IntervalBool(b::Bool) = IntervalBool(b, !b)
IntervalBool() = IntervalBool(true, true)

function (&)(b1::IntervalBool, b2::IntervalBool)
    IntervalBool(b1.can_be_true & b2.can_be_true,
                 b1.can_be_false | b2.can_be_false)
end

function (|)(b1::IntervalBool, b2::IntervalBool)
    IntervalBool(b1.can_be_true | b2.can_be_true,
                 b1.can_be_false & b2.can_be_false)
end

!(b::IntervalBool) = IntervalBool(b.can_be_false, b.can_be_true)

function isambiguous(b::IntervalBool)
    b.can_be_true && b.can_be_false && return true
    return false
end

struct AmbiguousError <: Exception
    func_call::AbstractString
end

function Base.showerror(io::IO, err::AmbiguousError)
      print(io, "AmbiguousError: ")
      print(io, "Result to $(err.func_call) is ambiguous.")
  end

function convert(Bool, b::IntervalBool)
    if b.can_be_true
        b.can_be_false && error("Interval valued boolean can be either true" *
                                "or false.")
        return true
    else
        !b.can_be_false && error("Interval valued boolean can be neither true" *
                                 "nor false.")
        return false
    end

end

function show(io::IO, b::IntervalBool)
    if b.can_be_true
        if b.can_be_false
            print(io, "[true, false]")
        else
            print(io, "[true]")
        end
    else
        if b.can_be_false
            print(io, "[false]")
        else
            print(io, "[]")
        end
    end
end
