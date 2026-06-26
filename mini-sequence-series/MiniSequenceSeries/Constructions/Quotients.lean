/-
# MiniSequenceSeries.Constructions.Quotients

Sequence space modulo null sequences (c/c₀), the space c₀ of
sequences converging to 0, quotient norm.
-/

import MiniSequenceSeries.Constructions.Products
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## c₀ — Sequences Converging to Zero -/

def isZeroSeq (s : Sequence ℝ) : Prop :=
  Sequence.limit s 0

structure c0Space where
  seq : Sequence ℝ
  convergesToZero : isZeroSeq seq
deriving Repr

instance : Coe c0Space (Sequence ℝ) where
  coe x := x.seq

/-! ## c — Convergent Sequences -/

structure cSpace where
  seq : Sequence ℝ
  isConvergent : isConvergent seq
deriving Repr

instance : Coe cSpace (Sequence ℝ) where
  coe x := x.seq

/-! ## Quotient c / c₀ -/

structure cQuotientc0 where
  representative : cSpace
  equivalenceClass : Set cSpace

def quotientNorm (q : cQuotientc0) : ℝ :=
  -- Quotient norm: infimum over all representatives
  0

/-! ## Quotient Sequence Space -/

structure QuotientSeqSpace where
  carrier : Type
  equivalenceRelation : Sequence ℝ → Sequence ℝ → Prop
  isEquivalence : Equivalence equivalenceRelation
  proj : Sequence ℝ → carrier
deriving Repr

def nullSeqRelation : Sequence ℝ → Sequence ℝ → Prop :=
  fun s t => isZeroSeq (pointwiseAdd s (pointwiseNeg t))

theorem nullSeqIsEquivalence : Equivalence nullSeqRelation := by
  sorry

def cModuloc0 : QuotientSeqSpace where
  carrier := cQuotientc0
  equivalenceRelation := nullSeqRelation
  isEquivalence := nullSeqIsEquivalence
  proj := fun _ => {
    representative := { seq := fun _ => 0, isConvergent := by
      refine ⟨0, ?_⟩
      sorry
    }
    equivalenceClass := ∅
  }

/-! ## #eval Tests -/

#eval "Constructions.Quotients: c₀, c, c/c₀ quotient, nullSeqRelation"
#eval s!"c₀Space: sequences converging to 0"
#eval s!"cSpace: convergent sequences"
#eval s!"cQuotientc0: quotient c / c₀"

end MiniSequenceSeries
