/-
# Benchmark: Jacobian Bench

Coverage benchmark for Jacobians, Hessians, and multivariable calculus.
-/

import MiniDifferentiation

/-!
## Jacobian Benchmarks — 10 targets

[x] partialDerivative f i a                       | Core/Basic
[x] directionalDerivative f v a                   | Core/Basic
[x] gradient f a                                   | Core/Basic
[x] jacobianMatrix f a                             | Core/Basic
[x] Hessian structure                              | Properties/Invariants
[x] MultivariableHessian                           | Properties/Invariants
[x] MorseIndex                                     | Properties/Invariants
[x] HessianSignature                               | Properties/Invariants
[x] inverseFunctionTheorem1D                       | Theorems/Basic
[x] inverseFunctionTheoremND                       | Theorems/Basic
-/

#eval "JacobianBench: 10 Jacobian targets, 10 done, 100%"
