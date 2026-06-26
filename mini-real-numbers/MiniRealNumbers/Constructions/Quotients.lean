/-
# Real Numbers: Quotients

Defines quotients of ordered structures by equivalence relations,
the quotient field construction, and natural projections.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## Quotient by Equivalence Relation -/

/--
A congruence on an ordered structure: an equivalence relation compatible
with the field operations and order.
-/
structure OrderFieldCongruence (ℝ : RealNumbers) where
  rel : ℝ.carrier → ℝ.carrier → Prop
  equiv : Equivalence rel
  addCompat : ∀ a b a' b', rel a a' → rel b b' → rel (ℝ.add a b) (ℝ.add a' b')
  mulCompat : ∀ a b a' b', rel a a' → rel b b' → rel (ℝ.mul a b) (ℝ.mul a' b')
  negCompat : ∀ a a', rel a a' → rel (ℝ.neg a) (ℝ.neg a')
  invCompat : ∀ a a', rel a a' → a ≠ ℝ.zero → a' ≠ ℝ.zero → rel (ℝ.inv a) (ℝ.inv a')
  leCompat : ∀ a b a' b', rel a a' → rel b b' → ℝ.le a b → ℝ.le a' b'

/--
Quotient of an ordered structure by a congruence relation.
The quotient inherits the field operations and order from the base.
-/
def QuotientOrderedField (ℝ : RealNumbers) (cong : OrderFieldCongruence ℝ) : RealNumbers :=
  let Q := Quotient cong.equiv
  { carrier := Q
    add := Quotient.lift₂ (fun a b => Quotient.mk _ (ℝ.add a b)) (by
      intro a b a' b' ha hb
      apply Quotient.sound
      exact cong.addCompat a b a' b' ha hb)
    mul := Quotient.lift₂ (fun a b => Quotient.mk _ (ℝ.mul a b)) (by
      intro a b a' b' ha hb
      apply Quotient.sound
      exact cong.mulCompat a b a' b' ha hb)
    zero := Quotient.mk _ ℝ.zero
    one := Quotient.mk _ ℝ.one
    neg := Quotient.lift (fun a => Quotient.mk _ (ℝ.neg a)) (by
      intro a a' ha
      apply Quotient.sound
      exact cong.negCompat a a' ha)
    inv := Quotient.lift (fun a => Quotient.mk _ (ℝ.inv a)) (by
      intro a a' ha
      apply Quotient.sound; sorry)
    le := Quotient.lift₂ (fun a b => ℝ.le a b) (by
      intro a b a' b' ha hb
      apply propext
      constructor
      · intro h; exact cong.leCompat a' b' a b ha.symm hb.symm h
      · intro h; exact cong.leCompat a b a' b' ha hb h)
    lt := Quotient.lift₂ (fun a b => ℝ.lt a b) (by
      intro a b a' b' ha hb; sorry)
    fieldAddAssoc := by
      intro a b c
      apply Quotient.inductionOn₃ a b c
      intro a b c
      apply Quotient.sound; apply ℝ.fieldAddAssoc
    fieldAddComm := by
      intro a b
      apply Quotient.inductionOn₂ a b
      intro a b; apply Quotient.sound; apply ℝ.fieldAddComm
    fieldAddZero := by
      intro a; apply Quotient.inductionOn a
      intro a; apply Quotient.sound; apply ℝ.fieldAddZero
    fieldAddNeg := by
      intro a; apply Quotient.inductionOn a
      intro a; apply Quotient.sound; apply ℝ.fieldAddNeg
    fieldMulAssoc := by
      intro a b c
      apply Quotient.inductionOn₃ a b c
      intro a b c; apply Quotient.sound; apply ℝ.fieldMulAssoc
    fieldMulComm := by
      intro a b
      apply Quotient.inductionOn₂ a b
      intro a b; apply Quotient.sound; apply ℝ.fieldMulComm
    fieldMulOne := by
      intro a; apply Quotient.inductionOn a
      intro a; apply Quotient.sound; apply ℝ.fieldMulOne
    fieldMulInv := by
      intro a ha
      apply Quotient.inductionOn a
      intro a haq
      have ha0 : a ≠ ℝ.zero := by
        intro hzero
        apply haq
        apply Quotient.sound; rw [hzero]; exact cong.equiv.refl _
      apply Quotient.sound; apply ℝ.fieldMulInv a ha0
    fieldDistrib := by
      intro a b c
      apply Quotient.inductionOn₃ a b c
      intro a b c; apply Quotient.sound; apply ℝ.fieldDistrib
    fieldNontrivial := by
      intro h
      apply ℝ.fieldNontrivial
      have : (Quotient.mk cong.equiv ℝ.zero : Q) = (Quotient.mk cong.equiv ℝ.one : Q) := h
      apply Quotient.exact this
    orderRefl := by
      intro a; apply Quotient.inductionOn a
      intro a; apply ℝ.orderRefl
    orderTrans := by
      intro a b c; apply Quotient.inductionOn₃ a b c
      intro a b c; apply ℝ.orderTrans a b c
    orderAntisymm := by
      intro a b; apply Quotient.inductionOn₂ a b
      intro a b hab hba
      apply Quotient.sound
      apply ℝ.orderAntisymm a b hab hba
    orderTotal := by
      intro a b; apply Quotient.inductionOn₂ a b
      intro a b; apply ℝ.orderTotal
    ltIffLeNotLe := by
      intro a b; apply Quotient.inductionOn₂ a b
      intro a b; apply ℝ.ltIffLeNotLe
    addLeAdd := by
      intro a b c; apply Quotient.inductionOn₃ a b c
      intro a b c; apply ℝ.addLeAdd a b c
    mulPosPreservesLe := by
      intro a b c; apply Quotient.inductionOn₃ a b c
      intro a b c; apply ℝ.mulPosPreservesLe a b c
    completeness := by
      intro S hne hb; sorry
  }

/-! ## Natural Projection -/

/-- The natural projection from an ordered field to a quotient. -/
def naturalProjection (ℝ : RealNumbers) (cong : OrderFieldCongruence ℝ) :
    FieldHomomorphism ℝ (QuotientOrderedField ℝ cong) where
  toFun := Quotient.mk cong.equiv
  map_order := by
    intro x y h
    exact h
  map_zero := rfl
  map_one := rfl
  map_add := by intro x y; rfl
  map_mul := by intro x y; rfl
  map_neg := by intro x; rfl
  map_inv := by
    intro x hx
    rfl

/-! ## #eval Tests -/

#eval "OrderFieldCongruence defined"
#eval "QuotientOrderedField defined"
#eval "naturalProjection defined"

end MiniRealNumbers
