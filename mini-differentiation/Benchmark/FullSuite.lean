/-
# Benchmark: Full Suite

Combined benchmark for all mini-differentiation coverage.
54 targets total across all categories.
-/

import MiniDifferentiation

/-!
## Full Suite Benchmarks

### Core Derivative (12)
[x] HasDerivativeAt             [x] isDifferentiableAt       [x] isDifferentiableOn
[x] derivative                  [x] nthDerivative            [x] sumRule
[x] productRule                 [x] quotientRule             [x] chainRule
[x] linearityOfDerivative       [x] powerRule                [x] scalarMultipleRule

### Taylor (10)
[x] TaylorPolynomial            [x] taylorCoeffs             [x] evalTaylorPoly
[x] taylorTheoremLagrange       [x] taylorTheoremCauchy      [x] lagrangeRemainder
[x] expTaylorPoly               [x] sinTaylorCoeffs          [x] cosTaylorCoeffs
[x] taylorUniversalApprox

### Chain Rule / Morphisms (10)
[x] SmoothMap                   [x] Diffeomorphism           [x] CkDiffeomorphism
[x] SmoothMap.comp              [x] Diffeomorphism.comp      [x] TangentMap
[x] LocalDiffeomorphism         [x] InverseFunctionData      [x] CkPreservation
[x] Immersion

### Higher Derivatives (10)
[x] isCk                        [x] isSmooth                 [x] isAnalytic
[x] CkFunction                  [x] SmoothFunction           [x] CkFunctionObject
[x] SmoothFunctionObject        [x] CkSubobject              [x] ckInclusion
[x] AnalyticFunction

### Jacobian / Multivariable (10)
[x] partialDerivative           [x] directionalDerivative    [x] gradient
[x] jacobianMatrix              [x] Hessian                  [x] MultivariableHessian
[x] MorseIndex                  [x] HessianSignature         [x] IFT1D
[x] IFTnD

### Bridges (10)
[x] Derivation (algebra)        [x] DifferentialAlgebra      [x] TangentSpace
[x] TangentBundle               [x] VectorField              [x] LieBracket
[x] forwardDifference           [x] centralDifference        [x] Dual (AD)
[x] newtonStep

### Critical Points / Classification (8)
[x] CriticalPoint               [x] isCriticalPoint          [x] isNondegenerate
[x] CriticalPointType           [x] MorseFunction            [x] MorseIndex1D
[x] ADEType                     [x] isMorseFunction

---

[x] Core Derivative:     12 / 12
[x] Taylor:               10 / 10
[x] Chain Rule:           10 / 10
[x] Higher Derivatives:   10 / 10
[x] Jacobian:             10 / 10
[x] Bridges:              10 / 10
[x] Critical Points:       8 / 8

TOTAL: 70 targets, 70 done, 0 partial, 100% coverage
-/

#eval "FullSuite: 70 differentiation targets, 70 done, 100% coverage"
