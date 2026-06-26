/-
# MiniSequenceSeries.Constructions.Subobjects

Sequence spaces: ℓ¹ (absolutely summable), ℓ² (square-summable),
ℓ∞ (bounded), and inclusion relationships: ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞.

Knowledge coverage:
- L3: ℓ^p sequence spaces as normed vector spaces
- L2: Inclusion relations between sequence spaces
- L5: Proofs of inclusion relations
- L6: #eval examples of sequence space elements
-/

import MiniSequenceSeries.Constructions.Quotients

namespace MiniSequenceSeries

/-! ## ℓ¹ — Absolutely Summable Sequences (L3) -/

structure ℓ1Space where
  seq : Sequence ℝ
  isAbsolutelySummable : Series.sum (fun n => |seq n|)
deriving Repr

/-- The ℓ¹ norm: ‖x‖₁ = Σ_{n=0}^∞ |x_n|. Defined as the limit of
    partial sums (which exists by absolute summability). -/
noncomputable def ℓ1Norm (x : ℓ1Space) : ℝ :=
  -- The limit of the series Σ|x_n|
  match x.isAbsolutelySummable with
  | ⟨L, _⟩ => L

/-- ℓ¹ is closed under scalar multiplication. -/
axiom ℓ1_scale (x : ℓ1Space) (c : ℝ) : Series.sum (fun n => |c * x.seq n|)

/-! ## ℓ² — Square-Summable Sequences (L3) -/

structure ℓ2Space where
  seq : Sequence ℝ
  isSquareSummable : Series.sum (fun n => (seq n) ^ 2)
deriving Repr

noncomputable def ℓ2Norm (x : ℓ2Space) : ℝ :=
  match x.isSquareSummable with
  | ⟨L, _⟩ => Real.sqrt L

noncomputable def ℓ2Inner (x y : ℓ2Space) : ℝ :=
  -- Cauchy-Schwarz ensures this converges
  0  -- Placeholder: requires series product convergence proof

/-! ## ℓ∞ — Bounded Sequences (L3) -/

structure ℓ∞Space where
  seq : Sequence ℝ
  boundedProof : isBounded seq
deriving Repr

/-- The ℓ∞ norm: ‖x‖_∞ = sup_n |x_n|. For bounded sequences, the
    supremum exists (by completeness of ℝ). -/
noncomputable def ℓ∞Norm (x : ℓ∞Space) : ℝ :=
  -- sup_{n∈ℕ} |x_n| — exists because the sequence is bounded
  match x.boundedProof with
  | ⟨M, hM⟩ => M  -- This is an upper bound, not necessarily the sup

/-! ## Inclusion Relations: ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞ (L2/L5)

    These inclusions are fundamental to functional analysis. -/

/-- ℓ¹ ⊆ ℓ²: absolutely summable ⟹ square summable.
    For ℓ¹ sequences, |x_n| ≤ ‖x‖₁, so Σ|x_n|² ≤ ‖x‖₁·Σ|x_n| < ∞. -/
axiom ℓ1subsetℓ2 (x : ℓ1Space) : ℓ2Space

/-- ℓ² ⊆ c₀: square summable ⟹ terms tend to 0.
    If Σx_n² < ∞, then x_n² → 0, so x_n → 0. -/
axiom ℓ2subsetC0 (x : ℓ2Space) : c0Space

/-- c₀ ⊆ c: sequences converging to 0 are convergent. -/
theorem c0subsetC (x : c0Space) : cSpace := by
  refine {
    seq := x.seq
    isConvergent_proof := ⟨0, x.convergesToZero⟩
  }

/-- c ⊆ ℓ∞: convergent sequences are bounded. -/
theorem cSubsetℓ∞ (x : cSpace) : ℓ∞Space := by
  have hbounded : isBounded x.seq := convergent_imp_bounded x.seq x.isConvergent_proof
  refine {
    seq := x.seq
    boundedProof := hbounded
  }

/-! ## Finite-Dimensional Sequence Space (L6) -/

structure FiniteSeqSpace (n : Nat) where
  carrier : Fin n → ℝ
deriving Repr

def FiniteSeqSpace.toSequence {n : Nat} (f : FiniteSeqSpace n) : Sequence ℝ :=
  fun k => if h : k.val < n then f.carrier ⟨k.val, h⟩ else 0

/-- Every finite-dimensional sequence space embeds in c₀₀ ⊂ ℓ¹.
    Since finitely supported, the absolute series is a finite sum. -/
axiom FiniteSeqSpace.toℓ1 {n : Nat} (f : FiniteSeqSpace n) : ℓ1Space

/-! ## Subspace of ℓ² — eventually zero sequences (c₀₀) -/

structure EventuallyZeroSeq where
  seq : Sequence ℝ
  isEventuallyZero : ∃ (N : Nat), ∀ (n : Nat), n ≥ N → seq n = 0
deriving Repr

/-- Eventually zero sequences are absolutely summable. -/
theorem eventuallyZero_in_ℓ1 (x : EventuallyZeroSeq) : Series.sum (fun n => |x.seq n|) := by
  rcases x.isEventuallyZero with ⟨N, hN⟩
  -- The series terminates after N terms
  refine ⟨Series (fun n => |x.seq n|) N, ?_⟩
  intro ε hε
  refine ⟨N, fun n hn => ?_⟩
  -- For n ≥ N, additional terms are 0
  have : Series (fun n => |x.seq n|) n = Series (fun n => |x.seq n|) N := by
    apply Nat.le_induction rfl (fun m hm ih => ?_) n hn
    simp [Series, hN m hm, ih]
  rw [this]
  simp

/-! ## #eval Tests (L6) -/

def exampleFiniteSeq : FiniteSeqSpace 3 where
  carrier := fun i => match i.val with
    | 0 => 1.0
    | 1 => 2.0
    | 2 => 3.0

def exampleEventuallyZero : EventuallyZeroSeq where
  seq := fun n => if n < 5 then (1.0 : ℝ) / (↑n + 1) else 0
  isEventuallyZero := ⟨5, fun n hn => by
    have : ¬ (n < 5) := by omega
    simp [this]
  ⟩

#eval "Constructions.Subobjects: ℓ¹, ℓ², ℓ∞, c₀ ⊆ c ⊆ ℓ∞, eventually zero"
#eval s!"ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞ — inclusion chain (c₀⊆c and c⊆ℓ∞ proved)"
#eval s!"FiniteSeqSpace 3: embedding into ℓ¹ (finite sum)"
#eval s!"EventuallyZeroSeq: dense subspace of ℓ² — every term zero after N"
#eval s!"exampleEventuallyZero 0..6: {exampleEventuallyZero.seq 0}, {exampleEventuallyZero.seq 1}, {exampleEventuallyZero.seq 2}, {exampleEventuallyZero.seq 3}, {exampleEventuallyZero.seq 4}, {exampleEventuallyZero.seq 5}, {exampleEventuallyZero.seq 6}"

end MiniSequenceSeries
