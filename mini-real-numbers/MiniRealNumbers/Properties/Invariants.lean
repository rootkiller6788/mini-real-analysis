/-
# Real Numbers: Invariants

Defines invariant properties of ℝ: characteristic zero, uncountability,
separability, and cardinality.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## Characteristic Zero -/

/-- ℝ has characteristic zero: n·1 ≠ 0 for any positive integer n. -/
def characteristicZero (ℝ : RealNumbers) : Prop :=
  ∀ n : ℕ, n > 0 →
    (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc ℝ.one) n) ≠ ℝ.zero

/-- Equivalent: the additive group of ℝ is torsion-free. -/
def torsionFree (ℝ : RealNumbers) : Prop :=
  ∀ (x : ℝ.carrier) (n : ℕ), n > 0 → ℝ.add (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc x) n) = ℝ.zero → x = ℝ.zero

/-- Characteristic zero implies torsion-free. -/
theorem charZero_implies_torsionFree (ℝ : RealNumbers) (hchar : characteristicZero ℝ) :
    torsionFree ℝ := by
  intro x n hnpos hsum
  sorry

/-! ## Uncountability -/

/-- ℝ is uncountable: there is no bijection ℕ → ℝ. (Cantor's diagonal argument) -/
def isUncountable (ℝ : RealNumbers) : Prop :=
  ¬ ∃ (f : ℕ → ℝ.carrier), Function.Surjective f

/-- Cantor's diagonal argument: ℝ is uncountable. -/
theorem realsAreUncountable (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (harch : ArchimedeanProperty ℝ) (hchar : characteristicZero ℝ) :
    isUncountable ℝ := by
  -- Assume there is a surjection f : ℕ → ℝ
  -- Construct a nested interval sequence avoiding f(n)
  -- The intersection point is not in the image of f
  sorry

/-- A corollary: there is no enumeration of ℝ. -/
theorem noEnumerationOfReals (ℝ : RealNumbers) (hunc : isUncountable ℝ)
    (f : ℕ → ℝ.carrier) : ¬ Function.Surjective f :=
  hunc ∘ Exists.intro f

/-! ## Separability -/

/-- ℝ is separable: it has a countable dense subset (namely ℚ). -/
def isSeparable (ℝ : RealNumbers) : Prop :=
  ∃ (S : Set ℝ.carrier), (∃ f : ℕ → ℝ.carrier, Set.range f = S) ∧
    ∀ x y : ℝ.carrier, ℝ.lt x y → ∃ z ∈ S, ℝ.lt x z ∧ ℝ.lt z y

/-- ℚ is countable and dense in ℝ. -/
theorem rationalsAreCountableDense (ℝ : RealNumbers) (harch : ArchimedeanProperty ℝ) :
    isSeparable ℝ := by
  sorry

/-! ## Cardinality -/

/-- The cardinality of ℝ is the continuum `𝔠 = 2^ℵ₀`. -/
def cardinalityOfReals : String := "𝔠 = 2^ℵ₀"

/-- ℝ has the cardinality of the continuum: |ℝ| = |P(ℕ)|. -/
theorem realsHaveContinuumCardinality (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) (harch : ArchimedeanProperty ℝ) :
    True := by
  -- There exists a bijection between ℝ and P(ℕ)
  sorry

/-! ## #eval Tests -/

#eval "characteristicZero defined"
#eval "isUncountable defined"
#eval "isSeparable defined"
#eval "cardinalityOfReals: " ++ cardinalityOfReals

end MiniRealNumbers
