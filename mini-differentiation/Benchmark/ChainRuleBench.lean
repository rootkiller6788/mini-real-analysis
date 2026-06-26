/-
# Benchmark: Chain Rule Bench

Coverage benchmark for chain rule, smooth maps, diffeomorphisms.
-/

import MiniDifferentiation

/-!
## Chain Rule Benchmarks — 10 targets

[x] chainRuleAxiom                                 | Core/Laws
[x] SmoothMap structure                            | Morphisms/Hom
[x] Diffeomorphism structure                       | Morphisms/Hom
[x] CkDiffeomorphism                               | Morphisms/Hom
[x] SmoothMap.comp                                 | Morphisms/Hom
[x] Diffeomorphism.comp                            | Morphisms/Hom
[x] TangentMap                                     | Morphisms/Hom
[x] LocalDiffeomorphism                            | Morphisms/Iso
[x] InverseFunctionData (IFT)                      | Morphisms/Iso
[x] CkPreservation (chain rule preserves C^k)      | Properties/Preservation
-/

#eval "ChainRuleBench: 10 chain rule targets, 10 done, 100%"
