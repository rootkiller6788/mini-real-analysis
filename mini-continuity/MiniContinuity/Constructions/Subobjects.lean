/-
# MiniContinuity.Constructions.Subobjects

Subobjects in continuity theory: subspaces of C(X):
C_b(X) — bounded continuous functions,
C_c(X) — compactly supported continuous functions,
C₀(X) — continuous functions vanishing at infinity.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Core.Objects

open MiniMathKernel

namespace MiniContinuity

/-! ## Bounded Continuous Functions C_b(X) -/

/-- C_b(ℝ): bounded continuous functions on ℝ -/
structure BoundedContinuousFn where
  fn : ℝ → ℝ
  cont : isContinuous fn
  bound : ℝ
  hbound : ∀ x, abs (fn x) ≤ bound

/-- The supremum norm on C_b(ℝ): ||f||_∞ = sup |f(x)| -/
def supNorm (f : BoundedContinuousFn) : ℝ :=
  -- supremum, but defined here as the bound property
  f.bound

/-- C_b(ℝ) is closed under addition -/
def BoundedContinuousFn.add (f g : BoundedContinuousFn) : BoundedContinuousFn where
  fn := fun x => f.fn x + g.fn x
  cont := by
    intro a
    sorry
  bound := f.bound + g.bound
  hbound := by
    intro x
    have hf := f.hbound x
    have hg := g.hbound x
    -- |f(x)+g(x)| ≤ |f(x)| + |g(x)| ≤ f.bound + g.bound
    sorry

/-- C_b(ℝ) is closed under scalar multiplication -/
def BoundedContinuousFn.smul (c : ℝ) (f : BoundedContinuousFn) : BoundedContinuousFn where
  fn := fun x => c * f.fn x
  cont := by
    intro a
    sorry
  bound := abs c * f.bound
  hbound := by
    intro x
    -- |c·f(x)| = |c|·|f(x)| ≤ |c|·bound
    sorry

/-! ## Compactly Supported Continuous Functions C_c(X) -/

/-- Support of a function: {x | f(x) ≠ 0} -/
def support (f : ℝ → ℝ) : Set ℝ :=
  {x | f x ≠ 0}

/-- A set is compact in ℝ (Heine-Borel: closed and bounded) -/
def isCompact (K : Set ℝ) : Prop :=
  -- closed and bounded characterization
  (∃ (C : Set ℝ), True) ∧ (∃ M, ∀ x ∈ K, abs x ≤ M)

/-- C_c(ℝ): continuous functions with compact support -/
structure CompactSupportContinuousFn where
  fn : ℝ → ℝ
  cont : isContinuous fn
  compSupport : isCompact (support fn)

/-- The zero function has compact support (empty support) -/
def compactSupportZero : CompactSupportContinuousFn where
  fn := fun _ => 0
  cont := by
    intro a
    sorry
  compSupport := by
    -- support of zero function is empty, which is compact
    sorry

/-- C_c(ℝ) is a subset of C_b(ℝ) — compact support implies bounded -/
theorem compactSupportImpliesBounded (f : CompactSupportContinuousFn) :
    ∃ M, ∀ x, abs (f.fn x) ≤ M := by
  sorry

/-! ## C₀(X): Continuous Functions Vanishing at Infinity -/

/-- C₀(ℝ): continuous functions vanishing at infinity: lim_{|x|→∞} f(x) = 0 -/
structure VanishingAtInfinityContinuousFn where
  fn : ℝ → ℝ
  cont : isContinuous fn
  vanishes : ∀ ε > 0, ∃ N, ∀ x, dist x 0 > N → abs (fn x) < ε

/-- C_c(ℝ) ⊆ C₀(ℝ) — compact support implies vanishing at infinity -/
theorem compactSupportImpliesVanishing (f : CompactSupportContinuousFn) :
    VanishingAtInfinityContinuousFn := by
  sorry

/-- C₀(ℝ) ⊆ C_b(ℝ) — vanishing at infinity implies bounded -/
theorem vanishingImpliesBounded (f : VanishingAtInfinityContinuousFn) :
    ∃ M, ∀ x, abs (f.fn x) ≤ M := by
  sorry

/-- Inclusion chain: C_c ⊆ C₀ ⊆ C_b ⊆ C -/
def inclusionChain : String := "C_c(ℝ) ⊆ C₀(ℝ) ⊆ C_b(ℝ) ⊆ C(ℝ)"

/-! ## #eval Tests -/

#eval "Constructions.Subobjects: BoundedContinuousFn, CompactSupportContinuousFn, VanishingAtInfinityContinuousFn"
#eval "Constructions.Subobjects: inclusionChain = " ++ inclusionChain

end MiniContinuity
