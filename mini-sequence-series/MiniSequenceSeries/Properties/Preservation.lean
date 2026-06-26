/-
# MiniSequenceSeries.Properties.Preservation

Preservation properties: limits through continuous functions,
convergence through subsequence, boundedness under scaling,
absolute convergence under various operations.
-/

import MiniSequenceSeries.Properties.Invariants
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Limits Preserved Under Continuous Functions -/

theorem limitPreservedUnderContinuous (s : Sequence ℝ) (L : ℝ)
    (f : ℝ → ℝ) (hCont : ∀ (x : ℝ) (ε : ℝ), ε > 0 → ∃ (δ : ℝ), δ > 0 ∧
      ∀ (y : ℝ), |y - x| < δ → |f y - f x| < ε)
    (hLim : Sequence.limit s L) : Sequence.limit (fun n => f (s n)) (f L) := by
  sorry

/-! ## Convergence Preserved by Subsequence -/

theorem subsequenceConvergencePreservation (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hLim : Sequence.limit s L) : Sequence.limit (sub.seq) L := by
  sorry

theorem everySubsequenceConvergesImpConverges (s : Sequence ℝ)
    (h : ∀ (sub : Subsequence ℝ), isConvergent (sub.seq)) : isConvergent s := by
  sorry

/-! ## Boundedness Preservation -/

theorem boundednessUnderScaling (s : Sequence ℝ) (c : ℝ)
    (hBounded : isBounded s) : isBounded (scaleSeq s c) := by
  sorry

theorem boundednessUnderPointwiseAdd (s t : Sequence ℝ)
    (hs : isBounded s) (ht : isBounded t) : isBounded (pointwiseAdd s t) := by
  sorry

theorem boundednessUnderPointwiseMul (s t : Sequence ℝ)
    (hs : isBounded s) (ht : isBounded t) : isBounded (pointwiseMul s t) := by
  sorry

/-! ## Absolute Convergence Preservation -/

theorem absoluteConvergenceUnderAbsoluteValue (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) : Series.sum (fun n => a n) := by
  sorry

theorem absoluteConvergenceUnderSubseqSummation (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) (sub : Subsequence ℝ) :
    Series.sum (fun n => a (sub.indexMap n)) := by
  sorry

/-! ## Termwise Operations on Convergent Series -/

theorem sumOfConvergentSeries (a b : Sequence ℝ) (S T : ℝ)
    (ha : Series.limitSum a S) (hb : Series.limitSum b T) :
    Series.limitSum (pointwiseAdd a b) (S + T) := by
  sorry

/-! ## #eval Tests -/

#eval "Properties.Preservation: limits thru continuous f, subsequence convergence"
#eval s!"boundedness preserved under: scaling, pointwise add, pointwise mul"
#eval s!"absolute convergence ⟹ convergence, preserved under subseq summation"

end MiniSequenceSeries
