# LinearAlgebra

Interval matrices support standard linear algebra operations from the `LinearAlgebra`
standard library.

```@repl linearalgebra
using IntervalArithmetic, LinearAlgebra
A = interval.([1.0 0.5; 0.5 2.0], 0.1; format = :midpoint)
```



## Eigenvalues and eigenvectors

The eigenvalues (`eigvals`) and the eigendecomposition (`eigen`) are computed by one of
several algorithms, all subtypes of
[`AbstractIntervalEigenAlg`](@ref IntervalArithmetic.AbstractIntervalEigenAlg), which
can be selected via the `alg` keyword argument:

| Algorithm | `eigvals` | `eigen` |
| :-------- | :-------- | :------ |
| [`IntervalEigen`](@ref IntervalArithmetic.IntervalEigen) (default) | Gershgorin circle theorem intersected with Rohn | contraction mapping theorem, falls back to `eigvals` and NaI eigenvectors |
| [`IntervalEigenContraction`](@ref IntervalArithmetic.IntervalEigenContraction) | contraction mapping theorem | contraction mapping theorem |
| [`IntervalEigenRohn`](@ref IntervalArithmetic.IntervalEigenRohn) | Rohn enclosure | Rohn enclosure, NaI eigenvectors |
| [`IntervalEigenHertz`](@ref IntervalArithmetic.IntervalEigenHertz) | Hertz exact hull (exponential complexity) | Hertz exact hull, NaI eigenvectors |

The Gershgorin circle theorem and the contraction mapping theorem enclose each
eigenvalue individually, but only succeed when the interval radii are small enough.
The Rohn and Hertz methods return a single interval enclosing all the eigenvalues, and
are valid for any interval radius. As neither the Gershgorin circle theorem nor the Rohn
enclosure is always tighter than the other, the default takes their intersection.

```@repl linearalgebra
eigvals(A)
eigen(A)
eigvals(Symmetric(A); alg = IntervalEigenRohn())
eigvals(Symmetric(A); alg = IntervalEigenHertz())
```

When the algorithm fails, the eigenvalues and eigenvectors are NaIs.

```@repl linearalgebra
eigen(interval.([1.0 0.5; 0.5 2.0], 1.0; format = :midpoint); alg = IntervalEigenContraction())
```

A matrix of intervals contains non-symmetric matrices, even if its entries are
symmetric. Use the `Symmetric` and `Hermitian` wrappers to only consider the symmetric
and Hermitian matrices: their eigenvalues are real, and the Rohn and Hertz enclosures
are tighter.

```@repl linearalgebra
eigvals(A; alg = IntervalEigenRohn())
eigvals(Symmetric(A))
```

!!! note
    The matrix functions of `LinearAlgebra` for `Symmetric` and `Hermitian` matrices (e.g.
    `sqrt`, `cos`, `svd`) assume that the eigenvectors are orthonormal and that the
    eigenvalues are accurate up to roundoff errors. They throw an `ArgumentError` for
    interval matrices, except `exp`, `log` and integer powers, which have rigorous
    implementations.
