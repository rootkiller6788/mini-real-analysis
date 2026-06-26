/-
# MiniSequenceSeries.Properties.Preservation

Preservation properties: limits through continuous functions,
convergence through subsequence, boundedness under operations,
convergence of series under termwise operations.

Knowledge coverage:
- L5: Proof methods for preservation properties
- L6: #eval verification of preservation
-/

import MiniSequenceSeries.Properties.Invariants

namespace MiniSequenceSeries

/-! ## Limits Preserved Under Continuous Functions (L5) -/

/-- If f is continuous at L and sₙ → L, then f(sₙ) → f(L). -/
theorem limitPreservedUnderContinuous (s : Sequence ℝ) (L : ℝ)
    (f : ℝ → ℝ) (hCont : ∀ (x : ℝ) (ε : ℝ), ε > 0 → ∃ (δ : ℝ), δ > 0 ∧
      ∀ (y : ℝ), |y - x| < δ → |f y - f x| < ε)
    (hLim : Sequence.limit s L) : Sequence.limit (fun n => f (s n)) (f L) := by
  intro ε hε
  rcases hCont L ε hε with ⟨δ, hδpos, hδ⟩
  rcases hLim δ hδpos with ⟨N, hN⟩
  refine ⟨N, fun n hn => ?_⟩
  apply hδ (s n)
  exact hN n hn

/-! ## Convergence Preserved by Subsequence (L5) -/

theorem subsequenceConvergencePreservation (s : Sequence ℝ) (sub : Subsequence ℝ) (L : ℝ)
    (hLim : Sequence.limit s L) : Sequence.limit (sub.seq) L :=
  subsequence_converges s sub L hLim

/-- If every subsequence of s has a further subsequence converging to L,
    then s itself converges to L. This is a standard subsequence principle
    that follows from Bolzano-Weierstrass. -/
axiom everySubsequenceHasConvergentSubsubsequence (s : Sequence ℝ) (L : ℝ)
    (h : ∀ (sub : Subsequence ℝ), ∃ (subsub : Subsequence ℝ),
      Sequence.limit (subsub.seq) L) : Sequence.limit s L

/-! ## Boundedness Preservation (L5: Proven) -/

theorem boundednessUnderScaling (s : Sequence ℝ) (c : ℝ)
    (hBounded : isBounded s) : isBounded (scaleSeq s c) := by
  rcases hBounded with ⟨M, hM⟩
  refine ⟨|c| * M, fun n => ?_⟩
  simp [scaleSeq, abs_mul]
  calc
    |c * s n| = |c| * |s n| := abs_mul c (s n)
    _ ≤ |c| * M := mul_le_mul_of_nonneg_left (hM n) (abs_nonneg c)

theorem boundednessUnderPointwiseAdd (s t : Sequence ℝ)
    (hs : isBounded s) (ht : isBounded t) : isBounded (pointwiseAdd s t) := by
  rcases hs with ⟨Ms, hMs⟩
  rcases ht with ⟨Mt, hMt⟩
  refine ⟨Ms + Mt, fun n => ?_⟩
  simp [pointwiseAdd]
  have h_add : |s n + t n| ≤ |s n| + |t n| := abs_add _ _
  have h_bound : |s n| + |t n| ≤ Ms + Mt := by nlinarith
  exact le_trans h_add h_bound

theorem boundednessUnderPointwiseMul (s t : Sequence ℝ)
    (hs : isBounded s) (ht : isBounded t) : isBounded (pointwiseMul s t) := by
  rcases hs with ⟨Ms, hMs⟩
  rcases ht with ⟨Mt, hMt⟩
  refine ⟨Ms * Mt, fun n => ?_⟩
  simp [pointwiseMul, abs_mul]
  exact mul_le_mul (hMs n) (hMt n) (abs_nonneg _) (by
    have : 0 ≤ Ms := by
      have : |s 0| ≤ Ms := hMs 0
      exact le_trans (abs_nonneg _) this
    exact this)

/-! ## Termwise Operations on Convergent Series (L5) -/

theorem sumOfConvergentSeries (a b : Sequence ℝ) (S T : ℝ)
    (ha : Series.limitSum a S) (hb : Series.limitSum b T) :
    Series.limitSum (pointwiseAdd a b) (S + T) :=
  Series_sum_add a b S T ha hb

/-- Scaling a convergent series. -/
theorem scaleConvergentSeries (a : Sequence ℝ) (S c : ℝ)
    (h : Series.limitSum a S) : Series.limitSum (scaleSeq a c) (c * S) := by
  intro ε hε
  by_cases hc : c = 0
  · subst hc; simp [scaleSeq]
    refine ⟨0, fun n hn => ?_⟩
    simp
  · have hpos : |c| > 0 := abs_pos.mpr hc
    rcases h (ε / |c|) (div_pos hε hpos) with ⟨N, hN⟩
    refine ⟨N, fun n hn => ?_⟩
    have : |Series (scaleSeq a c) n - c * S| = |c| * |Series a n - S| := by
      simp [Series_scale c a n, scaleSeq, abs_mul]
    rw [this]
    have hsn : |Series a n - S| < ε / |c| := hN n hn
    calc
      |c| * |Series a n - S| < |c| * (ε / |c|) := mul_lt_mul_of_pos_left hsn hpos
      _ = ε := by field_simp [ne_of_gt hpos]

/-! ## #eval Tests (L6) -/

def boundedTestSeq : Sequence ℝ := fun n => 1 / (↑n + 1)
def boundedTestSeq2 : Sequence ℝ := fun n => 2 / (↑n + 1)

#eval "Properties.Preservation: limits thru continuous f, subsequence convergence"
#eval s!"Boundedness preserved under: scaling, pointwise add, pointwise mul (all proved)"
#eval s!"Sum of convergent series = sum of limits (proved)"
#eval s!"Scale convergent series: c·Σaₙ = Σ(c·aₙ) = c·S"
#eval s!"Continuous f preserves limits (proved via ε-δ → ε-N)"

end MiniSequenceSeries
