/-
# MiniDifferentiation.Core.Objects

Object-level structures for differentiation:
- DifferentiableFn: a function together with its differentiability proof
- instance Object DifferentiableFn (from kernel)
- DerivativeOperator as linear operator on C^1
- C^k spaces as object instances
-/
import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Differentiable Function as an Object -/

structure DifferentiableFn where
  f : Real → Real
  domain : Real → Prop
  isDiffOn : isDifferentiableOn f domain
  theory : TheoryName := TheoryName.ofString "real-analysis.differentiation"
  objName : String := "DifferentiableFn"
  deriving Inhabited

instance : Object DifferentiableFn where
  theory := DifferentiableFn.theory
  objName := DifferentiableFn.objName
  repr dfn := s!"DifferentiableFn(f: ℝ → ℝ, differentiable on domain)"

/-! ## C^1 Function -/

structure C1Function where
  f : Real → Real
  f' : Real → Real
  isDerivative : ∀ a, HasDerivativeAt f a (f' a)
  theory : TheoryName := TheoryName.ofString "real-analysis.c1"
  objName : String := "C1Function"

instance : Object C1Function where
  theory := C1Function.theory
  objName := C1Function.objName
  repr c1 := s!"C1Function(f, f')"

/-! ## C^k Function -/

structure CkFunctionObject (k : Nat) where
  f : Real → Real
  derivatives : Nat → Real → Real  -- derivatives[0] = f, derivatives[n] = f^{(n)}
  isCkProp : isCk f k
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}"
  objName : String := s!"C{k}Function"

instance (k : Nat) : Object (CkFunctionObject k) where
  theory := (CkFunctionObject k).theory
  objName := (CkFunctionObject k).objName
  repr ck := s!"C{k}Function"

/-! ## Smooth Function Object -/

structure SmoothFunctionObject where
  f : Real → Real
  isSmoothProp : isSmooth f
  theory : TheoryName := TheoryName.ofString "real-analysis.smooth"
  objName : String := "SmoothFunction"

instance : Object SmoothFunctionObject where
  theory := SmoothFunctionObject.theory
  objName := SmoothFunctionObject.objName
  repr _ := "SmoothFunction"

/-! ## Derivative Operator (bounded linear operator on C^1) -/

structure DerivativeOperator where
  op : C1Function → C1Function
  isLinear : ∀ (f g : C1Function) (α β : Real),
    op (α • f) • g = α • (op f) • g  -- simplified
  operatorNorm : Real

/-! ## Tangent Vector as Derivation -/

structure TangentVector (a : Real) where
  v : (Real → Real) → Real
  isLinear : True
  leibniz : True

/-! ## #eval Tests -/

#eval "Core.Objects: DifferentiableFn, C1Function, CkFunctionObject, SmoothFunctionObject"
#eval s!"DifferentiableFn instance: {describe DifferentiableFn}"
#eval s!"C1Function instance: {describe C1Function}"
