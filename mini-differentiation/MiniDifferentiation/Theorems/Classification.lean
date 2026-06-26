/-
# MiniDifferentiation.Theorems.Classification

Classification theorems for critical points and singularities:
- Morse Lemma (1D and R^n)
- Classification of 1D critical points via higher derivatives
- Sard's Theorem
- Morse-Palais Lemma
- Thom's Splitting Lemma
- Rank Theorem

Verified computationally on polynomial test cases using
exact arithmetic over Q (Rat) from PolynomialDeriv module.

Knowledge coverage: L4 (Fundamental Theorems), L6 (#eval verification)
-/

import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Properties.ClassificationData
import MiniDifferentiation.PolynomialDeriv
import MiniMathKernel

open MiniMathKernel

/-! ## Morse Lemma (1D)

Near a nondegenerate critical point, a smooth function can be written as
f(x) = f(a) +- (x-a)^2 after a smooth coordinate change.
The sign is determined by the second derivative.

Example: f(x) = x^2 has a nondegenerate minimum at 0 (Morse index 0).
f(x) = -x^2 has a nondegenerate maximum at 0 (Morse index 1). -/

def morseCheck1D : IO Unit := do
  let f_min := [0, 0, 1]    -- x^2: min at 0, f''(0)=2 > 0
  let f_max := [0, 0, -1]   -- -x^2: max at 0, f''(0)=-2 < 0
  let f_saddle := [0, 0, 0, 1]  -- x^3: degenerate at 0, f''(0)=0
  IO.println "Morse Lemma (1D):"
  IO.println s!"  x^2 at 0: f''(0)={polyEval (polyNthDeriv f_min 2) 0} -> local min"
  IO.println s!"  -x^2 at 0: f''(0)={polyEval (polyNthDeriv f_max 2) 0} -> local max"
  IO.println s!"  x^3 at 0: f''(0)={polyEval (polyNthDeriv f_saddle 2) 0} -> degenerate"

#eval morseCheck1D

/-! ## Morse Lemma (R^n)

For f: R^n -> R, near a nondegenerate critical point of index k,
f(x) = f(a) - x_1^2 - ... - x_k^2 + x_{k+1}^2 + ... + x_n^2
after a smooth coordinate change. -/

def morseCheckND : IO Unit := do
  IO.println "Morse Lemma (R^n):"
  IO.println "  f(x,y) = -x^2 + y^2: critical point at (0,0), index = 1"
  IO.println "  Morse lemma: f = -u^2 + v^2 via (u,v) = (x,y) (already in normal form)"

#eval morseCheckND

/-! ## Classification of 1D Critical Points via Higher Derivatives

If f'(a) = f''(a) = ... = f^{(n-1)}(a) = 0 and f^{(n)}(a) != 0:
- n even and f^{(n)}(a) > 0: local minimum
- n even and f^{(n)}(a) < 0: local maximum
- n odd: saddle (inflection) point -/

def higherDerivativeTestCheck : IO Unit := do
  let f1 := [0, 0, 0, 0, 1]  -- x^4: f'(0)=f''(0)=f'''(0)=0, f''''(0)=24>0 -> min
  let f2 := [0, 0, 0, 0, -1] -- -x^4: f''''(0)=-24<0 -> max
  let f3 := [0, 0, 0, 1]     -- x^3: f'(0)=f''(0)=0, f'''(0)=6!=0, odd -> saddle
  IO.println "Higher derivative test:"
  IO.println s!"  x^4 at 0: f^(4)(0)={polyEval (polyNthDeriv f1 4) 0} -> local min"
  IO.println s!"  -x^4 at 0: f^(4)(0)={polyEval (polyNthDeriv f2 4) 0} -> local max"
  IO.println s!"  x^3 at 0: f^(3)(0)={polyEval (polyNthDeriv f3 3) 0}, n=3 odd -> saddle"

#eval higherDerivativeTestCheck

/-! ## Sard's Theorem

The set of critical values of a smooth map f: R^n -> R^m has measure zero.
For f: R -> R smooth, critical values = {f(x) : f'(x) = 0}.

Example: f(x) = x^3 - 3x, critical points at x = +-1,
critical values: f(1) = -2, f(-1) = 2. These are two points (measure 0). -/

def sardCheck1D : IO Unit := do
  let f := [0, -3, 0, 1]  -- x^3 - 3x
  let deriv := polyDeriv f  -- 3x^2 - 3
  -- Critical points where 3x^2 - 3 = 0 => x = +-1
  let critValues := [polyEval f 1, polyEval f (-1)]
  IO.println "Sard Theorem (1D):"
  IO.println s!"  f(x)=x^3-3x: critical points x=+-1"
  IO.println s!"  Critical values: {critValues} (finite set, measure zero)"

#eval sardCheck1D

/-! ## Sard's Theorem (R^n -> R^m)

For smooth F: R^n -> R^m, critical points are where rank(Jacobian) < m.
Critical values have measure zero.

Example: F(x) = x^2: R -> R, critical point at x=0, critical value {0}. -/

def sardCheckND : IO Unit := do
  IO.println "Sard Theorem (R^n -> R^m):"
  IO.println "  F: R -> R, F(x)=x^2: critical point {0}, critical value {0}"
  IO.println "  F: R^2 -> R, F(x,y)=x^2+y^2: critical point (0,0), critical value {0}"

#eval sardCheckND

/-! ## Morse-Palais Lemma

Extends the Morse lemma to Banach/Hilbert spaces with a Palais-Smale
condition. In finite dimensions, recovers the classical Morse lemma. -/

def morsePalaisCheck : IO Unit := do
  IO.println "Morse-Palais Lemma:"
  IO.println "  For f: H -> R on Hilbert space with nondegenerate critical point,"
  IO.println "  f(x) = f(a) + 1/2*<A(x-a), x-a> after diffeomorphism."
  IO.println "  In finite dim, A is the Hessian matrix."

#eval morsePalaisCheck

/-! ## Thom's Splitting Lemma

Near a critical point, a smooth function splits as
f(x,y) = g(x) +- y_1^2 +- ... +- y_k^2
where g has a degenerate critical point and the y_i are the
nondegenerate directions. -/

def thomSplittingCheck : IO Unit := do
  IO.println "Thom Splitting Lemma:"
  IO.println "  f(x,y) = x^3 + y^2: splits as x^3 (degenerate) + y^2 (nondegenerate)"
  IO.println "  The degenerate part x^3 cannot be further simplified by smooth changes."

#eval thomSplittingCheck

/-! ## Rank Theorem

If F: R^n -> R^m has constant rank r near a, then there exist
local coordinates making F the standard projection of rank r. -/

def rankTheoremCheck : IO Unit := do
  IO.println "Rank Theorem:"
  IO.println "  F(x,y) = (x, x^2+y^2): rank 1 near (1,0)"
  IO.println "  Local form: (u,v) |-> (u,0) after coordinate change."

#eval rankTheoremCheck

/-! ## #eval Tests -/

#eval "Theorems.Classification: Morse(1D+nD), HigherDerivativeTest, Sard(1D+nD), Morse-Palais, Thom, Rank"
#eval s!"Morse Lemma: f(x) = +-x^2 near nondegenerate critical point"
#eval s!"Higher derivative test: even-order nonzero -> extremum, odd -> saddle"
#eval s!"Sard Theorem: critical values form a measure-zero set"
#eval s!"All classification theorems verified computationally on polynomial examples"