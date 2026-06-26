/-
# Computation.Evaluate

Evaluation and numerical experiments for differentiation:
- Compute derivative approximations with various schemes
- Stress-test Newton's method
- Compare forward vs central differences
- Plot convergence of Taylor series
-/
import MiniDifferentiation

open MiniDifferentiation

/-! ## Compare difference schemes -/

def compareSchemes (f : Real → Real) (exactDeriv : Real → Real) (x : Real) (hs : List Real) : List (String × Real × Real) :=
  hs.map fun h =>
    ("forward", forwardDifference f x h, exactDeriv x) ::
    ("central", centralDifference f x h, exactDeriv x) :: []

/-! ## Newton's method stress test -/

def newtonSolve (f f' : Real → Real) (x0 : Real) (tol : Real) (maxIter : Nat) : Real × Nat :=
  let rec iter (x : Real) (i : Nat) : Real × Nat :=
    if i > maxIter then (x, i)
    else if (f x).val.abs < tol.val then (x, i)
    else iter (newtonStep f f' x) (i+1)
  iter x0 0

def fSqrtOf2 (x : Real) : Real := { val := x.val ^ 2.0 - 2.0 }
def f'SqrtOf2 (x : Real) : Real := { val := 2.0 * x.val }

/-! ## Taylor series convergence test -/

def taylorConvergence (f : Real → Real) (a x : Real) (maxOrder : Nat) : List Real :=
  List.range (maxOrder+1) |>.map fun n =>
    expTaylorPoly n x  -- using exp as test

def taylorError (f : Real → Real) (exact : Real → Real) (a x : Real) (maxOrder : Nat) : List Real :=
  List.range (maxOrder+1) |>.map fun n =>
    { val := (expTaylorPoly n x - exact x).val.abs }

/-! ## Gradient descent convergence -/

def gdConvergence (f df : Real → Real) (x0 lr : Real) (iters : Nat) : List Real :=
  List.range (iters+1) |>.map fun k => gradientDescent f df x0 lr k

def quadFunc (x : Real) : Real := { val := (x.val - 3.0) ^ 2.0 }
def quadDeriv (x : Real) : Real := { val := 2.0 * (x.val - 3.0) }

/-! ## #eval Tests -/

#eval "Computation.Evaluate: compare schemes, Newton stress, Taylor convergence, GD convergence"
#eval s!"Newton solve sqrt(2) from x0=1: root = {(newtonSolve fSqrtOf2 f'SqrtOf2 { val := 1.0 } { val := 0.0001 } 20).1}"
#eval s!"Newton iterations: {(newtonSolve fSqrtOf2 f'SqrtOf2 { val := 1.0 } { val := 0.0001 } 20).2}"
#eval s!"GD step for (x-3)² from x0=0, lr=0.1, 5 iters: {gdConvergence quadFunc quadDeriv { val := 0.0 } { val := 0.1 } 5}"
