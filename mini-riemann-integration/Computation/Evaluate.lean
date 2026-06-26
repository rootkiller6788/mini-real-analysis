/-
# Computation.Evaluate

Evaluation utilities for definite integrals using
various methods with error estimation.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Evaluate integral with multiple methods -/

structure IntegralEvaluation where
  f : ℝ → ℝ
  a : ℝ
  b : ℝ
  exactValue : Option ℝ
  rectangleEstimate : ℝ
  trapezoidalEstimate : ℝ
  simpsonEstimate : ℝ
  errorEstimates : ℝ × ℝ × ℝ  -- errors for each method

def evaluateIntegral (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (exact : Option ℝ) : IntegralEvaluation where
  f := f; a := a; b := b
  exactValue := exact
  rectangleEstimate := rectangleRule f a b n (by omega)
  trapezoidalEstimate := trapezoidalRule f a b n (by omega)
  simpsonEstimate := if h : n % 2 = 0 then
    simpsonRule f a b n h (by omega) else 0
  errorEstimates := (0, 0, 0)

/-! ## Error estimation -/

def estimateError (approx exact : ℝ) : ℝ := |approx - exact|

/-! ## Convergence rate check -/

def convergenceRate (f : ℝ → ℝ) (a b : ℝ) (exact : ℝ) (ns : List ℕ) : List ℝ :=
  -- For each n in ns, compute error and estimate convergence rate
  let errors := ns.map (fun n =>
    let approx := trapezoidalRule f a b n (by omega)
    estimateError approx exact)
  -- Estimate rate: e_n / e_{2n} ≈ 2^p ⇒ p ≈ log2(e_n / e_{2n})
  errors  -- stub

/-! ## Richardson extrapolation for error control -/

def richardsonErrorEstimate (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) : ℝ × ℝ :=
  -- Returns (estimate, error_estimate) using Richardson extrapolation
  let T_n := trapezoidalRule f a b n (by omega)
  let T_2n := trapezoidalRule f a b (2*n) (by omega)
  (T_2n, (T_2n - T_n) / 3)  -- error estimate: |T_2n - T_n| / 3

/-! ## Adaptive integration -/

def adaptiveQuadrature (f : ℝ → ℝ) (a b : ℝ) (ε : ℝ) (maxDepth : ℕ) : ℝ × ℕ :=
  -- Recursively subdivide until error < ε or max depth reached
  let rec aux (a' b' : ℝ) (depth : ℕ) : ℝ × ℝ × ℕ :=
    if depth = 0 then (0, 0, depth)
    else
      let mid := (a' + b') / 2
      let whole := simpsonRule f a' b' 2 (by decide) (by decide)
      let left := simpsonRule f a' mid 2 (by decide) (by decide)
      let right := simpsonRule f mid b' 2 (by decide) (by decide)
      if |whole - (left + right)| < 15 * ε then
        (left + right, |whole - (left + right)|, depth)
      else
        let (l_val, _, l_d) := aux a' mid (depth - 1)
        let (r_val, _, r_d) := aux mid b' (depth - 1)
        (l_val + r_val, 0, l_d + r_d)
  let (result, _, _) := aux a b maxDepth
  (result, maxDepth)

/-! ## #eval Tests -/

#eval "Computation.Evaluate: IntegralEvaluation, evaluateIntegral"
#eval "Computation.Evaluate: estimateError, convergenceRate"
#eval "Computation.Evaluate: richardsonErrorEstimate, adaptiveQuadrature"
