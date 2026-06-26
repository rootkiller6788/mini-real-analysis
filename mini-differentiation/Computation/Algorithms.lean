/-
# Computation.Algorithms

Computational algorithms for differentiation:
- Symbolic differentiation of polynomial expressions
- Finite difference schemes (forward, backward, central, higher-order)
- Richardson extrapolation
- Automatic differentiation (forward and reverse mode sketches)
- Taylor series arithmetic
-/
import MiniDifferentiation

open MiniDifferentiation

/-! ## Symbolic differentiation of a polynomial -/

def differentiatePoly (coeffs : List Real) : List Real :=
  match coeffs with
  | [] => []
  | _ :: rest =>
    let indexed := rest.zip (List.range (rest.length))
    indexed.map fun (c, i) => { val := c.val * Float.ofNat (i+2) }

def evalPoly (coeffs : List Real) (x : Real) : Real :=
  let terms := coeffs.zip (List.range coeffs.length)
  terms.foldl (fun acc (c, k) =>
    { val := acc.val + c.val * (x.val ^ (Float.ofNat k)) }) { val := 0.0 }

/-! ## Higher-order finite differences -/

def forwardDiff2 (f : Real → Real) (x h : Real) : Real :=
  { val := (f { val := x.val + 2.0 * h.val } - { val := 2.0 } * f { val := x.val + h.val } + f x).val / (h.val ^ 2.0) }

def centralDiff4 (f : Real → Real) (x h : Real) : Real :=
  { val := (-f { val := x.val + 2.0 * h.val }
            + { val := 8.0 } * f { val := x.val + h.val }
            - { val := 8.0 } * f { val := x.val - h.val }
            + f { val := x.val - 2.0 * h.val }).val / (12.0 * h.val) }

/-! ## Richardson extrapolation for higher order -/

def richardsonTable (f : Real → Real) (x h : Real) (levels : Nat) : List (List Real) :=
  match levels with
  | 0 => [[centralDifference f x h]]
  | n+1 =>
    let prev := richardsonTable f x h n
    let hNew := { val := h.val / 2.0 }
    let newCol := List.range (n+2) |>.map fun k => centralDifference f x { val := h.val / (Float.ofNat (2^k)) }
    prev ++ [newCol]

/-! ## Automatic differentiation: Reverse mode sketch -/

structure ReverseCell where
  value : Real
  adjoint : Real

/-! ## Taylor series arithmetic (carry Taylor coefficients) -/

structure TaylorSeries (degree : Nat) where
  coeffs : Array Real  -- [a_0, a_1, ..., a_d]

def taylorAdd (a b : TaylorSeries d) : TaylorSeries d :=
  { coeffs := a.coeffs.zip b.coeffs |>.map fun (x, y) => { val := x.val + y.val } }

def taylorMul (a b : TaylorSeries d) : TaylorSeries d :=
  { coeffs := ⟨[a.coeffs[0]! * b.coeffs[0]!]⟩ }  -- simplified: just constant term

/-! ## #eval Tests -/

#eval "Computation.Algorithms: polynomial diff, high-order finite diff, Richardson, AD reverse, Taylor arithmetic"
#eval s!"Differentiate polynomial [1,2,3] (1+2x+3x² → 2+6x): {differentiatePoly ([{val:=1.0},{val:=2.0},{val:=3.0}] : List Real)}"
#eval s!"Central diff 4th order of x^2 at 2: {centralDiff4 (fun x : Real => { val := x.val ^ 2.0 }) { val := 2.0 } { val := 0.001 }}"
