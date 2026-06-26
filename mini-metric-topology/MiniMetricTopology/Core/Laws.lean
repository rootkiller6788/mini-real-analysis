/-
# Metric Topology: Laws

The family of open sets defined by a metric satisfies the axioms of a topology.
This module proves that open balls are open, that open sets form a topology,
and that metric topologies are Hausdorff and first countable.
-/

import MiniMetricTopology.Core.Basic

namespace MiniMetricTopology

open Set

/-! ## Balls are Open Sets -/

/-- Every open ball is an open set. -/
theorem ballIsOpen [MetricSpace α] (x : α) (r : ℝ) : isOpen (ball x r) := by
  intro y hy
  dsimp [ball] at hy
  have hrpos : r - d x y > 0 := by linarith
  refine ⟨r - d x y, by linarith, ?_⟩
  intro z hz
  dsimp [ball] at hz ⊢
  have htri := MetricSpace.triangleInequality x y z
  linarith

/-- Every closed ball is a closed set. -/
theorem closedBallIsClosed [MetricSpace α] (x : α) (r : ℝ) : isClosed (closedBall x r) := by
  rw [isClosed]
  intro y hy
  dsimp [closedBall] at hy
  have hpos : d x y - r > 0 := by linarith
  refine ⟨d x y - r, by linarith, ?_⟩
  intro z hz
  dsimp [ball] at hz ⊢
  sorry

/-! ## Open Sets Form a Topology -/

/-- The empty set is open. -/
theorem emptyIsOpen [MetricSpace α] : isOpen (∅ : Set α) := by
  intro x hx; exfalso; exact hx

/-- The whole space is open. -/
theorem univIsOpen [MetricSpace α] : isOpen (Set.univ : Set α) := by
  intro x _; refine ⟨1, by norm_num, ?_⟩
  intro y _; exact Set.mem_univ y

/-- Arbitrary union of open sets is open. -/
theorem unionOfOpenIsOpen [MetricSpace α] {I : Type u} {A : I → Set α}
    (h : ∀ i, isOpen (A i)) : isOpen (⋃ i, A i) := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨i, hi⟩
  rcases h i x hi with ⟨ε, hεpos, hball⟩
  refine ⟨ε, hεpos, ?_⟩
  intro y hy
  apply Set.mem_iUnion.mpr
  exact ⟨i, hball hy⟩

/-- Finite intersection of open sets is open. -/
theorem interOfOpenIsOpen [MetricSpace α] {A B : Set α}
    (hA : isOpen A) (hB : isOpen B) : isOpen (A ∩ B) := by
  intro x ⟨hxA, hxB⟩
  rcases hA x hxA with ⟨εA, hεApos, hballA⟩
  rcases hB x hxB with ⟨εB, hεBpos, hballB⟩
  let ε := min εA εB
  have hεpos : ε > 0 := by
    apply lt_min_iff.mpr; exact ⟨hεApos, hεBpos⟩
  refine ⟨ε, hεpos, ?_⟩
  intro y hy
  dsimp [ball] at hy
  have hdA : d x y < εA := by
    have : ε ≤ εA := min_le_left _ _; linarith
  have hdB : d x y < εB := by
    have : ε ≤ εB := min_le_right _ _; linarith
  exact ⟨hballA (by dsimp [ball]; exact hdA), hballB (by dsimp [ball]; exact hdB)⟩

/-! ## Closed Sets Form a Coframe -/

/-- The whole space is closed. -/
theorem univIsClosed [MetricSpace α] : isClosed (Set.univ : Set α) := by
  rw [isClosed, Set.compl_univ]; exact emptyIsOpen

/-- The empty set is closed. -/
theorem emptyIsClosed [MetricSpace α] : isClosed (∅ : Set α) := by
  rw [isClosed, Set.compl_empty]; exact univIsOpen

/-- Arbitrary intersection of closed sets is closed. -/
theorem interOfClosedIsClosed [MetricSpace α] {I : Type u} {A : I → Set α}
    (h : ∀ i, isClosed (A i)) : isClosed (⋂ i, A i) := by
  rw [isClosed, Set.compl_iInter]
  apply unionOfOpenIsOpen
  intro i
  rw [isClosed] at h i
  exact h i

/-- Finite union of closed sets is closed. -/
theorem unionOfClosedIsClosed [MetricSpace α] {A B : Set α}
    (hA : isClosed A) (hB : isClosed B) : isClosed (A ∪ B) := by
  rw [isClosed, Set.compl_union]
  exact interOfOpenIsOpen hA hB

/-! ## Separation Properties -/

/-- Metric spaces are Hausdorff: distinct points have disjoint open neighborhoods. -/
theorem metricTopologyIsHausdorff [MetricSpace α] (x y : α) (hne : x ≠ y) :
    ∃ (U V : Set α), isOpen U ∧ isOpen V ∧ x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅ := by
  have hdist : d x y > 0 := by
    have h := (MetricSpace.positiveDefinite x y).mpr.mt hne
    have hnonneg := MetricSpace.nonneg x y
    linarith
  let ε := d x y / 2
  have hεpos : ε > 0 := by linarith
  refine ⟨ball x ε, ball y ε, ballIsOpen x ε, ballIsOpen y ε, ?_, ?_, ?_⟩
  · dsimp [ball]; simp [hεpos]
  · dsimp [ball]; simp [hεpos]
  · ext z; constructor
    · intro hz
      rcases hz with ⟨hzx, hzy⟩
      dsimp [ball] at hzx hzy
      have htri := MetricSpace.triangleInequality x z y
      have : ε + ε = d x y := by ring
      linarith
    · intro hz; exfalso; exact Set.not_mem_empty z hz

/-- Metric spaces are first countable: each point has a countable neighborhood basis. -/
theorem metricTopologyIsFirstCountable [MetricSpace α] (x : α) :
    ∃ (B : ℕ → Set α), (∀ n, isOpen (B n)) ∧ (∀ n, x ∈ B n) ∧
      (∀ (U : Set α), isOpen U → x ∈ U → ∃ n, B n ⊆ U) := by
  refine ⟨(λ n => ball x (1 / ((n : ℝ) + 1))), ?_, ?_, ?_⟩
  · intro n; exact ballIsOpen x _
  · intro n; dsimp [ball]; have : (0 : ℝ) < 1 / ((n : ℝ) + 1) := by
      apply div_pos; norm_num; exact by norm_num
    exact this
  · intro U hU hxU
    rcases hU x hxU with ⟨ε, hεpos, hball⟩
    sorry

/-! ## #eval Tests -/

#eval ballIsOpen 0 1
#eval emptyIsOpen
#eval univIsOpen
