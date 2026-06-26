/-
# Benchmark: Full Suite

Comprehensive benchmark running all performance tests in sequence.
-/

import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Theorems.Basic
import MiniFunctionSequences.Theorems.Main
import MiniFunctionSequences.Morphisms.Hom

namespace MiniFunctionSequences.Benchmark

#eval "============================================="
#eval "=== FULL BENCHMARK SUITE ==="
#eval "============================================="

/-! ### Section 1: Convergence -/

#eval "[Section 1] Convergence benchmarks"

def linearSeq (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

#eval "  linearSeq convergence:"
#eval linearSeq 1 5.0
#eval linearSeq 10 5.0
#eval linearSeq 50 5.0
#eval linearSeq 100 5.0

/-! ### Section 2: Arzela-Ascoli -/

#eval "[Section 2] Arzela-Ascoli benchmarks"

noncomputable def sinOverN (n : Nat) (x : ℝ) : ℝ :=
  Real.sin ((n : ℝ) * x) / ((n : ℝ) + 1)

#eval "  sinOverN equicontinuous family:"
#eval sinOverN 1 0.0
#eval sinOverN 5 (Real.pi / 2)
#eval sinOverN 10 (Real.pi / 4)

/-! ### Section 3: Stone-Weierstrass -/

#eval "[Section 3] Stone-Weierstrass benchmarks"

noncomputable def f_sq_full (x : ℝ) : ℝ := x ^ 2

#eval "  Bernstein approximation of x^2:"
#eval bernsteinPolynomial f_sq_full 1 0.5
#eval bernsteinPolynomial f_sq_full 5 0.5
#eval bernsteinPolynomial f_sq_full 10 0.5

/-! ### Section 4: Sup Norm -/

#eval "[Section 4] Sup norm benchmarks"

#eval "  supNormOn sin on [0, pi]:"
#eval supNormOn Real.sin (Set.Icc 0 Real.pi)

#eval "  supNormOn sin on [0, 2*pi]:"
#eval supNormOn Real.sin (Set.Icc 0 (2 * Real.pi))

/-! ### Section 5: Cesaro Summation -/

#eval "[Section 5] Cesaro summation benchmarks"

def altSeq_full : Nat → ℝ
  | 0 => 1
  | n+1 => (-1 : ℝ) ^ (n+1) / ((n+1 : ℕ) : ℝ)

#eval "  Cesaro mean of alternating sequence:"
#eval cesaroMean altSeq_full 10
#eval cesaroMean altSeq_full 50
#eval cesaroMean altSeq_full 100
#eval cesaroMean altSeq_full 500

/-! ### Section 6: Taylor/Polynomial Approximations -/

#eval "[Section 6] Taylor approximations"

noncomputable def taylorExp (n : Nat) (x : ℝ) : ℝ :=
  (Finset.range (n+1)).sum λ k => x ^ k / (Nat.factorial k : ℝ)

#eval "  Taylor exp(1) convergence:"
#eval taylorExp 0 1.0
#eval taylorExp 3 1.0
#eval taylorExp 5 1.0
#eval taylorExp 10 1.0

#eval "============================================="
#eval "=== BENCHMARK SUITE COMPLETE ==="
#eval "============================================="

end MiniFunctionSequences.Benchmark
