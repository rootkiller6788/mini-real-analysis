/-
# MiniContinuity.Core.Objects

Objects of continuity theory: ContinuousFn as a structure
with a function and a continuity proof. The space C(X,Y)
of continuous functions between metric spaces.
-/

import MiniContinuity.Core.Basic

open MiniMathKernel

namespace MiniContinuity

/-! ## Continuous Function as an Object -/

/-- A continuous function from ℝ to ℝ, carrying its continuity proof -/
structure ContinuousFn where
  fn : ℝ → ℝ
  cont : ∀ x, isContinuousAt fn x
  deriving Inhabited

/-- Identity continuous function -/
def ContinuousFn.id : ContinuousFn where
  fn := fun x => x
  cont := by
    intro x
    intro ε hε
    -- for the identity, choose δ = ε
    sorry

/-- Constant continuous function -/
def ContinuousFn.const (c : ℝ) : ContinuousFn where
  fn := fun _ => c
  cont := by
    intro x
    intro ε hε
    -- constant functions are continuous: choose any δ
    sorry

/-- Sum of two continuous functions is continuous -/
def ContinuousFn.add (f g : ContinuousFn) : ContinuousFn where
  fn := fun x => f.fn x + g.fn x
  cont := by
    intro x
    -- continuity of sum follows from continuity of components
    sorry

/-- Product of two continuous functions is continuous -/
def ContinuousFn.mul (f g : ContinuousFn) : ContinuousFn where
  fn := fun x => f.fn x * g.fn x
  cont := by
    intro x
    sorry

/-- Composition of two continuous functions is continuous -/
def ContinuousFn.comp (f g : ContinuousFn) : ContinuousFn where
  fn := fun x => f.fn (g.fn x)
  cont := by
    intro x
    sorry

/-! ## Space of Continuous Functions C(X) -/

/-- The space of continuous functions from ℝ to ℝ -/
def C_notation := ContinuousFn

-- Notation: C(X, Y) for space of continuous functions
notation "C(" X " → " Y ")" => (X → Y) → Prop

/-- Bounded continuous functions C_b(X) -/
structure BoundedContinuousFn extends ContinuousFn where
  bounded : ∃ M, ∀ x, abs (fn x) ≤ M

/-- Compactly supported continuous functions C_c(X) -/
structure CompactSupportContinuousFn extends ContinuousFn where
  hasCompactSupport : Prop
  -- support is compact: {x | f(x) ≠ 0} is contained in a compact set

/-- Continuous functions vanishing at infinity C₀(X) -/
structure VanishingAtInfinityContinuousFn extends ContinuousFn where
  vanishesAtInfinity : ∀ ε > 0, ∃ N, ∀ x, dist x 0 > N → abs (fn x) < ε

/-! ## Object instance -/

-- instance : Object ContinuousFn where
--   theory := ? "Continuity"
--   objName := "ContinuousFn"
--   repr f := s!"C-fn@{f.fn 0}"

/-! ## #eval Tests -/

#eval "Core.Objects: ContinuousFn, BoundedContinuousFn, CompactSupportContinuousFn"
#eval "Core.Objects: VanishingAtInfinityContinuousFn, C_notation"

end MiniContinuity
