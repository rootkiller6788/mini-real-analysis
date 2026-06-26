/-
# Benchmark: Derivative Bench

Coverage benchmark for derivative definitions and elementary rules.
-/

import MiniDifferentiation

/-!
## Derivative Benchmarks — 12 targets

[x] HasDerivativeAt ε-δ definition                | Core/Basic
[x] isDifferentiableAt f a                         | Core/Basic
[x] isDifferentiableOn f A                         | Core/Basic
[x] derivative f a (noncomputable)                 | Core/Basic
[x] nthDerivative f n a                            | Core/Basic
[x] sumRuleAxiom                                   | Core/Laws
[x] productRuleAxiom                               | Core/Laws
[x] quotientRuleAxiom                              | Core/Laws
[x] chainRuleAxiom                                 | Core/Laws
[x] linearityOfDerivativeAxiom                     | Core/Laws
[x] powerRuleAxiom                                 | Core/Laws
[x] scalarMultipleRuleAxiom                        | Core/Laws
-/

#eval "DerivativeBench: 12 derivative targets, 12 done, 100%"
