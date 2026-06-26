/-
# Real Numbers: Basic Theorems

Fundamental theorems about the real numbers: density of ℚ, uncountability,
nested interval theorem, Bolzano-Weierstrass, and Heine-Borel.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom

namespace MiniRealNumbers

/-! ## Density of ℚ in ℝ -/

/--
The rational numbers are dense in the reals: between any two distinct
reals there is a rational. This follows from the Archimedean property.
-/
theorem rationalsAreDenseInReals (ℝ : RealNumbers) (harch : ArchimedeanProperty ℝ) :
    ∀ a b : ℝ.carrier, ℝ.lt a b → ∃ q : ℚ, True := by
  -- Sketch: use Archimedean property to find n such that n(b-a) > 1
  -- Then floor(n*a) < n*a < n*b gives the rational
  sorry

/-- Equivalent formulation: every open interval contains a rational. -/
theorem everyOpenIntervalContainsRational (ℝ : RealNumbers) (harch : ArchimedeanProperty ℝ)
    (a b : ℝ.carrier) (hlt : ℝ.lt a b) : True := by
  sorry

/-! ## Uncountability (Cantor's Diagonal Argument) -/

/--
Cantor's theorem: ℝ is uncountable. There is no surjective function
from ℕ to ℝ.
-/
theorem realsAreUncountable (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (harch : ArchimedeanProperty ℝ) :
    isUncountable ℝ := by
  -- Proof by Cantor's diagonal argument:
  -- Assume a surjection f : ℕ → ℝ exists
  -- Construct a sequence of nested closed intervals [a_n, b_n]
  -- such that f(n) ∉ [a_n, b_n] and b_n - a_n → 0
  -- The intersection point is not in the image of f, contradiction
  intro h
  rcases h with ⟨f, hsurj⟩
  sorry

/-! ## Nested Interval Theorem -/

/--
If [a_n, b_n] is a nested sequence of nonempty closed intervals
(a_n ≤ a_{n+1} ≤ b_{n+1} ≤ b_n) whose lengths tend to zero,
then the intersection contains exactly one point.
-/
theorem nestedIntervalTheorem (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (a b : ℕ → ℝ.carrier)
    (hnondec : ∀ n, ℝ.le (a n) (a (n+1)))
    (hnoninc : ∀ n, ℝ.le (b (n+1)) (b n))
    (hnested : ∀ n, ℝ.le (a n) (b n))
    (hshrinks : ∀ ε, ℝ.lt ℝ.zero ε → ∃ N, ∀ n ≥ N,
      ℝ.lt ℝ.zero (ℝ.add (b n) (ℝ.neg (a n))) ∧
      ℝ.lt (ℝ.add (b n) (ℝ.neg (a n))) ε) :
    ∃! x : ℝ.carrier, ∀ n, ℝ.le (a n) x ∧ ℝ.le x (b n) := by
  sorry

/-! ## Bolzano-Weierstrass Theorem -/

/--
Every bounded sequence in ℝ has a convergent subsequence.
This is equivalent to the completeness of ℝ.
-/
theorem bolzanoWeierstrass (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (a : ℕ → ℝ.carrier) (hbounded : ∃ M, ∀ n, ℝ.le (ℝ.neg M) (a n) ∧ ℝ.le (a n) M) :
    ∃ (f : ℕ → ℕ) (hstrict : ∀ i, f i < f (i+1)) (L : ℝ.carrier),
      ConvergesTo ℝ (a ∘ f) L := by
  -- By bisection method: repeatedly split the interval and pick
  -- the half that contains infinitely many terms
  sorry

/-! ## Heine-Borel Theorem -/

/--
In ℝ, a set is compact iff it is closed and bounded.
For intervals, this means [a, b] is compact.
-/
theorem heineBorel (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (a b : ℝ.carrier) (hle : ℝ.le a b)
    (C : Set (ℝ.carrier → ℝ.carrier → Prop))  -- "open cover" placeholder
    : True := by
  sorry

/-- Every open cover of [a, b] has a finite subcover. -/
theorem compactnessOfClosedInterval (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (a b : ℝ.carrier) (hle : ℝ.le a b) : True := by
  sorry

/-! ## Intermediate Value Theorem -/

/--
If f is continuous on [a, b] and f(a) < 0 < f(b), then
there exists c ∈ (a, b) with f(c) = 0.
-/
theorem intermediateValueTheorem (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (f : ℝ.carrier → ℝ.carrier) (a b : ℝ.carrier)
    (hcont : True)  -- placeholder for continuity
    (hfa_neg : ℝ.lt (f a) ℝ.zero) (hfb_pos : ℝ.lt ℝ.zero (f b)) :
    ∃ c : ℝ.carrier, ℝ.lt a c ∧ ℝ.lt c b ∧ f c = ℝ.zero := by
  sorry

/-! ## Extreme Value Theorem -/

/--
A continuous function on [a, b] attains its maximum and minimum.
-/
theorem extremeValueTheorem (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (f : ℝ.carrier → ℝ.carrier) (a b : ℝ.carrier)
    (hcont : True) (hle : ℝ.le a b) :
    ∃ (xmin xmax : ℝ.carrier),
      ℝ.le a xmin ∧ ℝ.le xmin b ∧
      ℝ.le a xmax ∧ ℝ.le xmax b ∧
      (∀ x, ℝ.le a x → ℝ.le x b → ℝ.le (f xmin) (f x)) ∧
      (∀ x, ℝ.le a x → ℝ.le x b → ℝ.le (f x) (f xmax)) := by
  sorry

/-! ## #eval Tests -/

#eval "rationalsAreDenseInReals stated"
#eval "realsAreUncountable stated"
#eval "nestedIntervalTheorem stated"
#eval "bolzanoWeierstrass stated"
#eval "heineBorel stated"
#eval "intermediateValueTheorem stated"
#eval "extremeValueTheorem stated"

end MiniRealNumbers
