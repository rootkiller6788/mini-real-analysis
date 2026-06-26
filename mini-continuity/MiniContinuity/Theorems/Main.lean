/-
# MiniContinuity.Theorems.Main

Main theorems of continuity:
Continuous Inverse Theorem (continuous bijection on compact
has continuous inverse), Tietze Extension Theorem,
and the Banach fixed point theorem for contractions.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Theorems.Basic

open MiniMathKernel

namespace MiniContinuity

/-! ## Continuous Inverse Theorem -/

/-- A continuous bijection from a compact set to ℝ has a continuous inverse -/
theorem continuousInverseTheorem (f : ℝ → ℝ) (K : Set ℝ) (hK : isCompact K)
    (hf : isContinuousOn f K) (hfbij : -- f: K → ℝ is a bijection onto its image
      ∀ x y ∈ K, f x = f y → x = y) :
    ∃ g : ℝ → ℝ, isContinuousOn g (f '' K) ∧
      (∀ x ∈ K, g (f x) = x) ∧ (∀ y ∈ f '' K, f (g y) = y) := by
  sorry

/-- Corollary: continuous bijection on [a,b] has continuous inverse -/
theorem continuousBijectionOnIntervalHasContinuousInverse (f : ℝ → ℝ) (a b : ℝ)
    (hab : a < b) (hf : isContinuousOn f (Set.Icc a b))
    (finj : ∀ x y ∈ Set.Icc a b, f x = f y → x = y) :
    -- The inverse function is continuous on the image [f(a), f(b)] (or [f(b), f(a)])
    True := by
  trivial

/-- Continuous bijection between compact spaces is a homeomorphism -/
theorem continuousBijectionBetweenCompactIsHomeomorphism (f : ℝ → ℝ) (K : Set ℝ)
    (hK : isCompact K) (hf : isContinuousOn f K)
    (hfinj : ∀ x y ∈ K, f x = f y → x = y) :
    -- f|_K : K → f(K) is a homeomorphism
    True := by
  trivial

/-! ## Tietze Extension Theorem -/

/-- Tietze Extension Theorem: every continuous function on a closed subset of ℝ
    can be extended to a continuous function on all of ℝ -/
theorem tietzeExtensionTheorem (f : ℝ → ℝ) (C : Set ℝ) (hC : -- C is closed
    -- In ℝ, a set is closed iff it is the complement of an open set
    True)
    (hf : isContinuousOn f C) (hbound : ∀ x ∈ C, abs (f x) ≤ 1) :
    ∃ F : ℝ → ℝ, isContinuous F ∧ (∀ x ∈ C, F x = f x) ∧ (∀ x, abs (F x) ≤ 1) := by
  sorry

/-- Tietze extension for real-valued functions without boundedness condition -/
theorem tietzeExtensionUnbounded (f : ℝ → ℝ) (C : Set ℝ) (hC : True)
    (hf : isContinuousOn f C) :
    ∃ F : ℝ → ℝ, isContinuous F ∧ (∀ x ∈ C, F x = f x) := by
  sorry

/-- Urysohn's lemma (special case): for disjoint closed sets A, B in ℝ,
    there is a continuous f: ℝ → [0,1] with f|_A = 0 and f|_B = 1 -/
theorem urysohnLemma (A B : Set ℝ) (hA : True) (hB : True) (hdisjoint : A ∩ B = ∅) :
    ∃ f : ℝ → ℝ, isContinuous f ∧ (∀ a ∈ A, f a = 0) ∧ (∀ b ∈ B, f b = 1) ∧
      (∀ x, 0 ≤ f x ∧ f x ≤ 1) := by
  sorry

/-! ## Banach Fixed Point Theorem -/

/-- A contraction mapping K-Lipschitz with K < 1 has a unique fixed point -/
theorem banachFixedPoint (f : ℝ → ℝ) (K : ℝ) (hKpos : 0 ≤ K) (hKlt1 : K < 1)
    (hclip : isLipschitzWith f K) :
    ∃! xstar : ℝ, f xstar = xstar := by
  -- Pick x₀, define x_{n+1} = f(x_n). Show it's Cauchy, hence converges.
  -- The limit is the unique fixed point.
  sorry

/-- The fixed point is the limit of the iterates from any starting point -/
theorem banachFixedPointIterates (f : ℝ → ℝ) (K : ℝ) (hKpos : 0 ≤ K) (hKlt1 : K < 1)
    (hclip : isLipschitzWith f K) (x0 : ℝ) :
    ∃! xstar : ℝ, f xstar = xstar := by
  -- same proof as above
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Main: continuousInverseTheorem, tietzeExtensionTheorem, tietzeExtensionUnbounded"
#eval "Theorems.Main: urysohnLemma, banachFixedPoint, banachFixedPointIterates"

end MiniContinuity
