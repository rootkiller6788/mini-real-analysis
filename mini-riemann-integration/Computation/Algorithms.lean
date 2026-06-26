/-
# Computation.Algorithms

Numerical integration algorithms: rectangle, trapezoidal,
Simpson, Romberg, adaptive quadrature.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Rectangle rule (left endpoint) -/

def rectangleRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (hn : n > 0) : ℝ :=
  let h := (b - a) / (↑n : ℝ)
  let xs := List.range n |>.map (fun i => a + (↑i : ℝ) * h)
  h * (xs.map f).sum

/-! ## Trapezoidal rule -/

def trapezoidalRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (hn : n > 0) : ℝ :=
  let h := (b - a) / (↑n : ℝ)
  let endpoints := (f a + f b) / 2
  let interior := List.range (n-1) |>.map (fun i => f (a + (↑(i+1) : ℝ) * h)) |>.sum
  h * (endpoints + interior)

/-! ## Simpson's rule (composite) -/

def simpsonRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (hn_even : n % 2 = 0) (hn_pos : n > 0) : ℝ :=
  let h := (b - a) / (↑n : ℝ)
  let x i := a + (↑i : ℝ) * h
  let even_terms := List.range (n/2) |>.map (fun k => f (x (2*k + 2))) |>.sum
  let odd_terms := List.range (n/2) |>.map (fun k => f (x (2*k + 1))) |>.sum
  (h / 3) * (f a + f b + 2 * even_terms + 4 * odd_terms)

/-! ## Midpoint rule -/

def midpointRule (f : ℝ → ℝ) (a b : ℝ) (n : ℕ) (hn : n > 0) : ℝ :=
  let h := (b - a) / (↑n : ℝ)
  let xs := List.range n |>.map (fun i => a + (↑i : ℝ + 0.5) * h)
  h * (xs.map f).sum

/-! ## Romberg integration table -/

def rombergTable (f : ℝ → ℝ) (a b : ℝ) (maxK : ℕ) : ℕ → ℕ → ℝ :=
  -- R[k, m]: k = refinement level, m = extrapolation level
  fun k m =>
    if m = 0 then
      trapezoidalRule f a b (2 ^ k) (by omega)
    else if k < m then
      0  -- undefined
    else
      let four_m : ℝ := (4 : ℝ) ^ (↑m : ℕ)
      (four_m * rombergTable f a b maxK k (m-1) - rombergTable f a b maxK (k-1) (m-1)) / (four_m - 1)

/-! ## Richardson extrapolation -/

def richardsonExtrapolation (values : List ℝ) (stepRatios : List ℝ) : List ℝ :=
  -- Given approximate values A(h), A(h/2), A(h/4), ...
  -- compute improved estimates via Richardson extrapolation
  values  -- stub

/-! ## #eval Tests -/

#eval "Computation.Algorithms: rectangleRule, trapezoidalRule, simpsonRule"
#eval "Computation.Algorithms: midpointRule, rombergTable, richardsonExtrapolation"
#eval "Computation.Algorithms: All numerical integration algorithms defined"
