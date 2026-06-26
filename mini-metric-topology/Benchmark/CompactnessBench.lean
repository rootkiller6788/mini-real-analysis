/-
# Benchmark: Compactness Checks

Performance tests for compactness-related operations:
finite covers, sequential compactness, total boundedness.
-/

import MiniMetricTopology

open MiniMetricTopology

def benchmarkFiniteCoverCheck : IO Unit := do
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := totallyBounded (α := Fin 10)
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 totallyBounded checks: {elapsed - start}ms"

def benchmarkCauchySequenceCheck : IO Unit := do
  let seq : ℕ → ℝ := λ n => 1 / ((n : ℝ) + 1)
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := cauchySequence seq
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 Cauchy sequence checks: {elapsed - start}ms"

def benchmarkSequentialCompactness : IO Unit := do
  let seq : ℕ → Fin 5 := λ n => Fin.ofNat (n % 5)
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := sequentiallyCompact (α := Fin 5)
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 sequential compactness checks: {elapsed - start}ms"

def main : IO Unit := do
  IO.println "=== Compactness Benchmarks ==="
  benchmarkFiniteCoverCheck
  benchmarkCauchySequenceCheck
  benchmarkSequentialCompactness

#eval "Run: lake env lean --run Benchmark/CompactnessBench.lean"
