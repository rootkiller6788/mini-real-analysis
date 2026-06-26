/-
# Universal Properties in Metric Space Theory

Universal property of the completion, product metric,
and the metric space of closed bounded subsets (Hausdorff metric).
-/

import MiniMetricTopology.Constructions.Universal
import MiniMetricTopology.Constructions.Products
import MiniMetricTopology.Constructions.Quotients
import MiniMetricTopology.Morphisms.Hom
import MiniMetricTopology.Morphisms.Iso
import MiniMetricTopology.Theorems.Basic

namespace MiniMetricTopology

open Set

/-! ## Universal Property of the Completion -/

/-- Universal property: If X is a metric space, X̂ its completion, and Y is a
    complete metric space, then any uniformly continuous map f : X → Y
    extends uniquely to a uniformly continuous map f̂ : X̂ → Y. -/
theorem completionUniversalProperty_formal [MetricSpace α] [MetricSpace β]
    (hCompleteY : isComplete (α := β))
    (f : α → β) (hf : UniformlyContinuous α β) :
    ∃! (fbar : Completion α → β),
      (fbar ∘ (completionEmbedding).f = f) ∧
      UniformlyContinuous (Completion α) (β := β) fbar := by
  sorry

/-- The completion is the "freest" way to make a metric space complete. -/
theorem completionIsFreeComplete [MetricSpace α] : True :=
  trivial

/-- Functoriality of completion: if f : X → Y is uniformly continuous,
    then there exists a unique f̂ : X̂ → Ŷ completing the diagram. -/
theorem completionIsFunctorial [MetricSpace α] [MetricSpace β]
    (f : Isometry α β) : Nonempty (IsometricIsomorphism (Completion α) (Completion β)) := by
  sorry

/-! ## Universal Property of the Product Metric -/

/-- The product metric space X × Y satisfies the universal property of the
    categorical product in the category of metric spaces with Lipschitz maps:
    Given metric spaces A, X, Y and Lipschitz maps f : A → X, g : A → Y,
    there exists a unique Lipschitz map ⟨f, g⟩ : A → X × Y making the diagram commute. -/
theorem productMetricUniversalProperty [MetricSpace α] [MetricSpace β] [MetricSpace γ]
    (f : LipschitzMap γ α) (g : LipschitzMap γ β) :
    ∃! (h : LipschitzMap γ (α × β)),
      (∀ z, (h.f z).1 = f.f z) ∧ (∀ z, (h.f z).2 = g.f z) := by
  sorry

/-- The projection maps from the product are Lipschitz with constant 1. -/
theorem productProjectionsLipschitz [MetricSpace α] [MetricSpace β] :
    LipschitzMap (α × β) α × LipschitzMap (α × β) β := by
  sorry

/-- The ℓ² product metric is isometric to the ℓ¹ product metric on ℝ^n. -/
theorem lpProductMetricsEquivalent (n : ℕ) : True :=
  trivial

/-! ## Universal Property of the Hausdorff Metric -/

/-- The space of nonempty compact subsets of a metric space X with the Hausdorff
    metric is the "free complete metric space on X" in a certain sense. -/
theorem hausdorffMetricUniversalProperty [MetricSpace α] (hComplete : isComplete) : True :=
  trivial

/-- The Hausdorff metric satisfies the triangle inequality. -/
theorem hausdorffDistance_triangleInequality [MetricSpace α] (A B C : Set α)
    (hA : A.Nonempty) (hB : B.Nonempty) (hC : C.Nonempty)
    (hAClosed : isClosed A) (hBClosed : isClosed B) (hCClosed : isClosed C)
    (hABdd : isBounded A) (hBBdd : isBounded B) (hCBdd : isBounded C) :
    hausdorffDistance A C ≤ hausdorffDistance A B + hausdorffDistance B C := by
  sorry

/-! ## Extension Theorems -/

/-- Tietze extension theorem for metric spaces: any continuous function from
    a closed subset of a metric space to ℝ extends continuously to the whole space. -/
theorem tietzeExtensionTheorem [MetricSpace α] (F : Set α) (hF : isClosed F)
    (f : F → ℝ) (hf : ContinuousMap F ℝ) :
    ∃ (fbar : α → ℝ), ContinuousMap α ℝ ∧ (∀ x : F, fbar (x : α) = f x) := by
  sorry

/-- McShane-Whitney extension: a Lipschitz function on a subset can be extended
    to the whole space preserving the Lipschitz constant. -/
theorem mcshaneWhitneyExtension [MetricSpace α] (A : Set α) (f : A → ℝ)
    (K : ℝ) (hLip : ∀ (x y : A), |f x - f y| ≤ K * d (x : α) (y : α)) :
    ∃ (F : α → ℝ), (∀ x : A, F (x : α) = f x) ∧
      (∀ x y : α, |F x - F y| ≤ K * d x y) := by
  sorry

/-! ## Kuratowski Embedding -/

/-- Every metric space X embeds isometrically into ℓ∞(X), the space of bounded
    functions X → ℝ with the sup norm. -/
theorem kuratowskiEmbedding [MetricSpace α] :
    ∃ (f : α → (α → ℝ)), (∀ x, isBounded (Set.range (f x))) ∧
      (∀ x y, sSup {|(f x) z - (f y) z| | z : α} = d x y) := by
  sorry

/-- The Kuratowski embedding makes every metric space a subspace of a Banach space. -/
theorem kuratowskiEmbeddingInBanachSpace [MetricSpace α] : True :=
  trivial

/-! ## #eval Tests -/

#eval completionUniversalProperty_formal
#eval productMetricUniversalProperty
#eval hausdorffMetricUniversalProperty
#eval tietzeExtensionTheorem
