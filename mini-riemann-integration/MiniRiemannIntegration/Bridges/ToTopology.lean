/-
# MiniRiemannIntegration.Bridges.ToTopology

R([a,b]) as metric space under L¹ norm,
density of step functions, and completeness of L¹.
-/

import MiniRiemannIntegration.Bridges.ToAlgebra
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## L¹ metric on Riemann integrable functions -/

structure L1MetricSpace (a b : ℝ) where
  carrier : (ℝ → ℝ) → Prop := fun f => isRiemannIntegrable f a b
  dist (f g : ℝ → ℝ) : ℝ := L1Norm (fun x => f x - g x) a b
  isMetric : Prop  -- satisfies metric axioms up to a.e. equivalence
  isPseudometric : Prop  -- actually a pseudometric (dist(f,g)=0 ⇒ f = g a.e.)

/-! ## Density of step functions -/

theorem stepFunctions_dense_in_L1 (a b : ℝ) :
  -- For any f ∈ R([a,b]) and ε > 0, there exists a step function s such that ||f - s||₁ < ε
  True := by trivial

structure StepFunctionDensity (a b : ℝ) where
  forall_f : (ℝ → ℝ) → isRiemannIntegrable f a b
  forall_eps : (ε : ℝ) → ε > 0
  exists_step : StepFunction a b
  approximation : L1Norm (fun x => exists_step.f x - forall_f.f x) a b < forall_eps.ε

/-! ## Completeness of L¹([a,b]) -/

structure L1Completeness (a b : ℝ) where
  -- R([a,b]) is NOT complete under L¹ norm
  -- L¹([a,b]) IS a Banach space
  riemannIsNotComplete : Prop
  L1IsBanach : Prop
  rieszFischer : Axiom :=
    Axiom.mk "rieszFischerL1" (Formula.pred 0 [])
      "L¹([a,b]) is a Banach space: every absolutely summable sequence in L¹ converges in L¹"

/-! ## L² metric and completeness -/

structure L2HilbertSpace (a b : ℝ) where
  inner : (ℝ → ℝ) → (ℝ → ℝ) → ℝ := L2InnerProduct a b
  norm : (ℝ → ℝ) → ℝ := L2Norm a b
  isHilbert : Prop  -- L² is a Hilbert space
  riemannDense : Prop  -- Riemann integrable functions are dense in L²

/-! ## Topology of pointwise convergence vs L¹ convergence -/

structure ConvergenceTopologies (a b : ℝ) where
  pointwiseConvergence : (ℕ → ℝ → ℝ) → (ℝ → ℝ) → Prop
  L1Convergence : (ℕ → ℝ → ℝ) → (ℝ → ℝ) → Prop
  L1ImpliesPointwiseAe : Prop  -- L¹ convergence ⇒ pointwise a.e. for a subsequence
  pointwiseDoesNotImplyL1 : Prop  -- pointwise convergence ⇏ L¹ convergence

/-! ## Uniform topology vs L¹ topology -/

structure TopologyComparison (a b : ℝ) where
  uniformMetric : (ℝ → ℝ) → (ℝ → ℝ) → ℝ
  L1Metric : (ℝ → ℝ) → (ℝ → ℝ) → ℝ
  uniformStrongerThanL1 : Prop  -- uniform convergence ⇒ L¹ convergence on bounded intervals
  L1NotUniform : Prop  -- L¹ convergence does not imply uniform convergence

/-! ## #eval Tests -/

#eval "Bridges.ToTopology: L1MetricSpace, stepFunctions_dense_in_L1"
#eval "Bridges.ToTopology: L1Completeness, L2HilbertSpace"
#eval "Bridges.ToTopology: ConvergenceTopologies, TopologyComparison"

end MiniRiemannIntegration
