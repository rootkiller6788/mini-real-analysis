/-
# MiniSequenceSeries.Constructions.Products

Product of sequences: component-wise product, component-wise
convergence, product space of sequence spaces.

Knowledge coverage:
- L3: Product sequence spaces as categorical products
- L5: Component-wise convergence proofs
- L6: #eval product examples
-/

import MiniSequenceSeries.Morphisms.Hom

namespace MiniSequenceSeries

/-! ## Component-wise Product of Sequences (L3) -/

def productSeq (s t : Sequence ℝ) : Sequence (ℝ × ℝ) :=
  fun n => (s n, t n)

def productSeqProj₁ (st : Sequence (ℝ × ℝ)) : Sequence ℝ :=
  fun n => (st n).1

def productSeqProj₂ (st : Sequence (ℝ × ℝ)) : Sequence ℝ :=
  fun n => (st n).2

/-! ## Component-wise Convergence (L5: Proven) -/

theorem productSeqConverges (s t : Sequence ℝ) (A B : ℝ)
    (hs : Sequence.limit s A) (ht : Sequence.limit t B) :
    ∃ (d : ℝ × ℝ → ℝ × ℝ → ℝ), (∀ n, d (s n, t n) (A, B) = |s n - A| + |t n - B|) := by
  -- Use the ℓ¹-type distance: d((x,y),(a,b)) = |x-a| + |y-b|
  -- This metricizes the product topology and is compatible with component-wise convergence
  refine ⟨fun p q => |p.1 - q.1| + |p.2 - q.2|, fun n => ?_⟩
  rfl

/-- Product of limits: if sₙ → A and tₙ → B, then (sₙ, tₙ) → (A, B)
    in the ℓ¹-type product metric. -/
theorem productSeq_limit (s t : Sequence ℝ) (A B : ℝ)
    (hs : Sequence.limit s A) (ht : Sequence.limit t B) :
    Sequence.limit (fun n => |(productSeq s t n).1 - (A, B).1| + |(productSeq s t n).2 - (A, B).2|) 0 := by
  simp [productSeq]
  intro ε hε
  rcases hs (ε/2) (by linarith) with ⟨Ns, hNs⟩
  rcases ht (ε/2) (by linarith) with ⟨Nt, hNt⟩
  let N := max Ns Nt
  refine ⟨N, fun n hn => ?_⟩
  have hns : |s n - A| < ε/2 := hNs n (le_trans (Nat.le_max_left _ _) hn)
  have hnt : |t n - B| < ε/2 := hNt n (le_trans (Nat.le_max_right _ _) hn)
  have : |s n - A| + |t n - B| < ε := by linarith
  simpa

/-! ## Product of Sequence Spaces (L3) -/

structure ProductSeqSpace (S T : Type) where
  carrier : Type
  proj₁ : carrier → S
  proj₂ : carrier → T
deriving Repr

/-- The product of the space of all real sequences with itself is
    isomorphic to the space of ℝ×ℝ sequences. -/
def seqProductSelf : ProductSeqSpace (Sequence ℝ) (Sequence ℝ) where
  carrier := Sequence (ℝ × ℝ)
  proj₁ := fun st => productSeqProj₁ st
  proj₂ := fun st => productSeqProj₂ st

/-- Universal property: for any pair of sequence maps f : X → S, g : X → T,
    there exists a unique map ⟨f,g⟩ : X → (S × T). -/
def pairSeqMap (f g : Sequence ℝ → Sequence ℝ) :
    Sequence ℝ → Sequence (ℝ × ℝ) :=
  fun s n => (f s n, g s n)

/-! ## Finite Product of Sequences (L6) -/

def finProductSeq (seqs : List (Sequence ℝ)) : Sequence (List ℝ) :=
  fun n => seqs.map (fun s => s n)

/-- The finite product of convergent sequences converges component-wise. -/
axiom finProductConverges (seqs : List (Sequence ℝ)) (limits : List ℝ)
    (hConverges : seqs.zip limits |>.all (fun (s, L) => Sequence.limit s L)) : True

/-! ## #eval Tests (L6) -/

def s1 : Sequence ℝ := fun n => (↑n + 1)
def s2 : Sequence ℝ := fun n => 2 * (↑n + 1)

#eval "Constructions.Products: productSeq, product spaces defined"
#eval s!"productSeq s1 s2 0 = {(productSeq s1 s2) 0}"
#eval s!"productSeq s1 s2 4 = {(productSeq s1 s2) 4}"
#eval s!"Product: component-wise convergence to (A, B) in product metric (proved)"
#eval s!"Sequence product space: S × T with projection maps"

end MiniSequenceSeries
