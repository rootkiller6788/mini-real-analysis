/-
# Real Numbers: Core Definitions

Defines `RealNumbers` as a complete ordered field, along with
Dedekind cuts, Cauchy sequences, and basic order-theoretic notions.
-/

import MiniObjectKernel

namespace MiniRealNumbers

/-! ## Notation: ℝ -/

notation "ℝ" => RealNumbers

/-! ## RealNumbers: The Complete Ordered Field -/

/--
The type of real numbers. Defined axiomatically as a complete ordered field.
In this formalization, ℝ is a structure with carrier, field operations (+, *, 0, 1, -, inv),
and order relations (≤, <) satisfying the complete ordered field axioms.
-/
structure RealNumbers where
  carrier : Type
  add : carrier → carrier → carrier
  mul : carrier → carrier → carrier
  zero : carrier
  one : carrier
  neg : carrier → carrier
  inv : carrier → carrier
  le : carrier → carrier → Prop
  lt : carrier → carrier → Prop
  fieldAddAssoc : ∀ a b c : carrier, add (add a b) c = add a (add b c)
  fieldAddComm : ∀ a b : carrier, add a b = add b a
  fieldAddZero : ∀ a : carrier, add a zero = a
  fieldAddNeg : ∀ a : carrier, add a (neg a) = zero
  fieldMulAssoc : ∀ a b c : carrier, mul (mul a b) c = mul a (mul b c)
  fieldMulComm : ∀ a b : carrier, mul a b = mul b a
  fieldMulOne : ∀ a : carrier, mul a one = a
  fieldMulInv : ∀ a : carrier, a ≠ zero → mul a (inv a) = one
  fieldDistrib : ∀ a b c : carrier, mul a (add b c) = add (mul a b) (mul a c)
  fieldNontrivial : zero ≠ one
  orderRefl : ∀ a : carrier, le a a
  orderTrans : ∀ a b c : carrier, le a b → le b c → le a c
  orderAntisymm : ∀ a b : carrier, le a b → le b a → a = b
  orderTotal : ∀ a b : carrier, le a b ∨ le b a
  ltIffLeNotLe : ∀ a b : carrier, lt a b ↔ le a b ∧ ¬ le b a
  addLeAdd : ∀ a b c : carrier, le a b → le (add a c) (add b c)
  mulPosPreservesLe : ∀ a b c : carrier, le zero c → le a b → le (mul a c) (mul b c)
  completeness : ∀ (S : Set carrier),
    (∃ x : carrier, x ∈ S) → (∃ M : carrier, isUpperBound ℝ le S M) →
    ∃ s : carrier, isSupremum ℝ le S s

/-! ## Bounds and Completeness -/

/-- `a` is an upper bound of set `S` with respect to order ≤. -/
def isUpperBound {α : Type} (le : α → α → Prop) (S : Set α) (a : α) : Prop :=
  ∀ x ∈ S, le x a

/-- `a` is a lower bound of set `S` with respect to order ≤. -/
def isLowerBound {α : Type} (le : α → α → Prop) (S : Set α) (a : α) : Prop :=
  ∀ x ∈ S, le a x

/-- `s` is the supremum of `S`: s is an upper bound and s ≤ every upper bound. -/
def isSupremum {α : Type} (le : α → α → Prop) (S : Set α) (s : α) : Prop :=
  isUpperBound le S s ∧ ∀ b, isUpperBound le S b → le s b

/-- `i` is the infimum of `S`: i is a lower bound and every lower bound ≤ i. -/
def isInfimum {α : Type} (le : α → α → Prop) (S : Set α) (i : α) : Prop :=
  isLowerBound le S i ∧ ∀ b, isLowerBound le S b → le b i

/-- The supremum of a nonempty bounded-above set (partial function). -/
noncomputable def supremum (ℝ : RealNumbers) (S : Set ℝ.carrier)
    (hnonempty : ∃ x, x ∈ S) (hbounded : ∃ M, isUpperBound ℝ.le S M) : ℝ.carrier :=
  (ℝ.completeness S hnonempty hbounded).val

/-- The infimum of a nonempty bounded-below set (partial function). -/
noncomputable def infimum (ℝ : RealNumbers) (S : Set ℝ.carrier)
    (hnonempty : ∃ x, x ∈ S) (hbounded : ∃ m, isLowerBound ℝ.le S m) : ℝ.carrier :=
  have hnegbounded : ∃ M, isUpperBound ℝ.le {x | ℝ.neg x ∈ S} M := by
    rcases hbounded with ⟨m, hm⟩
    refine ⟨ℝ.neg m, ?_⟩
    intro y hy
    sorry
  have hnegSup := ℝ.completeness {x | ℝ.neg x ∈ S} ?_ hnegbounded
  ℝ.neg hnegSup.val
    -- sorry-bridge: formal infimum via sup-of-negatives

/-! ## Archimedean Property -/

/-- An ordered field has the Archimedean property if for every x there
exists a natural number n > x. -/
def ArchimedeanProperty (ℝ : RealNumbers) : Prop :=
  ∀ x : ℝ.carrier, ∃ n : ℕ, ℝ.lt x (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc ℝ.one) n)

/-! ## Dedekind Cut -/

