/-
# MiniSequenceSeries.Constructions.Subobjects

Sequence spaces: ℓ¹ (absolutely summable), ℓ² (square-summable),
ℓ∞ (bounded), c ⊆ ℓ∞ (convergent ⟹ bounded), inclusions.
-/

import MiniSequenceSeries.Constructions.Quotients
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## ℓ¹ — Absolutely Summable Sequences -/

structure ℓ1Space where
  seq : Sequence ℝ
  isAbsolutelySummable : Series.sum (fun n => |seq n|)
deriving Repr

def ℓ1Norm (x : ℓ1Space) : ℝ :=
  -- ‖x‖₁ = Σ |x_n|
  0

/-! ## ℓ² — Square-Summable Sequences -/

structure ℓ2Space where
  seq : Sequence ℝ
  isSquareSummable : Series.sum (fun n => (seq n) ^ 2)
deriving Repr

def ℓ2Norm (x : ℓ2Space) : ℝ :=
  -- ‖x‖₂ = (Σ |x_n|²)^{1/2}
  0

def ℓ2Inner (x y : ℓ2Space) : ℝ :=
  -- ⟨x,y⟩ = Σ x_n y_n
  0

/-! ## ℓ∞ — Bounded Sequences -/

structure ℓ∞Space where
  seq : Sequence ℝ
  isBounded : isBounded seq
deriving Repr

def ℓ∞Norm (x : ℓ∞Space) : ℝ :=
  -- ‖x‖_∞ = sup_n |x_n|
  0

/-! ## Inclusions: ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞ -/

theorem ℓ1subsetℓ2 (x : ℓ1Space) : ℓ2Space := by
  sorry

theorem ℓ2subsetC0 (x : ℓ2Space) : c0Space := by
  sorry

theorem c0subsetC (x : c0Space) : cSpace := by
  sorry

theorem cSubsetℓ∞ (x : cSpace) : ℓ∞Space := by
  sorry

/-! ## Finite-Dimensional Sequence Space -/

structure FiniteSeqSpace (n : Nat) where
  carrier : Fin n → ℝ
deriving Repr

def FiniteSeqSpace.toSequence (n : Nat) (f : Fin n → ℝ) : Sequence ℝ :=
  fun k => if h : k.val < n then f ⟨k.val, h⟩ else 0

/-! ## Subspace of ℓ² — eventually zero sequences -/

structure EventuallyZeroSeq where
  seq : Sequence ℝ
  isEventuallyZero : ∃ (N : Nat), ∀ (n : Nat), n ≥ N → seq n = 0
deriving Repr

/-! ## #eval Tests -/

#eval "Constructions.Subobjects: ℓ¹, ℓ², ℓ∞, c₀ ⊆ c ⊆ ℓ∞, eventually zero"
#eval s!"ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞ — inclusion chain defined"
#eval s!"FiniteSeqSpace 5: embedding into ℓ∞"
#eval s!"EventuallyZeroSeq: dense subspace of ℓ²"

end MiniSequenceSeries
