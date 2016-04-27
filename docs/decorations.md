# Decorations:

Decorations are flags or labels attached to intervals to indicate the status of a given interval as the product of a function evaluation on a given initial interval.

The possible decorations and their ordering are as follows (pg. 46):
`com` > `dac` > `def` > `trv` > `ill`.


- `com` ("common"): The meanings are (pg. 44): x is a bounded, nonempty subset of Dom(f); f is
continuous at each point of x; and the computed interval f(x) is bounded.
x is a nonempty subset of Dom(f), and the restriction of f to x is continuous;

- `dac` ("defined & continuous"): x is a nonempty subset of Dom(f), and the
restriction of f to x is continuous;

- `def` ("defined"): x is a nonempty subset of Dom(f), i.e. f is defined at each point of x

- `trv` ("trivial"): always true; gives no information

- `ill` ("ill-formed"): Not an Interval (an error occurred), e.g. Dom(f) = empty

## Initialisation
Each decorated interval is initialised with a decoration according to the status of its interval `x` (pg. 46 of the standard):

- `com`: if `x` is nonempty and bounded;
- `dac` if `x` is unbounded;
- `trv` if `x` is empty.


## Action of functions

A decoration is the combination of an interval together with the sequence of functions that it has passed through.

As an example, consider the `sqrt` function acting on an interval `x`.

If `x` is empty, then `sqrt` will return the, empty interval, together with the trivial decoration.

If `x` is [a, Inf] with a > 0 (`dac`), then `sqrt(x)` will return `[sqrt(a), Inf]`, so is also unbounded, and so will return (`[sqrt(a), Inf], dac`).

The domain of `sqrt` is `D := Dom(sqrt) = [0, Inf]`. We must first check if
`x ⊆ D`. If so, then the `sqrt` function is continuous and bounded on that interval, so we return `min(`com`, decoration(x))`,  where `decoration(x)` is the decoration of `x`.

E.g. consider the `sign` function:
sign(x) = 1, if x > 0; sign(x) = 0 if x = 0; sign(x) = -1 if x < 0

This function is defined for all x in R, but is not continuous at 0. Thus if the interval contains 0, the decoration that results cannot be better than `def`.
Thus `sqrt(sign([0,10]))` will return `([0,1], def)`, where the decoration is only `def`, indicating that we cannot guarantee that the function `sqrt ∘ sign` is continuous on the interval. (In fact, we know that it is not continuous, but this is not guaranteed by the decoration.)
