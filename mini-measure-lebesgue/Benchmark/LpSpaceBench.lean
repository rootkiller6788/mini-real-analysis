/-
# Benchmark: L^p Space Operations

Performance benchmarking for L^p norm computations,
L^p inclusions, and L^p metric operations.
-/

import MiniMeasureLebesgue
open MiniMeasureLebesgue

/-! ## Benchmark: L^1 Norm -/

def benchL1Norm (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _k in [0:n] do
    _acc := l1Norm (default : Measure Nat (default : MeasurableSpace Nat))
      (fun x : Nat => RealNumbers.one)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  L^1 norm ({n} ops): {elapsed}ms"

/-! ## Benchmark: L^2 Inner Product -/

def benchL2Inner (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _k in [0:n] do
    _acc := l2Inner (default : Measure Nat (default : MeasurableSpace Nat))
      (fun x : Nat => RealNumbers.one)
      (fun x : Nat => RealNumbers.one)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  L^2 inner product ({n} ops): {elapsed}ms"

/-! ## Benchmark: L^2 Norm -/

def benchL2Norm (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _k in [0:n] do
    _acc := l2Norm (default : Measure Nat (default : MeasurableSpace Nat))
      (fun x : Nat => RealNumbers.one)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  L^2 norm ({n} ops): {elapsed}ms"

/-! ## Benchmark: Essential Supremum -/

def benchEssentialSup (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _k in [0:n] do
    _acc := essentialSup (default : Measure Nat (default : MeasurableSpace Nat))
      (fun n : Nat => if n = 0 then RealNumbers.one else RealNumbers.zero)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Essential supremum ({n} ops): {elapsed}ms"

/-! ## Benchmark: L^p Distance -/

def benchLpDistance (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _acc := RealNumbers.zero
  for _k in [0:n] do
    _acc := lpDistance 2
      (fun x : Nat => RealNumbers.zero)
      (fun x : Nat => RealNumbers.one)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  L^p distance ({n} ops): {elapsed}ms"

/-! ## Main Benchmark -/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  Measure Theory Benchmark: L^p Spaces"
  IO.println "============================================"
  IO.println ""
  benchL1Norm 5000
  benchL2Inner 5000
  benchL2Norm 5000
  benchEssentialSup 5000
  benchLpDistance 1000
  IO.println ""
  IO.println "============================================"
  IO.println "  Benchmark complete."
  IO.println "============================================"
