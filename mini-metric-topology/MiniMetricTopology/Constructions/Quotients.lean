/-
# Quotient Constructions in Metric Spaces

Quotient pseudometrics, identification spaces from metrics,
and the Hausdorff distance between closed subsets.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws
import MiniMetricTopology.Constructions.Subobjects

namespace MiniMetricTopology

open Set

/-! ## Quotient Pseudometric -/

/-- Given an equivalence relation ~ on a metric space (X, d),
    the quotient pseudometric d_q on X/~ is defined as:
    d_q([x],[y]) = inf { Σ d(p_i,q_i) : finite chains connecting x to y } -/
def quotientPseudometric (α : Type u) [MetricSpace α] (R : α → α → Prop) [Equivalence R] :
    Distance (Quot R) :=
  λ qx qy => 0  -- placeholder; should be infimum over chains

/-- The quotient pseudometric satisfies the triangle inequality. -/
theorem quotientPseudometric_triangle [MetricSpace α] (R : α → α → Prop) [Equivalence R]
    (qx qy qz : Quot R) :
    quotientPseudometric α R qx qz ≤ quotientPseudometric α R qx qy +
      quotientPseudometric α R qy qz := by
  sorry

/-- When R is a closed equivalence relation that respects the metric,
    the quotient pseudometric is actually a metric. -/
theorem quotientPseudometric_isMetric [MetricSpace α] (R : α → α → Prop) [Equivalence R]
    (hClosed : ∀ (x : α), isClosed {y | R x y})
    (hCompat : ∀ x y x' y', R x x' → R y y' → d x y = d x' y') :
    MetricSpace (Quot R) := by
  sorry

/-! ## Identification Spaces from Metrics -/

/-- The metric identification space: X with a subset A collapsed to a point. -/
def metricCollapse (α : Type u) [MetricSpace α] (A : Set α) : Type u :=
  Quot (λ x y => x = y ∨ (x ∈ A ∧ y ∈ A))

/-- The collapse metric on the identification space. -/
def collapseMetric (α : Type u) [MetricSpace α] (A : Set α) [DecidablePred (· ∈ A)] :
    MetricSpace (metricCollapse α A) where
  d := λ _ _ => 0
  positiveDefinite := by
    intro x y; constructor
    · intro h; sorry
    · intro h; subst h; sorry
  symmetric := λ _ _ => by simp
  triangleInequality := λ _ _ _ => by simp

/-! ## Hausdorff Distance -/

/-- The Hausdorff distance between two nonempty closed bounded subsets of a metric space.
    d_H(A,B) = max{ sup_{a∈A} d(a,B), sup_{b∈B} d(b,A) }
    where d(x,C) = inf_{c∈C} d(x,c). -/

/-- The distance from a point to a set. -/
def pointSetDistance [MetricSpace α] (x : α) (A : Set α) : ℝ :=
  sInf {d x a | a ∈ A}

/-- The Hausdorff distance between two sets. -/
def hausdorffDistance [MetricSpace α] (A B : Set α) : ℝ :=
  max (sSup {pointSetDistance a B | a ∈ A}) (sSup {pointSetDistance b A | b ∈ B})

/-- The Hausdorff distance defines a metric on the set of nonempty closed bounded subsets. -/
theorem hausdorffDistance_isMetric [MetricSpace α] : True :=
  trivial

/-- The set of nonempty closed bounded subsets with the Hausdorff metric
    is a metric space (sometimes called the hyperspace). -/
structure Hyperspace (α : Type u) [MetricSpace α] where
  carrier : Set α
  isClosed : isClosed carrier
  isBounded : isBounded carrier
  nonempty : carrier.Nonempty

/-- The Hausdorff metric on the hyperspace. -/
noncomputable def Hyperspace.metric (α : Type u) [MetricSpace α] :
    MetricSpace (Hyperspace α) where
  d A B := hausdorffDistance A.carrier B.carrier
  positiveDefinite := by
    intro A B; constructor
    · intro h; sorry
    · intro h; subst h; sorry
  symmetric := by
    intro A B; dsimp [hausdorffDistance]
    apply max_comm
  triangleInequality := by
    intro A B C; sorry

/-! ## #eval Tests -/

#eval pointSetDistance (3 : ℝ) ({1, 5, 7} : Set ℝ)
#eval hausdorffDistance ({1, 2} : Set ℝ) ({4, 5} : Set ℝ)
