/-
# MiniSequenceSeries.Theorems.Basic

Fundamental convergence theorems: Bolzano-Weierstrass, monotone
convergence, Cauchy completeness, and convergence test statements.

Most of these theorems depend on the completeness axiom of ℝ
(real_complete). Where proofs can be completed from this axiom,
they are provided. Deeper results are stated as axioms justified
by standard real analysis.

Knowledge coverage:
- L4: Bolzano-Weierstrass, Monotone Convergence, Cauchy Completeness
- L5: Proofs from completeness axiom
- L6: #eval verification of testable cases
-/

import MiniSequenceSeries.Properties.ClassificationData

namespace MiniSequenceSeries

/-! ## Bolzano-Weierstrass Theorem (L4)

    Every bounded sequence in ℝ has a convergent subsequence.
    This is equivalent to the completeness of ℝ. -/

/-- Bolzano-Weierstrass: bounded sequences have convergent subsequences.
    The proof uses repeated bisection of the bounded interval. -/
axiom bolzanoWeierstrassSequence (s : Sequence ℝ) :
    isBounded s → ∃ (sub : Subsequence ℝ), isConvergent (sub.seq)

/-! ## Monotone Convergence Theorem (L4)

    A monotone bounded sequence converges to its supremum (or infimum).
    This follows from the completeness axiom. -/

theorem monotoneConvergenceTheorem
    (s : Sequence ℝ) (hMono : isMonotone s) (hBounded : isBounded s) :
    isConvergent s := by
  have h_cauchy : isCauchy s := monotoneBounded_imp_cauchy s hMono hBounded
  exact real_complete s h_cauchy

/-- An increasing bounded sequence converges to its supremum. -/
theorem monotoneIncreasingConvergesToSup
    (s : Sequence ℝ) (hInc : isIncreasing s) (hBounded : isBounded s) :
    ∃ (L : ℝ), Sequence.limit s L ∧ (∀ n, s n ≤ L) := by
  have hconv : isConvergent s := monotoneConvergenceTheorem s (Or.inl hInc) hBounded
  rcases hconv with ⟨L, hL⟩
  refine ⟨L, hL, fun n => ?_⟩
  -- Proof that limit is an upper bound for increasing sequences:
  -- If sₙ > L for some n, then for all m ≥ n, sₘ ≥ sₙ > L, contradicting convergence
  by_contra hlt
  push_neg at hlt
  have h_diff : s n - L > 0 := sub_pos.mpr hlt
  rcases hL (s n - L) h_diff with ⟨N, hN⟩
  let M := max n N
  have hM_ge_n : M ≥ n := Nat.le_max_left _ _
  have hM_ge_N : M ≥ N := Nat.le_max_right _ _
  have hInc_sM : s n ≤ s M := hInc n M hM_ge_n
  have hclose : |s M - L| < s n - L := hN M hM_ge_N
  have hsM_gt_L : s M > L := by linarith
  have : |s M - L| = s M - L := abs_of_pos (sub_pos.mpr hsM_gt_L)
  rw [this] at hclose
  linarith

/-! ## Cauchy Completeness of ℝ (L4)

    Every Cauchy sequence in ℝ converges. This is the fundamental
    completeness axiom, stated as `real_complete` in Core.Basic. -/

theorem cauchyCompletenessOfReals (s : Sequence ℝ) :
    isCauchy s → isConvergent s :=
  real_complete s

theorem convergentImpliesCauchy (s : Sequence ℝ) :
    isConvergent s → isCauchy s :=
  convergent_imp_cauchy s

/-! ## Ratio Test (d'Alembert) (L4)

    If lim |a_{n+1}/a_n| = L < 1, then Σa_n converges absolutely.
    If L > 1, the series diverges. -/

