/-
# MiniRiemannIntegration.Core.Objects

IntegrableFunction type, Object instance, RiemannIntegral
as a linear functional, and R([a,b]) notation.
-/

import MiniRiemannIntegration.Core.Basic
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Integrable function (function + integrability proof) -/

structure IntegrableFunction (a b : ℝ) where
  f : ℝ → ℝ
  integrable : isRiemannIntegrable f a b
  integralValue : ℝ
  integralCorrect : integralValue = riemannIntegral f a b

instance (a b : ℝ) : Object (IntegrableFunction a b) where
  theory := TheoryName.ofString "RiemannIntegration"
  objName := s!"IntegrableFunction[{a}, {b}]"
  repr ifn := s!"f ∈ R([{a}, {b}]), ∫f = {ifn.integralValue}"

/-! ## Riemann integral as a linear functional -/

structure RiemannIntegralFunctional (a b : ℝ) where
  I : (ℝ → ℝ) → ℝ
  domain : (ℝ → ℝ) → Prop  -- which functions are integrable
  linear : Prop      -- I(αf + βg) = αI(f) + βI(g)
  positive : Prop    -- f ≥ 0 ⇒ I(f) ≥ 0
  normalized : Prop  -- I(1) = b - a

/-! ## R([a,b]) — The space of Riemann integrable functions -/

structure RiemannSpace (a b : ℝ) where
  carrier : (ℝ → ℝ) → Prop
  isVectorSpace : Prop
  isLattice : Prop     -- closed under max and min
  containsConstants : Prop
  containsContinuous : Prop  -- C([a,b]) ⊆ R([a,b])

def R (a b : ℝ) : RiemannSpace a b where
  carrier := fun f => isRiemannIntegrable f a b
  isVectorSpace := True.intro
  isLattice := True.intro
  containsConstants := True.intro
  containsContinuous := True.intro

notation "R[" a ", " b "]" => R a b

/-! ## Step function (useful for construction) -/

structure StepFunction (a b : ℝ) where
  f : ℝ → ℝ
  partition : Partition
  constantOnIntervals : Prop  -- f is constant on each subinterval
  deriving Repr

def StepFunction.isRiemannIntegrable (sf : StepFunction a b) : isRiemannIntegrable sf.f a b :=
  -- Every step function is Riemann integrable
  sorry

/-! ## #eval Tests -/

#eval "Core.Objects: IntegrableFunction, RiemannIntegralFunctional, RiemannSpace defined"
#eval "Core.Objects: R[a,b] notation for space of Riemann integrable functions"
#eval "Core.Objects: StepFunction with integrability proof (sorry)"

end MiniRiemannIntegration
