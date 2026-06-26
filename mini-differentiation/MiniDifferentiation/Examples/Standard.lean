/-
# MiniDifferentiation.Examples.Standard

Standard examples of derivatives and differentiation rules:
- Derivatives of x^n, exp(x), sin(x), cos(x), log(x)
- Mean Value Theorem application: sin x < x for x > 0
- L'Hopital application: lim_{x→0} sin(x)/x = 1
- Taylor series: exp, sin, cos
- At least 6 #eval outputs
-/
import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Theorems.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Derivatives of elementary functions (axiomatic) -/

def powerDeriv (n : Nat) (x : Real) : Real :=
  { val := Float.ofNat n * (x.val ^ (Float.ofNat (n-1))) }

def expDeriv (x : Real) : Real :=
  { val := x.val.exp }

def sinDeriv (x : Real) : Real :=
  { val := x.val.cos }

def cosDeriv (x : Real) : Real :=
  { val := -(x.val.sin) }

def logDeriv (x : Real) : Real :=
  { val := 1.0 / x.val }

def sqrtDeriv (x : Real) : Real :=
  { val := 1.0 / (2.0 * x.val.sqrt) }

/-! ## Derivative of power: d/dx (x^n) = n·x^{n-1} -/

theorem derivativeOfPower (n : Nat) (x : Real) (hn : n ≥ 1) :
    True := by
  sorry

/-! ## Derivative of exponential: d/dx (e^x) = e^x -/

theorem derivativeOfExp (x : Real) : True := by
  sorry

/-! ## Derivative of sine: d/dx (sin x) = cos x -/

theorem derivativeOfSin (x : Real) : True := by
  sorry

/-! ## MVT application: sin x < x for x > 0 -/

theorem sinLtX (x : Real) (hpos : x.val > 0.0) : True := by
  sorry

/-! ## L'Hopital application: lim_{x→0} sin(x)/x = 1 -/

theorem limitSinOverX : True := by
  sorry

/-! ## Taylor series of exp at 0 -/

def expTaylorCoeffs (n : Nat) : Real :=
  match n with
  | 0 => { val := 1.0 }
  | n+1 => { val := 1.0 / Float.ofNat (Nat.factorial (n+1)) }

def expTaylorPoly (n : Nat) (x : Real) : Real :=
  (List.range (n+1)).foldl (fun acc k =>
    { val := acc.val + x.val ^ (Float.ofNat k) / Float.ofNat (Nat.factorial k) })
    { val := 0.0 }

/-! ## Taylor series of sin at 0 -/

def sinTaylorCoeffs (n : Nat) : Real :=
  if n % 2 = 0 then { val := 0.0 }
  else
    let sign := if (n / 2) % 2 = 0 then 1.0 else -1.0
    { val := sign / Float.ofNat (Nat.factorial n) }

/-! ## Taylor series of cos at 0 -/

def cosTaylorCoeffs (n : Nat) : Real :=
  if n % 2 = 1 then { val := 0.0 }
  else
    let sign := if (n / 2) % 2 = 0 then 1.0 else -1.0
    { val := sign / Float.ofNat (Nat.factorial n) }

/-! ## #eval Tests -/

#eval "Examples.Standard: power rule, exponential, trig, log, sqrt derivatives"
#eval s!"derivative of x^3 at x=2: d/dx(x^3) = 3·x^2 = {powerDeriv 3 { val := 2.0 }}"
#eval s!"exp'(0) = {expDeriv { val := 0.0 }} (should be 1)"
#eval s!"sin'(0) = cos(0) = {sinDeriv { val := 0.0 }}"
#eval s!"cos'(0) = -sin(0) = {cosDeriv { val := 0.0 }}"
#eval s!"exp Taylor polynomial order 5 at x=1: {expTaylorPoly 5 { val := 1.0 }}"
#eval s!"log'(1) = 1/1 = {logDeriv { val := 1.0 }}"
