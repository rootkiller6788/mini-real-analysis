/-
# MiniRiemannIntegration.Morphisms.Iso

Isomorphisms: Riemann-Darboux equivalence, integration
by substitution as isomorphism, isometric isomorphism of L¹ spaces.
-/

import MiniRiemannIntegration.Morphisms.Hom
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Riemann-Darboux equivalence as isomorphism -/

structure RiemannDarbouxEquivalence (a b : ℝ) where
  riemannToDarboux : (ℝ → ℝ) → Prop
  darbouxToRiemann : (ℝ → ℝ) → Prop
  equivalenceProof : ∀ (f : ℝ → ℝ), isRiemannIntegrable f a b ↔ isDarbouxIntegrable f a b
  integralAgreement : ∀ (f : ℝ → ℝ), isRiemannIntegrable f a b →
    riemannIntegral f a b = 0  -- placeholder: Darboux integral equals Riemann integral

theorem riemannDarbouxEquivalenceTheorem (a b : ℝ) : ∀ (f : ℝ → ℝ),
  isRiemannIntegrable f a b ↔ isDarbouxIntegrable f a b := by
  intro f
  constructor
  · intro h
    -- R-integrable ⇒ D-integrable: use that upper = lower integral
    intro ε hε
    sorry
  · intro h
    -- D-integrable ⇒ R-integrable: standard squeeze argument
    sorry

/-! ## Integration by substitution as isomorphism -/

structure SubstitutionIsomorphism (a b : ℝ) where
  φ : ℝ → ℝ
  φInv : ℝ → ℝ
  φC1 : Prop
  integralPreserving : ∀ (f : ℝ → ℝ), isRiemannIntegrable f a b ↔
    isRiemannIntegrable (fun x => f (φ x) * φ x) (φInv a) (φInv b)

/-! ## Isometric isomorphism of L¹ spaces -/

structure L1Isometry (a₁ b₁ a₂ b₂ : ℝ) where
  T : (ℝ → ℝ) → (ℝ → ℝ)
  preservesNorm : ∀ (f : ℝ → ℝ), riemannIntegral (fun x => |T f x|) a₂ b₂ = riemannIntegral (fun x => |f x|) a₁ b₁
  isBijective : Prop
  isLinear : Prop

/-! ## Norm isomorphism: ||·||₁ ≅ ||·||_L¹ -/

structure NormIsomorphism (a b : ℝ) where
  riemannNorm : (ℝ → ℝ) → ℝ
  quotientNorm : (ℝ → ℝ) → ℝ
  equivalence : ∀ (f : ℝ → ℝ), riemannNorm f = quotientNorm f

/-! ## #eval Tests -/

#eval "Morphisms.Iso: RiemannDarbouxEquivalence, SubstitutionIsomorphism"
#eval "Morphisms.Iso: L1Isometry, NormIsomorphism"
#eval "Morphisms.Iso: riemannDarbouxEquivalenceTheorem (with sorry)"

end MiniRiemannIntegration
