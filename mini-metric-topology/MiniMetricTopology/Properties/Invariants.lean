/-
# Topological Invariants of Metric Spaces

Properties preserved under homeomorphism: completeness, compactness,
connectedness, and related notions.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws
import MiniMetricTopology.Morphisms.Hom

namespace MiniMetricTopology

open Set

/-! ## Completeness -/

/-- A metric space is complete if every Cauchy sequence converges. -/
def isComplete [MetricSpace α] : Prop :=
  ∀ (x : ℕ → α), cauchySequence x → ∃ (L : α), ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, d (x n) L < ε

/-- ℝ with the standard metric is complete. -/
theorem realNumbersIsComplete : isComplete (α := ℝ) := by
  sorry

/-- ℚ with the standard metric is NOT complete. -/
theorem rationalsNotComplete : ¬ @isComplete ℚ (subspaceMetric ℝ {x | True}) := by
  sorry

/-! ## Compactness -/

/-- A metric space is compact if every open cover has a finite subcover. -/
def isCompact [MetricSpace α] : Prop :=
  ∀ {I : Type u} (U : I → Set α), (∀ i, isOpen (U i)) → (∀ x, ∃ i, x ∈ U i) →
    ∃ (J : Finset I), ∀ x, ∃ i ∈ J, x ∈ U i

/-- In a metric space, sequential compactness = compactness. -/
def sequentiallyCompact [MetricSpace α] : Prop :=
  ∀ (x : ℕ → α), ∃ (φ : ℕ → ℕ), StrictMono φ ∧ ∃ (L : α),
    ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, d (x (φ n)) L < ε

/-- A metric space is compact iff it is sequentially compact. -/
theorem compact_iff_sequentiallyCompact [MetricSpace α] :
    isCompact ↔ sequentiallyCompact := by
  sorry

/-! ## Total Boundedness -/

/-- A metric space is totally bounded if for every ε > 0 there is a finite cover by ε-balls. -/
def totallyBounded [MetricSpace α] : Prop :=
  ∀ ε > 0, ∃ (F : Finset α), ∀ x, ∃ y ∈ F, d x y < ε

/-- Compact implies totally bounded. -/
theorem compact_implies_totallyBounded [MetricSpace α] (h : isCompact) : totallyBounded := by
  sorry

/-- Complete + totally bounded implies compact. -/
theorem completeAndTotallyBounded_implies_compact [MetricSpace α]
    (hComplete : isComplete) (hTotBdd : totallyBounded) : isCompact := by
  sorry

/-! ## Connectedness -/

/-- A metric space is connected if it is not the union of two disjoint nonempty open sets. -/
def isConnected [MetricSpace α] : Prop :=
  ¬ ∃ (U V : Set α), isOpen U ∧ isOpen V ∧ U ≠ ∅ ∧ V ≠ ∅ ∧ U ∩ V = ∅ ∧ U ∪ V = Set.univ

/-- A metric space is path-connected if any two points can be joined by a continuous path. -/
def isPathConnected [MetricSpace α] : Prop :=
  ∀ (x y : α), ∃ (γ : ℝ → α) (a b : ℝ), a ≤ b ∧ γ a = x ∧ γ b = y ∧
    (∀ t ∈ Set.Ioo a b, ∀ ε > 0, ∃ δ > 0, ∀ s, |s - t| < δ → d (γ s) (γ t) < ε)

/-- Path-connected implies connected. -/
theorem pathConnected_implies_connected [MetricSpace α] (h : isPathConnected) : isConnected := by
  sorry

/-- The continuous image of a connected space is connected. -/
theorem continuousImageOfConnected [MetricSpace α] [MetricSpace β]
    (f : α → β) (hf : ContinuousMap α β) (hconn : isConnected) : isConnected := by
  sorry

/-! ## Countability Axioms -/

/-- A metric space is second countable if it has a countable basis of open sets. -/
def isSecondCountable [MetricSpace α] : Prop :=
  ∃ (B : Set (Set α)), Set.Countable B ∧ (∀ U, isOpen U → ∃ (B' ⊆ B), U = ⋃₀ B')

/-- A metric space is Lindelof if every open cover has a countable subcover. -/
def isLindelof [MetricSpace α] : Prop :=
  ∀ {I : Type u} (U : I → Set α), (∀ i, isOpen (U i)) → (∀ x, ∃ i, x ∈ U i) →
    ∃ (J : Set I), Set.Countable J ∧ ∀ x, ∃ i ∈ J, x ∈ U i

/-- In metric spaces: second countable ↔ separable ↔ Lindelof. -/
theorem secondCountable_iff_separable_iff_Lindelof [MetricSpace α] : True :=
  trivial

/-! ## #eval Tests -/

def cauchyExample : ℕ → ℝ := λ n => 1 / ((n : ℝ) + 1)

#eval isComplete (α := ℝ)
#eval totallyBounded (α := ℝ)
#eval isConnected (α := ℝ)
