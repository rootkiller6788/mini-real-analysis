/-
# Real Numbers: Equivalences

Defines order-isomorphism relations, the equivalence between
Dedekind completeness and Cauchy completeness, and equivalence
relation properties.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Morphisms.Iso

namespace MiniRealNumbers

/-! ## Order Isomorphism -/

/-- Two ordered structures are order-isomorphic if there exists a
bijective order-preserving map between them. -/
def isOrderIsomorphic (ℝ S : RealNumbers) : Prop :=
  ∃ (f : ℝ.carrier → S.carrier) (g : S.carrier → ℝ.carrier),
    (∀ x y, ℝ.le x y → S.le (f x) (f y)) ∧
    (∀ x y, S.le x y → ℝ.le (g x) (g y)) ∧
    (∀ x, g (f x) = x) ∧
    (∀ y, f (g y) = y)

/-- Order-isomorphism is reflexive. -/
theorem isOrderIsomorphic.refl (ℝ : RealNumbers) : isOrderIsomorphic ℝ ℝ := by
  refine ⟨id, id, ?_, ?_, ?_, ?_⟩
  · intro x y h; exact h
  · intro x y h; exact h
  · intro x; rfl
  · intro y; rfl

/-- Order-isomorphism is symmetric. -/
theorem isOrderIsomorphic.symm {ℝ S : RealNumbers} (h : isOrderIsomorphic ℝ S) :
    isOrderIsomorphic S ℝ := by
  rcases h with ⟨f, g, hf, hg, hleft, hright⟩
  refine ⟨g, f, hg, hf, hright, hleft⟩

/-- Order-isomorphism is transitive. -/
theorem isOrderIsomorphic.trans {ℝ S T : RealNumbers}
    (h1 : isOrderIsomorphic ℝ S) (h2 : isOrderIsomorphic S T) :
    isOrderIsomorphic ℝ T := by
  rcases h1 with ⟨f, g, hf, hg, hleft, hright⟩
  rcases h2 with ⟨f', g', hf', hg', hleft', hright'⟩
  refine ⟨f' ∘ f, g ∘ g', ?_, ?_, ?_, ?_⟩
  · intro x y h
    apply hf'
    apply hf
    exact h
  · intro x y h
    apply hg
    apply hg'
    exact h
  · intro x
    calc
      g (g' (f' (f x))) = g (f x) := by rw [hleft']
      _ = x := hleft x
  · intro y
    calc
      f' (f (g (g' y))) = f' (g' y) := by rw [hright]
      _ = y := hright' y

/-! ## Equivalence of Completeness Notions -/

/--
In an Archimedean ordered field, Dedekind completeness is equivalent
to Cauchy completeness. This is a fundamental theorem that connects
the two main constructions of ℝ.
-/
theorem dedekindCompleteness_iff_cauchyCompleteness (ℝ : RealNumbers)
    (harch : ArchimedeanProperty ℝ) :
    completenessProp ℝ ↔ cauchyCompleteness ℝ := by
  constructor
  · intro hcomplete
    intro a hcauchy
    -- Use completeness to find the limit as sup/inf of tail bounds
    sorry
  · intro hcauchy
    intro S hne hb
    -- Construct a monotone sequence whose limit is the supremum
    sorry

/-- Dedekind completeness implies that every Dedekind cut has a cut point. -/
theorem dedekindCompleteness_implies_cut (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) :
    isDedekindComplete ℝ := by
  intro L U hLne hUne hdisj hlower hcover
  -- The supremum of L is the cut point
  sorry

/-- The equivalence relation "is isomorphic as an ordered field". -/
def orderedFieldEquiv (ℝ S : RealNumbers) : Prop :=
  Nonempty (OrderedFieldIso ℝ S)

/-! ## #eval Tests -/

#eval "isOrderIsomorphic defined"
#eval "dedekindCompleteness_iff_cauchyCompleteness stated"
#eval "orderedFieldEquiv defined"
#eval "Equivalence relations reflexive/symmetric/transitive proven"

end MiniRealNumbers
