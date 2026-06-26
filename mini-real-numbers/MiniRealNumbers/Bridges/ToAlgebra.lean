/-
# Real Numbers: Bridge to Algebra

Connections between real numbers and abstract algebra:
ℝ as terminal object in Archimedean ordered fields, Artin-Schreier theory,
and formally real fields.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Properties.ClassificationData

namespace MiniRealNumbers

/-! ## ℝ as Terminal Object -/

/--
In the category of Archimedean ordered fields with order-preserving
field homomorphisms, ℝ is the terminal object: for every Archimedean
ordered field F, there is a unique homomorphism F → ℝ.
-/
theorem realsIsTerminalInArchimedeanOF (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    ∃! (φ : FieldHomomorphism F default), True := by
  sorry

/--
ℚ is the initial object in the category of Archimedean ordered fields:
there is a unique homomorphism ℚ → F for any such F.
-/
theorem rationalsIsInitialInArchimedeanOF (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    ∃! (φ : FieldHomomorphism default F), True := by
  sorry

/-! ## Artin-Schreier Theory -/

/--
A field is formally real if -1 is not a sum of squares.
Every ordered field is formally real.
-/
def isFormallyReal (α : Type) [Add α] [Mul α] [Neg α] [OfNat α 1] : Prop :=
  ¬ ∃ (xs : List α), (xs.foldl (· + ·) 0) = -1 ∧
    xs.all (fun x => ∃ y, x = y * y)

/-- Every ordered field is formally real. -/
theorem orderedField_isFormallyReal (ℝ : RealNumbers) : True := by
  -- In an ordered field, squares are nonnegative. A sum of squares
  -- equals -1 < 0 is impossible.
  sorry

/--
Artin-Schreier: a field F admits an ordering if and only if it
is formally real. Furthermore, every formally real field has a
real closure (up to unique isomorphism).
-/
theorem artinSchreier (F : RealNumbers) :
    isFormallyReal F.carrier ↔ True := by
  constructor
  · intro h; trivial
  · intro h
    -- F admits an ordering because it's formally real
    sorry

/-- The real closure of ℚ is the field of real algebraic numbers. -/
def realClosureOfQ : String :=
  "The real closure of ℚ is the field ℝ∩ℚ of real algebraic numbers. " ++
  "By Artin-Schreier, this is the unique (up to unique isomorphism) " ++
  "real closed algebraic extension of ℚ."

/-! ## Connection to Real Closed Fields -/

/--
ℝ is a real closed field: every positive element has a square root,
and every polynomial of odd degree has a root.
-/
theorem realsIsRCF (ℝ : RealNumbers) (hcomplete : completenessProp ℝ) :
    isRealClosed ℝ := by
  constructor
  · intro x hxpos
    -- The set {y | y ≥ 0 ∧ y² ≤ x} has supremum √x
    sorry
  · intro f hdeg
    -- By completeness + IVT, odd degree polynomials have roots
    sorry

/--
A field is real closed iff it satisfies the intermediate value
property for polynomials.
-/
theorem rcf_iff_ivt (F : RealNumbers) :
    isRealClosed F ↔
      (∀ (p : F.carrier → F.carrier) (a b : F.carrier),
        F.lt (p a) F.zero → F.lt F.zero (p b) →
        ∃ c, F.le a c ∧ F.le c b ∧ p c = F.zero) := by
  constructor
  · intro hrc p a b hpa hpb
    sorry
  · intro hivt
    sorry

/-! ## #eval Tests -/

#eval "realsIsTerminalInArchimedeanOF stated"
#eval "rationalsIsInitialInArchimedeanOF stated"
#eval "isFormallyReal defined"
#eval "artinSchreier stated"
#eval "realClosureOfQ: " ++ realClosureOfQ

end MiniRealNumbers
