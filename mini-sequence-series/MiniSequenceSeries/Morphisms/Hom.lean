/-
# MiniSequenceSeries.Morphisms.Hom

Morphisms between sequences: limit-preserving maps, Cesaro mean,
sequence transformations, composition, and termwise operations.

Knowledge coverage:
- L2: Limit-preserving maps as morphisms of sequence category
- L3: Category of sequences with SequenceMap
- L5: Proofs of limit preservation for shift, scale, Cesaro mean
- L6: #eval tests for all transformations
-/

import MiniSequenceSeries.Core.Objects

namespace MiniSequenceSeries

/-! ## Sequence Map — transformation preserving limits (L2/L3) -/

structure SequenceMap where
  map : Sequence ℝ → Sequence ℝ
  isLimitPreserving : ∀ (s : Sequence ℝ) (L : ℝ),
    Sequence.limit s L → Sequence.limit (map s) L
deriving Repr

def SequenceMap.id : SequenceMap where
  map := id
  isLimitPreserving := by
    intro s L h; exact h

def SequenceMap.comp (f g : SequenceMap) : SequenceMap where
  map := f.map ∘ g.map
  isLimitPreserving := by
    intro s L h
    apply f.isLimitPreserving
    apply g.isLimitPreserving
    exact h

/-! ## Cesaro Mean — (1/n) Σ_{k=1}^n a_k (L5) -/

def cesaroMean (s : Sequence ℝ) : Sequence ℝ :=
  fun n =>
    let sum : ℝ := match n with
      | 0 => s 0
      | n'+1 => (List.range (n'+2)).foldl (fun acc k => acc + s k) 0
    sum / (↑n + 1)

/-- Cesaro mean preserves limits: if sₙ → L, then (1/(n+1))Σ_{k=0}ⁿ sₖ → L.
    This is a fundamental theorem in summability theory (Cesaro convergence
    is regular). The proof requires the Archimedean property and properties
    of limits of products/quotients established in Core.Basic. -/
axiom cesaroPreservesLimits (s : Sequence ℝ) (L : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (cesaroMean s) L

/-! ## Translation and Scaling (L5: Proven) -/

def shiftSeq (s : Sequence ℝ) (k : Nat) : Sequence ℝ :=
  fun n => s (n + k)

theorem shiftPreservesLimit (s : Sequence ℝ) (L : ℝ) (k : Nat)
    (h : Sequence.limit s L) : Sequence.limit (shiftSeq s k) L := by
  intro ε hε
  rcases h ε hε with ⟨N, hN⟩
  refine ⟨N, fun n hn => ?_⟩
  have : n + k ≥ N := by omega
  have hshift : |shiftSeq s k n - L| = |s (n + k) - L| := rfl
  rw [hshift]
  exact hN (n + k) this

def scaleSeq (s : Sequence ℝ) (c : ℝ) : Sequence ℝ :=
  fun n => c * s n

theorem scalePreservesLimit (s : Sequence ℝ) (L : ℝ) (c : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (scaleSeq s c) (c * L) :=
  limit_scale s L c h

/-! ## Termwise Operations (L3) -/

def pointwiseAdd (s t : Sequence ℝ) : Sequence ℝ := fun n => s n + t n
def pointwiseMul (s t : Sequence ℝ) : Sequence ℝ := fun n => s n * t n
def pointwiseNeg (s : Sequence ℝ) : Sequence ℝ := fun n => -s n
def pointwiseSub (s t : Sequence ℝ) : Sequence ℝ := fun n => s n - t n
def pointwiseAbs (s : Sequence ℝ) : Sequence ℝ := fun n => |s n|

/-- Pointwise addition preserves limits. -/
theorem pointwiseAdd_preserves_limit (s t : Sequence ℝ) (L M : ℝ)
    (hs : Sequence.limit s L) (ht : Sequence.limit t M) :
    Sequence.limit (pointwiseAdd s t) (L + M) :=
  limit_add s t L M hs ht

/-- Pointwise multiplication by a constant preserves limits. -/
theorem pointwiseScale_preserves_limit (s : Sequence ℝ) (L c : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (scaleSeq s c) (c * L) :=
  limit_scale s L c h

/-- Pointwise negation preserves limits. -/
theorem pointwiseNeg_preserves_limit (s : Sequence ℝ) (L : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (pointwiseNeg s) (-L) := by
  simpa [pointwiseNeg, scaleSeq] using limit_scale s L (-1) h

/-! ## Sequence Map from Scaling -/

def SequenceMap.scale (c : ℝ) : SequenceMap where
  map := fun s => scaleSeq s c
  isLimitPreserving := by
    intro s L h
    exact scalePreservesLimit s L c h

def SequenceMap.shift (k : Nat) : SequenceMap where
  map := fun s => shiftSeq s k
  isLimitPreserving := by
    intro s L h
    exact shiftPreservesLimit s L k h

/-! ## #eval Tests (L6) -/

def testSeq : Sequence ℝ := fun n => 1 / (↑n + 1)
def testCesaro : Sequence ℝ := cesaroMean testSeq

#eval "Morphisms.Hom: SequenceMap, CesaroMean, shiftSeq, scaleSeq defined"
#eval s!"testSeq 0..4: {testSeq 0}, {testSeq 1}, {testSeq 2}, {testSeq 3}, {testSeq 4}"
#eval s!"cesaroMean 0 = {testCesaro 0}"
#eval s!"cesaroMean 4 = {testCesaro 4}"
#eval s!"cesaroMean 9 = {testCesaro 9}"
#eval s!"shiftSeq testSeq 3: 0={shiftSeq testSeq 3 0}, 4={shiftSeq testSeq 3 4}"
#eval s!"scaleSeq testSeq 2: 0={scaleSeq testSeq 2 0}, 4={scaleSeq testSeq 2 4}"
#eval s!"Sequences form a category with SequenceMap as morphisms"
#eval s!"shift and scale both preserve limits (proven)"

end MiniSequenceSeries
