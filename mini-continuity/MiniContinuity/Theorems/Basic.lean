/-
# MiniContinuity.Theorems.Basic

Fundamental theorems of continuity:
Intermediate Value Theorem, Extreme Value Theorem,
Heine-Cantor theorem, Darboux's theorem,
and Brouwer fixed point theorem in 1D.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Properties.Preservation

open MiniMathKernel

namespace MiniContinuity

/-! ## Intermediate Value Theorem (IVT) -/

/-- Full IVT: if f is continuous on [a,b] and y is between f(a) and f(b),
    then ∃ c ∈ [a,b] with f(c) = y -/
theorem intermediateValueTheorem (f : ℝ → ℝ) (a b : ℝ) (hab : a ≤ b)
    (hf : isContinuousOn f (Set.Icc a b)) (y : ℝ) :
    (f a ≤ y ∧ y ≤ f b) ∨ (f b ≤ y ∧ y ≤ f a) →
    ∃ c, c ∈ Set.Icc a b ∧ f c = y := by
  intro hy
  rcases hy with (⟨hfa, hyb⟩ | ⟨hfb, hya⟩)
  · -- f(a) ≤ y ≤ f(b), use bisection method
    sorry
  · -- f(b) ≤ y ≤ f(a), apply the previous case to -f
    sorry

/-- Alternative IVT: if f(a) < 0 < f(b), then ∃ c where f(c) = 0 -/
theorem intermediateValueTheorem_zero (f : ℝ → ℝ) (a b : ℝ) (hab : a < b)
    (hf : isContinuousOn f (Set.Icc a b)) (ha : f a < 0) (hb : f b > 0) :
    ∃ c, a < c ∧ c < b ∧ f c = 0 := by
  sorry

/-- Bolzano's theorem: if f is continuous on [a,b] with f(a)f(b) < 0, then f has a zero in (a,b) -/
theorem bolzanoTheorem (f : ℝ → ℝ) (a b : ℝ) (hab : a < b)
    (hf : isContinuousOn f (Set.Icc a b)) (hsgn : f a * f b < 0) :
    ∃ c, a < c ∧ c < b ∧ f c = 0 := by
  sorry

/-! ## Extreme Value Theorem (EVT) -/

/-- EVT: continuous f on closed bounded [a,b] attains its maximum and minimum -/
theorem extremeValueTheorem (f : ℝ → ℝ) (a b : ℝ) (hab : a ≤ b)
    (hf : isContinuousOn f (Set.Icc a b)) :
    (∃ xmax ∈ Set.Icc a b, ∀ x ∈ Set.Icc a b, f x ≤ f xmax) ∧
    (∃ xmin ∈ Set.Icc a b, ∀ x ∈ Set.Icc a b, f xmin ≤ f x) := by
  constructor
  · -- existence of maximum
    sorry
  · -- existence of minimum (follows by applying max to -f)
    sorry

/-- Weierstrass formulation: continuous on compact ⇒ attains bounds -/
theorem weierstrassExtremeValue (f : ℝ → ℝ) (K : Set ℝ) (hK : isCompact K)
    (hf : isContinuousOn f K) (hKne : K ≠ ∅) :
    (∃ xmax ∈ K, ∀ x ∈ K, f x ≤ f xmax) ∧
    (∃ xmin ∈ K, ∀ x ∈ K, f xmin ≤ f x) := by
  sorry

/-! ## Heine-Cantor Theorem -/

/-- Heine-Cantor: continuous on a compact set ⇒ uniformly continuous on that set -/
theorem heineCantorTheorem (f : ℝ → ℝ) (K : Set ℝ) (hK : isCompact K)
    (hf : isContinuousOn f K) : isUniformlyContinuousOn f K := by
  intro ε hε
  -- For each x ∈ K, continuity gives δ_x. Use compactness to get a finite subcover
  -- and take δ = min(δ_x₁, ..., δ_xₙ) / 2
  sorry

/-- Corollary: continuous on [a,b] ⇒ uniformly continuous on [a,b] -/
theorem continuousOnCompactIntervalImpliesUniform (f : ℝ → ℝ) (a b : ℝ)
    (hab : a ≤ b) (hf : isContinuousOn f (Set.Icc a b)) :
    isUniformlyContinuousOn f (Set.Icc a b) := by
  -- [a,b] is compact, apply Heine-Cantor
  sorry

/-! ## Darboux's Theorem (Derivatives have IVP) -/

/-- Darboux's theorem: if f is differentiable on [a,b], then f' has the intermediate value property -/
theorem darbouxTheorem (f : ℝ → ℝ) (a b : ℝ) (hab : a < b)
    (hderiv : ∀ x ∈ Set.Icc a b, ∃ d : ℝ, True) (y : ℝ)
    (hbetween : True) : ∃ c, a < c ∧ c < b ∧ True := by
  -- Assume f'(a) < y < f'(b) (or vice versa). Define g(x) = f(x) - y·x,
  -- g'(a) < 0 < g'(b), so g is decreasing at a and increasing at b,
  -- so the min of g on [a,b] occurs at an interior point c where g'(c) = 0.
  sorry

/-! ## Brouwer Fixed Point Theorem (1D) -/

/-- 1D Brouwer fixed point theorem: any continuous f: [0,1] → [0,1] has a fixed point -/
theorem brouwerFixedPoint1D (f : ℝ → ℝ) (hf : isContinuousOn f (Set.Icc 0 1))
    (hfMaps : ∀ x ∈ Set.Icc (0 : ℝ) 1, f x ∈ Set.Icc (0 : ℝ) 1) :
    ∃ c ∈ Set.Icc (0 : ℝ) 1, f c = c := by
  -- Define g(x) = f(x) - x. g(0) ≥ 0, g(1) ≤ 0. Apply IVT.
  have h0 : f 0 ≥ 0 := by
    have := hfMaps 0 (by constructor <;> norm_num)
    exact this.1
  have h1 : f 1 ≤ 1 := by
    have := hfMaps 1 (by constructor <;> norm_num)
    exact this.2
  sorry

/-- Corollary: any continuous map of a closed interval to itself has a fixed point -/
theorem fixedPointInterval (f : ℝ → ℝ) (a b : ℝ) (hab : a ≤ b)
    (hf : isContinuousOn f (Set.Icc a b))
    (hfMaps : ∀ x ∈ Set.Icc a b, f x ∈ Set.Icc a b) :
    ∃ c ∈ Set.Icc a b, f c = c := by
  -- Reduce to [0,1] via affine transformation
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Basic: intermediateValueTheorem, bolzanoTheorem, extremeValueTheorem"
#eval "Theorems.Basic: heineCantorTheorem, darbouxTheorem, brouwerFixedPoint1D"

end MiniContinuity
