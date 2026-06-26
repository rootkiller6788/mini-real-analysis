/-
# Product Metric Spaces

Given two metric spaces (X, d_X) and (Y, d_Y), there are several natural
metrics on the product X × Y. The ℓ^p product metrics unify them.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws

namespace MiniMetricTopology

open Set

/-! ## Product Metric (ℓ¹ / taxicab) -/

/-- The ℓ¹ product metric: d((x₁,y₁),(x₂,y₂)) = d_X(x₁,x₂) + d_Y(y₁,y₂). -/
def productMetric (α β : Type u) [MetricSpace α] [MetricSpace β] :
    MetricSpace (α × β) where
  d := λ ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ => d x₁ x₂ + d y₁ y₂
  positiveDefinite := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    constructor
    · intro h
      have hsum : d x₁ x₂ + d y₁ y₂ = 0 := h
      have hx_nonneg := MetricSpace.nonneg x₁ x₂
      have hy_nonneg := MetricSpace.nonneg y₁ y₂
      have hx_zero : d x₁ x₂ = 0 := by nlinarith
      have hy_zero : d y₁ y₂ = 0 := by nlinarith
      have hx := (MetricSpace.positiveDefinite x₁ x₂).mp hx_zero
      have hy := (MetricSpace.positiveDefinite y₁ y₂).mp hy_zero
      simp [hx, hy]
    · intro h
      have ⟨hx, hy⟩ : x₁ = x₂ ∧ y₁ = y₂ := by
        injection h; exact And.intro ‹_› ‹_›
      simp [hx, hy]
      have := (MetricSpace.positiveDefinite x₁ x₁).mpr rfl
      have := (MetricSpace.positiveDefinite y₁ y₁).mpr rfl
      simp
  symmetric := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    simp [MetricSpace.symmetric x₁ x₂, MetricSpace.symmetric y₁ y₂]
  triangleInequality := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ ⟨x₃, y₃⟩
    have hx := MetricSpace.triangleInequality x₁ x₂ x₃
    have hy := MetricSpace.triangleInequality y₁ y₂ y₃
    nlinarith

/-- The ℓ∞ product metric: d((x₁,y₁),(x₂,y₂)) = max(d_X(x₁,x₂), d_Y(y₁,y₂)). -/
def maxProductMetric (α β : Type u) [MetricSpace α] [MetricSpace β] :
    MetricSpace (α × β) where
  d := λ ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ => max (d x₁ x₂) (d y₁ y₂)
  positiveDefinite := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    constructor
    · intro h
      have hmax : max (d x₁ x₂) (d y₁ y₂) = 0 := h
      have hx_nonneg := MetricSpace.nonneg x₁ x₂
      have hy_nonneg := MetricSpace.nonneg y₁ y₂
      sorry
    · intro h
      have ⟨hx, hy⟩ : x₁ = x₂ ∧ y₁ = y₂ := by
        injection h; exact And.intro ‹_› ‹_›
      simp [hx, hy]
      sorry
  symmetric := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    simp [MetricSpace.symmetric x₁ x₂, MetricSpace.symmetric y₁ y₂]
  triangleInequality := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ ⟨x₃, y₃⟩
    have hx := MetricSpace.triangleInequality x₁ x₂ x₃
    have hy := MetricSpace.triangleInequality y₁ y₂ y₃
    sorry

/-- The ℓ² product metric: d = sqrt(d_X² + d_Y²). -/
def euclideanProductMetric (α β : Type u) [MetricSpace α] [MetricSpace β] :
    MetricSpace (α × β) where
  d := λ ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ => Real.sqrt ((d x₁ x₂)^2 + (d y₁ y₂)^2)
  positiveDefinite := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    constructor
    · intro h
      have hsq : Real.sqrt ((d x₁ x₂)^2 + (d y₁ y₂)^2) = 0 := h
      sorry
    · intro h
      injection h with hx hy
      simp [hx, hy]
  symmetric := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩
    simp [MetricSpace.symmetric x₁ x₂, MetricSpace.symmetric y₁ y₂]
  triangleInequality := by
    intro ⟨x₁, y₁⟩ ⟨x₂, y₂⟩ ⟨x₃, y₃⟩
    sorry

/-! ## Product Open Sets -/

/-- In the product metric, open sets are unions of products of open sets. -/
theorem productOpenSetsAreProductsOfOpenSets [MetricSpace α] [MetricSpace β]
    (U : Set (α × β)) (hU : isOpen U) :
    ∀ p ∈ U, ∃ (V : Set α) (W : Set β), isOpen V ∧ isOpen W ∧ p.1 ∈ V ∧ p.2 ∈ W ∧
      (V ×ˢ W) ⊆ U := by
  intro p hp
  rcases hU p hp with ⟨ε, hεpos, hball⟩
  refine ⟨ball p.1 (ε/2), ball p.2 (ε/2),
    ballIsOpen p.1 (ε/2), ballIsOpen p.2 (ε/2), ?_, ?_, ?_⟩
  · dsimp [ball]; have h : ε/2 > 0 := by linarith; exact h
  · dsimp [ball]; have h : ε/2 > 0 := by linarith; exact h
  · intro q
    rcases q with ⟨x, y⟩
    intro ⟨hx, hy⟩
    dsimp [ball] at hx hy
    apply hball
    dsimp [ball]
    dsimp [productMetric] at *
    calc
      d p.1 x + d p.2 y < ε/2 + ε/2 := by
        apply add_lt_add hx hy
      _ = ε := by ring

/-- The projection maps from a product metric space are continuous. -/
theorem productProjectionsAreContinuous [MetricSpace α] [MetricSpace β] :
    (∀ (a : α) (b : β) (ε : ℝ), ε > 0 → ∃ δ > 0,
      ∀ (a' : α) (b' : β), d (a, b) (a', b') < δ → d a a' < ε) ∧
    (∀ (a : α) (b : β) (ε : ℝ), ε > 0 → ∃ δ > 0,
      ∀ (a' : α) (b' : β), d (a, b) (a', b') < δ → d b b' < ε) := by
  sorry

/-! ## #eval Tests -/

def prodSpace := productMetric ℝ ℝ
#eval d ((3, 5) : ℝ × ℝ) ((7, 9) : ℝ × ℝ)
#eval (productOpenSetsAreProductsOfOpenSets (Set.univ : Set (ℝ × ℝ)) univIsOpen
         ((0, 0) : ℝ × ℝ) (by simp))
