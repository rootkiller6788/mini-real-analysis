/-
# Benchmark: Metric Operations

Performance tests for basic metric operations: distance computation,
ball membership, open/closed set checks.
-/

import MiniMetricTopology

open MiniMetricTopology

def benchmarkDistanceCompute : IO Unit := do
  let a : ℝ := 3.14159
  let b : ℝ := 2.71828
  let start ← IO.monoMsNow
  for _ in List.range 100000 do
    let _ := d a b
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 100000 distance computations: {elapsed - start}ms"

def benchmarkBallMembership : IO Unit := do
  let x : ℝ := 0.5
  let r : ℝ := 1.0
  let ballSet := ball (0 : ℝ) r
  let start ← IO.monoMsNow
  for _ in List.range 100000 do
    let _ := x ∈ ballSet
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 100000 ball membership checks: {elapsed - start}ms"

def benchmarkOpenSetCheck : IO Unit := do
  let S := Set.univ : Set ℝ
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := isOpen S
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 open set checks: {elapsed - start}ms"

def main : IO Unit := do
  IO.println "=== MetricOps Benchmarks ==="
  benchmarkDistanceCompute
  benchmarkBallMembership
  benchmarkOpenSetCheck

#eval "Run MetricOps benchmark with: lake env lean --run Benchmark/MetricOps.lean"
