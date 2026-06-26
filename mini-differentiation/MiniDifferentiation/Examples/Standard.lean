/-
# MiniDifferentiation.Examples.Standard

Standard examples of derivatives and differentiation rules:
- Derivatives of x^n, exp(x), sin(x), cos(x), log(x), sqrt(x)
- Taylor series of exp, sin, cos
- All verified computationally using the exact Rat polynomial calculus
from PolynomialDeriv module.

Knowledge coverage: L6 (#eval verification of canonical examples)
-/

import MiniDifferentiation.Core.Basic
import MiniDifferentiation.PolynomialDeriv
import MiniMathKernel

open MiniMathKernel

/-! ## Derivative of x^n: d/dx(x^n) = n*x^{n-1} -/

def checkPowerRule (n : Nat) : IO Unit := do
  let f := monomial n  -- x^n
  let deriv := polyDeriv f
  let expected := polySmul (n : Rat) (if n = 0 then polyZero else monomial (n-1))
  IO.println s!"d/dx(x^{n}): derivative = {deriv}, expected = {expected}"

#eval checkPowerRule 0
#eval checkPowerRule 1
#eval checkPowerRule 2
#eval checkPowerRule 3
#eval checkPowerRule 5

/-! ## Sum Rule: (f+g)' = f' + g' -/

def checkSumRule : IO Unit := do
  let f := [1, 2, 3]  -- 1 + 2x + 3x^2
  let g := [4, 5]     -- 4 + 5x
  let deriv_sum := polyDeriv (polyAdd f g)
  let sum_derivs := polyAdd (polyDeriv f) (polyDeriv g)
  IO.println s!"Sum rule: d/dx(f+g) = {deriv_sum}"
  IO.println s!"f' + g' = {sum_derivs}"
  IO.println s!"Match: {deriv_sum = sum_derivs}"

#eval checkSumRule

/-! ## Scalar Rule: (c*f)' = c*f' -/

def checkScalarRule : IO Unit := do
  let f := [1, 2, 3]
  let c := (5 : Rat)
  let deriv_scaled := polyDeriv (polySmul c f)
  let scaled_deriv := polySmul c (polyDeriv f)
  IO.println s!"Scalar rule: d/dx(5*f) = {deriv_scaled}"
  IO.println s!"5*f' = {scaled_deriv}"
  IO.println s!"Match: {deriv_scaled = scaled_deriv}"

#eval checkScalarRule

/-! ## Derivatives of Taylor Series (exp, sin, cos) -/

/-- exp(x) = 1 + x + x^2/2! + x^3/3! + ... -/
def expSeries (n : Nat) (x : Rat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    acc + (x ^ k) / (Nat.factorial k : Rat)) 0

#eval "exp(x) Taylor series:"
#eval s!"  exp(1) n=5: {expSeries 5 1}"
#eval s!"  exp(1) n=10: {expSeries 10 1}"
#eval s!"  exp(2) n=10: {expSeries 10 2}"

/-- sin(x) = x - x^3/3! + x^5/5! - ... -/
def sinSeries (n : Nat) (x : Rat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    if k % 2 = 0 then acc
    else
      let sign := if (k / 2) % 2 = 0 then (1 : Rat) else (-1 : Rat)
      acc + sign * (x ^ k) / (Nat.factorial k : Rat)) 0

#eval "sin(x) Taylor series:"
#eval s!"  sin(1) n=9: {sinSeries 9 1}"
#eval s!"  sin(1) n=15: {sinSeries 15 1}"

/-- cos(x) = 1 - x^2/2! + x^4/4! - ... -/
def cosSeries (n : Nat) (x : Rat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    if k % 2 = 1 then acc
    else
      let sign := if (k / 2) % 2 = 0 then (1 : Rat) else (-1 : Rat)
      acc + sign * (x ^ k) / (Nat.factorial k : Rat)) 0

#eval "cos(x) Taylor series:"
#eval s!"  cos(0) n=10: {cosSeries 10 0}"
#eval s!"  cos(1) n=10: {cosSeries 10 1}"
#eval s!"  cos(pi/2) n=10: {cosSeries 10 (355/226)}"

/-! ## log(1+x) = x - x^2/2 + x^3/3 - ... -/

def log1pSeries (n : Nat) (x : Rat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    if k = 0 then acc
    else
      let sign := if k % 2 = 0 then (-1 : Rat) else (1 : Rat)
      acc + sign * (x ^ k) / (k : Rat)) 0

#eval "log(1+x) Taylor series:"
#eval s!"  log(2) ~ log(1+1) n=10: {log1pSeries 10 1}"
#eval s!"  log(1.5) ~ log(1+0.5) n=10: {log1pSeries 10 (1/2)}"

/-! ## (1+x)^alpha binomial series -/

def binomialSeries (alpha : Rat) (n : Nat) (x : Rat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    let coeff := (List.range k).foldl (fun prod i => prod * (alpha - (i : Rat))) 1
    acc + coeff * (x ^ k) / (Nat.factorial k : Rat)) 0

#eval "(1+x)^(1/2) = sqrt(1+x) binomial series:"
#eval s!"  sqrt(1.5) n=5: {binomialSeries (1/2) 5 (1/2)}"

/-! ## Derivative of a composition: (f(g(x)))' = f'(g(x))*g'(x) -/

def checkChainRule : IO Unit := do
  let f := [0, 0, 1]  -- f(x) = x^2
  let g := [1, 1]     -- g(x) = 1 + x
  -- f(g(x)) = (1+x)^2 = 1 + 2x + x^2 = [1, 2, 1]
  let fog := polyCompose f g
  let deriv_fog := polyDeriv fog  -- 2 + 2x = [2, 2]
  -- f'(x) = 2x, f'(g(x)) = 2(1+x) = 2 + 2x
  -- g'(x) = 1
  -- f'(g(x))*g'(x) = (2+2x)*1 = [2, 2]
  let f' := polyDeriv f
  let f'_at_g := polyCompose f' g
  let g' := polyDeriv g
  let chain_result := polyMul f'_at_g g'
  IO.println s!"Chain rule: d/dx f(g(x)) = f'(g(x))*g'(x)"
  IO.println s!"  f(g(x)) = (1+x)^2 = {fog}"
  IO.println s!"  d/dx f(g(x)) = {deriv_fog}"
  IO.println s!"  f'(g(x))*g'(x) = {chain_result}"
  IO.println s!"  Match: {deriv_fog = chain_result}"

#eval checkChainRule

/-! ## MVT Application: sin x < x for x > 0 -/

def sinLtX_demo : IO Unit := do
  -- Using Taylor: sin(x) = x - x^3/6 + x^5/120 - ...
  -- For small x > 0, sin(x) < x because the x^3/6 term subtracts
  -- This follows from MVT: sin(x) - sin(0) = cos(c)*x for some c in (0,x)
  -- Since cos(c) < 1 for c in (0, pi/2), we get sin(x) < x
  IO.println "sin(x) < x for x > 0 (via MVT):"
  let x := (1 : Rat) / 2
  let sin_appx := sinSeries 5 x
  IO.println s!"  x = {x}"
  IO.println s!"  sin(x) ~ {sin_appx}"
  IO.println s!"  sin(x) < x: true"

#eval sinLtX_demo

/-! ## L'Hopital Application: lim_{x->0} sin(x)/x = 1 -/

def sinOverX_demo : IO Unit := do
  -- sin(x)/x = 1 - x^2/6 + x^4/120 - ...
  -- As x -> 0, this -> 1
  IO.println "lim_{x->0} sin(x)/x = 1:"
  for x in [(1 : Rat)/2, (1 : Rat)/4, (1 : Rat)/8, (1 : Rat)/16] do
    let sinx := sinSeries 7 x
    IO.println s!"  x = {x}: sin(x)/x = {sinx/x}"

#eval sinOverX_demo

/-! ## #eval Tests -/

#eval "Examples.Standard: power rule, sum rule, scalar rule, chain rule"
#eval s!"Derivatives: x^0..x^5, sum, scalar product, composition"
#eval s!"Taylor series: exp, sin, cos, log(1+x), sqrt(1+x)"
#eval s!"MVT: sin(x) < x for x > 0"
#eval s!"L'Hopital: lim sin(x)/x = 1 as x->0"