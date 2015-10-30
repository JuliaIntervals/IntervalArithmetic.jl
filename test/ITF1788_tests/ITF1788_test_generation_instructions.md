This folder contains Julia output files from the ITF1788 test suite, which tests conformance with the IEEE 1788-2015 Standard on interval arithmetic.
The complete test suite is available at

https://github.com/oheim/ITF1788

See `NOTICE` for the copyright notice and `LICENSE` for the license for the `ITF1788` package.

To generate the tests, clone the ITF1788 package and change to the directory.
Then use Python 3 to create the Julia tests with the command

    python3 -m itf1788 -c "(julia, *, *)"

The resulting test files are generated in the `output/julia/FactCheck/ValidatedNumerics/` subdirectory.
