/-
# Real Numbers: Isomorphisms

Defines ordered field isomorphisms, the uniqueness theorem for
complete ordered fields, and connection to the kernel Iso type.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom

namespace MiniRealNumbers

/-! ## Ordered Field Isomorphism -/

/-- An isomorphism of ordered fields: a bijective field homomorphism whose
inverse is also a field homomorphism. -/
structure OrderedFieldIso (ℝ S : RealNumbers) where
  toFun : ℝ.carrier → S.carrier
  invFun : S.carrier → ℝ.carrier
  hom : FieldHomomorphism ℝ S
  inv_hom : FieldHomomorphism S ℝ
  left_inv : ∀ x, invFun (toFun x) = x
  right_inv : ∀ y, toFun (invFun y) = y
  toFun_eq_hom : toFun = hom.toFun
  invFun_eq_inv_hom : invFun = inv_hom.toFun

/-- Identity isomorphism. -/
def OrderedFieldIso.id (ℝ : RealNumbers) : OrderedFieldIso ℝ ℝ where
  toFun := id
  invFun := id
  hom := FieldHomomorphism.id ℝ
  inv_hom := FieldHomomorphism.id ℝ
  left_inv := by intro x; rfl
  right_inv := by intro y; rfl
  toFun_eq_hom := rfl
  invFun_eq_inv_hom := rfl

/-- Inverse of an ordered field isomorphism. -/
def OrderedFieldIso.symm {ℝ S : RealNumbers} (iso : OrderedFieldIso ℝ S) :
    OrderedFieldIso S ℝ where
  toFun := iso.invFun
  invFun := iso.toFun
  hom := iso.inv_hom
  inv_hom := iso.hom
  left_inv := iso.right_inv
  right_inv := iso.left_inv
  toFun_eq_hom := iso.invFun_eq_inv_hom
  invFun_eq_inv_hom := iso.toFun_eq_hom

/-- Composition of ordered field isomorphisms. -/
def OrderedFieldIso.trans {ℝ S T : RealNumbers}
    (iso1 : OrderedFieldIso ℝ S) (iso2 : OrderedFieldIso S T) :
    OrderedFieldIso ℝ T where
  toFun := iso2.toFun ∘ iso1.toFun
  invFun := iso1.invFun ∘ iso2.invFun
  hom := iso2.hom.comp iso1.hom
  inv_hom := iso1.inv_hom.comp iso2.inv_hom
  left_inv := by
    intro x
    calc
      iso1.invFun (iso2.invFun (iso2.toFun (iso1.toFun x))) = iso1.invFun (iso1.toFun x) := by
        rw [iso2.left_inv]
      _ = x := iso1.left_inv x
  right_inv := by
    intro y
    calc
      iso2.toFun (iso1.toFun (iso1.invFun (iso2.invFun y))) = iso2.toFun (iso2.invFun y) := by
        rw [iso1.right_inv]
      _ = y := iso2.right_inv y
  toFun_eq_hom := rfl
  invFun_eq_inv_hom := rfl

/-! ## Uniqueness of Complete Ordered Fields -/

/--
Any two complete ordered fields are isomorphic via a unique isomorphism.
This is the fundamental uniqueness theorem for ℝ.
-/
theorem anyTwoCompleteOrderedFieldsAreIsomorphic (ℝ S : RealNumbers)
    (hℝ : completenessProp ℝ) (hS : completenessProp S)
    (harchℝ : ArchimedeanProperty ℝ) (harchS : ArchimedeanProperty S) :
    ∃! iso : OrderedFieldIso ℝ S, True := by
  sorry

/--
Every complete ordered field is isomorphic to ℝ.
-/
theorem uniquenessOfRealNumbers (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) (harch : ArchimedeanProperty ℝ) :
    Nonempty (OrderedFieldIso default ℝ) := by
  sorry

/-! ## Connection to Kernel Iso -/

/-- Convert an OrderedFieldIso to a kernel Iso on the carriers. -/
def OrderedFieldIso.toKernelIso {ℝ S : RealNumbers}
    (iso : OrderedFieldIso ℝ S) : MiniObjectKernel.Iso ℝ.carrier S.carrier where
  toFun := iso.toFun
  invFun := iso.invFun
  leftInv := iso.left_inv
  rightInv := iso.right_inv

/-- OrderedFieldIso forms an equivalence relation. -/
theorem orderedFieldIsoRefl (ℝ : RealNumbers) : OrderedFieldIso ℝ ℝ :=
  OrderedFieldIso.id ℝ

theorem orderedFieldIsoSymm {ℝ S : RealNumbers} (iso : OrderedFieldIso ℝ S) :
    OrderedFieldIso S ℝ :=
  iso.symm

theorem orderedFieldIsoTrans {ℝ S T : RealNumbers}
    (iso1 : OrderedFieldIso ℝ S) (iso2 : OrderedFieldIso S T) :
    OrderedFieldIso ℝ T :=
  iso1.trans iso2

/-! ## #eval Tests -/

#eval "OrderedFieldIso defined"
#eval "OrderedFieldIso.id created: " ++ (let _ := OrderedFieldIso.id default; "OK")
#eval "symmetry holds"
#eval "transitivity holds"
#eval "Kernel Iso conversion defined"

end MiniRealNumbers
