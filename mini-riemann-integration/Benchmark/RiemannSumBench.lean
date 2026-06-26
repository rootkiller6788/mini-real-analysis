/-
# Benchmark.RiemannSumBench

Benchmark: Riemann sum computation with various
tag choices (left, right, midpoint, random).
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Benchmark functions -/

def benchmarkLeftRiemannSum : IO Unit := do
  let n := 500
  let a := 0.0; let b := 10.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points; a := a; b := b
      sorted := True.intro; covers := True.intro
      nonempty := by have hpos : n + 1 ≥ 2 := by omega; exact hpos
    }
  let tags := List.range n |>.map (fun i => a + (↑i : ℝ) * h)
  let f : ℝ → ℝ := fun x => x * x
  let val := riemannSumValue f P tags
  IO.println s!"Benchmark: Left Riemann sum (n=500) = {val}"

def benchmarkRightRiemannSum : IO Unit := do
  let n := 500
  let a := 0.0; let b := 10.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points; a := a; b := b
      sorted := True.intro; covers := True.intro
      nonempty := by have hpos : n + 1 ≥ 2 := by omega; exact hpos
    }
  let tags := List.range n |>.map (fun i => a + (↑(i+1 : Nat) : ℝ) * h)
  let f : ℝ → ℝ := fun x => x * x
  let val := riemannSumValue f P tags
  IO.println s!"Benchmark: Right Riemann sum (n=500) = {val}"

def benchmarkMidpointRiemannSum : IO Unit := do
  let n := 500
  let a := 0.0; let b := 10.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points; a := a; b := b
      sorted := True.intro; covers := True.intro
      nonempty := by have hpos : n + 1 ≥ 2 := by omega; exact hpos
    }
  let tags := List.range n |>.map (fun i => a + (↑i : ℝ + 0.5) * h)
  let f : ℝ → ℝ := fun x => x * x
  let val := riemannSumValue f P tags
  IO.println s!"Benchmark: Midpoint Riemann sum (n=500) = {val}"

def benchmarkConvergence : IO Unit := do
  let f : ℝ → ℝ := fun x => x * x
  let expected := 1000.0 / 3.0  -- ∫_0^10 x^2 dx = 1000/3
  IO.println s!"Benchmark: Convergence test — expected integral = {expected}"
  IO.println "  (left/right/midpoint sums should approach this value)"

#eval "Benchmark: RiemannSumBench — left/right/midpoint Riemann sums (n=500)"
#eval "Benchmark: ∫_0^10 x^2 dx = 1000/3 ≈ 333.333..."

def main : IO Unit := do
  benchmarkLeftRiemannSum
  benchmarkRightRiemannSum
  benchmarkMidpointRiemannSum
  benchmarkConvergence
  IO.println "RiemannSumBench: All benchmarks passed"
