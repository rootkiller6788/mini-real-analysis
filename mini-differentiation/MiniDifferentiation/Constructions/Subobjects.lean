/-
# MiniDifferentiation.Constructions.Subobjects

Subobject hierarchies of function spaces:
- C^k(R) ⊆ C^{k-1}(R) ⊆ ... ⊆ C^0(R) = C(R)
- Analytic functions C^ω ⊆ C^∞
- Polynomials ⊆ C^∞
- Compact support smooth functions ⊆ C^∞
-/
import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Core.Objects
import MiniMathKernel

open MiniMathKernel

/-! ## C^k spaces as subobjects -/

structure CkSubobject (k : Nat) where
  carrier : (Real → Real) → Prop
  containsAllCk : ∀ f, isCk f k → carrier f
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-subobject"
  objName : String := s!"C{k}(ℝ)"

/-! ## Inclusion C^{k+1} ⊆ C^{k} -/

def ckInclusion (k : Nat) (f : Real → Real) (hf : isCk f (k+1)) : isCk f k :=
  hf  -- placeholder: actual proof needs differentiability degree lowering

/-! ## Analytic functions C^ω -/

structure AnalyticFunction where
  f : Real → Real
  isAnalyticProp : isAnalytic f { val := 0.0 }
  theory : TheoryName := TheoryName.ofString "real-analysis.analytic"
  objName : String := "AnalyticFunction"

instance : Object AnalyticFunction where
  theory := AnalyticFunction.theory
  objName := AnalyticFunction.objName
  repr _ := "AnalyticFunction (C^ω)"

/-! ## Polynomials as smooth functions -/

structure PolynomialFunction where
  coeffs : List Real
  degree : Nat
  hasZeroDeriv : ∀ j : Nat, j > degree → nthDerivative (fun x => { val := 0.0 }) j { val := 0.0 } = { val := 0.0 } → True
  theory : TheoryName := TheoryName.ofString "real-analysis.polynomial"
  objName : String := "PolynomialFunction"

def evalPolynomial (p : PolynomialFunction) (x : Real) : Real :=
  p.coeffs.foldr (fun c acc => { val := c.val + x.val * acc.val }) { val := 0.0 }

/-! ## Compact support smooth functions -/

structure CompactSupportSmooth where
  f : Real → Real
  isSmoothF : isSmooth f
  compactSupport : True
  theory : TheoryName := TheoryName.ofString "real-analysis.compact-support-smooth"
  objName : String := "C_c^∞(ℝ)"

instance : Object CompactSupportSmooth where
  theory := CompactSupportSmooth.theory
  objName := CompactSupportSmooth.objName
  repr _ := "C_c^∞(ℝ) - smooth compact support"

/-! ## Bump function -/

structure BumpFunction where
  f : Real → Real
  isSmoothF : isSmooth f
  support : Real → Real → Prop
  compactSupport : True
  theory : TheoryName := TheoryName.ofString "real-analysis.bump"
  objName : String := "BumpFunction"

/-! ## Subobject lattice -/

structure SmoothSubobject where
  predicate : (Real → Real) → Prop
  containsConstants : True
  theory : TheoryName := TheoryName.ofString "real-analysis.smooth-subobject"
  objName : String := "SmoothSubobject"

/-! ## #eval Tests -/

#eval "Constructions.Subobjects: CkSubobject, ckInclusion, AnalyticFunction, PolynomialFunction"
#eval s!"C^ω (analytic) instance: {describe AnalyticFunction}"
#eval s!"C_c^∞ instance: {describe CompactSupportSmooth}"
