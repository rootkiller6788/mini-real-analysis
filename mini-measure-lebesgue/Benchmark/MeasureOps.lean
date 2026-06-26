/-
# Benchmark: Measure Operations

Performance benchmarking for sigma-algebra membership, measure evaluation,
and set operations.
-/

import MiniMeasureLebesgue
open MiniMeasureLebesgue

/-! ## Benchmark: Sigma-Algebra Membership -/

def benchSigmaAlgebraMembership (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _count : Nat := 0
  for _ in [0:n] do
    if (SigmaAlgebra.trivial Nat).emptyMem then
      _count := _count + 1
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Sigma-algebra membership ({n} ops): {elapsed}ms"

/-! ## Benchmark: Measure Evaluation -/

def benchMeasureEval (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := μ.value ∅
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Measure evaluation ({n} ops): {elapsed}ms"

/-! ## Benchmark: Set Operations -/

def benchSetOperations (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let A : Set Nat := {x | x % 2 = 0}
  let B : Set Nat := {x | x % 3 = 0}
  let mut _acc : Set Nat := ∅
  for _ in [0:n] do
    _acc := A ∪ B
    _acc := A ∩ B
    _acc := A \ B
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Set operations ({n} cycles): {elapsed}ms"

/-! ## Benchmark: Measurable Function Composition -/

def benchMeasurableComposition (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let f : MeasurableMap Nat Nat
    (default : MeasurableSpace Nat) (default : MeasurableSpace Nat) :=
    MeasurableMap.id Nat (default : MeasurableSpace Nat)
  let mut _f := f
  for _ in [0:n] do
    _f := MeasurableMap.comp _f f
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Measurable composition ({n} comps): {elapsed}ms"

/-! ## Main Benchmark -/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  Measure Theory Benchmark: Measure Ops"
  IO.println "============================================"
  IO.println ""
  benchSigmaAlgebraMembership 10000
  benchMeasureEval 10000
  benchSetOperations 1000
  benchMeasurableComposition 1000
  IO.println ""
  IO.println "============================================"
  IO.println "  Benchmark complete."
  IO.println "============================================"
