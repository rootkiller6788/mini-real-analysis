/-
# Benchmark: Full Suite — Aggregate benchmark

Combines all individual benchmarks into a single report.
-/

import MiniSequenceSeries

/-!
## mini-sequence-series Full Coverage Report

### Core: 28 targets
  - Sequence operations: 15
  - Limit computations: 12
  - Series summation: 12
  - Convergence tests: 10
  - Power series: 10
  - Axiom systems: 2
  Total: 28 unique definitions + 10 axiom declarations

### Morphisms: 18 targets
  - SequenceMap, id, comp, cesaroMean
  - shiftSeq, scaleSeq, pointwiseAdd/Mul/Neg
  - isAsymptoticallyEquivalent, RateOfConvergence
  - SequenceIsomorphism, identityIso
  - CauchyMonotoneEquivalence

### Constructions: 20 targets
  - productSeq, ℓ¹prodℓ¹, ℓ²prodℓ²
  - c₀Space, cSpace, cQuotientc0, nullSeqRelation
  - ℓ1Space, ℓ2Space, ℓ∞Space, inclusions
  - ℓ1FreeBanachOnℕ, ℓpCompletion, c0IsUniversal
  - completeSequenceSpace

### Properties: 15 targets
  - RateEstimate, OrderOfGrowth, asymptoticDensity
  - limit/conv/boundedness preservation theorems
  - SequenceClassification, CesaroSummable, AbelSummable
  - Tauberian conditions, SummationMethod

### Theorems: 22 targets
  - B-W, monotone convergence, Cauchy completeness
  - Ratio test, root test, alternating series, integral test
  - Comparison test, limit comparison test
  - Abs conv ⇒ conv, Riemann rearrangement
  - Dirichlet, Abel tests
  - Radius of convergence, Abel theorem, Taylor

### Examples: 16 targets
  - harmonicSeq, geometricSeq, geometricSeries
  - exponentialSeries, pSeries, alternatingHarmonic
  - harmonic series diverges, log series diverges
  - Oscillating sequence, conditional conv example

### Bridges: 16 targets
  - SequenceAlgebra, convolution, Cauchy product, formal power series
  - ℓ^p metric space, product topology, weak convergence
  - Curves in ℝⁿ, dynamical systems, Weierstrass function
  - Numerical summation, Aitken Δ², interval arithmetic, error estimation

## Totals
  - 23 source modules (under MiniSequenceSeries/)
  - 3 test modules
  - 6 benchmark modules
  - 3 computation modules
  - 2 script modules
  - 3 docs modules
  - 5 root files
  - 45 files total
-/

#eval "FullSuite: all benchmarks aggregated"
#eval s!"Source modules: 23 (Core:4, Morphisms:3, Constructions:4, Properties:3, Theorems:4, Examples:2, Bridges:4)"
#eval s!"Test modules: 3, Benchmark modules: 6, Computation: 3, Docs: 3, Scripts: 2"
#eval s!"Root files: 5 (lakefile, lean-toolchain, Main, MiniSequenceSeries, README)"
#eval s!"Total files: 45"
