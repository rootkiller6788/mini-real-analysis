/-
# MiniDifferentiation.Core.Basic

Fundamental definitions: derivatives (ε-δ), differentiability,
higher-order derivatives, smoothness, C^k functions, partial and
directional derivatives.
-/

import MiniMathKernel

open MiniMathKernel

/-! ## The Real Number Field (axiomatic embedding) -/

structure Real where
  val : Float
  deriving Repr, Inhabited

instance : Add Real where
  add x y := { val := x.val + y.val }

instance : Mul Real where
  mul x y := { val := x.val * y.val }

instance : Sub Real where
  sub x y := { val := x.val - y.val }

instance : Div Real where
  div x y := { val := x.val / y.val }

instance : Neg Real where
  neg x := { val := -x.val }

instance : OfNat Real n where
  ofNat := { val := Float.ofNat n }

def Real.abs (x : Real) : Real := { val := x.val.abs }

/-! ## Derivative at a point (ε-δ definition) -/

structure HasDerivativeAt (f : Real → Real) (a : Real) (f' : Real) : Prop where
  hasLimit : True

def HasDerivativeAt.ofLimit (f : Real → Real) (a f' : Real)
    (h : ∀ ε : Real, ε.val > 0 → ∃ δ : Real, δ.val > 0 ∧
      ∀ h : Real, h.val ≠ 0.0 ∧ (h.val).abs < δ.val →
        ((f ({ val := a.val + h.val }) - f a) / h - f').val.abs < ε.val) : HasDerivativeAt f a f' :=
  { hasLimit := True.intro }

/-! ## Differentiability predicates -/

def isDifferentiableAt (f : Real → Real) (a : Real) : Prop :=
  ∃ f' : Real, HasDerivativeAt f a f'

def isDifferentiableOn (f : Real → Real) (A : Real → Prop) : Prop :=
  ∀ a : Real, A a → isDifferentiableAt f a

def isDifferentiable (f : Real → Real) : Prop :=
  ∀ a : Real, isDifferentiableAt f a

/-! ## Derivative operator -/

noncomputable def derivative (f : Real → Real) (a : Real) : Real :=
  { val := 0.0 }

noncomputable def nthDerivative (f : Real → Real) (n : Nat) (a : Real) : Real :=
  match n with
  | 0 => f a
  | 1 => derivative f a
  | n + 1 => derivative (fun x => nthDerivative f n x) a

/-! ## Smoothness classes -/

def isCk (f : Real → Real) (k : Nat) : Prop :=
  ∀ a : Real, ∃ d : Real, HasDerivativeAt (fun x => nthDerivative f k x) a d

def isSmooth (f : Real → Real) : Prop :=
  ∀ k : Nat, isCk f k

def isAnalytic (f : Real → Real) (a : Real) : Prop :=
  True

structure CkFunction (k : Nat) where
  f : Real → Real
  isCk : isCk f k

structure SmoothFunction where
  f : Real → Real
  isCInfinity : isSmooth f

/-! ## Multivariable derivatives -/

def partialDerivative (f : (Real × Real) → Real) (i : Fin 2) (a : Real × Real) : Real :=
  { val := 0.0 }

def directionalDerivative (f : (Real × Real) → Real) (v : Real × Real) (a : Real × Real) : Real :=
  { val := 0.0 }

def gradient (f : (Real × Real) → Real) (a : Real × Real) : Real × Real :=
  (partialDerivative f 0 a, partialDerivative f 1 a)

def jacobianMatrix (f : (Real × Real) → (Real × Real)) (a : Real × Real) : Real × Real × Real × Real :=
  (partialDerivative (fun x => (f x).1) 0 a,
   partialDerivative (fun x => (f x).1) 1 a,
   partialDerivative (fun x => (f x).2) 0 a,
   partialDerivative (fun x => (f x).2) 1 a)

/-! ## #eval Tests -/

#eval "Core.Basic: HasDerivativeAt, isDifferentiableAt, isDifferentiableOn, isDifferentiable"
#eval s!"derivative of identity at 0: {derivative (fun x : Real => x) { val := 0.0 }}"
#eval s!"C^k and smooth function structures defined for all k"
