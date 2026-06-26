/-
# Benchmark: Sequence Operations — 15 targets

Benchmark measuring sequence operation coverage.
-/

import MiniSequenceSeries

/-!
## Sequence Operations: 15 targets

[x] Sequence α := ℕ → α                                       | Core.Basic:10
[x] Sequence.eval s n                                          | Core.Basic:11
[x] Sequence.limit s L (ε-N definition)                        | Core.Basic:15
[x] isConvergent s                                             | Core.Basic:19
[x] isBounded s                                                | Core.Basic:21
[x] isMonotone, isIncreasing, isDecreasing                     | Core.Basic:26-34
[x] isStrictlyIncreasing, isStrictlyDecreasing                 | Core.Basic:36-41
[x] Subsequence with indexMap, isStrictlyIncreasingProof        | Core.Basic:45-48
[x] Series as sequence of partial sums                         | Core.Basic:53-56
[x] Series.sum, Series.limitSum                                | Core.Basic:59,64
[x] isAbsolutelyConvergent, isConditionallyConvergent           | Core.Basic:61-62
[x] PowerSeries with coefficients, center, eval                | Core.Basic:68-75
[x] radiusOfConvergence                                        | Core.Basic:77
[x] isCauchy (Cauchy criterion)                                | Core.Basic:81
[x] divergesToPosInf/NegInf, isOscillatory                     | Core.Basic:85-91
-/

#eval "SeqOps: 15 targets | 15 done | 0 partial | 100% coverage"
