/-
# MiniSequenceSeries.Core.Objects

Object instances for sequence and series types within the kernel.
-/

import MiniSequenceSeries.Core.Basic
import MiniSequenceSeries.Core.Laws
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Kernel Object Instances -/

instance : Object (Sequence ℝ) where
  theory := TheoryName.ofString "SequenceSeries"
  objName := "Sequence ℝ"
  repr s := s!"Sequence({toString <| s 0}, {toString <| s 1}, ...)"

instance : Object (Series ℝ) where
  theory := TheoryName.ofString "SequenceSeries"
  objName := "Series ℝ"
  repr s := s!"Series(...)"

instance : Object PowerSeries where
  theory := TheoryName.ofString "SequenceSeries"
  objName := "PowerSeries"
  repr ps := s!"PowerSeries(a₀={ps.coefficients 0}, center={ps.center})"

/-! ## Theory Names -/

def sequenceTheory : TheoryName :=
  TheoryName.ofString "SequenceTheory"

def seriesTheory : TheoryName :=
  TheoryName.ofString "SeriesTheory"

def convergenceTheory : TheoryName :=
  TheoryName.ofString "ConvergenceTheory"

/-! ## Derived Types Carrying Proofs -/

structure LimSeq where
  seq : Sequence ℝ
  limit : ℝ
  convergesProof : Sequence.limit seq limit
  deriving Repr, Inhabited

structure SumSeq where
  terms : Sequence ℝ
  sum : ℝ
  convergesProof : Series.limitSum terms sum
  deriving Repr, Inhabited

structure AbsSumSeq where
  terms : Sequence ℝ
  sum : ℝ
  absConvergesProof : Series.limitSum (fun n => |terms n|) sum
  deriving Repr, Inhabited

/-! ## Theory Nodes -/

def sequenceNode : Dependency.TheoryNode :=
  Dependency.node sequenceTheory #["SetModelTheory"]

def seriesNode : Dependency.TheoryNode :=
  Dependency.node seriesTheory #["SequenceTheory"]

def convergenceNode : Dependency.TheoryNode :=
  Dependency.node convergenceTheory #["SequenceTheory", "SeriesTheory"]

/-! ## #eval Tests -/

#eval "Core.Objects: Object instances for Sequence, Series, PowerSeries"
#eval s!"Theory: {sequenceNode.name} depends on {sequenceNode.dependencies.length}"
#eval s!"Theory: {seriesNode.name} depends on {seriesNode.dependencies.length}"
#eval s!"Theory: {convergenceNode.name} depends on {convergenceNode.dependencies.length}"

end MiniSequenceSeries
