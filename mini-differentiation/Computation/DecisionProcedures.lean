/-
# Computation.DecisionProcedures

Decision procedures for differentiation problems:
- Checking if a function is C^k
- Determining critical point type via second derivative test
- Checking Morse condition
- Verifying Taylor remainder bounds
-/
import MiniDifferentiation

open MiniDifferentiation

/-! ## Check if a point is critical -/

def checkCritical (f : Real → Real) (df : Real → Real) (a : Real) (ε : Real) : Bool :=
  (df a).val.abs < ε.val

/-! ## Second derivative test for classification -/

def secondDerivativeTest (f : Real → Real) (d2f : Real → Real) (a : Real) : String :=
  let val := d2f a
  if val.val > 0.0 then "local minimum"
  else if val.val < 0.0 then "local maximum"
  else "inconclusive (possibly saddle or degenerate)"

/-! ## Check if Hessian is nondegenerate -/

def isNondegenerateCheck (d2f : Real → Real) (a : Real) (ε : Real) : Bool :=
  (d2f a).val.abs > ε.val

/-! ## Verify Taylor remainder bound -/

def verifyTaylorRemainder (f : Real → Real) (a x : Real) (n : Nat)
    (maxDeriv : Real) (tol : Real) : Bool :=
  let remainder_bound := { val := maxDeriv.val * ((x.val - a.val).abs ^ (Float.ofNat (n+1))) / Float.ofNat (Nat.factorial (n+1)) }
  remainder_bound.val < tol.val

/-! ## Finite difference convergence test -/

def convergenceTest (f : Real → Real) (x : Real) (hs : List Real) : List Real :=
  hs.map fun h => centralDifference f x h

def convergenceRate (vals : List Real) : List Real :=
  match vals with
  | a :: b :: rest =>
    let ratio := { val := a.val / b.val }
    ratio :: convergenceRate (b :: rest)
  | _ => []

/-! ## Detect inflection point via 2nd derivative -/

def isInflectionPoint (d2f : Real → Real) (a : Real) (ε : Real) : Bool :=
  (d2f a).val.abs < ε.val

/-! ## #eval Tests -/

#eval "Computation.DecisionProcedures: critical point check, 2nd derivative test, nondegeneracy, Taylor bound"
#eval s!"2nd derivative test for x² at 0: {secondDerivativeTest (fun x : Real => { val := x.val ^ 2.0 }) (fun _ : Real => { val := 2.0 }) { val := 0.0 }}"
#eval s!"Check if x² critical at 0: {checkCritical (fun x : Real => { val := x.val ^ 2.0 }) (fun x : Real => { val := 2.0 * x.val }) { val := 0.0 } { val := 0.001 }}"
