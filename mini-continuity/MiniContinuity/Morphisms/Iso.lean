/-
# MiniContinuity.Morphisms.Iso

Isomorphisms in continuity theory: homeomorphisms,
isometries, dilatations, and scaling maps.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Morphisms.Hom

open MiniMathKernel

namespace MiniContinuity

/-! ## Homeomorphism (topological equivalence) -/

/-- Two maps f and g form a homeomorphism pair -/
def isHomeomorphism (f g : ℝ → ℝ) : Prop :=
  (∀ a, isContinuousAt f a) ∧ (∀ a, isContinuousAt g a) ∧
  (∀ x, g (f x) = x) ∧ (∀ x, f (g x) = x)

/-- Spaces are homeomorphic: there exists a homeomorphism between them -/
def areHomeomorphic (X Y : Set ℝ) : Prop :=
  ∃ (f g : ℝ → ℝ), isHomeomorphism f g ∧ (∀ x ∈ X, f x ∈ Y) ∧ (∀ y ∈ Y, g y ∈ X)

/-! ## Isometry (distance-preserving bijection) -/

/-- f is an isometry: preserves distances exactly -/
def isIsometry (f : ℝ → ℝ) : Prop :=
  ∀ x y, dist (f x) (f y) = dist x y

/-- Isometries are bi-Lipschitz with K = 1 -/
theorem isometryIsLipschitz (f : ℝ → ℝ) (h : isIsometry f) : isLipschitzWith f 1 := by
  have hK : (1 : ℝ) ≥ 0 := by norm_num
  refine And.intro hK ?_
  intro x y
  -- from isometry: dist(f x, f y) = dist(x, y) ≤ 1 * dist(x, y)
  have hdist := h x y
  -- hdist gives equality, so inequality follows
  sorry

/-- Isometries are injective -/
theorem isometryIsInjective (f : ℝ → ℝ) (h : isIsometry f) : ∀ x y, f x = f y → x = y := by
  intro x y hxy
  have hdist := h x y
  have : dist (f x) (f y) = 0 := by
    rw [hxy, dist, sub_self, abs_zero]
  rw [this] at hdist
  -- dist x y = 0 → x = y
  sorry

/-- Identity is an isometry -/
def idIsometry : isIsometry (fun x : ℝ => x) := by
  intro x y; rfl

/-- Negation x ↦ -x is an isometry -/
theorem negIsometry : isIsometry (fun x : ℝ => -x) := by
  intro x y
  -- dist(-x, -y) = |-x + y| = |y - x| = dist(x, y)
  sorry

/-! ## Dilatation (scaling map) -/

/-- A λ-dilatation scales distances by factor λ: d(f x, f y) = λ·d(x, y) -/
def isDilatation (f : ℝ → ℝ) (λ : ℝ) : Prop :=
  λ > 0 ∧ ∀ x y, dist (f x) (f y) = λ * dist x y

/-- Scaling x ↦ λ·x is a λ-dilatation -/
theorem scalingIsDilatation (λ : ℝ) (hλ : λ > 0) : isDilatation (fun x => λ * x) λ := by
  refine And.intro hλ ?_
  intro x y
  -- dist(λx, λy) = |λx - λy| = λ|x - y| = λ·dist(x, y)
  sorry

/-- Composition of isometries is an isometry -/
theorem isometryComposition (f g : ℝ → ℝ) (hf : isIsometry f) (hg : isIsometry g) :
    isIsometry (f ∘ g) := by
  intro x y
  -- d(f(g x), f(g y)) = d(g x, g y) = d(x, y)
  rw [hg, hf]

/-! ## Bi-Lipschitz equivalence -/

/-- f is bi-Lipschitz: both f and its inverse are Lipschitz -/
def isBiLipschitz (f : ℝ → ℝ) (K : ℝ) : Prop :=
  K ≥ 1 ∧ isLipschitzWith f K ∧ (∃ g, isLipschitzWith g K ∧ ∀ x, g (f x) = x ∧ f (g x) = x)

/-! ## #eval Tests -/

#eval "Morphisms.Iso: isHomeomorphism, isIsometry, isDilatation, isBiLipschitz"
#eval "Morphisms.Iso: idIsometry, negIsometry, scalingIsDilatation"
#eval "Morphisms.Iso: isometryComposition — composition of isometries is an isometry"

end MiniContinuity
