/-
# MiniSequenceSeries.Theorems.Classification

Classification results: absolutely convergent ⇒ convergent,
conditionally convergent ⇒ rearrangement can give any sum
(Riemann rearrangement theorem), convergence type hierarchy.
-/

import MiniSequenceSeries.Theorems.Basic
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Absolute Convergence Implies Convergence -/

theorem absoluteConvergenceImpliesConvergence (a : Sequence ℝ) :
    isAbsolutelyConvergent a → Series.sum a := by
  sorry

/-! ## Riemann Rearrangement Theorem -/

theorem riemannRearrangementTheorem (a : Sequence ℝ)
    (hConditional : isConditionallyConvergent a) :
    ∀ (S : ℝ), ∃ (π : Nat → Nat), Function.Bijective π ∧
      Series.limitSum (fun n => a (π n)) S := by
  sorry

theorem rearragementPreservesSumAbsConvergence (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) (π : Nat → Nat) (hBij : Function.Bijective π) (S : ℝ)
    (hSum : Series.limitSum a S) : Series.limitSum (fun n => a (π n)) S := by
  sorry

/-! ## Convergence Type Classification -/

inductive SeriesConvergenceType
  | absolutelyConvergent
  | conditionallyConvergent
  | divergent
deriving BEq, Repr, Inhabited

def classifySeries (a : Sequence ℝ) : SeriesConvergenceType :=
  if isAbsolutelyConvergent a then
    SeriesConvergenceType.absolutelyConvergent
  else if Series.sum a then
    SeriesConvergenceType.conditionallyConvergent
  else
    SeriesConvergenceType.divergent

/-! ## Dirichlet Test -/

theorem dirichletTest (a b : Sequence ℝ)
    (hPartialSumsBounded : isBounded (Series b))
    (hAMonotoneToZero : isMonotone a ∧ Sequence.limit a 0) :
    Series.sum (pointwiseMul a b) := by
  sorry

/-! ## Abel Test -/

theorem abelTest (a b : Sequence ℝ)
    (hAConvergent : Series.sum a)
    (hBMonotoneBounded : isMonotone b ∧ isBounded b) :
    Series.sum (pointwiseMul a b) := by
  sorry

/-! ## Rearrangement of Absolutely Convergent Series -/

theorem absoluteConvergenceRearrangementInvariant (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) (π : Nat → Nat) (hBij : Function.Bijective π) :
    isAbsolutelyConvergent (fun n => a (π n)) := by
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Classification: abs conv ⇒ conv, Riemann rearrangement, Dirichlet, Abel"
#eval s!"SeriesConvergenceType: absolutely, conditionally convergent, divergent"
#eval s!"Riemann: conditionally conv ⟹ can rearrange to any sum"
#eval s!"Absolutely convergent: all rearrangements give same sum"

end MiniSequenceSeries
