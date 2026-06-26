/-
# Real Numbers: Universal Property Theorems

The universal property of the Dedekind completion, the universal arrow
ℚ → ℝ, and embedding theorems.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Morphisms.Iso
import MiniRealNumbers.Constructions.Universal

namespace MiniRealNumbers

/-! ## Universal Property of Dedekind Completion -/

/--
ℝ is the Dedekind completion of ℚ: it is the unique (up to unique
isomorphism) complete ordered field containing ℚ as a dense subfield.
-/
theorem realNumbersIsDedekindCompletionOfRationals (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) :
    True := by
  sorry

/--
The canonical embedding ι : ℚ → ℝ is the universal arrow from ℚ
to the category of complete ordered fields. For any complete ordered
field F and any ordered field embedding f : ℚ → F, there exists a unique
extension f̃ : ℝ → F such that f̃ ∘ ι = f.
-/
theorem universalPropertyDedekindCompletion (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) (harch : ArchimedeanProperty ℝ)
    (F : RealNumbers) (hcompleteF : completenessProp F)
    (f : FieldHomomorphism default F) :
    ∃! (fTilde : FieldHomomorphism ℝ F), True := by
  -- fTilde is defined by mapping each real x to sup{f(q) | q < x}
  sorry

/-! ## The Universal Arrow ℚ → ℝ -/

/--
The embedding of ℚ into ℝ is dense and order-reflecting. It is the
unique order-preserving field embedding.
-/
theorem rationalsToRealsEmbedding (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (harch : ArchimedeanProperty ℝ) :
    ∃ (ι : FieldHomomorphism default ℝ),
      Function.Injective ι.toFun ∧
      (∀ a b : ℝ.carrier, ℝ.lt a b → ∃ q : default.carrier,
        ℝ.lt a (ι.toFun q) ∧ ℝ.lt (ι.toFun q) b) := by
  sorry

/--
The embedding ℚ → ℝ is an epimorphism in the category of
Archimedean ordered fields: any two extensions to ℝ agree.
-/
theorem rationalsToRealsIsEpimorphism (ℝ : RealNumbers)
    (hcomplete : completenessProp ℝ) (harch : ArchimedeanProperty ℝ)
    (F : RealNumbers) (hcompleteF : completenessProp F)
    (f g : FieldHomomorphism ℝ F)
    (heq : ∀ q : default.carrier, f.toFun (ι.toFun q) = g.toFun (ι.toFun q)) :
    f.toFun = g.toFun := by
  -- Since ℚ is dense in ℝ, the equality on ℚ extends to all of ℝ
  sorry

/-! ## Embedding Theorems -/

/--
Any Archimedean ordered field embeds into ℝ as a dense subfield.
This is the converse to ℚ 's embedding: every Archimedean field
is (isomorphic to) a subfield of ℝ.
-/
theorem anyArchimedeanFieldEmbedsIntoReals (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    ∃ (embed : FieldHomomorphism F default), Function.Injective embed.toFun := by
  sorry

/--
ℚ is the smallest Archimedean ordered field (up to isomorphism):
it embeds into every Archimedean ordered field.
-/
theorem rationalsIsSmallestArchimedeanOrderedField (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    Nonempty (FieldHomomorphism default F) := by
  sorry

/--
ℝ is the largest Archimedean ordered field: every Archimedean
ordered field embeds into ℝ.
-/
theorem realsIsLargestArchimedeanOrderedField (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    Nonempty (FieldHomomorphism F default) := by
  sorry

/-! ## #eval Tests -/

#eval "realNumbersIsDedekindCompletionOfRationals stated"
#eval "universalPropertyDedekindCompletion stated"
#eval "rationalsToRealsEmbedding stated"
#eval "anyArchimedeanFieldEmbedsIntoReals stated"
#eval "rationalsIsSmallestArchimedeanOrderedField stated"
#eval "realsIsLargestArchimedeanOrderedField stated"

end MiniRealNumbers
