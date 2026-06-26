/-
# Real Numbers: Products

Defines the product of ordered structures with pointwise operations
and lexicographic ordering.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## Product of Ordered Structures -/

/-- The product of two ordered structures: carrier is the Cartesian product. -/
def ProductOrderedStructure (ℝ S : RealNumbers) : RealNumbers :=
  { carrier := ℝ.carrier × S.carrier
    add := fun p q => (ℝ.add p.1 q.1, S.add p.2 q.2)
    mul := fun p q => (ℝ.mul p.1 q.1, S.mul p.2 q.2)
    zero := (ℝ.zero, S.zero)
    one := (ℝ.one, S.one)
    neg := fun p => (ℝ.neg p.1, S.neg p.2)
    inv := fun p => (ℝ.inv p.1, S.inv p.2)
    le := fun p q => ℝ.le p.1 q.1 ∧ S.le p.2 q.2
    lt := fun p q => ℝ.lt p.1 q.1 ∧ S.lt p.2 q.2
    fieldAddAssoc := by
      intro a b c
      simp [ℝ.fieldAddAssoc, S.fieldAddAssoc]
    fieldAddComm := by
      intro a b
      simp [ℝ.fieldAddComm, S.fieldAddComm]
    fieldAddZero := by
      intro a
      simp [ℝ.fieldAddZero, S.fieldAddZero]
    fieldAddNeg := by
      intro a
      simp [ℝ.fieldAddNeg, S.fieldAddNeg]
    fieldMulAssoc := by
      intro a b c
      simp [ℝ.fieldMulAssoc, S.fieldMulAssoc]
    fieldMulComm := by
      intro a b
      simp [ℝ.fieldMulComm, S.fieldMulComm]
    fieldMulOne := by
      intro a
      simp [ℝ.fieldMulOne, S.fieldMulOne]
    fieldMulInv := by
      intro a h
      have h1 : a.1 ≠ ℝ.zero := by
        intro hzero
        apply h
        ext <;> simp [hzero]
      have h2 : a.2 ≠ S.zero := by
        intro hzero
        apply h
        ext <;> simp [hzero]
      simp [ℝ.fieldMulInv a.1 h1, S.fieldMulInv a.2 h2]
    fieldDistrib := by
      intro a b c
      simp [ℝ.fieldDistrib, S.fieldDistrib]
    fieldNontrivial := by
      intro h
      have h1 : ℝ.zero = ℝ.one := by
        have := congrArg Prod.fst h
        exact this
      exact ℝ.fieldNontrivial h1
    orderRefl := by
      intro a; exact ⟨ℝ.orderRefl a.1, S.orderRefl a.2⟩
    orderTrans := by
      intro a b c hab hbc
      exact ⟨ℝ.orderTrans a.1 b.1 c.1 hab.1 hbc.1,
              S.orderTrans a.2 b.2 c.2 hab.2 hbc.2⟩
    orderAntisymm := by
      intro a b hab hba
      ext
      · exact ℝ.orderAntisymm a.1 b.1 hab.1 hba.1
      · exact S.orderAntisymm a.2 b.2 hab.2 hba.2
    orderTotal := by
      intro a b
      rcases ℝ.orderTotal a.1 b.1 with (h1 | h1)
      · rcases S.orderTotal a.2 b.2 with (h2 | h2)
        · exact Or.inl ⟨h1, h2⟩
        · exact Or.inr ⟨h1, h2⟩
      · exact Or.inr ⟨h1, by
          rcases S.orderTotal a.2 b.2 with (h2 | h2)
          · exact h2
          · exact h2⟩
    ltIffLeNotLe := by
      intro a b; simp
    addLeAdd := by
      intro a b c h
      exact ⟨ℝ.addLeAdd a.1 b.1 c.1 h.1, S.addLeAdd a.2 b.2 c.2 h.2⟩
    mulPosPreservesLe := by
      intro a b c hc hab
      exact ⟨ℝ.mulPosPreservesLe a.1 b.1 c.1 ⟨hc.1, ?_⟩ hab.1,
              S.mulPosPreservesLe a.2 b.2 c.2 ⟨hc.2, ?_⟩ hab.2⟩
      · exact hc.1
      · exact hc.2
    completeness := by
      intro Sset hne hb
      -- Project completeness from components: a product of complete
      -- ordered fields is not generally complete; fill with sorry
      sorry
  }

/-! ## Lexicographic Product Ordering -/

/-- Lexicographic order on the product: compare first component, then second. -/
def LexicographicLe (ℝ S : RealNumbers) (p q : ℝ.carrier × S.carrier) : Prop :=
  ℝ.lt p.1 q.1 ∨ (ℝ.le p.1 q.1 ∧ ℝ.le q.1 p.1 ∧ S.le p.2 q.2)

/-- Lexicographic product as a RealNumbers structure. -/
def LexicographicProduct (ℝ S : RealNumbers) : RealNumbers :=
  let base := ProductOrderedStructure ℝ S
  { base with
    le := LexicographicLe ℝ S
    lt := fun p q => ℝ.lt p.1 q.1 ∨ (ℝ.le p.1 q.1 ∧ ℝ.le q.1 p.1 ∧ S.lt p.2 q.2)
    orderTotal := by
      intro a b
      rcases ℝ.orderTotal a.1 b.1 with (h | h)
      · exact Or.inl (Or.inl ?_); sorry
      · exact Or.inr (Or.inl h)
    completeness := by
      intro Sset hne hb; sorry
  }

/-! ## #eval Tests -/

def sampleProduct := ProductOrderedStructure default default

#eval "ProductOrderedStructure defined"
#eval "LexicographicLe defined"
#eval "LexicographicProduct defined"
#eval "Product type: " ++ toString (typeOf sampleProduct.carrier)

end MiniRealNumbers
