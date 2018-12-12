macro interval_function(expr)
    # Keep track of the original definition of the function
    base_expr = deepcopy(expr)

    funcdef = expr.args[1]

    has_where = funcdef.head == :where

    if !has_where
        # Wrap in a dummy `where` expression to always have the same structure
        funcdef = Expr(:where, funcdef, :DUMMY)
    end

    set_funcdef = deepcopy(funcdef)
    realset_funcdef = deepcopy(funcdef)
    pseudo_funcdef = deepcopy(funcdef)

    func = funcdef.args[1]
    set_func = set_funcdef.args[1]
    realset_func = realset_funcdef.args[1]
    pseudo_func = pseudo_funcdef.args[1]

    outargs = func.args[2:end]  # Arguments for the returned function
    set_args = set_func.args[2:end]
    realset_args = realset_func.args[2:end]
    pseudo_args = pseudo_func.args[2:end]

    for (k, arg) in enumerate(outargs)
        if !isa(arg, Symbol) && arg.head == :(::)
            var = arg.args[1]
            targ = arg.args[2]

            # Change arguments of type BaseInterval to interval wrappers
            # and call the base function with `x.interval` for argument `x`
            if targ == :BaseInterval
                set_args[k].args[2] = :SetInterval
                realset_args[k].args[2] = :RealSetInterval
                pseudo_args[k].args[2] = :PseudoNumberInterval

                outargs[k] = Expr(:(.), var, QuoteNode(:interval))

            elseif isa(targ, Expr) && targ.head == :curly
                if targ.args[1] == :BaseInterval
                    set_args[k].args[2].args[1] = :SetInterval
                    realset_args[k].args[2].args[1] = :RealSetInterval
                    pseudo_args[k].args[2].args[1] = :PseudoNumberInterval

                    outargs[k] = Expr(:(.), var, QuoteNode(:interval))
                end
            else
                outargs[k] = var
            end
        end
    end

    # Revert the dummy `where` syntax
    if !has_where
        set_funcdef = set_funcdef.args[1]
        realset_funcdef = realset_funcdef.args[1]
        pseudo_funcdef = pseudo_funcdef.args[1]
    end

    set_body = deepcopy(func)
    realset_body = deepcopy(func)
    pseudo_body = deepcopy(func)

    set_body.args[2:end] = outargs
    realset_body.args[2:end] = outargs
    pseudo_body.args[2:end] = outargs

    set_body = Expr(:call, :adapt_result, :SetInterval, "# TODO", set_body)
    realset_body = Expr(:call, :adapt_result, :RealSetInterval, "# TODO", realset_body)
    pseudo_body = Expr(:call, :adapt_result, :PseudoNumberInterval, "# TODO", pseudo_body)

    set_def = Expr(:(=), set_funcdef, set_body)
    realset_def = Expr(:(=), realset_funcdef, realset_body)
    pseudo_def = Expr(:(=), pseudo_funcdef, pseudo_body)

    return quote
        $(esc(base_expr))

        $(esc(set_def))

        $(esc(realset_def))

        $(esc(pseudo_def))
    end
end
