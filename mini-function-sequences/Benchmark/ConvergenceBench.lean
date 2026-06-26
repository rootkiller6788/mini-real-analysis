/-
# Benchmark: Convergence

Performance tests for pointwise and uniform convergence checks.
-/

import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences.Benchmark

#eval "=== Benchmark: Convergence ==="

/-- Benchmark: Check uniform convergence of x/n → 0 on [-100, 100]. -/
def linearSeq (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

/-- Count how many terms needed for ε = 0.1 on [0, 10]. -/
def convergenceRate (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ) (A : Set ℝ) (ε : ℝ) : Nat :=
  0  -- placeholder, would compute the minimal N

#eval "Benchmark 1: convergence check"
#eval linearSeq 10 5.0
#eval linearSeq 100 5.0
#eval linearSeq 1000 5.0

/-- Benchmark: Pointwise convergence of power sequence. -/
def powSeq (n : Nat) (x : ℝ) : ℝ := x ^ n

#eval "Benchmark 2: power sequence decay"
#eval powSeq 1 0.5
#eval powSeq 5 0.5
#eval powSeq 10 0.5
#eval powSeq 20 0.5
#eval powSeq 50 0.5

/-- Benchmark: sup norm computation on dense set. -/
#eval "Benchmark 3: sup norm"
#eval supNormOn (λ x : ℝ => x ^ 2 - x) (Set.Icc 0 1)

/-- Benchmark: Cesàro mean convergence rate. -/
def altSeq : Nat → ℝ
  | 0 => 1
  | n+1 => -((1 : ℝ) / ((n+2 : ℕ) : ℝ))

#eval "Benchmark 4: Cesàro mean"
#eval cesaroMean altSeq 10
#eval cesaroMean altSeq 50
#eval cesaroMean altSeq 100
#eval cesaroMean altSeq 500

end MiniFunctionSequences.Benchmark
