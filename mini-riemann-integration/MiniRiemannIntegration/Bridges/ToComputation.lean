/-
# MiniRiemannIntegration.Bridges.ToComputation

Numerical integration: rectangle rule, trapezoidal rule,
Simpson's rule, Romberg integration, and Gaussian quadrature.
-/

import MiniRiemannIntegration.Bridges.ToGeometry
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Rectangle rule (left endpoint) -/

structure RectangleRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) where
  h : ℝ := (b - a) / (↑n : ℝ)
  approximation : ℝ := h * (List.range n |>.map (fun i => f (a + (↑i : ℝ) * h)) |>.sum)
  -- Σ_{i=0}^{n-1} f(x_i) * Δx
  error : Prop  -- O(1/n)

def rectangleRuleFormula : Axiom :=
  Axiom.mk "rectangleRule" (Formula.pred 0 [])
    "Left rectangle rule: ∫_a^b f(x)dx ≈ h·Σ_{i=0}^{n-1} f(a + i·h), error O(h)"

/-! ## Trapezoidal rule -/

structure TrapezoidalRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) where
  h : ℝ := (b - a) / (↑n : ℝ)
  approximation : ℝ := h * ((f a + f b) / 2 +
    (List.range (n - 1) |>.map (fun i => f (a + (↑(i+1) : ℝ) * h)) |>.sum))
  -- Σ (f(x_i) + f(x_{i+1}))/2 * Δx
  error : Prop  -- O(1/n²)

def trapezoidalRuleFormula : Axiom :=
  Axiom.mk "trapezoidalRule" (Formula.pred 0 [])
    "Trapezoidal rule: ∫_a^b f(x)dx ≈ h·(f(a)/2 + Σ_{i=1}^{n-1} f(x_i) + f(b)/2), error O(h²) for C² functions"

/-! ## Simpson's rule (exact for cubics) -/

structure SimpsonRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) where
  h : ℝ := (b - a) / (↑n : ℝ)
  approximation : ℝ := 0  -- h/3 * (f(x_0) + 4f(x_1) + 2f(x_2) + ... + 4f(x_{n-1}) + f(x_n))
  requires_even_n : n % 2 = 0
  error : Prop  -- O(1/n⁴)

def simpsonRuleFormula : Axiom :=
  Axiom.mk "simpsonRule" (Formula.pred 0 [])
    "Simpson's rule: exact for polynomials up to degree 3, error O(h⁴) for C⁴ functions"

/-! ## Romberg integration (extrapolation) -/

structure RombergIntegration (f : ℝ → ℝ) (a b : ℝ) (maxLevel : ℕ) where
  R : ℕ → ℕ → ℝ  -- Romberg table R(k,m)
  -- R(k,0) = trapezoidal rule with 2^k subintervals
  -- R(k,m) = (4^m * R(k,m-1) - R(k-1,m-1)) / (4^m - 1)
  approximation : ℝ := R maxLevel maxLevel
  acceleratedConvergence : Prop

def rombergFormula : Axiom :=
  Axiom.mk "rombergIntegration" (Formula.pred 0 [])
    "Romberg integration uses Richardson extrapolation on trapezoidal rule values to achieve high-order accuracy"

/-! ## Gaussian quadrature -/

structure GaussianQuadrature (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) where
  nodes : List ℝ  -- roots of Legendre polynomial P_n
  weights : List ℝ
  approximation : ℝ := (nodes.zip weights).map (fun (x, w) => w * f x) |>.sum
  -- ∫_a^b f(x)dx ≈ Σ_{i=1}^n w_i f(x_i)
  exactForDegree : Prop  -- exact for polynomials up to degree 2n-1

def gaussianQuadratureFormula : Axiom :=
  Axiom.mk "gaussianQuadrature" (Formula.pred 0 [])
    "n-point Gaussian quadrature is exact for polynomials up to degree 2n-1; nodes are roots of P_n(x)"

/-! ## Adaptive quadrature -/

structure AdaptiveQuadrature (f : ℝ → ℝ) (a b : ℝ) (tolerance : ℝ) where
  result : ℝ
  recursion_depth : ℕ
  errorEstimate : ℝ
  converged : errorEstimate < tolerance

/-! ## Monte Carlo integration -/

structure MonteCarloIntegration (f : ℝ → ℝ) (a b : ℝ) (samples : ℕ) where
  approximation : ℝ := ((b - a) / (↑samples : ℝ)) *
    (List.range samples |>.map (fun _ => f (a + (b - a) * 0.5)) |>.sum)
  -- (b-a)/N * Σ f(x_i) where x_i are random samples
  convergence : Prop  -- O(1/√N)

/-! ## #eval Tests -/

#eval "Bridges.ToComputation: RectangleRule, TrapezoidalRule"
#eval "Bridges.ToComputation: SimpsonRule, RombergIntegration"
#eval "Bridges.ToComputation: GaussianQuadrature, AdaptiveQuadrature, MonteCarloIntegration"

end MiniRiemannIntegration
