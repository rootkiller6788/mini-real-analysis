/-
# Benchmark: Full Suite

Aggregates all measure theory benchmarks into a single run.
-/

import MiniMeasureLebesgue
open MiniMeasureLebesgue

/-! ## Run All Benchmarks -/

def benchAllMeasureOps (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := (default : Measure Nat (default : MeasurableSpace Nat)).value ∅
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  [FullSuite] Measure ops ({n}): {elapsed}ms"

def benchAllSimpleFunctions (n : Nat) : IO Unit := do
  let sf : SimpleFunction Nat (default : MeasurableSpace Nat) :=
    { coeffs := [RealNumbers.one]
      sets := [{n : Nat | n = 0}]
      len_eq := rfl
      measurable_sets := by
        intro s hs; simp at hs; subst hs; exact trivial
      disjoint := by
        intro i j hi hj hne; simp
    }
  let start ← IO.monoMsNow
  let mut _eval := RealNumbers.zero
  for i in [0:n] do
    _eval := sf.eval i
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  [FullSuite] Simple functions ({n}): {elapsed}ms"

def benchAllConvergence (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := RealNumbers.one  -- MCT/DCT/Fatou simulation
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  [FullSuite] Convergence ({n}): {elapsed}ms"

def benchAllLpSpaces (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _norm := RealNumbers.zero
  for _ in [0:n] do
    _norm := l1Norm (default : Measure Nat (default : MeasurableSpace Nat))
      (fun _ : Nat => RealNumbers.one)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  [FullSuite] L^p spaces ({n}): {elapsed}ms"

def benchAllProductMeasures (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let ν : Measure Nat (default : MeasurableSpace Nat) := default
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := RealNumbers.mul (μ.value ∅) (ν.value ∅)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  [FullSuite] Product measures ({n}): {elapsed}ms"

/-! ## Full Suite Report -/

def reportSummary (times : List (String × Nat)) : IO Unit := do
  IO.println ""
  IO.println "============================================"
  IO.println "  Full Suite Summary"
  IO.println "============================================"
  let total := times.map (·.2) |>.sum
  for (name, t) in times do
    IO.println s!"  {name}: {t}ms"
  IO.println s!"  TOTAL: {total}ms"
  IO.println "============================================"

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  MiniMeasureLebesgue: Full Benchmark Suite"
  IO.println "============================================"
  IO.println ""
  let startTotal ← IO.monoMsNow

  benchAllMeasureOps 10000
  benchAllSimpleFunctions 5000
  benchAllConvergence 5000
  benchAllLpSpaces 5000
  benchAllProductMeasures 5000

  let totalElapsed := (← IO.monoMsNow) - startTotal
  IO.println ""
  IO.println s!"  TOTAL SUITE TIME: {totalElapsed}ms"
  IO.println "============================================"
  IO.println "  Full benchmark suite complete."
  IO.println "============================================"
