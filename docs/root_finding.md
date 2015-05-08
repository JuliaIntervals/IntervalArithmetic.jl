# Root finding

Interval arithmetic not only provides guaranteed numerical calculations; it also makes possible fundamentally new algorithms.

One such algorithm is the **interval Newton method**. This is a version of the standard Newton (or Newton--Raphson) algorithm for finding roots of equations. The interval version, however, is fundamentally different from its standard counterpart, in that it can (under the best circumstances) provide rigorous *guarantees* about the presence or absence and uniqueness of roots of a given function in a given interval.

## Interval Newton method

The interval Newton method is implementated for real functions of a single variable as the function `newton`.
