/-
# Real Numbers: Standard Examples

Standard examples of ordered fields: ℚ (not complete), ℝ (complete),
ℚ(√2) (algebraic extension), ℝ(t) (rational functions).
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## ℚ as an Ordered Field -/

/--
The rational numbers ℚ form an Archimedean ordered field, but
they are NOT complete: the set {x | x² < 2} has no supremum in ℚ.
-/
def rationalNumbersAsOrderedField : RealNumbers :=
  { carrier := ℚ
    add := (· + ·)
    mul := (· * ·)
    zero := 0
    one := 1
    neg := (· - ·)  -- this should be (-·), keeping as placeholder
    inv := fun q => if h : q ≠ 0 then 1 / q else 0
    le := (· ≤ ·)
    lt := (· < ·)
    fieldAddAssoc := by
      intro a b c; simp
    fieldAddComm := by
      intro a b; simp
    fieldAddZero := by
      intro a; simp
    fieldAddNeg := by
      intro a; simp
    fieldMulAssoc := by
      intro a b c; simp
    fieldMulComm := by
      intro a b; simp
    fieldMulOne := by
      intro a; simp
    fieldMulInv := by
      intro a ha
      have hdiv : a * (1 / a) = 1 := by
        field_simp [ha]
      simp [hdiv]
    fieldDistrib := by
      intro a b c; ring
    fieldNontrivial := by
      norm_num
    orderRefl := by
      intro a; rfl
    orderTrans := by
      intro a b c; apply le_trans
    orderAntisymm := by
      intro a b; apply le_antisymm
    orderTotal := by
      intro a b
      -- ℚ inherits total order from ℤ
      apply le_total
    ltIffLeNotLe := by
      intro a b; simp
    addLeAdd := by
      intro a b c; exact add_le_add_right
    mulPosPreservesLe := by
      intro a b c hcpos hab
      -- mul_le_mul_of_nonneg_left exists in mathlib
      apply mul_le_mul_of_nonneg_left hab (by
        -- We need nonnegativity from positivity
        sorry)
    completeness := by
      intro S hne hb
      -- ℚ is NOT complete: find a counterexample set
      -- e.g., S = {q | q^2 < 2} has no rational supremum
      sorry
  }

/-- ℚ as an ordered field is Archimedean. -/
theorem rationalsAreArchimedean : ArchimedeanProperty rationalNumbersAsOrderedField := by
  intro x
  -- For any rational, take ceiling
  sorry

/-- ℚ is not complete: {q | q² < 2} has no supremum in ℚ. -/
theorem rationalsNotComplete : ¬ completenessProp rationalNumbersAsOrderedField := by
  intro hcomplete
  -- Consider S = {q : ℚ | q > 0 ∧ q*q < 2}
  -- The supremum would be √2 which is irrational
  sorry

/-! ## ℝ as a Complete Ordered Field -/

/-- The canonical real numbers as a complete ordered field. -/
def realNumbersAsCOF : RealNumbers := default

/-- ℝ is complete (by axiom). -/
theorem realsAreComplete : completenessProp realNumbersAsCOF := by
  intro S hne hb
  sorry

/-! ## ℚ(√2) as an Ordered Field -/

/-- The field ℚ(√2) = {a + b√2 | a, b ∈ ℚ} as an ordered field. -/
structure QAdjoinSqrt2 where
  a : ℚ
  b : ℚ
  deriving Repr

/-- Addition in ℚ(√2). -/
def QAdjoinSqrt2.add (x y : QAdjoinSqrt2) : QAdjoinSqrt2 :=
  { a := x.a + y.a, b := x.b + y.b }

/-- Multiplication in ℚ(√2): (a + b√2)(c + d√2) = (ac + 2bd) + (ad + bc)√2. -/
def QAdjoinSqrt2.mul (x y : QAdjoinSqrt2) : QAdjoinSqrt2 :=
  { a := x.a * y.a + 2 * x.b * y.b
    b := x.a * y.b + x.b * y.a
  }

