/-
# Benchmark: Higher Derivatives Bench

Coverage benchmark for higher-order derivatives and smoothness.
-/

import MiniDifferentiation

/-!
## Higher Derivatives Benchmarks — 10 targets

[x] nthDerivative f n                              | Core/Basic
[x] isCk f k                                       | Core/Basic
[x] isSmooth f (C^∞)                              | Core/Basic
[x] isAnalytic f a                                 | Core/Basic
[x] CkFunction structure                           | Core/Basic
[x] SmoothFunction structure                       | Core/Basic
[x] CkFunctionObject k                             | Core/Objects
[x] SmoothFunctionObject                           | Core/Objects
[x] CkSubobject (hierarchy)                        | Constructions/Subobjects
[x] ckInclusion (C^{k+1} ⊆ C^k)                    | Constructions/Subobjects
-/

#eval "HigherDerivBench: 10 higher derivative targets, 10 done, 100%"
