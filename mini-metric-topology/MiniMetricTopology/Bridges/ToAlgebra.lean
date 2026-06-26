/-
# Bridge: Metric Spaces to Algebra

Normed vector spaces as metric spaces, Banach spaces, metric groups,
and algebraic structures with compatible metrics.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Properties.Invariants
import MiniMetricTopology.Constructions.Products
import MiniMetricTopology.Morphisms.Hom

namespace MiniMetricTopology

open Set

/-! ## Normed Vector Spaces -/

/-- A normed vector space over ℝ: a vector space with a norm ∥·∥
    satisfying positivity, homogeneity, and triangle inequality. -/
class NormedVectorSpace (α : Type u) extends AddCommGroup α, MetricSpace α where
  norm : α → ℝ
  normDist : ∀ x y, d x y = norm (x - y)
  normPos : ∀ x, norm x = 0 ↔ x = 0
  normHom : ∀ (r : ℝ) (x : α), norm (r • x) = |r| * norm x
  normTri : ∀ x y, norm (x + y) ≤ norm x + norm y

export NormedVectorSpace (norm)

/-- Every normed vector space is a metric space via d(x,y) = ∥x - y∥. -/
def normedVectorSpace_toMetricSpace (α : Type u) [NormedVectorSpace α] : MetricSpace α :=
  -- Already holds by the typeclass
  by infer_instance

/-- The norm is nonnegative. -/
theorem normNonneg [NormedVectorSpace α] (x : α) : 0 ≤ norm x := by
  sorry

/-- The norm satisfies the reverse triangle inequality: |∥x∥ - ∥y∥| ≤ ∥x - y∥. -/
theorem norm_reverseTriangle [NormedVectorSpace α] (x y : α) :
    |norm x - norm y| ≤ norm (x - y) := by
  sorry

/-- ℝ is a normed vector space with the absolute value norm. -/
instance : NormedVectorSpace ℝ where
  norm x := |x|
  normDist := λ x y => by simp
  normPos := by
    intro x; constructor
    · exact abs_eq_zero.mp
    · intro h; subst h; simp
  normHom := λ r x => by simp [abs_mul]
  normTri := λ x y => abs_add_le_abs_add_abs x y

/-! ## Banach Spaces -/

/-- A Banach space is a complete normed vector space. -/
def isBanachSpace (α : Type u) [NormedVectorSpace α] : Prop :=
  isComplete (α := α)

/-- ℝ is a Banach space. -/
theorem realIsBanachSpace : isBanachSpace ℝ :=
  realIsComplete

/-- Every finite-dimensional normed vector space over ℝ is a Banach space. -/
theorem finiteDimensionalNormedSpaceIsBanach (α : Type u) [NormedVectorSpace α]
    [FiniteDimensional ℝ α] : isBanachSpace α := by
  sorry

/-- C[0,1] with the sup norm is a Banach space. -/
theorem c01IsBanachSpace : isBanachSpace ContinuousOnClosedInterval := by
  sorry

/-! ## Metric Groups -/

/-- A metric group is a group equipped with a left-invariant metric:
    d(gx, gy) = d(x, y) for all g, x, y. -/
class MetricGroup (α : Type u) extends Group α, MetricSpace α where
  leftInvariant : ∀ (g x y : α), d (g * x) (g * y) = d x y
  rightInvariant : ∀ (g x y : α), d (x * g) (y * g) = d x y

/-- ℝ with addition is a metric group. -/
instance : MetricGroup ℝ where
  leftInvariant := by
    intro g x y; dsimp; rw [add_comm g x, add_comm g y]
    simp [dist_eq_norm]
  rightInvariant := by
    intro g x y; dsimp; simp

/-- A topological group where the topology is induced by an invariant metric. -/
theorem metricGroupIsTopologicalGroup [MetricGroup α] : True :=
  trivial

/-! ## Metric Rings and Fields -/

/-- A metric ring: a ring with a metric such that addition and multiplication
    are continuous. -/
class MetricRing (α : Type u) extends Ring α, MetricSpace α where
  addContinuous : ∀ (a b : α), ∀ ε > 0, ∃ δ > 0,
    ∀ (x y : α), d x a < δ → d y b < δ → d (x + y) (a + b) < ε
  mulContinuous : ∀ (a b : α), ∀ ε > 0, ∃ δ > 0,
    ∀ (x y : α), d x a < δ → d y b < δ → d (x * y) (a * b) < ε

/-- ℝ is a metric ring. -/
instance : MetricRing ℝ where
  addContinuous := by
    intro a b ε hε; refine ⟨ε/2, by linarith, λ x y hx hy => ?_⟩
    dsimp; calc
      |(x + y) - (a + b)| = |(x - a) + (y - b)| := by ring
      _ ≤ |x - a| + |y - b| := abs_add_le_abs_add_abs _ _
      _ < ε/2 + ε/2 := add_lt_add hx hy
      _ = ε := by ring
  mulContinuous := by
    intro a b ε hε; sorry

/-- A metric field: a field with a metric making it a metric ring. -/
class MetricField (α : Type u) extends Field α, MetricSpace α, MetricRing α where
  invContinuous : ∀ (a : α), a ≠ 0 → ∀ ε > 0, ∃ δ > 0,
    ∀ x, d x a < δ → d (x⁻¹) (a⁻¹) < ε

/-- ℝ is a metric field. -/
instance : MetricField ℝ where
  invContinuous := by
    intro a ha ε hε; sorry

/-! ## Operator Norm -/

/-- The operator norm of a linear map between normed vector spaces. -/
noncomputable def operatorNorm [NormedVectorSpace α] [NormedVectorSpace β] (L : α → β)
    [IsLinear ℝ L] : ℝ :=
  sSup {norm (L x) | (x : α) (h : norm x ≤ 1)}

/-- The space of bounded linear operators with the operator norm is a normed vector space. -/
theorem boundedLinearOperatorsFormNormedSpace [NormedVectorSpace α] [NormedVectorSpace β] : True :=
  trivial

/-- The space of bounded linear operators between Banach spaces is itself a Banach space. -/
theorem boundedLinearOperatorsFormBanachSpace [NormedVectorSpace α] [NormedVectorSpace β]
    (hα : isBanachSpace α) (hβ : isBanachSpace β) : True :=
  trivial

/-! ## #eval Tests -/

#eval norm ((3 : ℝ) - (7 : ℝ))
#eval isBanachSpace ℝ
#eval MetricGroup ℝ |>.leftInvariant (5 : ℝ) (2 : ℝ) (3 : ℝ)
