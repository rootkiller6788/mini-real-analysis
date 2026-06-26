/-
# Metric Space as a Mathematical Object

Registration of MetricSpace with the kernel Object typeclass,
and the definition of the metric topology as a topology induced by a metric.
-/

import MiniObjectKernel
import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws

namespace MiniMetricTopology

/-! ## Object Instance -/

/-- Register MetricSpace as a kernel `Object`. -/
instance {α : Type u} [MetricSpace α] : Object α where
  theory := TheoryName.ofString "metric"
  objName := "MetricSpace"
  repr x := s!"{x}"

/-- The theory name for metric topology. -/
def metricTheory : TheoryName := TheoryName.ofString "metric.metricTopology"

/-! ## Metric Topology -/

/-- The topology induced by a metric: the collection of all open sets.
    This is a bona fide topology. -/
structure MetricTopology (α : Type u) [MetricSpace α] where
  opens : Set (Set α)
  containsEmpty : ∅ ∈ opens
  containsUniv : Set.univ ∈ opens
  closedUnderArbitraryUnion : ∀ {I : Type u} (A : I → Set α),
    (∀ i, A i ∈ opens) → (⋃ i, A i) ∈ opens
  closedUnderFiniteInter : ∀ (A B : Set α),
    A ∈ opens → B ∈ opens → (A ∩ B) ∈ opens

/-- Construct a MetricTopology from a MetricSpace. -/
def MetricTopology.ofMetricSpace (α : Type u) [MetricSpace α] : MetricTopology α where
  opens := {A | isOpen A}
  containsEmpty := emptyIsOpen
  containsUniv := univIsOpen
  closedUnderArbitraryUnion := by
    intro I A h
    apply unionOfOpenIsOpen
    intro i; rw [Set.mem_setOf_eq]; exact h i
  closedUnderFiniteInter := by
    intro A B hA hB
    rw [Set.mem_setOf_eq] at hA hB
    exact interOfOpenIsOpen hA hB

/-- The `isOpen` predicate matches membership in the metric topology. -/
theorem isOpen_iff_mem_opens [MetricSpace α] (A : Set α) :
    isOpen A ↔ A ∈ (MetricTopology.ofMetricSpace α).opens := by
  rfl

/-- The metric topology as a type synonym indicating we view the metric space
    through its topological structure. -/
def MetTop (α : Type u) [MetricSpace α] : Type u := α

/-- Every metric topology object is an Object in the kernel. -/
instance {α : Type u} [MetricSpace α] : Object (MetricTopology α) where
  theory := metricTheory
  objName := "MetricTopology"
  repr _ := "MetricTopology"

/-! ## #eval Tests -/

#eval metricTheory
#eval (MetricTopology.ofMetricSpace ℝ : MetricTopology ℝ).containsEmpty
#eval isOpen_iff_mem_opens (ball (0 : ℝ) 1)
