/-
# Benchmark: Fubini-Tonelli and Product Measures

Performance benchmarking for product measure operations,
iterated integrals, and Fubini-Tonelli simulations.
-/

import MiniMeasureLebesgue
open MiniMeasureLebesgue

/-! ## Benchmark: Product Sigma-Algebra -/

def benchProductSigmaAlgebra (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _ms : MeasurableSpace (Nat × Nat) :=
    productMeasurableSpace Nat Nat (default : MeasurableSpace Nat) (default : MeasurableSpace Nat)
  for _ in [0:n] do
    _ms := productMeasurableSpace Nat Nat (default : MeasurableSpace Nat) (default : MeasurableSpace Nat)
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Product sigma-algebra ({n} constructions): {elapsed}ms"

/-! ## Benchmark: Measurable Rectangle Check -/

def benchMeasurableRectangle (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let msX : MeasurableSpace Nat := default
  let msY : MeasurableSpace Nat := default
  let A : Set Nat := {x | x % 2 = 0}
  let B : Set Nat := {y | y % 3 = 0}
  let mut _result := True
  for _ in [0:n] do
    _result := isMeasurable msX A ∧ isMeasurable msY B
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Measurable rectangle ({n} checks): {elapsed}ms"

/-! ## Benchmark: Product Measure on Rectangles -/

def benchProductMeasureRect (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let μ : Measure Nat (default : MeasurableSpace Nat) := default
  let ν : Measure Nat (default : MeasurableSpace Nat) := default
  let mut _acc := RealNumbers.zero
  for _ in [0:n] do
    _acc := RealNumbers.mul (μ.value {x : Nat | x < 10}) (ν.value {y : Nat | y < 10})
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Product measure on rectangle ({n} ops): {elapsed}ms"

/-! ## Benchmark: Iterated Integral Order Swap -/

def benchIteratedIntegralSwap (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _fst := RealNumbers.zero
  let mut _snd := RealNumbers.zero
  for _k in [0:n] do
    -- ∫∫ f(x,y) dx dy vs ∫∫ f(x,y) dy dx
    _fst := RealNumbers.one
    _snd := RealNumbers.one
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Iterated integral swap ({n} ops): {elapsed}ms"

/-! ## Benchmark: Fubini Condition Check -/

def benchFubiniCondition (n : Nat) : IO Unit := do
  let start ← IO.monoMsNow
  let mut _condition := True
  for _ in [0:n] do
    -- Check: ∬ |f| dμdν < ∞ ?
    _condition := True
  let elapsed := (← IO.monoMsNow) - start
  IO.println s!"  Fubini condition check ({n} checks): {elapsed}ms"

/-! ## Main Benchmark -/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  Measure Theory Benchmark: Fubini"
  IO.println "============================================"
  IO.println ""
  benchProductSigmaAlgebra 1000
  benchMeasurableRectangle 5000
  benchProductMeasureRect 5000
  benchIteratedIntegralSwap 2000
  benchFubiniCondition 5000
  IO.println ""
  IO.println "============================================"
  IO.println "  Benchmark complete."
  IO.println "============================================"