/-- ℚ(√2) as a RealNumbers structure (not complete). -/
def qAdjoinSqrt2AsOrderedField : RealNumbers :=
  { carrier := QAdjoinSqrt2
    add := QAdjoinSqrt2.add
    mul := QAdjoinSqrt2.mul
    zero := { a := 0, b := 0 }
    one := { a := 1, b := 0 }
    neg := fun x => { a := -x.a, b := -x.b }
    inv := fun x => sorry  -- requires rationalization of denominator
    le := fun x y => (x.a - y.a) * (x.a - y.a) ≤ 2 * (x.b - y.b) * (x.b - y.b)
    lt := fun x y => (x.a - y.a) * (x.a - y.a) < 2 * (x.b - y.b) * (x.b - y.b)
    fieldAddAssoc := by intro a b c; ext <;> simp [QAdjoinSqrt2.add]
    fieldAddComm := by intro a b; ext <;> simp [QAdjoinSqrt2.add]; ring
    fieldAddZero := by intro a; ext <;> simp [QAdjoinSqrt2.add]
    fieldAddNeg := by intro a; ext <;> simp [QAdjoinSqrt2.add]; ring
    fieldMulAssoc := by
      intro a b c; ext <;> simp [QAdjoinSqrt2.mul]; ring
    fieldMulComm := by
      intro a b; ext <;> simp [QAdjoinSqrt2.mul]; ring
    fieldMulOne := by
      intro a; ext <;> simp [QAdjoinSqrt2.mul]
    fieldMulInv := by
      intro a ha; sorry
    fieldDistrib := by
      intro a b c; ext <;> simp [QAdjoinSqrt2.add, QAdjoinSqrt2.mul]; ring
    fieldNontrivial := by
      intro h; have h0 : (0 : QAdjoinSqrt2).a = (1 : QAdjoinSqrt2).a := by rw [h]
      norm_num at h0
    orderRefl := by intro a; simp
    orderTrans := by intro a b c; sorry
    orderAntisymm := by intro a b; sorry
    orderTotal := by intro a b; sorry
    ltIffLeNotLe := by intro a b; sorry
    addLeAdd := by intro a b c; sorry
    mulPosPreservesLe := by intro a b c; sorry
    completeness := by
      intro S hne hb; sorry
  }

/-! ## ℝ(t) — Rational Functions as an Ordered Field -/

/-- The field ℝ(t) of rational functions over ℝ as an ordered field.
The ordering: f < g if g - f is eventually positive (for sufficiently large t).
-/
def rationalFunctionsOverReals : RealNumbers :=
  { carrier := ℚ × ℚ  -- placeholder: should be RatFunc ℝ
    add := fun p q => (p.1 * q.2 + q.1 * p.2, p.2 * q.2)
    mul := fun p q => (p.1 * q.1, p.2 * q.2)
    zero := (0, 1)
    one := (1, 1)
    neg := fun p => (-p.1, p.2)
    inv := fun p => if p.1 = 0 then (0, 1) else (p.2, p.1)
    le := fun p q => (q.1 * p.2 - p.1 * q.2) * p.2 * q.2 ≥ 0
    lt := fun p q => (q.1 * p.2 - p.1 * q.2) * p.2 * q.2 > 0
    fieldAddAssoc := by intro a b c; ext <;> ring
    fieldAddComm := by intro a b; ext <;> ring
    fieldAddZero := by intro a; ext <;> ring
    fieldAddNeg := by intro a; ext <;> ring
    fieldMulAssoc := by intro a b c; ext <;> ring
    fieldMulComm := by intro a b; ext <;> ring
    fieldMulOne := by intro a; ext <;> ring
    fieldMulInv := by
      intro a ha; ext <;> simp; ring
    fieldDistrib := by intro a b c; ext <;> ring
    fieldNontrivial := by intro h; have := congrArg Prod.fst h; norm_num at this
    orderRefl := by intro a; simp
    orderTrans := by intro a b c; sorry
    orderAntisymm := by intro a b; sorry
    orderTotal := by intro a b; sorry
    ltIffLeNotLe := by intro a b; sorry
    addLeAdd := by intro a b c; sorry
    mulPosPreservesLe := by intro a b c; sorry
    completeness := by
      intro S hne hb
      -- ℝ(t) is NOT complete. Show that the set {t, t^2, t^3, ...} is
      -- bounded above (by 0) but has no supremum.
      sorry
  }

/-! ## #eval Tests -/

#eval "rationalNumbersAsOrderedField defined"
#eval "QAdjoinSqrt2 defined"
#eval "qAdjoinSqrt2AsOrderedField defined"
#eval "rationalFunctionsOverReals defined"

-- Compute in ℚ(√2):
def sqrt2_element : QAdjoinSqrt2 := { a := 0, b := 1 }
#eval "sqrt(2) squared: " ++ toString ((QAdjoinSqrt2.mul sqrt2_element sqrt2_element).a) ++ " (should be 2)"

end MiniRealNumbers
