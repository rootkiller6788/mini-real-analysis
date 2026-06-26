/-
# Real Numbers: Universal Constructions

Defines the universal property of ℝ as the unique complete ordered field,
initial/terminal objects in the category, and the embedding of ℚ into
any complete ordered field.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Morphisms.Iso

namespace MiniRealNumbers

/-! ## Universal Property of ℝ -/

/--
The universal property: any Archimedean ordered field embeds into ℝ
via a unique order-preserving field homomorphism.
-/
theorem universalPropertyOfRealNumbers (F : RealNumbers) (harch : ArchimedeanProperty F) :
    ∃! (φ : FieldHomomorphism F default), True := by
  sorry

/--
ℝ is the unique (up to unique isomorphism) complete ordered field.
This is the categorical characterization in the category of Archimedean
ordered fields and order-preserving field homomorphisms.
-/
theorem realNumbersIsTerminalObject (F : RealNumbers)
    (hcompleteF : completenessProp F) (harchF : ArchimedeanProperty F) :
    ∃! (iso : OrderedFieldIso F default), True := by
  -- Uniqueness of complete ordered fields: there is a unique isomorphism
  -- between any two complete Archimedean ordered fields.
  sorry

/-! ## Initial and Terminal Objects -/

/--
In the category of Archimedean ordered fields with field homomorphisms,
ℚ is the initial object and ℝ is the terminal object.
-/
def categoryArchField : String :=
  "Category: Archimedean ordered fields. Initial: ℚ. Terminal: ℝ."

/-- Existence of a unique map from ℚ to any Archimedean ordered field. -/
theorem rationalsInitial (F : RealNumbers) (harch : ArchimedeanProperty F) :
    ∃! (φ : FieldHomomorphism default F), True := by
  sorry

/-- Existence of a unique map from any Archimedean complete ordered field to ℝ. -/
theorem realsTerminal (F : RealNumbers)
    (hcomplete : completenessProp F) (harch : ArchimedeanProperty F) :
    ∃! (φ : FieldHomomorphism F default), True := by
  sorry

/-! ## Embedding of ℚ into Complete Ordered Fields -/

/--
Every complete ordered field contains a unique isomorphic copy of ℚ.
This embedding is constructed by mapping n/1 → n·1 and extending.
-/
theorem rationalsEmbedding (ℝ : RealNumbers) (hcomplete : completenessProp ℝ) :
    ∃ (embed : FieldHomomorphism default ℝ), Function.Injective embed.toFun := by
  sorry

/--
The embedding of ℚ into ℝ is dense: every open interval in ℝ contains
the image of a rational number.
-/
theorem rationalsEmbeddingIsDense (ℝ : RealNumbers) (hcomplete : completenessProp ℝ)
    (harch : ArchimedeanProperty ℝ) (embed : FieldHomomorphism default ℝ)
    (hinj : Function.Injective embed.toFun) :
    ∀ a b : ℝ.carrier, ℝ.lt a b → ∃ q : default.carrier,
      ℝ.lt a (embed.toFun q) ∧ ℝ.lt (embed.toFun q) b := by
  sorry

/-! ## Universal Property of Dedekind Completion -/

/--
The Dedekind completion of an ordered field F is the universal complete
ordered field containing F.
-/
theorem dedekindCompletionUniversal (F : RealNumbers)
    (harch : ArchimedeanProperty F) :
    ∃ (ℝc : RealNumbers) (hcomplete : completenessProp ℝc) (embed : FieldHomomorphism F ℝc),
      (Function.Injective embed.toFun) ∧
      (∀ (G : RealNumbers) (hcompleteG : completenessProp G) (f : FieldHomomorphism F G),
        ∃! (φ : FieldHomomorphism ℝc G), φ.comp embed = f) := by
  sorry

/-! ## #eval Tests -/

#eval "universalPropertyOfRealNumbers stated"
#eval "realNumbersIsTerminalObject stated"
#eval "categoryArchField: " ++ categoryArchField
#eval "rationalsEmbedding stated"
#eval "dedekindCompletionUniversal stated"

end MiniRealNumbers
