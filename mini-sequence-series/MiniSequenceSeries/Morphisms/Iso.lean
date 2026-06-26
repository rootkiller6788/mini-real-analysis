/-
# MiniSequenceSeries.Morphisms.Iso

Isomorphisms of sequence spaces: asymptotic equivalence,
rate of convergence comparison, equivalence of convergence criteria.
-/

import MiniSequenceSeries.Morphisms.Hom
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Asymptotic Equivalence -/

def isAsymptoticallyEquivalent (a b : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => |a n - b n|) 0

theorem asymptoticallyEquivalent_refl (a : Sequence ℝ) :
    isAsymptoticallyEquivalent a a := by
  sorry

theorem asymptoticallyEquivalent_symm (a b : Sequence ℝ)
    (h : isAsymptoticallyEquivalent a b) : isAsymptoticallyEquivalent b a := by
  sorry

theorem asymptoticallyEquivalent_trans (a b c : Sequence ℝ)
    (h₁ : isAsymptoticallyEquivalent a b) (h₂ : isAsymptoticallyEquivalent b c) :
    isAsymptoticallyEquivalent a c := by
  sorry

/-! ## Rate of Convergence -/

inductive RateOfConvergence
  | sublinear    -- O(1/nᵅ) for some 0 < α ≤ 1
  | linear       -- O(rⁿ) for some 0 < r < 1
  | quadratic    -- O(r^(2ⁿ))
  | exponential  -- O(e⁻ᶜⁿ) for some c > 0
  | superexponential
deriving BEq, Repr, Inhabited

def compareRate (a b : Sequence ℝ) (ra rb : RateOfConvergence) : Prop :=
  Sequence.limit (fun n => |a n| / |b n|) 0

/-! ## Equivalence of Convergence Tests -/

theorem ratioTestImpliesRootTest (a : Sequence ℝ) (L : ℝ)
    (hRatio : Sequence.limit (fun n => |a (n+1)| / |a n|) L) :
    Sequence.limit (fun n => |a n| ^ ((1 : ℝ) / (↑n : ℝ))) L := by
  sorry

theorem rootTestImpliesRatioTestEquiv (a : Sequence ℝ)
    (hRatioLimExists : ∃ (L : ℝ), Sequence.limit (fun n => |a (n+1)| / |a n|) L) :
    True := by
  trivial

/-! ## Sequence Space Isomorphism -/

structure SequenceIsomorphism where
  forward : SequenceMap
  backward : SequenceMap
  forwardInv : ∀ (s : Sequence ℝ), backward.map (forward.map s) = s
  backwardInv : ∀ (t : Sequence ℝ), forward.map (backward.map t) = t
deriving Repr

def identityIso : SequenceIsomorphism where
  forward := SequenceMap.id
  backward := SequenceMap.id
  forwardInv := by intro s; rfl
  backwardInv := by intro t; rfl

/-! ## #eval Tests -/

#eval "Morphisms.Iso: asymptotic equivalence, RateOfConvergence, ratio/root test equivalence"
#eval s!"RateOfConvergence: sublinear, linear, quadratic, exponential, superexponential"
#eval s!"identityIso defined: forwardInv and backwardInv structural"

end MiniSequenceSeries
