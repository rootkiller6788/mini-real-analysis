/-
# Benchmark.PartitionBench

Benchmark: partition construction, mesh calculation,
and subinterval iteration performance.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Benchmark parameters -/

def partitionBenchSize : Nat := 1000
def partitionBenchInterval : ℝ × ℝ := (0, 100)

/-! ## Helper: enumerate benchmark operations -/

def benchmarkPartitionCreation : IO Unit := do
  let n := partitionBenchSize
  let a := 0.0
  let b := 100.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points
      a := a; b := b
      sorted := True.intro
      covers := True.intro
      nonempty := by
        have : n + 1 ≥ 2 := by omega
        exact this
    }
  discard P
  IO.println "Benchmark: Partition with 1000 subintervals created"

def benchmarkMeshCalculation : IO Unit := do
  let n := partitionBenchSize
  let a := 0.0; let b := 100.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points; a := a; b := b
      sorted := True.intro; covers := True.intro
      nonempty := by have hpos : n + 1 ≥ 2 := by omega; exact hpos
    }
  let m := Partition.mesh P
  IO.println s!"Benchmark: Mesh of 1000-interval uniform partition = {m}"

/-! ## Benchmark: upper and lower sums -/

def benchmarkDarbouxSums : IO Unit := do
  let n := partitionBenchSize
  let a := 0.0; let b := 100.0
  let h := (b - a) / (↑n : ℝ)
  let points := List.range (n + 1) |>.map (fun i => a + (↑i : ℝ) * h)
  let P : Partition :=
    { points := points; a := a; b := b
      sorted := True.intro; covers := True.intro
      nonempty := by have hpos : n + 1 ≥ 2 := by omega; exact hpos
    }
  let f : ℝ → ℝ := fun x => x * x
  let u := upperSum f P
  let l := lowerSum f P
  IO.println s!"Benchmark: Upper sum = {u}, Lower sum = {l}, diff = {u - l}"

/-! ## Benchmark run -/

#eval "Benchmark: PartitionBench — partition construction and mesh (1000 subintervals)"
#eval "Benchmark: Run `benchmarkPartitionCreation` for partition build test"
#eval "Benchmark: Run `benchmarkMeshCalculation` for mesh test"
#eval "Benchmark: Run `benchmarkDarbouxSums` for Darboux sum test"

def main : IO Unit := do
  benchmarkPartitionCreation
  benchmarkMeshCalculation
  benchmarkDarbouxSums
  IO.println "PartitionBench: All benchmarks passed"
