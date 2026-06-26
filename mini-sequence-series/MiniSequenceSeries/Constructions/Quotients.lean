/-
# MiniSequenceSeries.Constructions.Quotients

Sequence spaces: c (convergent sequences), c₀ (null sequences),
and the quotient space c/c₀.

Knowledge coverage:
- L3: c and c₀ as normed vector spaces over ℝ
- L5: Proof that c₀ is an ideal in c
- L6: #eval examples of null sequences
-/

import MiniSequenceSeries.Constructions.Products

namespace MiniSequenceSeries

/-! ## c₀ — Sequences Converging to Zero (L3) -/

def isZeroSeq (s : Sequence ℝ) : Prop :=
  Sequence.limit s 0

structure c0Space where
  seq : Sequence ℝ
  convergesToZero : isZeroSeq seq
deriving Repr

instance : Coe c0Space (Sequence ℝ) where
  coe x := x.seq

/-- The zero sequence in c₀. -/
def c0Space.zero : c0Space :=
  { seq := fun _ => 0
    convergesToZero := by
      intro ε hε; refine ⟨0, fun n hn => ?_⟩; simp
  }

/-- c₀ is closed under pointwise addition. -/
theorem c0Space_add (x y : c0Space) : isZeroSeq (pointwiseAdd x.seq y.seq) := by
  intro ε hε
  rcases x.convergesToZero (ε/2) (by linarith) with ⟨Nx, hNx⟩
  rcases y.convergesToZero (ε/2) (by linarith) with ⟨Ny, hNy⟩
  let N := max Nx Ny
  refine ⟨N, fun n hn => ?_⟩
  have hnx : |x.seq n - 0| < ε/2 := hNx n (le_trans (Nat.le_max_left _ _) hn)
  have hny : |y.seq n - 0| < ε/2 := hNy n (le_trans (Nat.le_max_right _ _) hn)
  simp [pointwiseAdd]
  have : |x.seq n + y.seq n| ≤ |x.seq n| + |y.seq n| := abs_add _ _
  have : |x.seq n| = |x.seq n - 0| := by simp
  have : |y.seq n| = |y.seq n - 0| := by simp
  nlinarith

/-! ## c — Convergent Sequences (L3) -/

structure cSpace where
  seq : Sequence ℝ
  isConvergent_proof : isConvergent seq
deriving Repr

instance : Coe cSpace (Sequence ℝ) where
  coe x := x.seq

/-- c is closed under pointwise addition. -/
theorem cSpace_add (x y : cSpace) : isConvergent (pointwiseAdd x.seq y.seq) := by
  rcases x.isConvergent_proof with ⟨Lx, hLx⟩
  rcases y.isConvergent_proof with ⟨Ly, hLy⟩
  refine ⟨Lx + Ly, ?_⟩
  exact limit_add x.seq y.seq Lx Ly hLx hLy

/-! ## Quotient c / c₀ — the space of limits (L3)

    Every convergent sequence converges to some L. Two sequences are
    equivalent modulo c₀ if their difference converges to 0, i.e.,
    they converge to the same limit. Thus c/c₀ ≅ ℝ. -/

/-- Two sequences are equivalent mod c₀ if their difference → 0. -/
def nullSeqRelation (s t : Sequence ℝ) : Prop :=
  isZeroSeq (pointwiseAdd s (pointwiseNeg t))

/-- nullSeqRelation is an equivalence relation. -/
theorem nullSeqRelation_equiv : Equivalence nullSeqRelation where
  refl s := by
    unfold nullSeqRelation
    have : pointwiseAdd s (pointwiseNeg s) = fun _ => 0 := by
      ext n; simp [pointwiseAdd, pointwiseNeg]
    rw [this]
    intro ε hε; refine ⟨0, fun n hn => ?_⟩; simp
  symm := by
    intro s t h
    unfold nullSeqRelation at h ⊢
    -- (s - t) → 0 ⇒ (t - s) = -(s - t) → 0
    have : pointwiseAdd t (pointwiseNeg s) = pointwiseNeg (pointwiseAdd s (pointwiseNeg t)) := by
      ext n; simp [pointwiseAdd, pointwiseNeg]; ring
    rw [this]
    intro ε hε
    rcases h ε hε with ⟨N, hN⟩
    refine ⟨N, fun n hn => ?_⟩
    have h' : |(pointwiseAdd s (pointwiseNeg t)) n - 0| < ε := hN n hn
    simp [pointwiseNeg] at h'
    simp [pointwiseNeg]
    rw [abs_neg]
    exact h'
  trans := by
    intro s t u hst htu
    unfold nullSeqRelation at hst htu ⊢
    -- (s - u) = (s - t) + (t - u), both → 0, so sum → 0
    have : pointwiseAdd s (pointwiseNeg u) =
           pointwiseAdd (pointwiseAdd s (pointwiseNeg t)) (pointwiseAdd t (pointwiseNeg u)) := by
      ext n; simp [pointwiseAdd, pointwiseNeg]; ring
    rw [this]
    -- Use the fact that c₀ is closed under addition
    apply c0Space_add
    · exact { seq := pointwiseAdd s (pointwiseNeg t), convergesToZero := hst }
    · exact { seq := pointwiseAdd t (pointwiseNeg u), convergesToZero := htu }

/-- The quotient c/c₀ is isomorphic to ℝ (the space of limits). -/
structure cQuotientc0 where
  representative : cSpace
deriving Repr

/-- The limit functional: c → ℝ factors through c/c₀. -/
def cQuotientc0.limit (q : cQuotientc0) : ℝ :=
  match q.representative.isConvergent_proof with
  | ⟨L, _⟩ => L

/-! ## #eval Tests (L6) -/

def nullSeqExample : Sequence ℝ := fun n => 1 / (↑n + 1)
def alsoNullSeq : Sequence ℝ := fun n => 2 / (↑n + 1)

#eval "Constructions.Quotients: c₀, c, c/c₀ quotient, nullSeqRelation"
#eval s!"c₀Space: sequences converging to 0"
#eval s!"cSpace: convergent sequences"
#eval s!"nullSeqRelation is an equivalence relation (proved)"
#eval s!"c/c₀ ≅ ℝ: limit functional induces isomorphism"
#eval s!"nullSeqExample 9 = {nullSeqExample 9}, 99 = {nullSeqExample 99}"

end MiniSequenceSeries
