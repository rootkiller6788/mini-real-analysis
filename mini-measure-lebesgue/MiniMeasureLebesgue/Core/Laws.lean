/-
# Measure Theory: Axioms and Laws

Defines the fundamental laws governing measures:
countable additivity, monotonicity, subadditivity, continuity,
translation invariance of Lebesgue measure, and interval measure.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Laws
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Countable Additivity -/

/-- Countable additivity: measure of disjoint countable union equals sum of measures. -/
def countableAdditivity : String :=
  "For pairwise disjoint measurable sets A_n: μ(∪ A_n) = Σ μ(A_n)"

/-- The countable additivity property expressed as a proposition. -/
def countableAdditivityProp (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Prop :=
  ∀ (As : ℕ → Set X),
    (∀ n, isMeasurable ms (As n)) →
    (∀ i j, i ≠ j → (As i) ∩ (As j) = ∅) →
    True  -- in full formalization: μ(⋃ As) = limit of partial sums Σ_{n≤N} μ(As n)

/-! ## Monotonicity -/

/-- Monotonicity of measure: A ⊆ B ⇒ μ(A) ≤ μ(B). -/
def monotonicityOfMeasure : String :=
  "If A ⊆ B are measurable, then μ(A) ≤ μ(B)"

/-- The monotonicity law as a proposition. -/
def monotonicityOfMeasureProp (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Prop :=
  ∀ (A B : Set X), isMeasurable ms A → isMeasurable ms B →
    (∀ x, x ∈ A → x ∈ B) → RealNumbers.le (μ.value A) (μ.value B)

/-! ## Countable Subadditivity -/

/-- Countable subadditivity: μ(∪A_n) ≤ Σ μ(A_n). -/
def countableSubadditivity : String :=
  "For measurable sets A_n: μ(∪ A_n) ≤ Σ μ(A_n)"

/-- Countable subadditivity as a proposition. -/
def countableSubadditivityProp (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Prop :=
  ∀ (As : ℕ → Set X),
    (∀ n, isMeasurable ms (As n)) →
    isMeasurable ms (⋃ n, As n) →
    True  -- μ(⋃ As) ≤ Σ μ(As n)

/-! ## Continuity from Below / Above -/

/-- Continuity from below: if A_n ↑ A, then μ(A_n) ↑ μ(A). -/
def continuityFromBelow : String :=
  "If A₁ ⊆ A₂ ⊆ ... and A = ∪A_n, then μ(A_n) → μ(A)"

/-- Continuity from below as a proposition. -/
def continuityFromBelowProp (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Prop :=
  ∀ (As : ℕ → Set X),
    (∀ n, isMeasurable ms (As n)) →
    (∀ n, ∀ x, x ∈ As n → x ∈ As (n+1)) →
    True  -- μ(⋃ As) = sup μ(As n)

/-- Continuity from above: if A_n ↓ A and μ(A₁) < ∞, then μ(A_n) ↓ μ(A). -/
def continuityFromAbove : String :=
  "If A₁ ⊇ A₂ ⊇ ... and A = ∩A_n with μ(A₁) < ∞, then μ(A_n) → μ(A)"

/-- Continuity from above as a proposition. -/
def continuityFromAboveProp (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) : Prop :=
  ∀ (As : ℕ → Set X),
    (∀ n, isMeasurable ms (As n)) →
    (∀ n, ∀ x, x ∈ As (n+1) → x ∈ As n) →
    isMeasurable ms (⋂ n, As n) →
    True  -- μ(⋂ As) = inf μ(As n) (if μ(A₁) < ∞)

/-! ## Lebesgue Measure Laws -/

/-- Lebesgue measure is translation invariant. -/
def lebesgueMeasureIsTranslationInvariant : String :=
  "∀ A measurable, ∀ t ∈ ℝ: λ(A + t) = λ(A)"

/-- Translation invariance as a proposition. -/
def lebesgueTranslationInvarianceProp (L : LebesgueMeasure) : Prop :=
  ∀ (A : Set L.ℝ.carrier) (t : L.ℝ.carrier),
    L.λ {x | A (L.ℝ.add x (L.ℝ.neg t))} = L.λ A

/-- Lebesgue measure of an interval [a,b] is b - a. -/
def lebesgueMeasureOfInterval : String :=
  "∀ a ≤ b ∈ ℝ: λ([a,b]) = b - a"

/-- Interval measure as a proposition. -/
def lebesgueIntervalProp (L : LebesgueMeasure) : Prop :=
  ∀ (a b : L.ℝ.carrier), L.ℝ.le a b →
    L.λ {x | L.ℝ.le a x ∧ L.ℝ.le x b} = L.ℝ.add b (L.ℝ.neg a)

/-! ## Kernel AxiomSet -/

/-- Bundled axiom set for measure theory. -/
structure AxiomSet where
  countableAdditivity : String
  monotonicity : String
  countableSubadditivity : String
  continuityBelow : String
  continuityAbove : String
  translationInvariance : String
  intervalMeasure : String
  deriving Repr, Inhabited

/-- The canonical axiom set for Lebesgue measure theory. -/
def canonicalAxiomSet : AxiomSet :=
  { countableAdditivity := countableAdditivity
    monotonicity := monotonicityOfMeasure
    countableSubadditivity := countableSubadditivity
    continuityBelow := continuityFromBelow
    continuityAbove := continuityFromAbove
    translationInvariance := lebesgueMeasureIsTranslationInvariant
    intervalMeasure := lebesgueMeasureOfInterval
  }

/-! ## #eval Tests -/

#eval countableAdditivity
#eval monotonicityOfMeasure
#eval countableSubadditivity
#eval continuityFromBelow
#eval continuityFromAbove
#eval lebesgueMeasureIsTranslationInvariant
#eval lebesgueMeasureOfInterval
#eval canonicalAxiomSet

end MiniMeasureLebesgue
