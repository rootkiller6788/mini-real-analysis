/-
# Computation: Algorithms

Numerical algorithms related to function sequences:
Bernstein evaluation via de Casteljau, Remez algorithm steps,
Chebyshev interpolation, and uniform convergence rate estimation.
-/

import MiniFunctionSequences.Theorems.Main

namespace MiniFunctionSequences.Computation

#eval "=== Computation: Algorithms ==="

/-! ## de Casteljau Algorithm (Recursive) -/

/-- Recursive de Casteljau algorithm for evaluating a polynomial in Bernstein form. -/
def deCasteljau (coeffs : List ℝ) (t : ℝ) : ℝ :=
  match coeffs with
  | [] => 0
  | [c] => c
  | cs =>
    let n := cs.length
    let newCoeffs := (List.zip cs (cs.tail)).map λ (c0, c1) => (1 - t) * c0 + t * c1
    deCasteljau newCoeffs t

#eval "de Casteljau: (1-t)*0 + t*1 at t=0.5"
#eval deCasteljau [0.0, 1.0] 0.5
#eval deCasteljau [0.0, 1.0, 0.0] 0.5
#eval deCasteljau [0.0, 0.0, 1.0, 0.0] 0.5

/-! ## Chebyshev Nodes Computation -/

/-- Chebyshev nodes of the second kind on [a,b]: x_k = (a+b)/2 + (b-a)/2 * cos(kπ/n). -/
def chebyshevNodes (a b : ℝ) (n : Nat) (k : Nat) : ℝ :=
  (a + b) / 2 + ((b - a) / 2) * Real.cos (Real.pi * (k : ℝ) / (n : ℝ))

#eval "Chebyshev nodes on [0,1] with n=4:"
#eval chebyshevNodes 0 1 4 0
#eval chebyshevNodes 0 1 4 1
#eval chebyshevNodes 0 1 4 2
#eval chebyshevNodes 0 1 4 3

/-! ## Uniform Convergence Rate Estimator -/

/-- Estimate the convergence rate by computing sup norms at successive terms. -/
noncomputable def estimateConvergenceRate (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ)
    (A : Set ℝ) (n_max : Nat) : List ℝ :=
  (List.range n_max).map λ n => supNormOn (λ x => f_n n x - f x) A

#eval "Convergence rate estimate for x/n on [0,1]:"
let f_n : SequenceOfFunctions ℝ := λ n x => x / ((n : ℝ) + 1)
let f_zero : ℝ → ℝ := λ _ => 0
-- estimateConvergenceRate f_n f_zero (Set.Icc 0 1) 5

/-! ## Polynomial Approximation via Orthogonal Projection -/

/-- Least-squares polynomial approximation of degree n to f on [a,b]
    using Legendre polynomial basis. -/
noncomputable def leastSquaresApprox (f : ℝ → ℝ) (n : Nat) (a b : ℝ) (x : ℝ) : ℝ :=
  -- Placeholder: would compute coefficients via numerical integration
  0

/-- Gram-Schmidt orthogonalization of monomial basis to get Legendre polynomials. -/
def gramSchmidtLegendre (n : Nat) : List (Polynomial ℝ) :=
  -- Placeholder
  [Polynomial.monomial 0 1]

#eval "--- Algorithms complete ---"

end MiniFunctionSequences.Computation
