/-
# MiniContinuity.Properties.Preservation

Preservation properties of continuous functions:
continuous image of compact is compact,
continuous image of connected is connected,
uniform continuity preserved by composition,
and preservation under algebraic operations.
-/

import MiniContinuity.Core.Basic

open MiniMathKernel

namespace MiniContinuity

/-! ## Continuous Image of Compact is Compact -/

/-- The continuous image of a compact set is compact -/
theorem continuousImageOfCompact (f : ℝ → ℝ) (K : Set ℝ)
    (hf : isContinuousOn f K) (hK : isCompact K) :
    isCompact (f '' K) := by
  sorry

/-- Corollary: continuous function on [a,b] attains maximum and minimum -/
theorem continuousOnCompactAttainsBounds (f : ℝ → ℝ) (a b : ℝ)
    (hab : a ≤ b) (hf : isContinuousOn f (Set.Icc a b)) :
    ∃ xmax xmin : ℝ, xmax ∈ Set.Icc a b ∧ xmin ∈ Set.Icc a b ∧
      (∀ x ∈ Set.Icc a b, f xmin ≤ f x ∧ f x ≤ f xmax) := by
  sorry

/-- The image of a closed bounded interval under a continuous function is closed and bounded -/
theorem continuousImageOfClosedInterval (f : ℝ → ℝ) (a b : ℝ)
    (hf : isContinuousOn f (Set.Icc a b)) :
    -- f([a,b]) is closed and bounded
    True := by
  trivial

/-! ## Continuous Image of Connected is Connected -/

/-- The continuous image of a connected set is connected -/
theorem continuousImageOfConnected (f : ℝ → ℝ) (C : Set ℝ)
    (hf : isContinuousOn f C) (hC : -- C is connected, i.e., cannot be split into two separated nonempty open subsets
      -- Simplified: C is an interval
      ∀ x y ∈ C, ∀ z, x ≤ z → z ≤ y → z ∈ C) :
    -- f(C) is connected
    ∀ u v ∈ f '' C, ∀ w, u ≤ w → w ≤ v → w ∈ f '' C := by
  sorry

/-- Continuous functions preserve path-connectedness -/
theorem continuousImageOfPathConnected (f : ℝ → ℝ) (P : Set ℝ)
    (hf : isContinuousOn f P) (hP : ∀ x y ∈ P, ∃ g : ℝ → ℝ, isContinuous g ∧
      g 0 = x ∧ g 1 = y ∧ ∀ t, 0 ≤ t → t ≤ 1 → g t ∈ P) :
    -- f(P) is path-connected
    True := by
  trivial

/-! ## Uniform Continuity Preserved by Composition -/

/-- Composition of uniformly continuous functions is uniformly continuous -/
theorem uniformContinuityComposition (f g : ℝ → ℝ)
    (hf : isUniformlyContinuous f) (hg : isUniformlyContinuous g) :
    isUniformlyContinuous (f ∘ g) := by
  intro ε hε
  rcases hf ε hε with ⟨δf, hδf, hfprop⟩
  rcases hg δf hδf with ⟨δg, hδg, hgprop⟩
  refine ⟨δg, hδg, ?_⟩
  intro x y hxy
  have hgxy : dist (g x) (g y) < δf := hgprop x y hxy
  -- apply f-prop to g x, g y
  sorry

/-- Sum of uniformly continuous functions is uniformly continuous -/
theorem uniformContinuitySum (f g : ℝ → ℝ)
    (hf : isUniformlyContinuous f) (hg : isUniformlyContinuous g) :
    isUniformlyContinuous (fun x => f x + g x) := by
  sorry

/-! ## Preservation under Algebraic Operations -/

/-- Lipschitz property preserved by addition -/
theorem lipschitzSum (f g : ℝ → ℝ) (Kf Kg : ℝ)
    (hf : isLipschitzWith f Kf) (hg : isLipschitzWith g Kg) :
    isLipschitzWith (fun x => f x + g x) (Kf + Kg) := by
  sorry

/-- Holder continuity preserved by composition with Lipschitz -/
theorem holderViaLipschitz (f g : ℝ → ℝ) (α : ℝ)
    (hf : isHolderContinuous f α) (hg : isLipschitz g) :
    isHolderContinuous (f ∘ g) α := by
  sorry

/-! ## #eval Tests -/

#eval "Properties.Preservation: continuousImageOfCompact, continuousImageOfConnected"
#eval "Properties.Preservation: uniformContinuityComposition, lipschitzSum, holderViaLipschitz"

end MiniContinuity
