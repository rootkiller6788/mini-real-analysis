/-
# Benchmark: Completion Operations

Performance tests for completion-related operations:
Cauchy sequence equivalence, completion construction, limit computation.
-/

import MiniMetricTopology

open MiniMetricTopology

def benchmarkCauchySequenceEquiv : IO Unit := do
  let seq1 : ℕ → ℝ := λ n => 1 / ((n : ℝ) + 1)
  let seq2 : ℕ → ℝ := λ n => (-1) / ((n : ℝ) + 1)
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := cauchySequenceEquiv seq1 seq2
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 Cauchy equivalence checks: {elapsed - start}ms"

def benchmarkCompletionCreation : IO Unit := do
  let start ← IO.monoMsNow
  for _ in List.range 1000 do
    let _ := Completion ℝ
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 1000 completion creations: {elapsed - start}ms"

def benchmarkEmbedding : IO Unit := do
  let emb := completionEmbedding
  let x : ℝ := 3.14159
  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := emb x
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 10000 completion embeddings: {elapsed - start}ms"

def main : IO Unit := do
  IO.println "=== Completion Benchmarks ==="
  benchmarkCauchySequenceEquiv
  benchmarkCompletionCreation
  benchmarkEmbedding

#eval "Run: lake env lean --run Benchmark/CompletionBench.lean"
