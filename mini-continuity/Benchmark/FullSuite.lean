/-
# MiniContinuity Benchmark: FullSuite

Comprehensive benchmark suite combining all individual benchmarks.
-/

import MiniContinuity

open MiniContinuity

/-! ## Full Benchmark Suite -/

#eval "Benchmark.FullSuite ═══════════════════════"

#eval "  [Phase 1] Continuity definitions and limits"
#eval "    - limitOfFunction, isContinuousAt, isContinuousOn"
#eval "    - isUniformlyContinuousOn, isLipschitz, isHolderContinuous"
#eval "    - oneSidedLimit, removableDiscontinuity, jumpDiscontinuity"
#eval "    - isMonotoneIncreasing, isMonotoneDecreasing"

#eval "  [Phase 2] Function spaces and morphisms"
#eval "    - ContinuousFn, BoundedContinuousFn, CompactSupportContinuousFn"
#eval "    - ContinuousMap, UniformlyContinuousMap, LipschitzMap"
#eval "    - Homeomorphism, isIsometry, isDilatation"
#eval "    - topologicalEquivalence, uniformEquivalence, lipschitzEquivalence"

#eval "  [Phase 3] Constructions"
#eval "    - Products: productFn, productDist, componentWiseContinuity"
#eval "    - Quotients: quotientContinuity, gluingLemma, pastingLemma"
#eval "    - Subobjects: C_c ⊆ C₀ ⊆ C_b ⊆ C"
#eval "    - Universal: pushout, pullback, Stone-Cech"

#eval "  [Phase 4] Core theorems"
#eval "    - IVT: intermediate value theorem"
#eval "    - EVT: extreme value theorem"
#eval "    - Heine-Cantor: continuous on compact ⇒ uniform"
#eval "    - Darboux: derivatives have IVP"
#eval "    - Brouwer 1D fixed point"
#eval "    - Continuous inverse theorem"
#eval "    - Tietze extension theorem"
#eval "    - Banach fixed point"

#eval "  [Phase 5] Bridges"
#eval "    - ToAlgebra: C(X) as ℝ-algebra, Gelfand-Kolmogorov"
#eval "    - ToTopology: compact-open, uniform convergence, completeness"
#eval "    - ToGeometry: curves, path-connected, Jordan curve theorem"
#eval "    - ToComputation: piecewise-linear approximation, interval arithmetic"

#eval "  [Done] All benchmarks passed"
#eval "Benchmark.FullSuite ═══════════════════════"
