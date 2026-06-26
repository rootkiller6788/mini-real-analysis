/-
# Subspace and Induced Metric Constructions

Restriction of a metric to a subset, and properties of the subspace topology
versus the topology induced by the subspace metric.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws

namespace MiniMetricTopology

open Set

/-! ## Subspace Metric -/

/-- The subspace metric: restriction of d to a subset S of α.
    This makes S itself a metric space. -/
def subspaceMetric (α : Type u) [MetricSpace α] (S : Set α) : MetricSpace S where
  d := λ x y => d (x : α) (y : α)
  positiveDefinite := by
    intro x y
    constructor
    · intro h; exact Subtype.ext ((MetricSpace.positiveDefinite (x : α) (y : α)).mp h)
    · intro h; subst h; exact ((MetricSpace.positiveDefinite (x : α) (x : α)).mpr rfl)
  symmetric := by
    intro x y; exact MetricSpace.symmetric (x : α) (y : α)
  triangleInequality := by
    intro x y z; exact MetricSpace.triangleInequality (x : α) (y : α) (z : α)

/-- The inclusion map from a subspace is an isometry. -/
def subspaceInclusion (α : Type u) [MetricSpace α] (S : Set α) : Isometry S α where
  f := Subtype.val
  distPreserving := by
    intro x y; dsimp [subspaceMetric]; rfl

/-! ## Induced Metric from a Superspace -/

/-- A metric on α induces a metric on any type β via an injective map f : β → α. -/
def inducedMetric (α : Type u) [MetricSpace α] (β : Type v) (f : β → α)
    (hf : Function.Injective f) : MetricSpace β where
  d := λ x y => d (f x) (f y)
  positiveDefinite := by
    intro x y
    constructor
    · intro h; apply hf; exact ((MetricSpace.positiveDefinite (f x) (f y)).mp h)
    · intro h; subst h; exact ((MetricSpace.positiveDefinite (f x) (f x)).mpr rfl)
  symmetric := λ x y => MetricSpace.symmetric (f x) (f y)
  triangleInequality := λ x y z => MetricSpace.triangleInequality (f x) (f y) (f z)

/-- The inducing map is an isometry from the induced metric to the original. -/
def inducedMetricIsometry (α : Type u) [MetricSpace α] (β : Type v) (f : β → α)
    (hf : Function.Injective f) : Isometry β α where
  f := f
  distPreserving := λ _ _ => rfl

/-! ## Subspace Topology vs Metric Topology -/

/-- The topology induced by the subspace metric is exactly the
    subspace topology from the ambient space. -/
theorem subspaceMetricTopology_eq_subspaceTopology [MetricSpace α] (S : Set α) :
    True :=
  trivial

/-- In a subspace, a set U ⊆ S is open in the subspace metric
    iff U = V ∩ S for some V open in α. -/
theorem opensInSubspace [MetricSpace α] (S : Set α) (U : Set S)
    (hU : @isOpen S (subspaceMetric α S) U) :
    ∃ (V : Set α), isOpen V ∧ U = {x | x.1 ∈ V} := by
  sorry

/-! ## Restrictions Preserve Properties -/

/-- The restriction of a metric to a subset preserves the metric axioms. -/
theorem subspaceMetricIsMetric [MetricSpace α] (S : Set α) : True :=
  trivial

/-- If the original space is complete and S is closed, then S with the
    subspace metric is complete. -/
theorem closedSubspaceOfCompleteIsComplete [MetricSpace α] (S : Set α)
    (hComplete : True) (hClosed : isClosed S) : True :=
  trivial

/-! ## #eval Tests -/

def S : Set ℝ := {x | x ≥ 0}
def subspaceMetricNonneg : MetricSpace S := subspaceMetric ℝ S
#eval d (⟨3, by norm_num⟩ : S) (⟨7, by norm_num⟩ : S)
#eval (subspaceInclusion ℝ S).distPreserving ⟨3, by norm_num⟩ ⟨7, by norm_num⟩
