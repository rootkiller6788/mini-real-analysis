/-
# Benchmark: Distance Computation

Performance tests for various distance functions: standard metric,
Euclidean, discrete, product metrics.
-/

import MiniMetricTopology

open MiniMetricTopology

def benchmarkStandardDistance : IO Unit := do
  let points : List (ℝ × ℝ) := (List.range 1000).map λ i =>
    (Real.sin (i.toFloat.toFloat), Real.cos ((3*i).toFloat.toFloat))
  let start ← IO.monoMsNow
  for (a, b) in points do
    let _ := d a b
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 1000 standard distance pairs: {elapsed - start}ms"

def benchmarkProductDistance : IO Unit := do
  let points : List ((ℝ × ℝ) × (ℝ × ℝ)) := (List.range 1000).map λ i =>
    ((Real.sin (i.toFloat.toFloat), Real.cos ((2*i).toFloat.toFloat)),
     (Real.cos ((3*i).toFloat.toFloat), Real.sin ((5*i).toFloat.toFloat)))
  let start ← IO.monoMsNow
  for (a, b) in points do
    let _ := d a b
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 1000 product distance pairs: {elapsed - start}ms"

def benchmarkDiscreteDistance : IO Unit := do
  let indices : List (Fin 100× Fin 100) := (List.range 1000).map λ i =>
    (Fin.ofNat (i % 100), Fin.ofNat ((i*i) % 100))
  let start ← IO.monoMsNow
  for (a, b) in indices do
    let _ := d (discreteMetricSpace (Fin 100)) a b
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 1000 discrete distance pairs: {elapsed - start}ms"

def main : IO Unit := do
  IO.println "=== Distance Benchmarks ==="
  benchmarkStandardDistance
  benchmarkProductDistance
  benchmarkDiscreteDistance

#eval "Run: lake env lean --run Benchmark/DistanceBench.lean"
