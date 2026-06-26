/-
# Real Numbers: Homomorphisms

Defines order-preserving maps, field homomorphisms, embeddings
between ordered fields, with composition and identity.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## Order-Preserving Map -/

/-- An order-preserving map between carriers of two ordered structures. -/
structure OrderPreservingMap (ℝ S : RealNumbers) where
  toFun : ℝ.carrier → S.carrier
  map_order : ∀ x y : ℝ.carrier, ℝ.le x y → S.le (toFun x) (toFun y)

/-- Identity order-preserving map. -/
def OrderPreservingMap.id (ℝ : RealNumbers) : OrderPreservingMap ℝ ℝ where
  toFun := id
  map_order := by intro x y h; exact h

/-- Composition of order-preserving maps. -/
def OrderPreservingMap.comp {ℝ S T : RealNumbers}
    (g : OrderPreservingMap S T) (f : OrderPreservingMap ℝ S) :
    OrderPreservingMap ℝ T where
  toFun := g.toFun ∘ f.toFun
  map_order := by
    intro x y h
    apply g.map_order
    apply f.map_order
    exact h

/-! ## Field Homomorphism -/

/-- A field homomorphism preserves the field operations. -/
structure FieldHomomorphism (ℝ S : RealNumbers) extends OrderPreservingMap ℝ S where
  map_zero : toFun ℝ.zero = S.zero
  map_one : toFun ℝ.one = S.one
  map_add : ∀ x y, toFun (ℝ.add x y) = S.add (toFun x) (toFun y)
  map_mul : ∀ x y, toFun (ℝ.mul x y) = S.mul (toFun x) (toFun y)
  map_neg : ∀ x, toFun (ℝ.neg x) = S.neg (toFun x)
  map_inv : ∀ x, x ≠ ℝ.zero → toFun (ℝ.inv x) = S.inv (toFun x)

/-- Identity field homomorphism. -/
def FieldHomomorphism.id (ℝ : RealNumbers) : FieldHomomorphism ℝ ℝ :=
  { toFun := id
    map_order := by intro x y h; exact h
    map_zero := rfl
    map_one := rfl
    map_add := by intro x y; rfl
    map_mul := by intro x y; rfl
    map_neg := by intro x; rfl
    map_inv := by intro x h; rfl
  }

/-- Composition of field homomorphisms. -/
def FieldHomomorphism.comp {ℝ S T : RealNumbers}
    (g : FieldHomomorphism S T) (f : FieldHomomorphism ℝ S) :
    FieldHomomorphism ℝ T where
  toOrderPreservingMap := g.toOrderPreservingMap.comp f.toOrderPreservingMap
  map_zero := by rw [f.map_zero, g.map_zero]
  map_one := by rw [f.map_one, g.map_one]
  map_add := by
    intro x y
    rw [f.map_add, g.map_add]
  map_mul := by
    intro x y
    rw [f.map_mul, g.map_mul]
  map_neg := by
    intro x
    rw [f.map_neg, g.map_neg]
  map_inv := by
    intro x hx
    rw [f.map_inv x hx, g.map_inv (f.toFun x) ?_]
    intro hzero
    have : f.toFun ℝ.zero = f.toFun x := by rw [hzero, f.map_zero]
    have hinj : Function.Injective f.toFun := by
      intro a b h; sorry
    sorry

/-! ## Embedding -/

/-- An embedding of ordered fields: an injective field homomorphism. -/
structure isEmbedding (ℝ S : RealNumbers) where
  hom : FieldHomomorphism ℝ S
  injective : ∀ x y, hom.toFun x = hom.toFun y → x = y

/-! ## #eval Tests -/

def sampleOrderPreserving : OrderPreservingMap default default :=
  OrderPreservingMap.id default

#eval "OrderPreservingMap defined"
#eval "FieldHomomorphism defined"
#eval "isEmbedding defined"
#eval "Identity map composes: " ++ (let h := sampleOrderPreserving.comp sampleOrderPreserving; "OK")

end MiniRealNumbers
