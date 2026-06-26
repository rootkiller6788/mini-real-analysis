/-
# Benchmark: Stone-Weierstrass

Performance tests for polynomial approximation and Bernstein convergence.
-/

import MiniFunctionSequences.Theorems.Main

namespace MiniFunctionSequences.Benchmark

#eval "=== Benchmark: Stone-Weierstrass ==="

/-- Benchmark: Bernstein polynomial evaluation for various degrees. -/
noncomputable def f_abs (x : ℝ) : ℝ := |x - 0.5|

#eval "Benchmark 1: Bernstein B_n(|x-0.5|) at x=0.5"
#eval bernsteinPolynomial f_abs 2 0.5
#eval bernsteinPolynomial f_abs 5 0.5
#eval bernsteinPolynomial f_abs 10 0.5
#eval bernsteinPolynomial f_abs 20 0.5

/-- Benchmark: Bernstein convergence rate for x^2. -/
noncomputable def f_sq (x : ℝ) : ℝ := x ^ 2

#eval "Benchmark 2: Bernstein convergence for x^2"
#eval bernsteinPolynomial f_sq 1 0.5
#eval bernsteinPolynomial f_sq 3 0.5
#eval bernsteinPolynomial f_sq 5 0.5
#eval bernsteinPolynomial f_sq 10 0.5
-- Exact: B_n(x^2)(x) = x^2 + x(1-x)/n at x=0.5: 0.25 + 0.25/n

/-- Benchmark: Stone-Weierstrass on trigonometric polynomials. -/
def trigPoly (n : Nat) (x : ℝ) : ℝ :=
  ((Nat.factorial n : ℝ)⁻¹) * Real.sin ((n : ℝ) * x)

#eval "Benchmark 3: trigonometric approximation"
#eval trigPoly 1 (Real.pi / 2)
#eval trigPoly 2 (Real.pi / 2)
#eval trigPoly 3 (Real.pi / 2)

/-- Benchmark: Polynomial density check — approximate exp on [0,1] by Taylor. -/
noncomputable def taylorExp (n : Nat) (x : ℝ) : ℝ :=
  (Finset.range (n+1)).sum λ k => x ^ k / (Nat.factorial k : ℝ)

#eval "Benchmark 4: Taylor approximation of exp"
#eval taylorExp 0 1.0
#eval taylorExp 1 1.0
#eval taylorExp 3 1.0
#eval taylorExp 5 1.0
#eval taylorExp 10 1.0
-- Should approach Real.exp 1 = e ≈ 2.7182818

end MiniFunctionSequences.Benchmark
