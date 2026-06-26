/-
# Measure Theory: Object Registration

Registers measure-theoretic structures as `Object` instances
in the MiniObjectKernel framework.
-/

import MiniObjectKernel
import MiniObjectKernel.Core.Objects
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Object Instance for SigmaAlgebra -/

instance (X : Type u) [h : Inhabited X] : Object (SigmaAlgebra X) where
  theory := TheoryName.ofString "MeasureTheory.SetSystems.SigmaAlgebra"
  objName := s!"SigmaAlgebra on {X}"
  repr s := s!"σ-algebra on {X}"

/-! ## Object Instance for MeasurableSpace -/

instance (X : Type u) [h : Inhabited X] : Object (MeasurableSpace X) where
  theory := TheoryName.ofString "MeasureTheory.MeasurableSpace"
  objName := s!"MeasurableSpace on {X}"
  repr ms := s!"MeasurableSpace(X={X})"

/-! ## Object Instance for Measure -/

instance (X : Type u) (ms : MeasurableSpace X) : Object (Measure X ms) where
  theory := TheoryName.ofString "MeasureTheory.Measure"
  objName := s!"Measure on {X}"
  repr μ := s!"μ (countably additive set function)"

/-! ## Object Instance for MeasureSpace -/

instance : Object MeasureSpace where
  theory := TheoryName.ofString "MeasureTheory.MeasureSpace"
  objName := "MeasureSpace"
  repr _ := "MeasureSpace(X, Σ, μ)"

/-! ## Object Instance for MeasurableFunction -/

instance (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    : Object (MeasurableFunction X Y msX msY) where
  theory := TheoryName.ofString "MeasureTheory.MeasurableFunction"
  objName := s!"MeasurableFunction {X} → {Y}"
  repr _ := "Measurable function"

/-! ## Object Instance for SimpleFunction -/

instance (X : Type u) (ms : MeasurableSpace X) : Object (SimpleFunction X ms) where
  theory := TheoryName.ofString "MeasureTheory.SimpleFunction"
  objName := s!"SimpleFunction on {X}"
  repr sf := s!"SimpleFunction with {sf.coeffs.length} components"

/-! ## LebesgueIntegral as Functional -/

/--
The Lebesgue integral is a linear functional on the space of integrable functions.
-/
structure LebesgueIntegral (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) where
  integral : (X → RealNumbers.carrier) → RealNumbers.carrier
  linear : ∀ (f g : X → RealNumbers.carrier) (a : RealNumbers.carrier),
    integral (fun x => RealNumbers.add (RealNumbers.mul a (f x)) (g x)) =
    RealNumbers.add (RealNumbers.mul a (integral f)) (integral g)
  nonnegPreserving : ∀ f, (∀ x, RealNumbers.le RealNumbers.zero (f x)) →
    RealNumbers.le RealNumbers.zero (integral f)
  indicatorProperty : ∀ (A : Set X), isMeasurable ms A →
    integral (fun x => if x ∈ A then RealNumbers.one else RealNumbers.zero) = μ.value A

instance (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Object (LebesgueIntegral X ms μ) where
  theory := TheoryName.ofString "MeasureTheory.LebesgueIntegral"
  objName := s!"LebesgueIntegral on {X}"
  repr _ := "∫· dμ"

/-! ## #eval Tests -/

#eval describe (SigmaAlgebra.trivial Nat)
#eval describe (default : MeasureSpace)
#eval describe (default : SimpleFunction Nat (default : MeasurableSpace Nat))

def sampleSimpleFunction : SimpleFunction Nat (default : MeasurableSpace Nat) where
  coeffs := [RealNumbers.one]
  sets := [{n | n = 0}]
  len_eq := rfl
  measurable_sets := by
    intro s hs
    simp at hs; subst hs; exact trivial
  disjoint := by
    intro i j hi hj hne
    simp

#eval repr sampleSimpleFunction
#eval "Objects registered for: SigmaAlgebra, MeasurableSpace, Measure, MeasureSpace, MeasurableFunction, SimpleFunction, LebesgueIntegral"

end MiniMeasureLebesgue
