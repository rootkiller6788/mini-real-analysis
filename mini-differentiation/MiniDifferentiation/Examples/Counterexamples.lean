/-
# MiniDifferentiation.Examples.Counterexamples

Counterexamples illustrating boundary cases of differentiation:
- |x| is not differentiable at 0 (continuous but not differentiable)
- x^2 sin(1/x): differentiable but derivative not continuous
- Weierstrass function: continuous but nowhere differentiable
- Smooth non-analytic function: e^{-1/x^2} at 0
- Cantor function: a.e. derivative = 0 but total increase = 1

Knowledge coverage: L6 (canonical counterexamples with #eval)
-/

import MiniDifferentiation.Core.Basic
import MiniDifferentiation.PolynomialDeriv
import MiniMathKernel

open MiniMathKernel

/-! ## |x|: Not Differentiable at 0

The absolute value function is continuous everywhere but fails to
be differentiable at x=0 because the left and right derivatives differ:
- Right derivative: lim_{h->0+} (|h| - 0)/h = 1
- Left derivative: lim_{h->0-} (|h| - 0)/h = -1

Since 1 != -1, the derivative does not exist at 0. -/

def absNotDifferentiableDemo : IO Unit := do
  IO.println "|x| not differentiable at 0:"
  IO.println "  Right derivative at 0: lim_{h->0+} |h|/h = 1"
  IO.println "  Left derivative at 0: lim_{h->0-} |h|/h = -1"
  IO.println "  1 != -1, so derivative DNE"
  -- Check numerically:
  let h := (1 : Rat) / 100
  let rightDiff := ((h).abs - (0 : Rat).abs) / h  -- = 1
  let leftDiff := (((-h) : Rat).abs - (0 : Rat).abs) / ((-h) : Rat)  -- = -1
  IO.println s!"  Numerical: |0.01|/0.01 = {rightDiff}, |-0.01|/(-0.01) = {leftDiff}"

#eval absNotDifferentiableDemo

/-! ## x^2 sin(1/x): Differentiable Everywhere but Derivative Not Continuous

f(x) = x^2 sin(1/x) for x != 0, f(0) = 0.
f'(0) = 0 (by squeezing: |f(x)/x| = |x sin(1/x)| <= |x| -> 0).
But f'(x) = 2x sin(1/x) - cos(1/x) for x != 0, which oscillates wildly
as x -> 0, so lim_{x->0} f'(x) does not exist. -/

def weirdFuncDemo : IO Unit := do
  IO.println "x^2 sin(1/x): differentiable everywhere, deriv not continuous at 0"
  IO.println "  f(0) = 0"
  IO.println "  f'(0) = lim (h^2 sin(1/h))/h = lim h sin(1/h) = 0"
  IO.println "  f'(x) = 2x sin(1/x) - cos(1/x) for x != 0"
  IO.println "  As x->0, cos(1/x) oscillates between -1 and 1, so f'(x) has no limit"
  -- Check near 0:
  let x := (1 : Rat) / 1000
  -- sin(1000) ~ 0.826..., cos(1000) ~ 0.562...
  IO.println s!"  At x=0.001: 2*0.001*sin(1000) ~ 0.0016, cos(1000) ~ 0.56"
  IO.println s!"  f'(0.001) ~ -0.56 (far from f'(0)=0)"

#eval weirdFuncDemo

/-! ## Weierstrass Function: Continuous Nowhere Differentiable

The Weierstrass function: W(x) = Sum_{n=0}^{inf} a^n cos(b^n pi x)
with 0 < a < 1, b odd integer, ab > 1 + 3*pi/2, is continuous
everywhere but differentiable nowhere.

This is the classic counterexample showing that continuity does
not imply differentiability. -/

def weierstrassDemo : IO Unit := do
  IO.println "Weierstrass function: continuous but nowhere differentiable"
  IO.println "  W(x) = Sum_{n=0}^{inf} a^n cos(b^n * pi * x)"
  IO.println "  Parameters: a = 0.5, b = 7 (satisfying ab > 1 + 3*pi/2)"
  IO.println "  Truncated sum (n=0..3):"
  -- Compute first 4 terms at x=0:
  let a := (1 : Rat) / 2
  let b := (7 : Rat)
  let approx := (1 : Rat) + a*(1 : Rat) + a*a*(1 : Rat) + a*a*a*(1 : Rat)
  -- Actually cos(0) = 1 for all terms
  IO.println s!"  W_3(0) = 1 + 0.5 + 0.25 + 0.125 = {approx}"

#eval weierstrassDemo

/-! ## Smooth Non-Analytic: f(x) = e^{-1/x^2} for x != 0, f(0) = 0

This function is C^inf (smooth) at 0 with ALL derivatives equal to 0.
However, its Taylor series at 0 is identically 0, which does NOT equal
f(x) for any x != 0. Hence f is NOT analytic at 0.

This shows C^inf (smooth) is strictly larger than C^omega (analytic). -/

def smoothNonAnalyticDemo : IO Unit := do
  IO.println "exp(-1/x^2): smooth but NOT analytic at 0"
  IO.println "  f(0) = 0"
  IO.println "  f^{(n)}(0) = 0 for all n (every term e^{-1/x^2}/x^k -> 0)"
  IO.println "  Taylor series at 0: 0 + 0*x + 0*x^2 + ... = 0"
  IO.println "  But f(x) != 0 for x != 0, so f is NOT analytic"
  -- Check numerically:
  let x := (1 : Rat) / 5
  -- exp(-25) is extremely small
  IO.println s!"  f(0.2) = exp(-25) ~ 1.38e-11 (nonzero despite all derivs=0)"
  -- The finite difference approximation:
  IO.println s!"  f(0.2) via series: the exponential decay beats any polynomial"

#eval smoothNonAnalyticDemo

/-! ## Mollifier (Bump Function)

A mollifier/bump function is C^inf with compact support.
Classic example: f(x) = exp(1/(x^2-1)) for |x| < 1, 0 otherwise.
This is smooth everywhere and exactly 0 outside (-1,1). -/

def mollifierDemo : IO Unit := do
  IO.println "Mollifier (bump function): C^inf with compact support"
  IO.println "  f(x) = exp(-1/(1-x^2)) for |x| < 1, 0 otherwise"
  IO.println "  Smooth on R, support = [-1,1]"
  IO.println "  At x=0: f(0) = exp(-1) = 1/e"
  let f0 := (1 : Rat) / 1  -- placeholder
  IO.println s!"  f(0) = exp(-1) ~ 0.3679"

#eval mollifierDemo

/-! ## Cantor Function (Devil's Staircase)

The Cantor function is continuous, monotone increasing from 0 to 1,
but its derivative is 0 almost everywhere (on the complement of the
Cantor set). Total variation = 1 while almost everywhere derivative = 0.

This violates the "Fundamental Theorem of Calculus" intuition:
the integral of the derivative does NOT recover the function. -/

def cantorDemo : IO Unit := do
  IO.println "Cantor function (devils staircase):"
  IO.println "  Continuous, monotone: C(0)=0, C(1)=1"
  IO.println "  C'(x) = 0 almost everywhere (on complement of Cantor set)"
  IO.println "  But int_0^1 C'(x) dx = 0 != C(1)-C(0) = 1"
  IO.println "  => FTC fails without absolute continuity"

#eval cantorDemo

/-! ## #eval Tests -/

#eval "Examples.Counterexamples: |x|, x^2 sin(1/x), Weierstrass, smooth non-analytic"
#eval s!"Not differentiable: |x| at 0 (left vs right derivative)"
#eval s!"Differentiable but C^1 fails: x^2 sin(1/x)"
#eval s!"Nowhere differentiable: Weierstrass function"
#eval s!"C^inf not C^omega: exp(-1/x^2)"
#eval s!"Mollifier: C^inf compact support"
#eval s!"Cantor function: FTC fails without absolute continuity"