/--
A Dedekind cut is a partition of the rationals into two sets (L, U)
such that L has no maximum, U has no minimum (if U is nonempty), and
every element of L is less than every element of U. Here we define cuts
over the carrier of an arbitrary ordered field.
-/
structure DedekindCut (ℝ : RealNumbers) where
  lowerSet : Set ℝ.carrier
  upperSet : Set ℝ.carrier
  lowerNonempty : ∃ x, x ∈ lowerSet
  upperNonempty : ∃ x, x ∈ upperSet
  lowerHasNoMax : ∀ x ∈ lowerSet, ∃ y ∈ lowerSet, ℝ.lt x y
  partition : ∀ x y, x ∈ lowerSet → y ∈ upperSet → ℝ.lt x y
  covered : ∀ x, x ∈ lowerSet ∨ x ∈ upperSet

/-! ## Cauchy Sequence -/

/--
A Cauchy sequence in an ordered field: a sequence `a : ℕ → ℝ` such that
∀ ε > 0, ∃ N, ∀ m n ≥ N, |a_m - a_n| < ε.
-/
def CauchySequence (ℝ : RealNumbers) (a : ℕ → ℝ.carrier) : Prop :=
  ∀ (ε : ℝ.carrier), ℝ.lt ℝ.zero ε →
    ∃ N : ℕ, ∀ m n : ℕ, m ≥ N → n ≥ N →
      ℝ.lt (ℝ.add (a m) (ℝ.neg (a n))) ε ∧ ℝ.lt (ℝ.add (a n) (ℝ.neg (a m))) ε

/-- A sequence converges to a limit L: ∀ ε > 0, ∃ N, ∀ n ≥ N, |a_n - L| < ε. -/
def ConvergesTo (ℝ : RealNumbers) (a : ℕ → ℝ.carrier) (L : ℝ.carrier) : Prop :=
  ∀ (ε : ℝ.carrier), ℝ.lt ℝ.zero ε →
    ∃ N : ℕ, ∀ n : ℕ, n ≥ N →
      ℝ.lt (ℝ.add (a n) (ℝ.neg L)) ε ∧ ℝ.lt (ℝ.add L (ℝ.neg (a n))) ε

/-! ## Complete Ordered Field Axioms -/

/-- The complete ordered field axioms for a type. -/
class CompleteOrderedField (α : Type) where
  add : α → α → α
  mul : α → α → α
  zero : α
  one : α
  neg : α → α
  inv : α → α
  le : α → α → Prop
  lt : α → α → Prop
  fieldAddAssoc : ∀ a b c, add (add a b) c = add a (add b c)
  fieldAddComm : ∀ a b, add a b = add b a
  fieldAddZero : ∀ a, add a zero = a
  fieldAddNeg : ∀ a, add a (neg a) = zero
  fieldMulAssoc : ∀ a b c, mul (mul a b) c = mul a (mul b c)
  fieldMulComm : ∀ a b, mul a b = mul b a
  fieldMulOne : ∀ a, mul a one = a
  fieldMulInv : ∀ a, a ≠ zero → mul a (inv a) = one
  fieldDistrib : ∀ a b c, mul a (add b c) = add (mul a b) (mul a c)
  fieldNontrivial : zero ≠ one
  orderRefl : ∀ a, le a a
  orderTrans : ∀ a b c, le a b → le b c → le a c
  orderAntisymm : ∀ a b, le a b → le b a → a = b
  orderTotal : ∀ a b, le a b ∨ le b a
  ltIffLeNotLe : ∀ a b, lt a b ↔ le a b ∧ ¬ le b a
  addLeAdd : ∀ a b c, le a b → le (add a c) (add b c)
  mulPosPreservesLe : ∀ a b c, le zero c → le a b → le (mul a c) (mul b c)
  completeness : ∀ (S : Set α),
    (∃ x, x ∈ S) → (∃ M, isUpperBound le S M) →
    ∃ s, isSupremum le S s

/-! ## Object Instance -/

instance : Object RealNumbers where
  theory := TheoryName.ofString "RealAnalysis.OrderedFields.RealNumbers"
  objName := "RealNumbers"
  repr := fun _ => "ℝ"

instance : ToString RealNumbers where
  toString := fun _ => "ℝ"

instance : Inhabited RealNumbers := ⟨
  { carrier := Unit
    add := fun _ _ => ()
    mul := fun _ _ => ()
    zero := ()
    one := ()
    neg := fun _ => ()
    inv := fun _ => ()
    le := fun _ _ => True
    lt := fun _ _ => True
    fieldAddAssoc := by intro; rfl
    fieldAddComm := by intro; rfl
    fieldAddZero := by intro; rfl
    fieldAddNeg := by intro; rfl
    fieldMulAssoc := by intro; rfl
    fieldMulComm := by intro; rfl
    fieldMulOne := by intro; rfl
    fieldMulInv := by intro; sorry
    fieldDistrib := by intro; rfl
    fieldNontrivial := by trivial
    orderRefl := by intro; trivial
    orderTrans := by intro; trivial
    orderAntisymm := by intro; trivial
    orderTotal := by intro; left; trivial
    ltIffLeNotLe := by intro; simp
    addLeAdd := by intro; trivial
    mulPosPreservesLe := by intro; trivial
    completeness := by
      intro S hne hb
      rcases hne with ⟨x, hx⟩
      refine ⟨x, ?_⟩
      refine ⟨?_, ?_⟩
      · intro y hy; trivial
      · intro b hb'; trivial
  }⟩

/-! ## #eval Tests -/

#eval describe RealNumbers

def sampleReal : RealNumbers := by
  -- Use the default inhabited unit-carrier for eval purposes
  exact default

#eval "RealNumbers: " ++ toString sampleReal
#eval "ArchimedeanProperty defined as Prop: " ++ toString (ArchimedeanProperty sampleReal)

end MiniRealNumbers
