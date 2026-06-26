/-
# Metric Spaces: Basic Definitions

A metric space is a set equipped with a distance function satisfying
positivity, symmetry, and the triangle inequality. This module defines
the fundamental notions: balls, open/closed sets, interior, closure,
boundary, limit points, density, separability, boundedness, and diameter.
-/

import MiniObjectKernel

namespace MiniMetricTopology

/-! ## Carrier Type and Distance Function -/

/-- A distance function (quasi-metric) on a type α.
    d : α → α → ℝ satisfying d(x,x) = 0.
    This is a raw distance; the axioms are bundled in `MetricSpace`. -/
def Distance (α : Type u) : Type u := α → α → ℝ

/-! ## Metric Space Typeclass -/

/-- A metric space structure on a type α.
    - `d` is the distance function α → α → ℝ
    - `positiveDefinite`: d(x,y) = 0 ↔ x = y
    - `symmetric`: d(x,y) = d(y,x)
    - `triangleInequality`: d(x,z) ≤ d(x,y) + d(y,z) -/
class MetricSpace (α : Type u) where
  d : α → α → ℝ
  positiveDefinite : ∀ x y, d x y = 0 ↔ x = y
  symmetric : ∀ x y, d x y = d y x
  triangleInequality : ∀ x y z, d x z ≤ d x y + d y z

export MetricSpace (d)

/-- Infrastructure for metric space coercion. -/
instance [MetricSpace α] : CoeDep (α → α → ℝ) (Distance α) where
  coe f := f

/-! ## Constructors and Convenience -/

/-- Construct a metric space from a distance function and proofs of the axioms. -/
def MetricSpace.mk' (α : Type u) (d : α → α → ℝ)
    (pos : ∀ x y, d x y = 0 ↔ x = y)
    (sym : ∀ x y, d x y = d y x)
    (tri : ∀ x y z, d x z ≤ d x y + d y z) : MetricSpace α :=
  { d := d
    positiveDefinite := pos
    symmetric := sym
    triangleInequality := tri }

/-- Non-negativity of the metric: d(x,y) ≥ 0 for all x, y. -/
theorem MetricSpace.nonneg [MetricSpace α] (x y : α) : 0 ≤ d x y := by
  have h := MetricSpace.triangleInequality x y x
  rw [MetricSpace.symmetric x y] at h
  sorry

/-! ## Balls -/

/-- The open ball of radius r > 0 around x. -/
def ball [MetricSpace α] (x : α) (r : ℝ) : Set α :=
  {y | d x y < r}

/-- The closed ball of radius r ≥ 0 around x. -/
def closedBall [MetricSpace α] (x : α) (r : ℝ) : Set α :=
  {y | d x y ≤ r}

/-- The sphere of radius r around x. -/
def sphere [MetricSpace α] (x : α) (r : ℝ) : Set α :=
  {y | d x y = r}

/-! ## Topological Notions Induced by a Metric -/

/-- A set A is open if every point in A has an open ball contained in A. -/
def isOpen [MetricSpace α] (A : Set α) : Prop :=
  ∀ x ∈ A, ∃ ε > 0, ball x ε ⊆ A

/-- A set A is closed if its complement is open. -/
def isClosed [MetricSpace α] (A : Set α) : Prop :=
  isOpen (Aᶜ)

/-- The interior of A: the union of all open sets contained in A. -/
def interior [MetricSpace α] (A : Set α) : Set α :=
  {x | ∃ ε > 0, ball x ε ⊆ A}

/-- The closure of A: the intersection of all closed sets containing A. -/
def closure [MetricSpace α] (A : Set α) : Set α :=
  {x | ∀ ε > 0, (ball x ε ∩ A).Nonempty}

/-- The boundary of A: closure(A) \ interior(A). -/
def boundary [MetricSpace α] (A : Set α) : Set α :=
  closure A \ interior A

/-- x is a limit point of A if every ball around x contains a point of A other than x. -/
def limitPoint [MetricSpace α] (A : Set α) (x : α) : Prop :=
  ∀ ε > 0, ∃ y ∈ ball x ε ∩ A, y ≠ x

/-- x is an isolated point of A if it belongs to A and has a ball containing only x from A. -/
def isolatedPoint [MetricSpace α] (A : Set α) (x : α) : Prop :=
  x ∈ A ∧ ∃ ε > 0, ball x ε ∩ A = {x}

/-! ## Density, Separability, Boundedness -/

/-- A is dense if its closure is the whole space. -/
def isDense [MetricSpace α] (A : Set α) : Prop :=
  closure A = Set.univ

/-- The space is separable if it has a countable dense subset. -/
def isSeparable [MetricSpace α] : Prop :=
  ∃ (A : Set α), Set.Countable A ∧ isDense A

/-- A set is bounded if it is contained in some ball. -/
def isBounded [MetricSpace α] (A : Set α) : Prop :=
  ∃ (x : α) (R : ℝ), A ⊆ ball x R

/-- The diameter of a set A. -/
def diameter [MetricSpace α] (A : Set α) : ℝ :=
  if h : A.Nonempty then
    sSup {d x y | (x ∈ A) (y ∈ A)}
  else
    0

/-! ## #eval Tests -/

def exampleMetric : MetricSpace ℝ where
  d x y := |x - y|
  positiveDefinite := by
    intro x y; constructor
    · intro h; have := sub_eq_zero_of_abs_eq_zero h; linarith
    · intro h; subst h; simp
  symmetric := by
    intro x y; rw [abs_sub_comm]
  triangleInequality := by
    intro x y z
    have h := abs_add_le_abs_add_abs (x - y) (y - z)
    ring_nf at h; exact h

#eval d 3 7
#eval ball 0 1
#eval closedBall 5 3
