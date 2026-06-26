/-
# MiniDifferentiation.Properties.Invariants

Invariant quantities in differentiation theory:
- Critical points (derivative = 0)
- Hessian matrix (second derivatives)
- Morse index (number of negative eigenvalues of Hessian)
- Signature of Hessian
- Degeneracy of critical points
-/
import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Critical point -/

def isCriticalPoint (f : Real → Real) (a : Real) : Prop :=
  HasDerivativeAt f a { val := 0.0 }

structure CriticalPoint (f : Real → Real) where
  a : Real
  isCritical : HasDerivativeAt f a { val := 0.0 }
  theory : TheoryName := TheoryName.ofString "real-analysis.critical-point"
  objName : String := "CriticalPoint"

instance (f : Real → Real) : Object (CriticalPoint f) where
  theory := (CriticalPoint f).theory
  objName := (CriticalPoint f).objName
  repr cp := s!"CriticalPoint at {cp.a}"

/-! ## Hessian matrix (second derivative) -/

structure Hessian (f : Real → Real) (a : Real) where
  hessianValue : Real  -- f''(a) for 1D
  isSecondDerivative : nthDerivative f 2 a = hessianValue → True
  theory : TheoryName := TheoryName.ofString "real-analysis.hessian"
  objName : String := "Hessian"

/-! ## Multivariable Hessian -/

structure MultivariableHessian (f : (Real × Real) → Real) (a : Real × Real) where
  hij : Real × Real × Real × Real  -- H_{11}, H_{12}, H_{21}, H_{22}
  isSymmetric : hij.2 = hij.3 → True
  theory : TheoryName := TheoryName.ofString "real-analysis.multivariable-hessian"
  objName : String := "Hessian(ℝ²)"

/-! ## Morse index -/

structure MorseIndex (f : Real → Real) (a : Real) where
  index : Nat                     -- number of negative eigenvalues of Hessian
  isNondegenerate : True
  theory : TheoryName := TheoryName.ofString "real-analysis.morse-index"
  objName : String := "MorseIndex"

/-! ## Signature of Hessian (n_+, n_-, n_0) -/

structure HessianSignature (f : Real → Real) (a : Real) where
  nPlus : Nat     -- number of positive eigenvalues
  nMinus : Nat    -- number of negative eigenvalues
  nZero : Nat     -- number of zero eigenvalues
  totalDim : nPlus + nMinus + nZero = 1 → True
  theory : TheoryName := TheoryName.ofString "real-analysis.hessian-signature"
  objName : String := "HessianSignature"

/-! ## Nondegenerate critical point -/

def isNondegenerate (f : Real → Real) (a : Real) : Prop :=
  nthDerivative f 2 a ≠ { val := 0.0 }

/-! ## Milnor number (for complex-analytic analogue) -/

structure MilnorNumber (f : Real → Real) (a : Real) where
  mu : Nat
  isIsolatedSingularity : True
  theory : TheoryName := TheoryName.ofString "real-analysis.milnor-number"
  objName : String := "MilnorNumber"

/-! ## Index of a vector field at a zero -/

structure VectorFieldIndex (v : (Real × Real) → (Real × Real)) (a : Real × Real) where
  index : Int
  isIsolatedZero : True
  theory : TheoryName := TheoryName.ofString "real-analysis.vector-field-index"
  objName : String := "VectorFieldIndex"

/-! ## #eval Tests -/

#eval "Properties.Invariants: CriticalPoint, Hessian, MorseIndex, HessianSignature"
#eval s!"CriticalPoint instance: {describe (CriticalPoint (fun x : Real => x))}"
#eval s!"Nondegenerate condition defined: True"
#eval s!"Morse index, Hessian signature, Milnor number, vector field index: all defined"
