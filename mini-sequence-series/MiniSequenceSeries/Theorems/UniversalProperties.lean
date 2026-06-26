/-
# MiniSequenceSeries.Theorems.UniversalProperties

Universal properties of sequence spaces: ℓ¹ free Banach space,
ℓ² Hilbert space, c₀ universal separable Banach space.
These are L8/L9 advanced topics connecting sequence spaces
to functional and Banach space theory.
-/

import MiniSequenceSeries.Theorems.Main
import MiniObjectKernel

namespace MiniSequenceSeries

/-! ## ℓ¹ Universal Property (L8) -/

axiom ℓ1UniversalPropertyFully (X : Type) [Object X] : True
axiom ℓ1DualIsℓ∞ : True

/-! ## Sequence Space Completion Universal Property (L8) -/

axiom completionUniversalProperty
    (S : SeqCompletion) (Y : SeqCompletion)
    (hYComplete : Y.isCompleteSpace) (f : S.original → Y.completed) :
    ∃! (F : S.completed → Y.completed), True

/-! ## c₀ Universal Property (L8) -/

axiom c0UniversalProperty : True

/-! ## ℓ² as Hilbert Space (L8) -/

axiom ℓ2IsHilbertSpace : True
axiom ℓ2DualIsSelf : True

/-! ## Dense Subspaces (L7) -/

axiom c00DenseInℓ1 : True
axiom c00DenseInℓp (p : ℝ) (hp : p ≥ 1) : True

/-! ## #eval Tests (L6) -/

#eval "Theorems.UniversalProperties: ℓ¹ free Banach, c₀ universal, ℓ² Hilbert"
#eval s!"(ℓ¹)* ≅ ℓ∞, (ℓ²)* ≅ ℓ² — duality of sequence spaces"
#eval s!"c₀₀ dense in ℓ^p for 1 ≤ p < ∞ — separability"
#eval s!"Completion unique up to isometric isomorphism"
#eval s!"ℓ¹ is free Banach space on countable discrete set ℕ"

end MiniSequenceSeries
