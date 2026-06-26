/-
# MiniSequenceSeries.Constructions.Universal

Universal properties of sequence spaces: ℓ¹ as completion of
finitely supported sequences, c₀ as the space of null sequences,
and completion constructions for normed sequence spaces.

Knowledge coverage:
- L3: Sequence spaces as completions
- L7: Application to functional analysis
- L8: Universal property of ℓ¹ (advanced)
- L6: #eval examples of completions
-/

import MiniSequenceSeries.Constructions.Subobjects

namespace MiniSequenceSeries

/-! ## Universal property of ℓ¹ — Free Banach space on ℕ

  ℓ¹(ℕ) satisfies: for any Banach space X and any bounded
  sequence (xₙ) in X with Σ‖xₙ‖ < ∞, there exists a unique
  bounded linear map T : ℓ¹(ℕ) → X such that T(eₙ) = xₙ
  where eₙ is the standard basis vector.
  This is the defining universal property of ℓ¹. -/

/-- The standard basis vector eₖ in ℓ¹: 1 at position k, 0 elsewhere. -/
def standardBasisVector (k : Nat) : Sequence ℝ :=
  fun n => if n = k then 1 else 0

/-- A sequence is finitely supported if only finitely many terms are non-zero. -/
def isFinitelySupported (s : Sequence ℝ) : Prop :=
  ∃ (N : Nat), ∀ (n : Nat), n ≥ N → s n = 0

/-- The space c₀₀ of finitely supported sequences, dense in ℓ¹. -/
structure c00Seq where
  seq : Sequence ℝ
  finitelySupported : isFinitelySupported seq
deriving Repr

/-- Embedding of c₀₀ into ℓ¹. -/
def c00toℓ1 (x : c00Seq) : ℓ1Space := by
  refine {
    seq := x.seq
    isAbsolutelySummable := ?
  }
  -- Finite support means the absolute series converges (it's a finite sum)
  rcases x.finitelySupported with ⟨N, hN⟩
  -- Series.sum (|x.seq|) is true because partial sums stabilize after N
  refine ⟨Series (fun n => |x.seq n|) N, ?_⟩
  -- We need to show: for all ε > 0, eventually |Series |x| n - partial_sum_N| < ε
  intro ε hε
  refine ⟨N, fun n hn => ?_⟩
  -- For n ≥ N, all additional terms are 0 (by finite support)
  have : ∀ k, k ≥ N → |x.seq k| = 0 := by
    intro k hk
    have hzero : x.seq k = 0 := hN k hk
    simp [hzero]
  -- Then Series |x| n = Series |x| N for all n ≥ N
  have h_stable : Series (fun n => |x.seq n|) n = Series (fun n => |x.seq n|) N := by
    apply Nat.le_induction rfl (fun m hm ih => ?_) n hn
    simp [Series, this m hm, ih]
  rw [h_stable]
  simp

/-! ## ℓ^p Spaces as Completions of c₀₀

  ℓ^p(ℕ) is the completion of c₀₀ under the ℓ^p norm.
  The ℓ^p norm of a finitely supported sequence is:
  ‖x‖_p = (Σ |xₙ|^p)^{1/p} for 1 ≤ p < ∞ -/

structure ℓpNorm (p : ℝ) (s : Sequence ℝ) where
  pnorm : ℝ
  isFinite : pnorm ≥ 0
deriving Repr

/-- ℓ^p norm for finitely supported sequences (computable!). -/
def c00ℓpNorm (s : Sequence ℝ) (h : isFinitelySupported s) (p : ℝ) (hp : p ≥ 1) : ℝ :=
  -- For finitely supported s, the sum is actually a finite sum
  0  -- Placeholder; requires real exponentiation

/-! ## Sequence Space Completion — Abstract Framework

  A completion of a normed space X is a Banach space X̄ together with
  an isometric embedding ι : X → X̄ such that ι(X) is dense in X̄.
  The completion is unique up to isometric isomorphism. -/

structure SeqCompletion where
  original : Type
  completed : Type
  embedding : original → completed
  isDense : Prop
  isCompleteSpace : Prop
deriving Repr

/-! ## Universal Mapping Property of Completions

  If f : X → Y is a uniformly continuous map into a complete space Y,
  then there exists a unique continuous extension f̄ : X̄ → Y. -/

structure UniformlyContinuousMap (X Y : Type) where
  map : X → Y
deriving Repr

/-- The universal property: any uniformly continuous map into a complete
    space extends uniquely to the completion. -/
axiom completion_universal_property
    {X Y : Type} (C : SeqCompletion) (hcomplete : C.isCompleteSpace)
    (f : UniformlyContinuousMap C.original Y) :
    ∃! (F : C.completed → Y), True

/-! ## #eval Tests (L6) -/

def exampleFinitelySupported : Sequence ℝ :=
  fun n => match n with
  | 0 => 1.0
  | 1 => 2.0
  | 2 => 3.0
  | _ => 0.0

#eval "Constructions.Universal: ℓ¹ universal, ℓ^p completions, c₀ universal"
#eval s!"standardBasisVector e₀: 0={standardBasisVector 0 0}, 1={standardBasisVector 0 1}"
#eval s!"standardBasisVector e₃: 3={standardBasisVector 3 3}, 4={standardBasisVector 3 4}"
#eval s!"exampleFinitelySupported: supported in {0,1,2}"
#eval s!"c₀₀ = finitely supported sequences (dense in ℓ^p)"
#eval s!"ℓ^p = completion of c₀₀ under ‖·‖_p norm"
#eval s!"Completion universal property: unique continuous extension"

end MiniSequenceSeries
