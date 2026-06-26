/-
# Constructions: Quotients

Quotients by uniform equivalence, C(X)/c₀ type quotients,
and Banach space quotients of function spaces.
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Morphisms.Iso

namespace MiniFunctionSequences

/-! ## Quotient by Uniform Equivalence -/

/-- The quotient of function sequences modulo uniform equivalence. -/
def uniformEquivalenceQuotient (α : Type) (A : Set α) : Type :=
  Quot (uniformlyEquivalent (α := α) (A := A))

/-- The canonical projection to the quotient. -/
def uniformEquivalenceQuotient.mk (α : Type) (A : Set α) (f_n : SequenceOfFunctions α) :
    uniformEquivalenceQuotient α A :=
  Quot.mk (uniformlyEquivalent (α := α) (A := A)) f_n

/-! ## C(X) / c₀ Quotients -/

/-- Bounded sequences modulo sequences vanishing at infinity (c₀). -/
def c0Quotient (α : Type) : Type :=
  Quot (λ (f g : α → ℝ) => ∀ ε > 0, ∃ (K : Set α), IsCompact K ∧ supNormOn (λ x => f x - g x) (Kᶜ) < ε)

/-- The quotient norm on C_b(X) / C₀(X). -/
noncomputable def quotientNorm (f : α → ℝ) : ℝ :=
  infₛ { supNormOn (λ x => f x - g x) Set.univ | (g : α → ℝ) // supNormOn g Set.univ = 0 }

/-! ## Banach Space Quotients -/

/-- A closed subspace of bounded functions. -/
structure ClosedSubspace (α : Type) where
  subspace : (α → ℝ) → Prop
  closed : ∀ (f_n : Nat → α → ℝ), (∀ n, subspace (f_n n)) →
    (∃ f, uniformlyConvergesOnAll f_n f) → subspace f
  zero_mem : subspace (λ _ => 0)
  add_mem : ∀ f g, subspace f → subspace g → subspace (λ x => f x + g x)
  smul_mem : ∀ (c : ℝ) f, subspace f → subspace (λ x => c * f x)

/-- The quotient space C_b(X) / S where S is a closed subspace. -/
def quotientByClosedSubspace (α : Type) (S : ClosedSubspace α) : Type :=
  Quot (λ f g => S.subspace (λ x => f x - g x))

/-- Object instance for the quotient space. -/
instance (α : Type) (S : ClosedSubspace α) : MiniObjectKernel.Object (quotientByClosedSubspace α S) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences.quotient"
  objName := "QuotientSpace"
  repr q := "C_b(X)/S"

/-! ## Tests -/

#eval "--- Constructions.Quotients tests ---"

/-- Create a quotient of function sequences. -/
def myQuot : uniformEquivalenceQuotient ℝ Set.univ :=
  uniformEquivalenceQuotient.mk ℝ Set.univ (λ n x => x / (n+1 : ℝ))

#eval "Quotient created"

/-- The zero subspace. -/
def zeroSubspace : ClosedSubspace ℝ where
  subspace f := f = (λ _ => 0)
  closed := by
    intro f_n h_n h_conv
    rcases h_conv with ⟨f, h_u⟩
    ext x
    sorry
  zero_mem := rfl
  add_mem := by intro f g hf hg; simp [hf, hg]
  smul_mem := by intro c f hf; simp [hf]

example : zeroSubspace.subspace (λ _ : ℝ => (0 : ℝ)) := rfl

end MiniFunctionSequences
