/-
# MiniSequenceSeries.Morphisms.Hom

Morphisms between sequences: limit-preserving maps, Cesaro mean,
sequence transformations, composition.
-/

import MiniSequenceSeries.Core.Basic
import MiniSequenceSeries.Core.Objects
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Sequence Map — transformation preserving limits -/

structure SequenceMap where
  map : Sequence ℝ → Sequence ℝ
  isLimitPreserving : ∀ (s : Sequence ℝ) (L : ℝ),
    Sequence.limit s L → Sequence.limit (map s) L
deriving Repr

def SequenceMap.id : SequenceMap where
  map := id
  isLimitPreserving := by
    intro s L h
    exact h

def SequenceMap.comp (f g : SequenceMap) : SequenceMap where
  map := f.map ∘ g.map
  isLimitPreserving := by
    intro s L h
    apply f.isLimitPreserving
    apply g.isLimitPreserving
    exact h

/-! ## Cesaro Mean — (1/n) Σ_{k=1}^n a_k -/

def cesaroMean (s : Sequence ℝ) : Sequence ℝ :=
  fun n =>
    let sum : ℝ :=
      match n with
      | 0 => s 0
      | n'+1 => (List.range (n'+2)).foldl (fun acc k => acc + s k) 0
    sum / (↑n + 1)

theorem cesaroPreservesLimits (s : Sequence ℝ) (L : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (cesaroMean s) L := by
  sorry

/-! ## Translation and Scaling -/

def shiftSeq (s : Sequence ℝ) (k : Nat) : Sequence ℝ :=
  fun n => s (n + k)

def scaleSeq (s : Sequence ℝ) (c : ℝ) : Sequence ℝ :=
  fun n => c * s n

theorem shiftPreservesLimit (s : Sequence ℝ) (L : ℝ) (k : Nat)
    (h : Sequence.limit s L) : Sequence.limit (shiftSeq s k) L := by
  sorry

theorem scalePreservesLimit (s : Sequence ℝ) (L : ℝ) (c : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (scaleSeq s c) (c * L) := by
  sorry

/-! ## Termwise Operations -/

def pointwiseAdd (s t : Sequence ℝ) : Sequence ℝ := fun n => s n + t n
def pointwiseMul (s t : Sequence ℝ) : Sequence ℝ := fun n => s n * t n
def pointwiseNeg (s : Sequence ℝ) : Sequence ℝ := fun n => -s n

/-! ## #eval Tests -/

def testSeq : Sequence ℝ := fun n => 1 / (↑n + 1)
def testCesaro : Sequence ℝ := cesaroMean testSeq

#eval "Morphisms.Hom: SequenceMap, CesaroMean, shiftSeq, scaleSeq defined"
#eval s!"testSeq 0..4: {testSeq 0}, {testSeq 1}, {testSeq 2}, {testSeq 3}, {testSeq 4}"
#eval s!"cesaroMean 0 = {testCesaro 0}"
#eval s!"cesaroMean 4 = {testCesaro 4}"

end MiniSequenceSeries