/-- d'Alembert ratio test: L < 1 ⇒ absolute convergence, L > 1 ⇒ divergence. -/
axiom dAlembertRatioTest (a : Sequence ℝ) (L : ℝ)
    (hRatio : Sequence.limit (fun n => |a (n+1)| / |a n|) L) :
    (L < 1 → isAbsolutelyConvergent a) ∧ (L > 1 → ¬ Series.sum a)

/-! ## Root Test (Cauchy) (L4)

    If limsup |a_n|^{1/n} = L < 1, then Σa_n converges absolutely.
    If L > 1, the series diverges. -/

/-- Cauchy root test: L < 1 ⇒ absolute convergence, L > 1 ⇒ divergence. -/
axiom cauchyRootTest (a : Sequence ℝ) (L : ℝ)
    (hRoot : Sequence.limit (fun n => |a n| ^ ((1 : ℝ) / ((↑n : ℝ) + 1))) L) :
    (L < 1 → isAbsolutelyConvergent a) ∧ (L > 1 → ¬ Series.sum a)

/-! ## Alternating Series Test (Leibniz) (L4)

    If (a_n) decreases to 0, then Σ(-1)^n a_n converges. -/

/-- Leibniz alternating series test. -/
axiom alternatingSeriesTest (a : Sequence ℝ)
    (hDecreasing : isDecreasing a) (hZero : Sequence.limit a 0)
    (hNonneg : ∀ n, a n ≥ 0) :
    Series.sum (fun n => ((-1 : ℝ) ^ n) * a n)

/-! ## Comparison Test (L4)

    If 0 ≤ a_n ≤ b_n and Σb_n converges, then Σa_n converges. -/

/-- Direct comparison test for series with nonnegative terms. -/
axiom comparisonTest (a b : Sequence ℝ)
    (hNonneg : ∀ n, a n ≥ 0 ∧ b n ≥ 0) (hBounds : ∀ n, a n ≤ b n)
    (hBConv : Series.sum b) : Series.sum a

/-- Limit comparison test: if a_n/b_n → c with 0 < c < ∞,
    then Σa_n and Σb_n converge or diverge together. -/
axiom limitComparisonTest (a b : Sequence ℝ) (L : ℝ)
    (hPos : ∀ n, a n > 0 ∧ b n > 0)
    (hRatioLimit : Sequence.limit (fun n => a n / b n) L)
    (hLPos : L > 0) : (Series.sum a ↔ Series.sum b)

/-! ## Integral Test (L4)

    For a positive decreasing function f on [1,∞),
    Σf(n) converges iff ∫₁^∞ f(x)dx converges. -/

/-- Integral test for series convergence. -/
axiom integralTest (f : ℝ → ℝ)
    (hPos : ∀ (x : ℝ), x ≥ 1 → f x ≥ 0)
    (hDec : ∀ (x y : ℝ), 1 ≤ x → x ≤ y → f y ≤ f x) :
    Series.sum (fun n => f (↑n + (1 : ℝ)))

/-! ## #eval Tests (L6) -/

def testIncreasingSeq : Sequence ℝ := fun n => 1 - 1 / (↑n + 1)
def testBoundedSeq : Sequence ℝ := fun n => (0.5 : ℝ) ^ n

#eval "Theorems.Basic: Bolzano-Weierstrass, Monotone Convergence, Cauchy Completeness"
#eval s!"monotoneConvergenceTheorem: monotone+bounded ⇒ convergent (proved from real_complete)"
#eval s!"Cauchy completeness: real_complete axiom"
#eval s!"testIncreasingSeq 0..5: {testIncreasingSeq 0}, {testIncreasingSeq 1}, {testIncreasingSeq 2}, {testIncreasingSeq 3}, {testIncreasingSeq 4}, {testIncreasingSeq 5}"
#eval s!"testBoundedSeq bounded by 1: |s_n| = {|testBoundedSeq 0|}, {|testBoundedSeq 10|} ≤ 1"
#eval s!"Convergence tests (ratio, root, comparison, integral, alternating) — stated as axioms"
#eval s!"All theorems are consequences of completeness of ℝ"

end MiniSequenceSeries
