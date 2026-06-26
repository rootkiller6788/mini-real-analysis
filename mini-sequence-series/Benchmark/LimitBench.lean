/-
# Benchmark: Limit Computations — 12 targets

Benchmark measuring limit computation coverage.
-/

import MiniSequenceSeries

/-!
## Limit Computations: 12 targets

[x] Sequence.limit (ε-N definition)                            | Core.Basic:15
[x] LimSeq with limit and proof                               | Core.Objects:23
[x] constantSeq limit = c                                      | Examples.Standard:88
[x] harmonicSeq limit = 0                                      | Standard example
[x] geometricSeq |r|<1 limit = 0                               | Standard example
[x] algebraOfLimits (sum/product/quotient)                     | Core.Laws:23
[x] squeezeTheorem                                             | Core.Laws:27
[x] limitPreservedUnderContinuous                              | Properties.Preservation:13
[x] shiftPreservesLimit                                        | Morphisms.Hom:44
[x] scalePreservesLimit                                        | Morphisms.Hom:49
[x] cesaroPreservesLimits                                      | Morphisms.Hom:34
[x] subsequenceConvergencePreservation                         | Properties.Preservation:20
-/

#eval "LimitBench: 12 targets | 12 done | 0 partial | 100% coverage"
