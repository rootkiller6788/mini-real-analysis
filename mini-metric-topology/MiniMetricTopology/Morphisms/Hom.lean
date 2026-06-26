/-
# Morphisms Between Metric Spaces

Structure-preserving maps between metric spaces: isometries (distance-preserving),
contraction mappings (distance-shrinking), uniformly continuous maps,
Lipschitz maps, and continuous maps.
-/

import MiniMetricTopology.Core.Basic

namespace MiniMetricTopology

open Set

/-! ## Isometry -/

/-- An isometry is a distance-preserving map between metric spaces.
    d_Y(f x, f y) = d_X(x, y) for all x, y. -/
structure Isometry (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  f : α → β
  distPreserving : ∀ x y, d (f x) (f y) = d x y

/-- An isometry is automatically injective. -/
theorem Isometry.injective [MetricSpace α] [MetricSpace β] (iso : Isometry α β) :
    Function.Injective iso.f := by
  intro x y h
  have hd := iso.distPreserving x y
  rw [h] at hd
  have hzero : d (iso.f y) (iso.f y) = 0 := by
    have := (MetricSpace.positiveDefinite (iso.f y) (iso.f y)).mpr rfl
    exact this
  rw [hzero] at hd
  exact ((MetricSpace.positiveDefinite x y).mp hd)

/-- An isometry is uniformly continuous. -/
theorem Isometry.uniformlyContinuous [MetricSpace α] [MetricSpace β] (iso : Isometry α β) :
    ∀ ε > 0, ∃ δ > 0, ∀ x y, d x y < δ → d (iso.f x) (iso.f y) < ε := by
  intro ε hε
  refine ⟨ε, hε, λ x y h => ?_⟩
  rw [iso.distPreserving x y]
  exact h

/-! ## Contraction Mapping -/

/-- A contraction mapping: there exists k < 1 such that
    d(f x, f y) ≤ k * d(x, y) for all x, y. -/
structure ContractionMapping (α : Type u) [MetricSpace α] where
  f : α → α
  k : ℝ
  hk_pos : 0 ≤ k
  hk_lt_one : k < 1
  contract : ∀ x y, d (f x) (f y) ≤ k * d x y

/-- A contraction mapping is uniformly continuous. -/
theorem ContractionMapping.uniformlyContinuous [MetricSpace α] (cm : ContractionMapping α) :
    ∀ ε > 0, ∃ δ > 0, ∀ x y, d x y < δ → d (cm.f x) (cm.f y) < ε := by
  intro ε hε
  by_cases hk0 : cm.k = 0
  · refine ⟨1, by norm_num, λ x y _ => ?_⟩
    have h := cm.contract x y
    rw [hk0] at h
    have : 0 * d x y = 0 := by ring
    rw [this] at h
    have hnonneg := MetricSpace.nonneg (cm.f x) (cm.f y)
    have : d (cm.f x) (cm.f y) = 0 := by linarith
    exact this.trans_lt hε
  · refine ⟨ε / cm.k, div_pos hε cm.hk_pos, λ x y h => ?_⟩
    have hc := cm.contract x y
    have : d x y < ε / cm.k := h
    calc
      d (cm.f x) (cm.f y) ≤ cm.k * d x y := hc
      _ < cm.k * (ε / cm.k) := by
        apply mul_lt_mul_of_pos_left this cm.hk_pos
      _ = ε := by field_simp [hk0]

/-! ## Uniformly Continuous Map -/

/-- A uniformly continuous map between metric spaces. -/
structure UniformlyContinuous (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  f : α → β
  uniformCondition : ∀ ε > 0, ∃ δ > 0, ∀ x y, d x y < δ → d (f x) (f y) < ε

/-- Every uniformly continuous map is continuous. -/
theorem UniformlyContinuous.isContinuous [MetricSpace α] [MetricSpace β]
    (uc : UniformlyContinuous α β) : ∀ x, ContinuousAt uc.f x := by
  intro x
  sorry

/-! ## Lipschitz Map -/

/-- A Lipschitz map with Lipschitz constant K. -/
structure LipschitzMap (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  f : α → β
  K : ℝ
  hK_nonneg : 0 ≤ K
  lipschitz : ∀ x y, d (f x) (f y) ≤ K * d x y

/-- A Lipschitz map is uniformly continuous. -/
theorem LipschitzMap.uniformlyContinuous [MetricSpace α] [MetricSpace β]
    (lip : LipschitzMap α β) : UniformlyContinuous α β where
  f := lip.f
  uniformCondition := by
    intro ε hε
    by_cases hK0 : lip.K = 0
    · refine ⟨1, by norm_num, λ x y _ => ?_⟩
      have h := lip.lipschitz x y
      rw [hK0] at h
      have hzero : 0 * d x y = 0 := by ring
      rw [hzero] at h
      have hnonneg := MetricSpace.nonneg (lip.f x) (lip.f y)
      have : d (lip.f x) (lip.f y) = 0 := by linarith
      rw [this]; exact hε
    · refine ⟨ε / lip.K, div_pos hε lip.hK_nonneg, λ x y hd => ?_⟩
      have hl := lip.lipschitz x y
      calc
        d (lip.f x) (lip.f y) ≤ lip.K * d x y := hl
        _ < lip.K * (ε / lip.K) := mul_lt_mul_of_pos_left hd lip.hK_nonneg
        _ = ε := by field_simp [hK0]

/-! ## Continuous Map -/

/-- A continuous map between metric spaces (pointwise continuous). -/
structure ContinuousMap (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  f : α → β
  continuous : ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, d x y < δ → d (f x) (f y) < ε

/-! ## #eval Tests -/

def idIsometry (α : Type) [MetricSpace α] : Isometry α α where
  f := id
  distPreserving := by intro x y; rfl

def halfContraction : ContractionMapping ℝ where
  f := λ x => x / 2
  k := 1/2
  hk_pos := by norm_num
  hk_lt_one := by norm_num
  contract := by
    intro x y; dsimp
    calc
      |x/2 - y/2| = |(x - y)/2| := by ring
      _ = |x - y| * |1/2| := by rw [abs_div, abs_mul]
      _ = |x - y| * (1/2) := by norm_num
      _ = (1/2) * |x - y| := by ring

#eval idIsometry ℝ |>.distPreserving 3 5
#eval halfContraction.contract 5 3
#eval halfContraction.k
