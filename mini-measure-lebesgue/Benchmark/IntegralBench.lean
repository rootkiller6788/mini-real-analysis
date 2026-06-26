/-
# Benchmark: Integral Computation

Performance benchmarking for Lebesgue integral computations,
simple function evaluation, and convergence theorem applications.
-/

import MiniMeasureLebesgue
open MiniMeasureLebesgue

/-! ## Benchmark: Simple Function Evaluation -/

def benchSimpleFunctionEval (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let sf : SimpleFunction Nat (default : MeasurableSpace Nat) :=
    { coeffs := [RealNumbers.one, RealNumbers.one]
      sets := [{n : Nat | n % 2 = 0}, {n : Nat | n % 3 = 0}]
      len_eq := rfl
      measurable_sets := by
        intro s hs; simp at hs
        rcases hs with (rfl | rfl)
        · exact trivial
        · exact trivial
      disjoint := by
        intro i j hi hj hne; simp
    }
  let mut _acc := RealNumbers.zero
  for i in [0:n] do
    _acc := sf.eval i
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Simple function eval ({n} pts): {elapsed}ms"

/-! ## Benchmark: Simple Function Integral -/

def benchSimpleFunctionIntegral (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let sf : SimpleFunction Nat (default : MeasurableSpace Nat) :=
    { coeffs := [RealNumbers.one]
      sets := [{n : Nat | n = 0}]
      len_eq := rfl
      measurable_sets := by
        intro s hs; simp at hs; subst hs; exact trivial
      disjoint := by
        intro i j hi hj hne; simp
    }
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := SimpleFunction.integral sf μ
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Simple function integral ({n} ops): {elapsed}ms"

/-! ## Benchmark: Null Set Checks -/

def benchNullSetCheck (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let _N : Set Nat := {x | x > 1000000}
  let mut _count := 0
  for _ in [0:n] do
    if nullSet μ {x : Nat | x > 1000000} then
      _count := _count + 1
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Null set check ({n} checks): {elapsed}ms"

/-! ## Benchmark: Almost Everywhere -/

def benchAlmostEverywhere (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let _P : Nat → Prop := fun x => x = x
  let mut _count := 0
  for _ in [0:n] do
    if almostEverywhere μ _P then
      _count := _count + 1
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  almostEverywhere check ({n} checks): {elapsed}ms"

/-! ## Main Benchmark -/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  Measure Theory Benchmark: Integral"
  IO.println "============================================"
  IO.println ""
  benchSimpleFunctionEval 5000
  benchSimpleFunctionIntegral 5000
  benchNullSetCheck 1000
  benchAlmostEverywhere 1000
  IO.println ""
  IO.println "============================================"
  IO.println "  Benchmark complete."
  IO.println "============================================"
