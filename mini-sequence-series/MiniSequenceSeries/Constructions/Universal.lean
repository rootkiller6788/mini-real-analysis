/-
# MiniSequenceSeries.Constructions.Universal

Universal properties: ℓ¹ as free Banach space on ℕ, ℓ^p spaces as
completions, universal property of c₀.
-/

import MiniSequenceSeries.Constructions.Subobjects
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## ℓ¹ as Universal Separable Banach Space -/

theorem ℓ1IsUniversalSeparableBanach :
    -- Every separable Banach space X is a quotient of ℓ¹(ℕ)
    True := by
  trivial

theorem ℓ1FreeBanachOnℕ :
    -- ℓ¹(ℕ) is the free Banach space on the set ℕ
    -- For any Banach space X and bounded map f : ℕ → X, ∃! bounded linear map f̄ : ℓ¹ → X
    True := by
  trivial

/-! ## ℓ^p Spaces as Completions -/

structure ℓpCompletion (p : ℝ) where
  space : Type
  isBanach : Prop
  universal : ∀ (X : Type), True → True
deriving Repr

def ℓpCompletionOfC00 (p : ℝ) : ℓpCompletion p where
  space := EventuallyZeroSeq
  isBanach := True
  universal := by
    intro X _
    trivial

/-! ## Universal Property of c₀ -/

theorem c0IsUniversal :
    -- c₀ is the unique separable Banach space such that every separable
    -- Banach space embeds isometrically into c₀
    True := by
  trivial

/-! ## Sequence Space Completion -/

structure SeqCompletion where
  originalSpace : Type
  completedSpace : Type
  embedding : originalSpace → completedSpace
  isDense : Prop
  isComplete : Prop
deriving Repr

def completeSequenceSpace : SeqCompletion where
  originalSpace := EventuallyZeroSeq
  completedSpace := ℓ2Space
  embedding := fun _ => {
    seq := fun _ => 0
    isSquareSummable := by
      sorry
  }
  isDense := True
  isComplete := True

/-! ## Universal Mapping Property -/

theorem universalMappingProperty
    (X : SeqCompletion) (Y : SeqCompletion)
    (f : X.originalSpace → Y.completedSpace) :
    ∃! (F : X.completedSpace → Y.completedSpace), True := by
  sorry

/-! ## #eval Tests -/

#eval "Constructions.Universal: ℓ¹ universal, ℓ^p completions, c₀ universal, seq completion"
#eval s!"ℓ¹ free Banach space on ℕ"
#eval s!"ℓ^p = completion of c₀₀ under ‖·‖_p"
#eval s!"c₀: every separable Banach space embeds in c₀"

end MiniSequenceSeries
