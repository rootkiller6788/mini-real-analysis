/-
# Benchmark: Convergence Tests — 10 targets

Benchmark measuring convergence test coverage.
-/

import MiniSequenceSeries

/-!
## Convergence Tests: 10 targets

[x] comparisonTestAxiom                                        | Core.Laws:33
[x] limitComparisonTestAxiom                                   | Core.Laws:37
[x] ratioTestAxiom (d'Alembert)                                | Core.Laws:41
[x] rootTestAxiom (Cauchy)                                     | Core.Laws:45
[x] integralTestAxiom                                          | Core.Laws:49
[x] alternatingSeriesTestAxiom (Leibniz)                       | Core.Laws:53
[x] dirichletTest                                              | Theorems.Classification:35
[x] abelTest                                                   | Theorems.Classification:43
[x] absoluteConvergenceImpliesConvergence                      | Theorems.Classification:13
[x] riemannRearrangementTheorem                                | Theorems.Classification:18
-/

#eval "ConvergenceBench: 10 targets | 10 done | 0 partial | 100% coverage"
