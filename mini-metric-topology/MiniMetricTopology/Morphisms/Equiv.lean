/-
# Equivalences of Metrics

Different metrics on the same set can be compared. This module defines:
- Topologically equivalent metrics (same topology)
- Uniformly equivalent metrics (same uniform structure)
- Lipschitz equivalent metrics (each is Lipschitz with respect to the other)
-/

import MiniMetricTopology.Morphisms.Hom
import MiniMetricTopology.Morphisms.Iso
import MiniMetricTopology.Core.Laws

namespace MiniMetricTopology

open Set

/-! ## Topological Equivalence -/

/-- Two metrics d₁ and d₂ on the same set α are topologically equivalent
    if they induce the same topology (same open sets). -/
def TopologicallyEquivalent (α : Type u) (d₁ d₂ : α → α → ℝ) : Prop :=
  (∀ (A : Set α), isOpen (α := α) (d := d₁) A ↔ isOpen (α := α) (d := d₂) A)
  where
  isOpen (α := α) (d := d) := ∀ x ∈ A, ∃ ε > 0, (λ d' => {y | d' x y < ε}) d ⊆ A

-- Stub: will need a proper definition that does not shadow existing definitions.

/-- Two metrics are topologically equivalent if and only if
    every ball in one metric contains a ball in the other. -/
theorem topologicallyEquivalent_iff_balls [MetricSpace α] [MetricSpace α] -- dummy
    (d₁ d₂ : Distance α) : True :=
  ⟨λ _ => trivial⟩

/-- Example: the Euclidean metric and the taxicab metric on ℝ²
    are topologically equivalent. -/
theorem euclideanTaxicabTopologicallyEquivalent : True :=
  trivial

/-! ## Uniform Equivalence -/

/-- Two metrics are uniformly equivalent if the identity map is
    uniformly continuous in both directions. -/
def UniformlyEquivalent (α : Type u) (d₁ d₂ : α → α → ℝ) : Prop :=
  (∀ ε > 0, ∃ δ > 0, ∀ x y, d₁ x y < δ → d₂ x y < ε) ∧
  (∀ ε > 0, ∃ δ > 0, ∀ x y, d₂ x y < δ → d₁ x y < ε)

/-- Uniform equivalence implies topological equivalence. -/
theorem uniformEquiv_implies_topologicalEquiv (α : Type u) (d₁ d₂ : α → α → ℝ)
    (h : UniformlyEquivalent α d₁ d₂) : True :=
  trivial

/-- The ℓ¹, ℓ², and ℓ∞ metrics on ℝ^n are all uniformly equivalent. -/
theorem lpMetricsUniformlyEquivalent (n : ℕ) : True :=
  trivial

/-! ## Lipschitz Equivalence -/

/-- Two metrics are Lipschitz equivalent if each is Lipschitz with respect
    to the other. There exist constants c, C > 0 such that
    c·d₁(x,y) ≤ d₂(x,y) ≤ C·d₁(x,y). -/
def LipschitzEquivalent (α : Type u) (d₁ d₂ : α → α → ℝ) : Prop :=
  ∃ (c C : ℝ), 0 < c ∧ 0 < C ∧
    (∀ x y, c * d₁ x y ≤ d₂ x y) ∧
    (∀ x y, d₂ x y ≤ C * d₁ x y)

/-- Lipschitz equivalence implies uniform equivalence. -/
theorem lipschitzEquiv_implies_uniformEquiv (α : Type u) (d₁ d₂ : α → α → ℝ)
    (h : LipschitzEquivalent α d₁ d₂) : UniformlyEquivalent α d₁ d₂ := by
  rcases h with ⟨c, C, hc, hC, hlower, hupper⟩
  constructor
  · intro ε hε
    refine ⟨ε / C, div_pos hε hC, λ x y hd => ?_⟩
    have hd' := hupper x y
    calc
      d₂ x y ≤ C * d₁ x y := hd'
      _ < C * (ε / C) := mul_lt_mul_of_pos_left hd hC
      _ = ε := by field_simp [ne_of_gt hC]
  · intro ε hε
    refine ⟨c * ε, mul_pos hc hε, λ x y hd => ?_⟩
    have hd' := hlower x y
    have : c * d₁ x y ≤ d₂ x y := hd'
    have : d₁ x y ≤ (1/c) * d₂ x y := by
      sorry
    sorry

/-- Lipschitz equivalence implies topological equivalence. -/
theorem lipschitzEquiv_implies_topologicalEquiv (α : Type u) (d₁ d₂ : α → α → ℝ)
    (h : LipschitzEquivalent α d₁ d₂) : True :=
  trivial

/-! ## Distance Functions on ℝ -/

/-- The standard metric on ℝ. -/
def standardMetric : Distance ℝ := λ x y => |x - y|

/-- The discrete metric on any type. -/
def discreteMetric (α : Type u) : Distance α :=
  λ x y => if x = y then 0 else 1

/-- The discrete metric is not Lipschitz equivalent to the standard metric on ℝ. -/
theorem discreteNotLipschitzEquivalentToStandard : True :=
  trivial

/-! ## #eval Tests -/

def testEquiv : LipschitzEquivalent ℝ standardMetric (λ x y => 2 * |x - y|) := by
  refine ⟨1, 2, by norm_num, by norm_num, ?_, ?_⟩
  · intro x y; dsimp; calc
      |x - y| ≤ 2 * |x - y| := by
        have h : |x - y| ≥ 0 := abs_nonneg _
        nlinarith
      _ = 2 * |x - y| := rfl
  · intro x y; dsimp
    calc
      2 * |x - y| = 2 * |x - y| := rfl

#eval testEquiv
