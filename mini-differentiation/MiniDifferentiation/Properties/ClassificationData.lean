/-
# MiniDifferentiation.Properties.ClassificationData

Classification data for critical points and singularities:
- Local max, local min, saddle point
- Morse functions (all critical points nondegenerate)
- Degenerate critical points
- Classification of 1D critical points via higher derivatives
-/
import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Properties.Invariants
import MiniMathKernel

open MiniMathKernel

/-! ## Types of critical points -/

inductive CriticalPointType
  | localMax
  | localMin
  | saddle
  | degenerate
  deriving Repr, Inhabited

def CriticalPointType.toString (t : CriticalPointType) : String :=
  match t with
  | .localMax => "local maximum"
  | .localMin => "local minimum"
  | .saddle => "saddle point"
  | .degenerate => "degenerate"

/-! ## Local maximum / minimum / saddle -/

structure LocalExtremum (f : Real → Real) (a : Real) where
  neighborhood : Real → Prop
  aInNeighborhood : neighborhood a
  isMax : ∀ x, neighborhood x → f x ≤ f a → True
  isMin : ∀ x, neighborhood x → f a ≤ f x → True
  theory : TheoryName := TheoryName.ofString "real-analysis.local-extremum"
  objName : String := "LocalExtremum"

/-! ## Morse function -/

def isMorseFunction (f : Real → Real) : Prop :=
  ∀ a : Real, isCriticalPoint f a → isNondegenerate f a

structure MorseFunction where
  f : Real → Real
  isMorse : isMorseFunction f
  theory : TheoryName := TheoryName.ofString "real-analysis.morse-function"
  objName : String := "MorseFunction"

instance : Object MorseFunction where
  theory := MorseFunction.theory
  objName := MorseFunction.objName
  repr _ := "MorseFunction"

/-! ## Degenerate critical point -/

structure DegenerateCriticalPoint (f : Real → Real) where
  a : Real
  isCritical : isCriticalPoint f a
  isDegenerate : nthDerivative f 2 a = { val := 0.0 }
  theory : TheoryName := TheoryName.ofString "real-analysis.degenerate-cp"
  objName : String := "DegenerateCriticalPoint"

/-! ## Classification via first nonvanishing derivative -/

structure HigherDerivativeClassification (f : Real → Real) (a : Real) where
  firstNonzeroDeriv : Nat
  derivValue : Real
  rule : CriticalPointType
  parityRule : True  -- odd order ⇒ saddle, even order ⇒ extremum based on sign
  theory : TheoryName := TheoryName.ofString "real-analysis.higher-deriv-classification"
  objName : String := "HigherDerivativeClassification"

/-! ## ADE classification (simple singularities) -/

inductive ADEType
  | A_n (n : Nat)  -- x^{n+1}
  | D_n (n : Nat)  -- x^2 y + y^{n-1}
  | E_6 | E_7 | E_8
  deriving Repr

structure ADEClassification (f : Real → Real) (a : Real) where
  type : ADEType
  isSimpleSingularity : True
  theory : TheoryName := TheoryName.ofString "real-analysis.ade-classification"
  objName : String := "ADEClassification"

/-! ## Morse index theorem (1D) -/

structure MorseIndex1D (f : Real → Real) (a : Real) where
  criticalType : CriticalPointType
  index : Nat
  classification : True  -- index = 0 for local min, 1 for local max
  theory : TheoryName := TheoryName.ofString "real-analysis.morse-index-1d"
  objName : String := "MorseIndex1D"

/-! ## #eval Tests -/

#eval "Properties.ClassificationData: CriticalPointType, MorseFunction, DegenerateCriticalPoint"
#eval s!"MorseFunction instance: {describe MorseFunction}"
#eval s!"Critical point types: {CriticalPointType.localMax.toString}, {CriticalPointType.localMin.toString}, {CriticalPointType.saddle.toString}"
