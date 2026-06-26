/-
# MiniSequenceSeries.Core.Objects

Object instances for sequence and series types within the kernel.
Provides the Object typeclass implementations and derived structures
with proof-carrying data (convergent sequences with their limits).

Knowledge coverage:
- L1: Object instances, LimSeq, SumSeq structures
- L3: Proof-carrying types as mathematical structures
- L6: #eval tests for Object instances
-/

import MiniSequenceSeries.Core.Laws
import MiniObjectKernel

open MiniObjectKernel

namespace MiniSequenceSeries

/-! ## Kernel Object Instances (L1) -/

instance : Object (Sequence ℝ) where
  theory := TheoryName.ofString "SequenceSeries"
  objName := "Sequence ℝ"
  repr s := s!"Sequence({s 0}, {s 1}, {s 2}, ...)"

instance : Object PowerSeries where
  theory := TheoryName.ofString "SequenceSeries"
  objName := "PowerSeries"
  repr ps := s!"PowerSeries(a₀={ps.coefficients 0}, center={ps.center})"

/-! ## Theory Names for Sub-Theories -/

def sequenceTheory : TheoryName :=
  TheoryName.ofString "SequenceSeries.SequenceTheory"

def seriesTheory : TheoryName :=
  TheoryName.ofString "SequenceSeries.SeriesTheory"

def convergenceTheory : TheoryName :=
  TheoryName.ofString "SequenceSeries.ConvergenceTheory"

def powerSeriesTheory : TheoryName :=
  TheoryName.ofString "SequenceSeries.PowerSeriesTheory"

/-! ## Derived Types Carrying Proofs (L3: Proof-relevant structures) -/

/-- A convergent sequence together with its limit and the convergence proof. -/
structure LimSeq where
  seq : Sequence ℝ
  limit : ℝ
  convergesProof : Sequence.limit seq limit
deriving Repr, Inhabited

/-- A summable series together with its sum and the convergence proof. -/
structure SumSeq where
  terms : Sequence ℝ
  sum : ℝ
  convergesProof : Series.limitSum terms sum
deriving Repr, Inhabited

/-- An absolutely summable series with its sum and proof. -/
structure AbsSumSeq where
  terms : Sequence ℝ
  sum : ℝ
  absConvergesProof : Series.limitSum (fun n => |terms n|) sum
deriving Repr, Inhabited

/-- A bounded sequence with its bound and proof. -/
structure BoundedSeq where
  seq : Sequence ℝ
  bound : ℝ
  boundedProof : ∀ n, |seq n| ≤ bound
deriving Repr, Inhabited

/-- A Cauchy sequence with its Cauchy proof. -/
structure CauchySeq where
  seq : Sequence ℝ
  cauchyProof : isCauchy seq
deriving Repr, Inhabited

/-- A monotone sequence with direction information. -/
structure MonotoneSeq where
  seq : Sequence ℝ
  isMonotoneProof : isMonotone seq
deriving Repr, Inhabited

/-! ## Constructing Proof-Carrying Objects -/

def LimSeq.mk (s : Sequence ℝ) (L : ℝ) (h : Sequence.limit s L) : LimSeq :=
  { seq := s, limit := L, convergesProof := h }

def SumSeq.mk (a : Sequence ℝ) (S : ℝ) (h : Series.limitSum a S) : SumSeq :=
  { terms := a, sum := S, convergesProof := h }

/-- The constant sequence forms a LimSeq. -/
def constLimSeq (c : ℝ) : LimSeq :=
  LimSeq.mk (fun _ => c) c (limit_const c)

/-- Zero sequence is convergent. -/
def zeroLimSeq : LimSeq := constLimSeq 0

/-! ## Conversions Between Proof-Carrying Types -/

/-- Every LimSeq gives a BoundedSeq. -/
def LimSeq.toBoundedSeq (ls : LimSeq) : BoundedSeq :=
  let hconv : isConvergent ls.seq := ⟨ls.limit, ls.convergesProof⟩
  let hbounded : isBounded ls.seq := convergent_imp_bounded ls.seq hconv
  match hbounded with
  | ⟨M, hM⟩ =>
    { seq := ls.seq
      bound := max M (|ls.limit| + 1)
      boundedProof := fun n => le_trans (hM n) (le_max_left _ _)
    }

/-- Every LimSeq gives a CauchySeq. -/
def LimSeq.toCauchySeq (ls : LimSeq) : CauchySeq :=
  { seq := ls.seq
    cauchyProof := convergent_imp_cauchy ls.seq ⟨ls.limit, ls.convergesProof⟩
  }

/-! ## #eval Tests (L6) -/

#eval "Core.Objects: Object instances for Sequence, PowerSeries"
#eval s!"theory: {theory (α := Sequence ℝ)}"
#eval s!"objName: {objName (α := Sequence ℝ)}"
#eval s!"describe Sequence ℝ: {describe (α := Sequence ℝ)}"
#eval s!"describe PowerSeries: {describe (α := PowerSeries)}"
#eval s!"Proof-carrying types: LimSeq, SumSeq, AbsSumSeq, BoundedSeq, CauchySeq, MonotoneSeq"
#eval s!"zeroLimSeq limit = {zeroLimSeq.limit} (expected 0)"
#eval s!"CauchySeq from LimSeq: structural conversion"

end MiniSequenceSeries
