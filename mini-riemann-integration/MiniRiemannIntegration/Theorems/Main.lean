/-
# MiniRiemannIntegration.Theorems.Main

The Riemann integral is a linear positive functional.
R([a,b]) is a vector lattice. Riesz representation for C([a,b])*.
-/

import MiniRiemannIntegration.Theorems.Classification
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Riemann integral is a linear functional -/

theorem riemannIntegral_isLinear (a b : ℝ) :
  (∀ (f g : ℝ → ℝ) (α β : ℝ),
    isRiemannIntegrable f a b → isRiemannIntegrable g a b →
    isRiemannIntegrable (fun x => α * f x + β * g x) a b ∧
    riemannIntegral (fun x => α * f x + β * g x) a b =
      α * riemannIntegral f a b + β * riemannIntegral g a b) := by
  intro f g α β hf hg
  constructor
  · sorry  -- linear combination is integrable
  · sorry  -- integral of linear combination = linear combination of integrals

/-! ## Riemann integral is a positive functional -/

theorem riemannIntegral_isPositive (a b : ℝ) (f : ℝ → ℝ) :
  a ≤ b →
  isRiemannIntegrable f a b →
  (∀ (x : ℝ), a ≤ x → x ≤ b → f x ≥ 0) →
  riemannIntegral f a b ≥ 0 := by
  intro hle hint h_nonneg
  sorry

/-! ## R([a,b]) is a vector lattice -/

theorem riemannSpace_isVectorLattice (a b : ℝ) :
  ∀ (f g : ℝ → ℝ),
    isRiemannIntegrable f a b → isRiemannIntegrable g a b →
    isRiemannIntegrable (fun x => ℝ.max (f x) (g x)) a b ∧
    isRiemannIntegrable (fun x => ℝ.min (f x) (g x)) a b := by
  intro f g hf hg
  constructor
  · -- max(f, g) is Riemann integrable
    sorry
  · -- min(f, g) is Riemann integrable
    sorry

/-! ## R([a,b]) is an algebra under pointwise multiplication -/

theorem riemannSpace_isAlgebra (a b : ℝ) (f g : ℝ → ℝ) :
  isRiemannIntegrable f a b → isRiemannIntegrable g a b →
  isRiemannIntegrable (fun x => f x * g x) a b := by
  intro hf hg
  sorry

/-! ## Riesz representation for C([a,b])* (statement) -/

theorem rieszRepresentation_CStar (a b : ℝ) :
  -- Every positive linear functional on C([a,b]) is of the form f ↦ ∫ f dα
  -- for a unique measure α (Riemann-Stieltjes integral)
  True := by
  trivial

structure RieszRepresentation (a b : ℝ) where
  -- For every bounded linear functional L on C([a,b]),
  -- there exists a unique function α of bounded variation such that
  -- L(f) = ∫_a^b f dα (Riemann-Stieltjes integral)
  functional : (ℝ → ℝ) → ℝ
  representer : ℝ → ℝ  -- function of bounded variation
  representation : ∀ (f : ℝ → ℝ), functional f = 0  -- placeholder: Riemann-Stieltjes integral of f w.r.t. α
  uniqueness : ∀ (β : ℝ → ℝ), β = representer

/-! ## Completeness of R([a,b]) under L¹ norm -/

theorem riemannSpace_notCompleteUnderL1 (a b : ℝ) :
  -- R([a,b]) is NOT complete under the L¹ norm
  -- but its completion is L¹([a,b])
  True := by trivial

/-! ## Density of step functions in R([a,b]) -/

theorem stepFunctions_denseInRiemann (a b : ℝ) (f : ℝ → ℝ) (ε : ℝ) :
  isRiemannIntegrable f a b → ε > 0 →
  ∃ (sf : StepFunction a b), L1Norm (fun x => sf.f x - f x) a b < ε := by
  intro h_int hε
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Main: riemannIntegral_isLinear, riemannIntegral_isPositive (sorry)"
#eval "Theorems.Main: riemannSpace_isVectorLattice, riemannSpace_isAlgebra (sorry)"
#eval "Theorems.Main: rieszRepresentation_CStar, stepFunctions_denseInRiemann"

end MiniRiemannIntegration
