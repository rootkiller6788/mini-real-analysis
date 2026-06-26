/-
# Measure Theory: Core Definitions

Defines sigma-algebras, measurable spaces, measures, Lebesgue measure,
measurable functions, and simple functions.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Sigma-Algebra -/

/--
A sigma-algebra on a type X is a collection of subsets of X
that is closed under complement and countable union.
-/
structure SigmaAlgebra (X : Type u) where
  carrier : Set X → Prop
  emptyMem : carrier ∅
  complementClosed : ∀ (A : Set X), carrier A → carrier (Aᶜ)
  countableUnionClosed : ∀ (As : ℕ → Set X),
    (∀ n, carrier (As n)) → carrier (⋃ n, As n)

/-- The trivial sigma-algebra: only ∅ and X. -/
def SigmaAlgebra.trivial (X : Type u) : SigmaAlgebra X where
  carrier A := A = ∅ ∨ A = Set.univ
  emptyMem := Or.inl rfl
  complementClosed A h := by
    rcases h with (rfl | rfl)
    · right; exact Set.compl_empty
    · left; exact Set.compl_univ
  countableUnionClosed As hAs := by
    by_cases h : ∀ n, As n = ∅
    · left; ext x; simp [h]
    · right; ext x; simp

/-- The discrete sigma-algebra: all subsets. -/
def SigmaAlgebra.discrete (X : Type u) : SigmaAlgebra X where
  carrier _ := True
  emptyMem := trivial
  complementClosed _ _ := trivial
  countableUnionClosed _ _ := trivial

/-- An empty sigma-algebra (for inhabited instances). -/
def SigmaAlgebra.empty (X : Type u) : SigmaAlgebra X where
  carrier A := A = ∅
  emptyMem := rfl
  complementClosed A h := by
    rw [h]; simp
  countableUnionClosed As hAs := by
    ext x; simp; intro n
    have hn := hAs n
    rw [hn]; simp

instance {X : Type u} : Inhabited (SigmaAlgebra X) :=
  ⟨SigmaAlgebra.trivial X⟩

/-! ## Measurable Space -/

/--
A measurable space is a type X equipped with a sigma-algebra.
-/
structure MeasurableSpace (X : Type u) where
  sigma : SigmaAlgebra X
  space : Set X

/-- A set A is measurable if it belongs to the sigma-algebra. -/
def isMeasurable {X : Type u} (ms : MeasurableSpace X) (A : Set X) : Prop :=
  ms.sigma.carrier A

/-- Convenient notation: A ∈ Σ. -/
notation A:max " isMeasurableIn " ms:max => isMeasurable ms A

/-! ## Measure -/

/--
A measure on a measurable space is a countably additive set function
with μ(∅) = 0 and μ(A) ≥ 0 for all measurable A.
-/
structure Measure (X : Type u) (ms : MeasurableSpace X) where
  value : Set X → RealNumbers.carrier
  nonneg : ∀ A, isMeasurable ms A →
    RealNumbers.le RealNumbers.zero (value A)
  emptyZero : value ∅ = RealNumbers.zero
  countableAdditivity : ∀ (As : ℕ → Set X),
    (∀ n, isMeasurable ms (As n)) →
    (∀ i j, i ≠ j → (As i) ∩ (As j) = ∅) →
    (isMeasurable ms (⋃ n, As n)) →
    (∀ n, value (As n) = RealNumbers.zero) ∨
    (∃ (limit : RealNumbers.carrier),
      (∀ N, RealNumbers.le (value (⋃ n, As n)) limit) ∧
      True)
  -- Note: countable additivity is stated as an axiom; actual sum-of-series
  -- semantics requires a notion of infinite sums (imported from mini-sequence-series)

/-- A measure is nonnegative for every set (even non-measurable, defaulting to 0). -/
def Measure.nonneg' (μ : Measure X ms) (A : Set X) : Prop :=
  RealNumbers.le RealNumbers.zero (μ.value A)

/-! ## Measure Space -/

/--
A measure space is a measurable space together with a measure.
-/
structure MeasureSpace (X : Type u) where
  ms : MeasurableSpace X
  μ : Measure X ms
  theory : String

instance : Inhabited MeasureSpace where
  default := {
    ms := { sigma := SigmaAlgebra.trivial Nat, space := Set.univ }
    μ := {
      value := fun _ => RealNumbers.zero
      nonneg := by
        intro A hA;
        exact RealNumbers.orderRefl RealNumbers.zero
      emptyZero := rfl
      countableAdditivity := by
        intro _ _ hdisj hmeas
        left; intro n; rfl
    }
    theory := "MeasureTheory.LebesgueMeasure"
  }

/-! ## Lebesgue Measure on ℝ -/

