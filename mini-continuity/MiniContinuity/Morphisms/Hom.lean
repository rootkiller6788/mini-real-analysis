/-
# MiniContinuity.Morphisms.Hom

Homomorphisms in continuity theory: continuous maps,
uniformly continuous maps, and Lipschitz maps between
metric spaces, each carrying their respective properties.
-/

import MiniContinuity.Core.Basic

open MiniMathKernel

namespace MiniContinuity

/-! ## Continuous Map between Metric Spaces -/

/-- A continuous map between ℝ and ℝ (generalizable to metric spaces) -/
structure ContinuousMap where
  fn : ℝ → ℝ
  cont : ∀ a, isContinuousAt fn a

/-- Identity continuous map -/
def ContinuousMap.id : ContinuousMap where
  fn := fun x => x
  cont := by
    intro a
    intro ε hε
    -- choose δ = ε for identity
    sorry

/-- Composition of continuous maps -/
def ContinuousMap.comp (f g : ContinuousMap) : ContinuousMap where
  fn := fun x => f.fn (g.fn x)
  cont := by
    intro a
    -- f continuous at g(a), g continuous at a ⇒ comp continuous
    sorry

/-- Constant continuous map -/
def ContinuousMap.const (c : ℝ) : ContinuousMap where
  fn := fun _ => c
  cont := by
    intro a
    sorry

/-! ## Uniformly Continuous Map -/

/-- A uniformly continuous map on ℝ -/
structure UniformlyContinuousMap extends ContinuousMap where
  unif : isUniformlyContinuous fn

/-- Identity is uniformly continuous -/
def UniformlyContinuousMap.id : UniformlyContinuousMap where
  fn := fun x => x
  cont := sorry
  unif := by
    intro ε hε
    -- δ = ε for identity
    sorry

/-- Composition of uniformly continuous maps -/
def UniformlyContinuousMap.comp (f g : UniformlyContinuousMap) : UniformlyContinuousMap where
  fn := fun x => f.fn (g.fn x)
  cont := sorry
  unif := by
    -- composition of uniformly continuous is uniformly continuous
    sorry

/-! ## Lipschitz Map -/

/-- A K-Lipschitz map -/
structure LipschitzMap where
  fn : ℝ → ℝ
  K : ℝ
  hKnonneg : K ≥ 0
  lip : ∀ x y, dist (fn x) (fn y) ≤ K * dist x y

/-- Identity is 1-Lipschitz -/
def LipschitzMap.id : LipschitzMap where
  fn := fun x => x
  K := 1
  hKnonneg := by norm_num
  lip := by
    intro x y
    simp [dist, abs]

/-- Constant map is 0-Lipschitz -/
def LipschitzMap.const (c : ℝ) : LipschitzMap where
  fn := fun _ => c
  K := 0
  hKnonneg := by norm_num
  lip := by
    intro x y
    simp [dist, abs]

/-- Every Lipschitz map is uniformly continuous -/
def LipschitzMap.toUniformlyContinuous (f : LipschitzMap) : UniformlyContinuousMap where
  fn := f.fn
  cont := by
    intro a
    sorry
  unif := by
    intro ε hε
    -- δ = ε / K  (handle K = 0 separately)
    sorry

/-! ## Homeomorphism -/

/-- A homeomorphism is a continuous bijection with continuous inverse -/
structure Homeomorphism where
  f : ContinuousMap
  g : ContinuousMap  -- inverse
  leftInv : ∀ x, g.fn (f.fn x) = x
  rightInv : ∀ x, f.fn (g.fn x) = x

/-- Identity homeomorphism -/
def Homeomorphism.id : Homeomorphism where
  f := ContinuousMap.id
  g := ContinuousMap.id
  leftInv := by intro x; rfl
  rightInv := by intro x; rfl

/-- Inverse of a homeomorphism is a homeomorphism -/
def Homeomorphism.symm (h : Homeomorphism) : Homeomorphism where
  f := h.g
  g := h.f
  leftInv := h.rightInv
  rightInv := h.leftInv

/-! ## #eval Tests -/

#eval "Morphisms.Hom: ContinuousMap, UniformlyContinuousMap, LipschitzMap, Homeomorphism"
#eval "Morphisms.Hom: LipschitzMap.id K=1, LipschitzMap.const K=0"

end MiniContinuity
