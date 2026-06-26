/-
# Benchmark: Fixed Point Iteration

Performance tests for contraction mappings and fixed point iteration.
-/

import MiniMetricTopology

open MiniMetricTopology

def benchmarkContractionIteration : IO Unit := do
  let f : ContractionMapping ℝ where
    f := λ x => x / 2
    k := 1/2
    hk_pos := by norm_num
    hk_lt_one := by norm_num
    contract := by
      intro x y; dsimp
      calc
        |x/2 - y/2| = (1/2) * |x - y| := by
          rw [← mul_sub, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 1/2)]
        _ ≤ (1/2) * |x - y| := le_refl _
  let x₀ : ℝ := 1.0
  let start ← IO.monoMsNow
  let mut x := x₀
  for _ in List.range 100000 do
    x := f.f x
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 100000 contraction iterations: {elapsed - start}ms"
  IO.println s!"Final x ≈ {x} (should be close to 0)"

def benchmarkMultipleContractions : IO Unit := do
  let start ← IO.monoMsNow
  for k in List.range 100 do
    let f : ContractionMapping ℝ where
      f := λ x => x * ((k : ℝ) / 100)
      k := k / 100
      hk_pos := by
        have : 0 ≤ (k : ℝ) := by exact_mod_cast (Nat.zero_le _)
        positivity
      hk_lt_one := by
        have : (k : ℕ) < 100 := by
          apply Nat.lt_of_lt_of_le (by decide) (by decide)
        sorry
      contract := by
        sorry
    let _ := f.k
  let elapsed ← IO.monoMsNow
  IO.println s!"Benchmarked 100 contraction creations: {elapsed - start}ms"

def main : IO Unit := do
  IO.println "=== Fixed Point Benchmarks ==="
  benchmarkContractionIteration
  benchmarkMultipleContractions

#eval "Run: lake env lean --run Benchmark/FixedPointBench.lean"
