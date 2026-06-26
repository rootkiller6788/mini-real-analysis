/-
# Benchmark: Full Suite

Runs all metric topology benchmarks and reports aggregate results.
-/

import MiniMetricTopology

open MiniMetricTopology

def runAllBenchmarks : IO Unit := do
  IO.println "════════════════════════════════════════"
  IO.println "  MiniMetricTopology Benchmark Suite"
  IO.println "════════════════════════════════════════"
  IO.println ""

  -- Distance operations
  let startTotal ← IO.monoMsNow

  let start ← IO.monoMsNow
  for _ in List.range 50000 do
    let _ := d ((3 : ℝ)) ((7 : ℝ))
  let distElapsed ← IO.monoMsNow
  IO.println s!"  50k standard distances:   {distElapsed - start}ms"

  let start ← IO.monoMsNow
  for _ in List.range 50000 do
    let _ := d ((3, 5) : ℝ × ℝ) ((7, 9) : ℝ × ℝ)
  let prodElapsed ← IO.monoMsNow
  IO.println s!"  50k product distances:    {prodElapsed - start}ms"

  let start ← IO.monoMsNow
  for _ in List.range 50000 do
    let _ := ball (0 : ℝ) 1
  let ballElapsed ← IO.monoMsNow
  IO.println s!"  50k ball constructions:   {ballElapsed - start}ms"

  let start ← IO.monoMsNow
  for _ in List.range 10000 do
    let _ := cauchySequence (λ n : ℕ => 1 / ((n : ℝ) + 1))
  let cauchyElapsed ← IO.monoMsNow
  IO.println s!"  10k Cauchy checks:        {cauchyElapsed - start}ms"

  let start ← IO.monoMsNow
  for _ in List.range 5000 do
    let _ := isOpen (Set.univ : Set ℝ)
  let openElapsed ← IO.monoMsNow
  IO.println s!"  5k open set checks:       {openElapsed - start}ms"

  let start ← IO.monoMsNow
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
  let mut x := (1 : ℝ)
  for _ in List.range 100000 do
    x := f.f x
  let fixedElapsed ← IO.monoMsNow
  IO.println s!"  100k fixed point iter:    {fixedElapsed - start}ms (final x={x})"

  let totalElapsed ← IO.monoMsNow
  IO.println ""
  IO.println s!"  Total benchmark time: {totalElapsed - startTotal}ms"
  IO.println "════════════════════════════════════════"

def main : IO Unit := runAllBenchmarks

#eval "Run: lake env lean --run Benchmark/FullSuite.lean"
