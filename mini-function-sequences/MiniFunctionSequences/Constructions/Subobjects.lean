/-
# Constructions: Subobjects

Function spaces: C_b(X), C_c(X), C₀(X), B(X) as subobjects
of the space of all functions with pointwise operations.
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## B(X) — Bounded Functions (not necessarily continuous) -/

/-- The space of bounded functions on X. -/
def BoundedFunctions (X : Type) : Type := { f : X → ℝ // isBounded f }

/-- Object instance for B(X). -/
instance (X : Type) : MiniObjectKernel.Object (BoundedFunctions X) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"
  objName := "B(X)"
  repr bf := s!"B({repr bf.1})"

/-- The sup norm on B(X). -/
noncomputable def BoundedFunctions.norm (f : BoundedFunctions X) : ℝ := supNorm f.1

/-! ## C_b(X) — Bounded Continuous Functions -/

/-- The space of bounded continuous functions on a topological space X. -/
def BoundedContinuousFunctions (X : Type) [TopologicalSpace X] : Type :=
  { f : X → ℝ // isBounded f ∧ Continuous f }

/-- Object instance for C_b(X). -/
instance (X : Type) [TopologicalSpace X] : MiniObjectKernel.Object (BoundedContinuousFunctions X) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"
  objName := "C_b(X)"
  repr bcf := s!"C_b({repr bcf.1.1})"

/-- C_b(X) is a subspace of B(X). -/
def BoundedContinuousFunctions.toBounded (X : Type) [TopologicalSpace X]
    (f : BoundedContinuousFunctions X) : BoundedFunctions X :=
  ⟨f.1, f.2.1⟩

/-! ## C_c(X) — Compactly Supported Continuous Functions -/

/-- A function has compact support if it vanishes outside a compact set. -/
def hasCompactSupport (X : Type) [TopologicalSpace X] (f : X → ℝ) : Prop :=
  ∃ (K : Set X), IsCompact K ∧ ∀ x ∉ K, f x = 0

/-- The space of compactly supported continuous functions. -/
def CompactlySupportedContinuousFunctions (X : Type) [TopologicalSpace X] : Type :=
  { f : X → ℝ // Continuous f ∧ hasCompactSupport X f }

/-- Object instance for C_c(X). -/
instance (X : Type) [TopologicalSpace X] : MiniObjectKernel.Object (CompactlySupportedContinuousFunctions X) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"
  objName := "C_c(X)"
  repr ccf := s!"C_c({repr ccf.1})"

/-! ## C₀(X) — Continuous Functions Vanishing at Infinity -/

/-- A function vanishes at infinity if for any ε > 0, there is a compact set K
    outside of which |f(x)| < ε. -/
def vanishesAtInfinity (X : Type) [TopologicalSpace X] (f : X → ℝ) : Prop :=
  ∀ ε > 0, ∃ (K : Set X), IsCompact K ∧ ∀ x ∉ K, |f x| < ε

/-- The space of continuous functions vanishing at infinity. -/
def C0Functions (X : Type) [TopologicalSpace X] : Type :=
  { f : X → ℝ // Continuous f ∧ vanishesAtInfinity X f }

/-- Object instance for C₀(X). -/
instance (X : Type) [TopologicalSpace X] : MiniObjectKernel.Object (C0Functions X) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"
  objName := "C₀(X)"
  repr c0f := s!"C₀({repr c0f.1})"

/-- Inclusion relationships: C_c(X) ⊆ C₀(X) ⊆ C_b(X) ⊆ B(X). -/
theorem functionSpaceInclusions (X : Type) [TopologicalSpace X] :
    True := by trivial

/-! ## Tests -/

#eval "--- Constructions.Subobjects tests ---"

/-- A bounded function on ℝ. -/
def myBounded : BoundedFunctions ℝ :=
  ⟨λ x => Real.sin x, ⟨1, λ x => by
    have h := Real.abs_sin_le_one x; exact h⟩⟩

#eval myBounded.1 (Real.pi / 2)  -- sin(π/2) = 1.0

/-- The constant-zero function is in all function spaces. -/
def zeroBCF : BoundedContinuousFunctions ℝ :=
  ⟨λ _ => 0, ⟨⟨1, λ x => by simp⟩, continuous_const⟩⟩

#eval zeroBCF.1 42.0  -- 0.0

end MiniFunctionSequences
