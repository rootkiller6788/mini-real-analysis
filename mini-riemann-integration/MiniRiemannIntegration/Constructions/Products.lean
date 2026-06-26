/-
# MiniRiemannIntegration.Constructions.Products

Fubini for Riemann integral on rectangles in ℝ²,
product integral, and iterated integrals.
-/

import MiniRiemannIntegration.Core.Objects
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Product interval -/

structure Rectangle where
  xMin : ℝ; xMax : ℝ
  yMin : ℝ; yMax : ℝ
  deriving Repr

/-! ## Product partition -/

structure RectanglePartition where
  rect : Rectangle
  xPartition : Partition
  yPartition : Partition
  subrectangles : Nat  -- number of subrectangles

/-! ## Double Riemann sum -/

def doubleRiemannSum (f : ℝ → ℝ → ℝ) (P : RectanglePartition) (tagsX tagsY : List ℝ) : ℝ :=
  -- Σ f(t_i, s_j) * Δx_i * Δy_j
  -- Stub implementation
  0

/-! ## Fubini theorem for Riemann integral (statement) -/

structure FubiniRiemann where
  f : ℝ → ℝ → ℝ
  rect : Rectangle
  integrable : Prop  -- f is Riemann integrable on the rectangle
  iteratedEqual : Prop  -- ∫∫ f(x,y) dx dy = ∫ (∫ f(x,y) dx) dy = ∫ (∫ f(x,y) dy) dx

def fubiniTheorem : Axiom :=
  Axiom.mk "fubiniRiemann" (Formula.pred 0 [])
    "If f is Riemann integrable on [a,b]×[c,d], then ∫_c^d (∫_a^b f(x,y) dx) dy = ∫_a^b (∫_c^d f(x,y) dy) dx"

/-! ## Product integral -/

structure ProductIntegral (a₁ b₁ a₂ b₂ : ℝ) where
  f : ℝ → ℝ → ℝ
  productIntegral : ℝ
  iterated1 : ℝ  -- ∫ (∫ f dx) dy
  iterated2 : ℝ  -- ∫ (∫ f dy) dx
  agreement : productIntegral = iterated1 ∧ iterated1 = iterated2

/-! ## Iterated integral computation -/

def iteratedIntegral (f : ℝ → ℝ → ℝ) (a₁ b₁ a₂ b₂ : ℝ) : ℝ :=
  -- ∫_{a₂}^{b₂} (∫_{a₁}^{b₁} f(x,y) dx) dy
  riemannIntegral (fun y => riemannIntegral (fun x => f x y) a₁ b₁) a₂ b₂

/-! ## Double integral as iterated integral -/

structure DoubleIntegral (a₁ b₁ a₂ b₂ : ℝ) where
  integrand : ℝ → ℝ → ℝ
  value : ℝ
  fubiniHolds : value = iteratedIntegral integrand a₁ b₁ a₂ b₂ ∧
               value = iteratedIntegral (fun y x => integrand x y) a₂ b₂ a₁ b₁

/-! ## #eval Tests -/

#eval "Constructions.Products: Rectangle, RectanglePartition, FubiniRiemann"
#eval "Constructions.Products: ProductIntegral, iteratedIntegral, DoubleIntegral"
#eval "Constructions.Products: fubiniTheorem axiom defined"

end MiniRiemannIntegration
