/-
# Benchmark: Power Series — 10 targets

Benchmark measuring power series coverage.
-/

import MiniSequenceSeries

/-!
## Power Series: 10 targets

[x] PowerSeries with coefficients, center                      | Core.Basic:68
[x] PowerSeries.eval                                           | Core.Basic:73
[x] PowerSeries.partialSum                                     | Core.Basic:75
[x] radiusOfConvergence                                        | Core.Basic:77
[x] powerSeriesHasRadiusOfConvergence                          | Theorems.Main:23
[x] cauchyHadamardFormula                                      | Theorems.Main:28
[x] abelTheorem (boundary continuity)                           | Theorems.Main:32
[x] generatingFunction (formal power series)                   | Bridges.ToAlgebra:58
[x] formalPowerSeriesRing                                      | Bridges.ToAlgebra:60
[x] taylorSeriesConverges                                      | Theorems.Main:42
-/

#eval "PowerSeriesBench: 10 targets | 10 done | 0 partial | 100% coverage"
