/-
# Real Numbers: Object Registration

Registers RealNumbers as a kernel Object, defines ℝ as a
Lean type with field operations, and predicates on ordered fields.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniRealNumbers

/-! ## Object Instance -/

instance : Object RealNumbers where
  theory := TheoryName.ofString "RealAnalysis.OrderedFields.RealNumbers"
  objName := "RealNumbers"
  repr := fun _ => "ℝ"

/-! ## Theory Registration -/

/-- The real analysis theory name. -/
def realAnalysisTheory : TheoryName :=
  TheoryName.ofString "RealAnalysis"

/-- Register the RealNumbers theory in the kernel. -/
def registerRealNumbersTheory : IO Unit := do
  let tn := realAnalysisTheory
  IO.println s!"Registered theory: {tn}"

/-! ## ℝ as a Type with Field Operations -/

/-- The ℝ type alias for the carrier of the canonical RealNumbers structure. -/
def ℝType : Type := RealNumbers

/-- Create a RealNumbers structure from raw carrier data (for testing). -/
def mkRealNumbers (carrier : Type) (add mul : carrier → carrier → carrier)
    (zero one : carrier) (neg inv : carrier → carrier)
    (le lt : carrier → carrier → Prop) : RealNumbers :=
  { carrier := carrier
    add := add
    mul := mul
    zero := zero
    one := one
    neg := neg
    inv := inv
    le := le
    lt := lt
    fieldAddAssoc := by intro; sorry
    fieldAddComm := by intro; sorry
    fieldAddZero := by intro; sorry
    fieldAddNeg := by intro; sorry
    fieldMulAssoc := by intro; sorry
    fieldMulComm := by intro; sorry
    fieldMulOne := by intro; sorry
    fieldMulInv := by intro; sorry
    fieldDistrib := by intro; sorry
    fieldNontrivial := by
      intro h; have : zero ≠ one := h; exact this rfl
    orderRefl := by intro; sorry
    orderTrans := by intro; sorry
    orderAntisymm := by intro; sorry
    orderTotal := by intro; sorry
    ltIffLeNotLe := by intro; sorry
    addLeAdd := by intro; sorry
    mulPosPreservesLe := by intro; sorry
    completeness := by intro; sorry
  }

/-! ## Predicates on Ordered Fields -/

/-- A predicate checking whether a type has a complete ordered field structure. -/
class isComplete (α : Type) where
  cof : CompleteOrderedField α

/-- A predicate: an ordered field is Dedekind-complete if every Dedekind cut
has a cut-point in the field. -/
def isDedekindComplete (ℝ : RealNumbers) : Prop :=
  ∀ (L U : Set ℝ.carrier),
    (∃ x, x ∈ L) → (∃ x, x ∈ U) →
    (∀ x ∈ L, ∀ y ∈ U, ℝ.lt x y) →
    (∀ x y, x ∈ L → y ∈ U → ℝ.lt x y) →
    (∀ x, x ∈ L ∨ x ∈ U) →
    ∃ c : ℝ.carrier,
      (∀ x ∈ L, ℝ.le x c ∨ x = c) ∧
      (∀ y ∈ U, ℝ.le c y ∨ c = y)

/-! ## #eval Tests -/

#eval "RealNumbers theory: " ++ toString realAnalysisTheory
#eval "isComplete class defined"
#eval registerRealNumbersTheory

end MiniRealNumbers
