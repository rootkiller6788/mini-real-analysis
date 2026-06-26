/-
# MiniDifferentiation.Bridges.ToComputation

Bridge from differentiation to computation:
- Numerical differentiation (forward, backward, central differences)
- Automatic differentiation (forward mode) outline
- Newton's method for root-finding
- Gradient descent and optimization
-/
import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Numerical differentiation schemes -/

def forwardDifference (f : Real → Real) (x h : Real) : Real :=
  { val := (f { val := x.val + h.val } - f x).val / h.val }

def backwardDifference (f : Real → Real) (x h : Real) : Real :=
  { val := (f x - f { val := x.val - h.val }).val / h.val }

def centralDifference (f : Real → Real) (x h : Real) : Real :=
  { val := (f { val := x.val + h.val } - f { val := x.val - h.val }).val / (2.0 * h.val) }

def richardsonExtrapolation (f : Real → Real) (x h : Real) (p : Nat) : Real :=
  let d1 := centralDifference f x h
  let d2 := centralDifference f x { val := h.val / 2.0 }
  { val := (d2.val * (Float.ofNat (2^p)) - d1.val) / (Float.ofNat (2^p) - 1.0) }

/-! ## Error analysis -/

structure DifferenceError where
  scheme : String
  truncationError : Real → Real  -- error as function of h
  order : Nat                  -- O(h^p)
  theory : TheoryName := TheoryName.ofString "real-analysis.difference-error"
  objName : String := "DifferenceError"

def forwardDiffError : DifferenceError :=
  { scheme := "forward"
    truncationError := fun h => { val := h.val }
    order := 1
    theory := TheoryName.ofString "real-analysis.difference-error"
    objName := "DifferenceError" }

def centralDiffError : DifferenceError :=
  { scheme := "central"
    truncationError := fun h => { val := h.val ^ 2.0 }
    order := 2
    theory := TheoryName.ofString "real-analysis.difference-error"
    objName := "DifferenceError" }

/-! ## Automatic differentiation (forward mode, simplified) -/

structure Dual where
  value : Real
  deriv : Real
  deriving Repr

instance : Add Dual where
  add a b := { value := { val := a.value.val + b.value.val }
               deriv := { val := a.deriv.val + b.deriv.val } }

instance : Mul Dual where
  mul a b := { value := { val := a.value.val * b.value.val }
               deriv := { val := a.deriv.val * b.value.val + a.value.val * b.deriv.val } }

def dualConst (c : Real) : Dual := { value := c, deriv := { val := 0.0 } }
def dualVar (x : Real) : Dual := { value := x, deriv := { val := 1.0 } }

def dualSin (a : Dual) : Dual :=
  { value := { val := a.value.val.sin }
    deriv := { val := a.deriv.val * a.value.val.cos } }

def dualExp (a : Dual) : Dual :=
  { value := { val := a.value.val.exp }
    deriv := { val := a.deriv.val * a.value.val.exp } }

/-! ## Newton's method for root finding -/

def newtonStep (f f' : Real → Real) (x0 : Real) : Real :=
  { val := x0.val - f x0.val / f' x0.val }

def newtonIteration (f f' : Real → Real) (x0 : Real) (n : Nat) : Real :=
  match n with
  | 0 => x0
  | n+1 => newtonStep f f' (newtonIteration f f' x0 n)

def isFixedPoint (f f' : Real → Real) (r : Real) : Bool :=
  newtonStep f f' r == r

/-! ## Gradient descent (simplified) -/

def gradientDescentStep (f : Real → Real) (df : Real → Real) (x0 : Real) (lr : Real) : Real :=
  { val := x0.val - lr.val * df x0.val }

def gradientDescent (f df : Real → Real) (x0 : Real) (lr : Real) (iters : Nat) : Real :=
  match iters with
  | 0 => x0
  | k+1 => gradientDescentStep f df (gradientDescent f df x0 lr k) lr

/-! ## #eval Tests -/

#eval "Bridges.ToComputation: forward/backward/central differences, Richardson, AD, Newton, GD"
#eval s!"Forward difference of x^2 at 2 (h=0.001): {forwardDifference (fun x : Real => { val := x.val ^ 2.0 }) { val := 2.0 } { val := 0.001 }}"
#eval s!"Central difference of x^2 at 2 (h=0.001): {centralDifference (fun x : Real => { val := x.val ^ 2.0 }) { val := 2.0 } { val := 0.001 }}"
#eval s!"Dual number exp(1): value={({ val := 1.0 } |> dualVar |> dualExp).value}, deriv={({ val := 1.0 } |> dualVar |> dualExp).deriv}"
#eval s!"Newton step for x^2 - 2 at x0=1: {newtonStep (fun x : Real => { val := x.val ^ 2.0 - 2.0 }) (fun x : Real => { val := 2.0 * x.val }) { val := 1.0 }}"
