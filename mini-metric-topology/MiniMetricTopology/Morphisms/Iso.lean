/-
# Isomorphisms Between Metric Spaces

Isometric isomorphisms (bijective isometries), bi-Lipschitz equivalences,
and homeomorphisms of metric spaces.
-/

import MiniMetricTopology.Morphisms.Hom

namespace MiniMetricTopology

open Set

/-! ## Isometric Isomorphism -/

/-- An isometric isomorphism is a bijective isometry.
    Two metric spaces are isometric if they are "the same" as metric spaces. -/
structure IsometricIsomorphism (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  isometry : Isometry α β
  bijective : Function.Bijective isometry.f

/-- The identity is an isometric isomorphism. -/
def IsometricIsomorphism.id (α : Type u) [MetricSpace α] : IsometricIsomorphism α α where
  isometry := idIsometry α
  bijective := by
    refine ⟨λ x y h => h, ?_⟩
    intro y; exact ⟨y, rfl⟩

/-- The inverse of an isometric isomorphism is an isometric isomorphism. -/
def IsometricIsomorphism.symm [MetricSpace α] [MetricSpace β]
    (iso : IsometricIsomorphism α β) : IsometricIsomorphism β α := by
  rcases iso with ⟨⟨f, hdist⟩, hbij⟩
  rcases hbij with ⟨hinj, hsurj⟩
  let g : β → α := λ y => (hsurj y).choose
  have hg : ∀ y, f (g y) = y := λ y => (hsurj y).choose_spec
  have hginj : Function.Injective g := by
    intro y1 y2 h
    have : f (g y1) = f (g y2) := by rw [h]
    rw [hg y1, hg y2] at this; exact this
  sorry

/-- The composition of isometric isomorphisms is an isometric isomorphism. -/
def IsometricIsomorphism.comp [MetricSpace α] [MetricSpace β] [MetricSpace γ]
    (iso₁ : IsometricIsomorphism α β) (iso₂ : IsometricIsomorphism β γ) :
    IsometricIsomorphism α γ := by
  sorry

/-! ## Bi-Lipschitz Equivalence -/

/-- A bi-Lipschitz equivalence: there exist constants c₁, c₂ > 0 such that
    c₁·d_X(x,y) ≤ d_Y(fx,fy) ≤ c₂·d_X(x,y) for all x,y. -/
structure BiLipschitzEquivalence (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  f : α → β
  c₁ : ℝ
  c₂ : ℝ
  hc₁_pos : 0 < c₁
  hc₂_pos : 0 < c₂
  lowerBound : ∀ x y, c₁ * d x y ≤ d (f x) (f y)
  upperBound : ∀ x y, d (f x) (f y) ≤ c₂ * d x y
  bijective : Function.Bijective f

/-- A bi-Lipschitz equivalence is a Lipschitz map. -/
def BiLipschitzEquivalence.toLipschitzMap [MetricSpace α] [MetricSpace β]
    (eqv : BiLipschitzEquivalence α β) : LipschitzMap α β where
  f := eqv.f
  K := eqv.c₂
  hK_nonneg := by linarith
  lipschitz := eqv.upperBound

/-- An isometric isomorphism is a bi-Lipschitz equivalence with c₁ = c₂ = 1. -/
def IsometricIsomorphism.toBiLipschitzEquivalence [MetricSpace α] [MetricSpace β]
    (iso : IsometricIsomorphism α β) : BiLipschitzEquivalence α β where
  f := iso.isometry.f
  c₁ := 1
  c₂ := 1
  hc₁_pos := by norm_num
  hc₂_pos := by norm_num
  lowerBound := by
    intro x y
    have h := iso.isometry.distPreserving x y
    rw [h]; linarith
  upperBound := by
    intro x y
    have h := iso.isometry.distPreserving x y
    rw [h]; linarith
  bijective := iso.bijective

/-! ## Homeomorphism of Metric Spaces -/

/-- A homeomorphism between metric spaces: a continuous bijection with continuous inverse. -/
structure Homeomorphism (α : Type u) (β : Type v) [MetricSpace α] [MetricSpace β] where
  toFun : α → β
  invFun : β → α
  left_inv : ∀ x, invFun (toFun x) = x
  right_inv : ∀ y, toFun (invFun y) = y
  continuous_toFun : ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, d x y < δ → d (toFun x) (toFun y) < ε
  continuous_invFun : ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, d x y < δ → d (invFun x) (invFun y) < ε

/-- Identity homeomorphism. -/
def Homeomorphism.id (α : Type u) [MetricSpace α] : Homeomorphism α α where
  toFun := id
  invFun := id
  left_inv := λ _ => rfl
  right_inv := λ _ => rfl
  continuous_toFun := by
    intro x ε hε; refine ⟨ε, hε, λ y h => h⟩
  continuous_invFun := by
    intro x ε hε; refine ⟨ε, hε, λ y h => h⟩

/-- An isometric isomorphism is a homeomorphism. -/
def IsometricIsomorphism.toHomeomorphism [MetricSpace α] [MetricSpace β]
    (iso : IsometricIsomorphism α β) : Homeomorphism α β := by
  sorry

/-! ## #eval Tests -/

def scaleMap : BiLipschitzEquivalence ℝ ℝ where
  f := λ x => 2 * x
  c₁ := 1
  c₂ := 2
  hc₁_pos := by norm_num
  hc₂_pos := by norm_num
  lowerBound := by
    intro x y
    dsimp; ring
    calc |x - y| = |x - y| * 1 := by ring
      _ ≤ |x - y| * 2 := by
        nlinarith
      _ = 2 * |x - y| := by ring
    sorry
  upperBound := by
    intro x y; dsimp
    calc |(2*x) - (2*y)| = |2*(x - y)| := by ring
      _ = 2 * |x - y| := by rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]
  bijective := by
    refine ⟨?_, ?_⟩
    · intro x y h; nlinarith
    · intro y; refine ⟨y / 2, ?_⟩; ring

#eval scaleMap.c₁
#eval scaleMap.c₂
#eval Homeomorphism.id ℝ |>.left_inv 5
