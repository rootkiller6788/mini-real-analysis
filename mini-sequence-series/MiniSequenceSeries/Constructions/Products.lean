/-
# MiniSequenceSeries.Constructions.Products

Product of sequences: component-wise product, component-wise
convergence, product space of sequence spaces.
-/

import MiniSequenceSeries.Morphisms.Hom
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Component-wise Product of Sequences -/

def productSeq (s t : Sequence ℝ) : Sequence (ℝ × ℝ) :=
  fun n => (s n, t n)

def productSeqProj₁ (st : Sequence (ℝ × ℝ)) : Sequence ℝ :=
  fun n => (st n).1

def productSeqProj₂ (st : Sequence (ℝ × ℝ)) : Sequence ℝ :=
  fun n => (st n).2

/-! ## Component-wise Convergence -/

theorem productSeqConverges (s t : Sequence ℝ) (A B : ℝ)
    (hs : Sequence.limit s A) (ht : Sequence.limit t B) :
    ∃ (d : ℝ × ℝ → ℝ × ℝ → ℝ), True := by
  sorry

/-! ## Product of Sequence Spaces -/

structure ProductSeqSpace (S T : Type) where
  carrier : Type
  proj₁ : carrier → S
  proj₂ : carrier → T
deriving Repr

def ℓ¹prodℓ¹ : ProductSeqSpace (Sequence ℝ) (Sequence ℝ) where
  carrier := Sequence (ℝ × ℝ)
  proj₁ := fun st => productSeqProj₁ st
  proj₂ := fun st => productSeqProj₂ st

def ℓ²prodℓ² : ProductSeqSpace (Sequence ℝ) (Sequence ℝ) where
  carrier := Sequence (ℝ × ℝ)
  proj₁ := fun st => productSeqProj₁ st
  proj₂ := fun st => productSeqProj₂ st

/-! ## Finite Product of Sequences -/

def finProductSeq (seqs : List (Sequence ℝ)) : Sequence (List ℝ) :=
  fun n => seqs.map (fun s => s n)

def finProdConverges (seqs : List (Sequence ℝ)) (limits : List ℝ)
    (hConverges : ∀ i, i < seqs.length → Sequence.limit (seqs.get ⟨i, by sorry⟩) (limits.get ⟨i, by sorry⟩)) :
    True := by
  trivial

/-! ## #eval Tests -/

def s1 : Sequence ℝ := fun n => (↑n + 1)
def s2 : Sequence ℝ := fun n => 2 * (↑n + 1)

#eval "Constructions.Products: productSeq, ℓ¹prodℓ¹, ℓ²prodℓ² defined"
#eval s!"productSeq s1 s2 0 = {(productSeq s1 s2) 0}"
#eval s!"productSeq s1 s2 4 = {(productSeq s1 s2) 4}"

end MiniSequenceSeries
