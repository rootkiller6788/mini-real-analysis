/-
# Benchmark: Taylor Bench

Coverage benchmark for Taylor expansions and approximations.
-/

import MiniDifferentiation

/-!
## Taylor Benchmarks — 10 targets

[x] TaylorPolynomial structure                     | Constructions/Universal
[x] taylorCoeffs helper                            | Constructions/Universal
[x] evalTaylorPoly                                 | Constructions/Universal
[x] taylorTheoremLagrange                          | Theorems/Basic
[x] taylorTheoremCauchy                            | Theorems/Basic
[x] lagrangeRemainder                              | Theorems/Basic
[x] taylorUniversalApproximation                   | Theorems/UniversalProperties
[x] expTaylorPoly                                  | Examples/Standard
[x] sinTaylorCoeffs                                | Examples/Standard
[x] cosTaylorCoeffs                                | Examples/Standard
-/

#eval "TaylorBench: 10 Taylor targets, 10 done, 100%"
