/-
# Real Numbers: Preservation Properties

Under order-preserving maps and field homomorphisms, what properties
are preserved: suprema, zero/one/characteristic, and Dedekind completeness.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Morphisms.Iso

namespace MiniRealNumbers

/-! ## Preservation of Suprema -/

/-- An order-preserving map preserves suprema if it maps the supremum
of a set to the supremum of the image set. -/
def preservesSuprema {ℝ S : RealNumbers} (f : OrderPreservingMap ℝ S) : Prop :=
  ∀ (A : Set ℝ.carrier) (s : ℝ.carrier),
    isSupremum ℝ.le A s →
    isSupremum S.le (f.toFun '' A) (f.toFun s)

/-- An order-isomorphism preserves suprema. -/
theorem iso_preservesSuprema {ℝ S : RealNumbers} (iso : OrderedFieldIso ℝ S) :
    preservesSuprema iso.hom.toOrderPreservingMap := by
  intro A s ⟨hub, hleast⟩
  constructor
  · intro y hy
    rcases hy with ⟨x, hx, rfl⟩
    apply iso.hom.map_order
    apply hub
    exact hx
  · intro b hb
    sorry

/-! ## Preservation of Field Constants -/

/-- Field homomorphisms preserve the additive identity (zero). -/
theorem hom_preservesZero {ℝ S : RealNumbers} (f : FieldHomomorphism ℝ S) :
    f.toFun ℝ.zero = S.zero :=
  f.map_zero

/-- Field homomorphisms preserve the multiplicative identity (one). -/
theorem hom_preservesOne {ℝ S : RealNumbers} (f : FieldHomomorphism ℝ S) :
    f.toFun ℝ.one = S.one :=
  f.map_one

/-- Field homomorphisms preserve characteristic. -/
theorem hom_preservesCharacteristic {ℝ S : RealNumbers} (f : FieldHomomorphism ℝ S)
    (hchar : characteristicZero ℝ) : characteristicZero S := by
  intro n hnpos
  intro h
  apply hchar n hnpos
  have : f.toFun ℝ.zero = f.toFun (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc ℝ.one) n) := by
    rw [f.map_zero, h, f.map_one]
    -- need to relate n·1_S to f(n·1_ℝ)
    sorry
  sorry

/-! ## Preservation of Dedekind Completeness -/

/-- Dedekind completeness is preserved under ordered field isomorphism. -/
theorem completenessPreservedUnderIso {ℝ S : RealNumbers}
    (iso : OrderedFieldIso ℝ S) (hcomplete : completenessProp ℝ) :
    completenessProp S := by
  intro T hne hb
  -- Pull back T along iso.invFun, get a sup in ℝ, push forward
  let T' : Set ℝ.carrier := iso.invFun '' T
  have hne' : ∃ x, x ∈ T' := by
    rcases hne with ⟨y, hy⟩
    refine ⟨iso.invFun y, ?_⟩
    exact ⟨y, hy, rfl⟩
  have hb' : ∃ M, isUpperBound ℝ.le T' M := by
    rcases hb with ⟨M, hM⟩
    refine ⟨iso.invFun M, ?_⟩
    intro x hx
    rcases hx with ⟨y, hy, rfl⟩
    apply iso.inv_hom.map_order
    apply hM
    exact hy
  rcases hcomplete T' hne' hb' with ⟨s, hs⟩
  refine ⟨iso.toFun s, ?_⟩
  constructor
  · intro y hy
    have : iso.invFun y ∈ T' := ⟨y, hy, rfl⟩
    have hle : ℝ.le (iso.invFun y) s := hs.1 (iso.invFun y) this
    -- apply iso.hom.map_order ... but we need to go from ℝ.le to S.le
    -- OrderFieldIso map_order works the other direction
    sorry
  · intro b hb_all
    sorry

/-! ## Lift of Axioms Along Isomorphism -/

/-- If ℝ satisfies the completeness axiom, any isomorphic field does too. -/
theorem completeness_lifts_along_iso {ℝ S : RealNumbers}
    (iso : OrderedFieldIso ℝ S) (hcomplete : completenessProp ℝ) :
    completenessProp S :=
  completenessPreservedUnderIso iso hcomplete

/-- The Archimedean property lifts along isomorphism. -/
theorem archimedean_lifts_along_iso {ℝ S : RealNumbers}
    (iso : OrderedFieldIso ℝ S) (harch : ArchimedeanProperty ℝ) :
    ArchimedeanProperty S := by
  intro x
  rcases harch (iso.invFun x) with ⟨n, hn⟩
  refine ⟨n, ?_⟩
  sorry

/-! ## #eval Tests -/

#eval "preservesSuprema defined"
#eval "hom_preservesZero: " ++ toString (hom_preservesZero (FieldHomomorphism.id default))
#eval "hom_preservesOne proved"
#eval "completenessPreservedUnderIso stated"
#eval "archimedean_lifts_along_iso stated"

end MiniRealNumbers
