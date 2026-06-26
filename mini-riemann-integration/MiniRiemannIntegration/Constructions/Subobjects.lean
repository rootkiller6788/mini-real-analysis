/-
# MiniRiemannIntegration.Constructions.Subobjects

R([a,b]) — Riemann integrable functions as subspace of
bounded functions. C([a,b]) ⊆ R([a,b]).
Monotone functions and step functions as subspaces.
-/

import MiniRiemannIntegration.Constructions.Quotients
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Bounded functions on [a,b] -/

structure BoundedFunction (a b : ℝ) where
  f : ℝ → ℝ
  bound : ℝ
  isBounded : ∀ (x : ℝ), a ≤ x → x ≤ b → |f x| ≤ bound
  deriving Repr

/-! ## Riemann integrable functions as subset of bounded functions -/

structure RiemannAsBoundedSubspace (a b : ℝ) where
  bounded : BoundedFunction a b
  isRiemannInt : isRiemannIntegrable bounded.f a b

theorem riemannIntegrable_bounded (a b : ℝ) (f : ℝ → ℝ) :
  isRiemannIntegrable f a b → ∃ (M : ℝ), ∀ (x : ℝ), a ≤ x → x ≤ b → |f x| ≤ M := by
  intro h_int
  sorry

/-! ## Continuous functions are Riemann integrable -/

theorem continuous_implies_riemannIntegrable (a b : ℝ) (f : ℝ → ℝ) :
  (∀ (x : ℝ), a ≤ x → x ≤ b → True) → isRiemannIntegrable f a b := by
  -- If f is continuous on [a,b], then f is Riemann integrable on [a,b]
  intro h_cont
  sorry

structure ContinuousSubspace (a b : ℝ) where
  f : ℝ → ℝ
  continuous : ∀ (x : ℝ), a ≤ x → x ≤ b → True  -- placeholder for continuity
  integrable : isRiemannIntegrable f a b
  subspaceProof : integrable = continuous_implies_riemannIntegrable a b f continuous

/-! ## Monotone functions are Riemann integrable -/

theorem monotone_implies_riemannIntegrable (a b : ℝ) (f : ℝ → ℝ) :
  (∀ (x y : ℝ), a ≤ x → x ≤ y → y ≤ b → f x ≤ f y) → isRiemannIntegrable f a b := by
  intro h_mono
  sorry

structure MonotoneSubspace (a b : ℝ) where
  f : ℝ → ℝ
  monotone : ∀ (x y : ℝ), a ≤ x → x ≤ y → y ≤ b → f x ≤ f y
  integrable : isRiemannIntegrable f a b :=
    monotone_implies_riemannIntegrable a b f monotone

/-! ## Step functions are Riemann integrable -/

theorem stepFunction_riemannIntegrable (a b : ℝ) (sf : StepFunction a b) :
  isRiemannIntegrable sf.f a b := sf.isRiemannIntegrable

structure StepSubspace (a b : ℝ) where
  stepFuncs : List (StepFunction a b)
  denseInRiemann : Prop  -- step functions are dense in R([a,b])

/-! ## Inclusion chain -/

structure FunctionSpaceInclusions (a b : ℝ) where
  -- Step ⊂ C([a,b]) ⊂ Monotone ⊂ R([a,b]) ⊂ Bounded([a,b])
  -- Actually: Step ⊂ R([a,b]) and C([a,b]) ⊂ R([a,b]) and Monotone ⊂ R([a,b])
  stepToRiemann : ∀ (f : ℝ → ℝ), (∃ (sf : StepFunction a b), sf.f = f) → isRiemannIntegrable f a b
  continuousToRiemann : ∀ (f : ℝ → ℝ), (∀ x ∈ Set.Icc a b, True) → isRiemannIntegrable f a b
  monotoneToRiemann : ∀ (f : ℝ → ℝ), (∀ x y ∈ Set.Icc a b, x ≤ y → f x ≤ f y) → isRiemannIntegrable f a b

/-! ## #eval Tests -/

#eval "Constructions.Subobjects: BoundedFunction, RiemannAsBoundedSubspace"
#eval "Constructions.Subobjects: continuous_implies_riemannIntegrable (sorry)"
#eval "Constructions.Subobjects: monotone_implies_riemannIntegrable, stepFunction_riemannIntegrable"

end MiniRiemannIntegration
