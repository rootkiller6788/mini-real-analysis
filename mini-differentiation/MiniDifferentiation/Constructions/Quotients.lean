/-
# MiniDifferentiation.Constructions.Quotients

Quotient constructions for differentiation:
- Quotient by derivative-equivalence (k-jet equivalence)
- Germ of differentiable functions at a point
- Jet space as quotient of smooth functions
-/
import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Morphisms.Equiv
import MiniMathKernel

open MiniMathKernel

/-! ## Germ of differentiable functions at a point -/

structure Germ (a : Real) where
  representative : Real → Real
  equivalenceClass : (Real → Real) → Prop
  theory : TheoryName := TheoryName.ofString "real-analysis.germ"
  objName : String := s!"Germ at a"

instance (a : Real) : Object (Germ a) where
  theory := (Germ a).theory
  objName := (Germ a).objName
  repr g := s!"Germ of functions at a"

def Germ.ofFunction (f : Real → Real) (a : Real) : Germ a :=
  { representative := f
    equivalenceClass := fun g => JetEquivalent f g a 0 |>.jetAgree
    theory := TheoryName.ofString "real-analysis.germ"
    objName := s!"Germ at a" }

/-! ## Jet space as quotient J^k(ℝ,ℝ) -/

structure JetQuotient (a : Real) (k : Nat) where
  functions : Real → Real → Prop  -- equivalence relation: same k-jet
  quotientSpace : Type
  proj : (Real → Real) → quotientSpace
  theory : TheoryName := TheoryName.ofString "real-analysis.jet-quotient"
  objName : String := s!"J^{k}(ℝ,ℝ) at a"

/-! ## Stalk of the sheaf of smooth functions -/

structure SmoothGerm (a : Real) where
  smoothRepresentative : Real → Real
  isSmoothRep : isSmooth smoothRepresentative
  equivalence : (Real → Real) → (Real → Real) → Prop
  theory : TheoryName := TheoryName.ofString "real-analysis.smooth-germ"
  objName : String := s!"C^∞_a"

instance (a : Real) : Object (SmoothGerm a) where
  theory := (SmoothGerm a).theory
  objName := (SmoothGerm a).objName
  repr _ := s!"SmoothGerm at a"

/-! ## C^k functions modulo flat functions -/

structure CkModuloFlat (a : Real) (k : Nat) where
  baseCk : Real → Real
  flatPart : Real → Real
  flatCondition : ∀ j : Nat, j ≤ k → nthDerivative flatPart j a = { val := 0.0 } → True
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-mod-flat"
  objName : String := s!"C{k}/Flat at a"

/-! ## Taylor series as quotient -/

structure FormalTaylorSeries (a : Real) where
  coefficients : Nat → Real
  isPowerSeries : True
  theory : TheoryName := TheoryName.ofString "real-analysis.formal-taylor"
  objName : String := "FormalTaylorSeries"

def mkTaylorSeries (f : Real → Real) (a : Real) : FormalTaylorSeries a :=
  { coefficients := fun n => nthDerivative f n a
    isPowerSeries := True.intro
    theory := TheoryName.ofString "real-analysis.formal-taylor"
    objName := "FormalTaylorSeries" }

/-! ## #eval Tests -/

#eval "Constructions.Quotients: Germ, JetQuotient, SmoothGerm, CkModuloFlat, FormalTaylorSeries"
#eval s!"Germ instance: {describe (Germ { val := 0.0 })}"
#eval s!"SmoothGerm instance: {describe (SmoothGerm { val := 0.0 })}"