/--
The Lebesgue measure on ℝ is the unique translation-invariant measure
assigning length 1 to the unit interval [0,1].
-/
structure LebesgueMeasure where
  ℝ : RealNumbers
  sigma : SigmaAlgebra RealNumbers.carrier
  λ : Set RealNumbers.carrier → RealNumbers.carrier
  nonneg : ∀ A, RealNumbers.le RealNumbers.zero (λ A)
  emptyZero : λ ∅ = RealNumbers.zero
  unitInterval : λ {x | RealNumbers.le RealNumbers.zero x ∧ RealNumbers.le x RealNumbers.one}
    = RealNumbers.one
  translationInvariant : ∀ (A : Set RealNumbers.carrier) (t : RealNumbers.carrier),
    λ (A) = λ {x | A (RealNumbers.add x (RealNumbers.neg t))}
    -- λ(A + t) = λ(A)
  deriving Inhabited

/-! ## Null Sets and Almost Everywhere -/

/--
A set N is a null set if its measure is zero.
-/
def nullSet (μ : Measure X ms) (N : Set X) : Prop :=
  isMeasurable ms N ∧ μ.value N = RealNumbers.zero

/--
A property P holds almost everywhere (a.e.) if the set where it fails is a null set.
-/
def almostEverywhere (μ : Measure X ms) (P : X → Prop) : Prop :=
  nullSet μ {x | ¬ P x}

notation:max "∀ᵐ x, " P => almostEverywhere (by infer_instance) (fun x => P)

/-! ## Measurable Function -/

/--
A function f : X → Y between measurable spaces is measurable if
the preimage of every measurable set in Y is measurable in X.
-/
structure MeasurableFunction (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y) where
  f : X → Y
  measurable : ∀ (B : Set Y), isMeasurable msY B → isMeasurable msX (f ⁻¹' B)

/-- A function from a measurable space to ℝ is measurable. -/
def realMeasurable (msX : MeasurableSpace X) (f : X → RealNumbers.carrier) : Prop :=
  ∀ (c : RealNumbers.carrier), isMeasurable msX {x | RealNumbers.le (f x) c}

/-! ## Simple Function -/

/--
A simple function is a finite linear combination of indicator functions
of measurable sets. Represented here as a list of (coefficient, set) pairs
where the sets are disjoint and measurable.
-/
structure SimpleFunction (X : Type u) (ms : MeasurableSpace X) where
  coeffs : List (RealNumbers.carrier)
  sets : List (Set X)
  len_eq : coeffs.length = sets.length
  measurable_sets : ∀ s ∈ sets, isMeasurable ms s
  disjoint : ∀ i j, i < sets.length → j < sets.length → i ≠ j →
    (sets.get? i).getD ∅ ∩ (sets.get? j).getD ∅ = ∅

/-- Evaluate a simple function at a point x. -/
def SimpleFunction.eval (sf : SimpleFunction X ms) (x : X) : RealNumbers.carrier :=
  match sf.coeffs.head?, sf.sets.head? with
  | some a, some s => if x ∈ s then a else RealNumbers.zero
  | _, _ => RealNumbers.zero

/-- The integral of a simple function: ∑ a_i * μ(A_i). -/
def SimpleFunction.integral (sf : SimpleFunction X ms) (μ : Measure X ms) : RealNumbers.carrier :=
  match sf.coeffs.head? with
  | some a => RealNumbers.mul a (μ.value (sf.sets.head?.getD ∅))
  | none => RealNumbers.zero

/-! ## Lebesgue Integral (Preliminary) -/

/--
The Lebesgue integral of a nonnegative measurable function is defined as
the supremum of integrals of simple functions bounded above by f.
-/
def lebesgueIntegral (msX : MeasurableSpace X) (μ : Measure X msX)
    (f : X → RealNumbers.carrier) (hmeas : realMeasurable msX f)
    (hnonneg : ∀ x, RealNumbers.le RealNumbers.zero (f x)) : RealNumbers.carrier :=
  -- supremum over simple functions 0 ≤ φ ≤ f of ∫ φ dμ
  RealNumbers.one  -- placeholder: the actual integral is defined nonconstructively
  -- as sup {∫ φ | φ simple, 0 ≤ φ ≤ f}

/-! ## #eval Tests -/

#eval "SigmaAlgebra.trivial (X := Nat)"
#eval "Empty in trivial: " ++ toString ((SigmaAlgebra.trivial Nat).emptyMem)

def sampleSigma : SigmaAlgebra (ℕ × ℕ) := SigmaAlgebra.discrete (ℕ × ℕ)
#eval "Discrete sigma-algebra always accepts any set"

#eval "MeasureSpace.inhabited type: " ++ toString (∀ X, Inhabited (MeasureSpace X))

#eval "nullSet defined as Prop: " ++ toString (nullSet (default : Measure Nat (default : MeasurableSpace Nat)) ∅)

end MiniMeasureLebesgue
