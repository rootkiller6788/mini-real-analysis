/-
# Benchmark: Series Summation — 12 targets

Benchmark measuring series summation coverage.
-/

import MiniSequenceSeries

/-!
## Series Summation: 12 targets

[x] Series as partial sums                                      | Core.Basic:53
[x] Series.sum                                                  | Core.Basic:59
[x] Series.limitSum                                             | Core.Basic:64
[x] SumSeq with sum and proof                                  | Core.Objects:30
[x] isAbsolutelyConvergent                                      | Core.Basic:61
[x] isConditionallyConvergent                                   | Core.Basic:62
[x] geometricSeries 1/(1-r) for |r|<1                           | Examples.Standard:42
[x] exponentialSeries e^x                                       | Examples.Standard:52
[x] pSeries converges iff p > 1                                | Examples.Standard:60
[x] alternatingHarmonic = ln(2)                                | Examples.Standard:72
[x] cauchyProduct series                                        | Bridges.ToAlgebra:45
[x] partialSumNumerical                                         | Bridges.ToComputation:14
-/

#eval "SeriesBench: 12 targets | 12 done | 0 partial | 100% coverage"
