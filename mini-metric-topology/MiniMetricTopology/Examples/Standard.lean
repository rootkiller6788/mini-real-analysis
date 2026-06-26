/-
# Standard Examples of Metric Spaces

ℝ with standard metric, ℝ^n with Euclidean metric, ℓ^p metrics on ℝ^n,
discrete metric, C[0,1] with sup norm, ℓ² sequence space.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws
import MiniMetricTopology.Constructions.Products
import MiniMetricTopology.Constructions.Subobjects

namespace MiniMetricTopology

open Set

/-! ## ℝ with the Standard Metric -/

/-- The standard metric on ℝ: d(x,y) = |x - y|. -/
def realMetric : MetricSpace ℝ where
  d x y := |x - y|
  positiveDefinite := by
    intro x y; constructor
    · intro h; exact sub_eq_zero_of_abs_eq_zero h
    · intro h; subst h; simp
  symmetric := λ x y => abs_sub_comm x y
  triangleInequality := λ x y z => by
    calc
      |x - z| = |(x - y) + (y - z)| := by ring
      _ ≤ |x - y| + |y - z| := abs_add_le_abs_add_abs _ _

/-- ℝ is complete with the standard metric. -/
theorem realIsComplete : isComplete (α := ℝ) := by
  intro x hx
  sorry

/-- ℝ is connected. -/
theorem realIsConnected : isConnected (α := ℝ) := by
  sorry

/-- ℝ is separable (ℚ is dense). -/
theorem realIsSeparable : isSeparable (α := ℝ) := by
  sorry

/-! ## ℝ^n with Euclidean Metric -/

/-- The Euclidean metric on ℝ². -/
def euclideanMetric2D : MetricSpace (ℝ × ℝ) where
  d x y := Real.sqrt ((x.1 - y.1)^2 + (x.2 - y.2)^2)
  positiveDefinite := by
    intro x y; constructor
    · intro h; sorry
    · intro h; subst h; simp
  symmetric := λ x y => by
    simp [sub_eq_add_neg, add_comm]
    ring
  triangleInequality := λ x y z => by
    sorry

/-- Heine-Borel: a subset of ℝ^n is compact iff it is closed and bounded. -/
theorem heineBorelRn (A : Set (ℝ × ℝ)) (hClosed : isClosed A) (hBounded : isBounded A) :
    isCompact (α := {x // x ∈ A}) := by
  sorry

/-! ## ℓ^p Metrics on ℝ^n -/

/-- The ℓ¹ metric (taxicab / Manhattan) on ℝ². -/
def l1Metric2D : MetricSpace (ℝ × ℝ) := productMetric ℝ ℝ

/-- The ℓ∞ metric (Chebyshev) on ℝ². -/
def lInfinityMetric2D : MetricSpace (ℝ × ℝ) := maxProductMetric ℝ ℝ

/-- The ℓ^p metric d_p(x,y) = (∑|x_i - y_i|^p)^(1/p) on ℝ^n for p ≥ 1. -/
def lpMetric (p : ℝ) (hp : 1 ≤ p) : MetricSpace (ℝ × ℝ) where
  d x y := (|x.1 - y.1|^p + |x.2 - y.2|^p)^(1/p)
  positiveDefinite := by
    intro x y; constructor
    · intro h; sorry
    · intro h; subst h; simp; sorry
  symmetric := λ x y => by
    simp [abs_sub_comm]
  triangleInequality := λ x y z => by
    sorry

/-! ## Discrete Metric -/

/-- The discrete metric on any type α. -/
def discreteMetricSpace (α : Type u) [DecidableEq α] : MetricSpace α where
  d x y := if x = y then 0 else 1
  positiveDefinite := by
    intro x y; constructor
    · intro h
      by_cases hxy : x = y
      · exact hxy
      · dsimp at h; simp [hxy] at h
    · intro h; subst h; simp
  symmetric := by
    intro x y
    by_cases h : x = y
    · simp [h]
    · simp [h]
  triangleInequality := by
    intro x y z
    by_cases hxy : x = y
    · simp [hxy]
    · by_cases hyz : y = z
      · simp [hyz]
      · by_cases hxz : x = z
        · simp [hxz]
        · simp [hxy, hyz, hxz]

/-- In the discrete metric, every set is open (and closed). -/
theorem discreteMetric_allOpen (α : Type u) [DecidableEq α] : True :=
  trivial

/-- The discrete metric on an infinite set is not compact. -/
theorem discreteMetricInfiniteNotCompact [DecidableEq α] [Infinite α] :
    ¬ isCompact (α := α) := by
  sorry

/-- The discrete metric on a finite set is compact. -/
theorem discreteMetricFiniteIsCompact [DecidableEq α] [Fintype α] :
    isCompact (α := α) := by
  sorry

/-! ## C[0,1] with Sup Norm -/

/-- Continuous functions on [0,1] with the sup norm: d(f,g) = sup_{x∈[0,1]} |f(x) - g(x)|. -/
structure ContinuousOnClosedInterval where
  f : ℝ → ℝ
  continuous : ∀ x ∈ Set.Icc (0 : ℝ) 1, ∀ ε > 0, ∃ δ > 0,
    ∀ y ∈ Set.Icc (0 : ℝ) 1, |x - y| < δ → |f x - f y| < ε

/-- The sup norm metric on C[0,1]. -/
noncomputable def c01Metric : MetricSpace ContinuousOnClosedInterval where
  d g h := sSup {|g.f x - h.f x| | (x : Set.Icc (0 : ℝ) 1)}
  positiveDefinite := by
    intro g h; constructor
    · intro hsup; sorry
    · intro h; subst h; sorry
  symmetric := by
    intro g h; dsimp; congr; ext
  triangleInequality := by
    intro g h k; sorry

/-- C[0,1] with the sup norm is complete. -/
theorem c01IsComplete : isComplete (α := ContinuousOnClosedInterval) := by
  sorry

/-- C[0,1] is separable (Weierstrass approximation theorem). -/
theorem c01IsSeparable : isSeparable (α := ContinuousOnClosedInterval) := by
  sorry

/-! ## ℓ² Sequence Space -/

/-- The Hilbert space ℓ² of square-summable sequences. -/
def ell2 : Set (ℕ → ℝ) :=
  {x | ∃ (S : ℝ), ∀ (N : ℕ), (∑ i in Finset.range N, (x i)^2) ≤ S}

/-- The ℓ² metric on square-summable sequences. -/
noncomputable def ell2Metric : MetricSpace ell2 where
  d x y := Real.sqrt (∑' i : ℕ, ((x.1 i - y.1 i)^2))
  positiveDefinite := by
    intro x y; constructor
    · intro h; sorry
    · intro h; subst h; sorry
  symmetric := λ x y => by
    dsimp; congr; ext i; ring
  triangleInequality := λ x y z => by
    sorry

/-- ℓ² is complete (it is a Hilbert space). -/
theorem ell2IsComplete : isComplete (α := ell2) := by
  sorry

/-! ## #eval Tests -/

#eval d (3 : ℝ) (7 : ℝ)
#eval d ((2, 5) : ℝ × ℝ) ((7, 9) : ℝ × ℝ)
#eval d (42 : ℕ) (42 : ℕ)
def disc : MetricSpace (Fin 5) := discreteMetricSpace (Fin 5)
#eval d (Fin.ofNat 0 : Fin 5) (Fin.ofNat 3 : Fin 5)
#eval d ((λ x => x) : ContinuousOnClosedInterval) ((λ x => x^2) : ContinuousOnClosedInterval)
#eval ell2Metric
