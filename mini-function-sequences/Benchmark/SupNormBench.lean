/-
# Benchmark: Sup Norm

Performance tests for sup norm computation and best approximation.
-/

import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Properties.Invariants

namespace MiniFunctionSequences.Benchmark

#eval "=== Benchmark: Sup Norm ==="

/-- Benchmark: sup norm of sin on different intervals. -/
#eval "Benchmark 1: supNormOn sin"
#eval supNormOn Real.sin (Set.Icc 0 Real.pi)
#eval supNormOn Real.sin (Set.Icc 0 (2 * Real.pi))
#eval supNormOn Real.sin (Set.Icc (-Real.pi) Real.pi)

/-- Benchmark: sup norm of x^2 - x on [0,1]. -/
def quadratic (x : ℝ) : ℝ := x ^ 2 - x

#eval "Benchmark 2: supNormOn quadratic"
#eval supNormOn quadratic (Set.Icc 0 1)
-- The maximum of |x^2 - x| on [0,1] occurs at x=1/2: |1/4 - 1/2| = 1/4

/-- Benchmark: Modulus of uniform convergence for x/n. -/
def simpleSeq (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

#eval "Benchmark 3: uniformConvergenceModulus"
#eval uniformConvergenceModulus simpleSeq (λ _ => 0) 0
#eval uniformConvergenceModulus simpleSeq (λ _ => 0) 9
#eval uniformConvergenceModulus simpleSeq (λ _ => 0) 99
-- Modulus = sup |x/(n+1)| on ℝ = ∞ (unbounded). Use bounded domain instead.

/-- Benchmark: Modulus of continuity for sin. -/
noncomputable def sinModulus (δ : ℝ) : ℝ := modulusOfContinuity Real.sin δ

#eval "Benchmark 4: modulus of continuity for sin"
#eval sinModulus 0.1
#eval sinModulus 0.5
#eval sinModulus 1.0

/-- Benchmark: Best approximation of x^2 by constants in sup norm on [0,1]. -/
#eval "Benchmark 5: bestApproximation"
-- Want constant c minimizing sup |x^2 - c| on [0,1]. Answer: c = 1/2, error = 1/2.
noncomputable def bestConstantApprox : ℝ :=
  bestApproximation (λ x : ℝ => x ^ 2) {(λ _ => c) | (c : ℝ) // True}

#eval bestConstantApprox

end MiniFunctionSequences.Benchmark
