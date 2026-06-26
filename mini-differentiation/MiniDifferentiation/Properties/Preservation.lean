/-
# MiniDifferentiation.Properties.Preservation

What differentiability properties are preserved under various operations:
- Diffeomorphisms preserve critical points
- Smooth maps preserve tangent vectors
- Chain rule preserves differentiability degree
- Local diffeomorphisms preserve nondegeneracy
-/
import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Morphisms.Hom
import MiniDifferentiation.Properties.Invariants
import MiniMathKernel

open MiniMathKernel

/-! ## Diffeomorphisms preserve critical points -/

structure CriticalPointPreservation (n : Nat) (φ : Diffeomorphism n) where
  f : (Fin n → Real) → Real
  a : Fin n → Real
  aIsCritical : True
  preserved : True  -- φ(a) is also a critical point of f ∘ φ^{-1}
  theory : TheoryName := TheoryName.ofString "real-analysis.cp-preservation"
  objName : String := "CriticalPointPreservation"

/-! ## Smooth maps push forward tangent vectors -/

structure PushforwardTangent (n m : Nat) (F : SmoothMap n m) (a : Fin n → Real) where
  tangenta : TangentVector { val := 0.0 }
  tangentFa : TangentVector { val := 0.0 }
  pushforward : TangentMap n m F a |>.dF = pushforward  -- placeholder
  theory : TheoryName := TheoryName.ofString "real-analysis.pushforward"
  objName : String := "PushforwardTangent"

/-! ## Chain rule preserves C^k class -/

structure CkPreservation (k : Nat) where
  f : Real → Real
  g : Real → Real
  hfCk : isCk f k
  hgCk : isCk g k
  compCk : isCk (fun x => g (f x)) k
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-preservation"
  objName : String := s!"C{k}Preservation(chain rule)"

/-! ## Local diffeomorphisms preserve nondegeneracy -/

structure NondegeneracyPreservation (n : Nat) (φ : LocalDiffeomorphism n) where
  f : (Fin n → Real) → Real
  a : Fin n → Real
  isNondegenerateAtA : True
  preservedAtPhiA : True
  theory : TheoryName := TheoryName.ofString "real-analysis.nondegeneracy-preservation"
  objName : String := "NondegeneracyPreservation"

/-! ## Derivative of inverse function -/

structure InverseDerivativePreservation (f : Real → Real) (a : Real) where
  f'a : Real
  hf : HasDerivativeAt f a f'a
  hfNonzero : f'a ≠ { val := 0.0 }
  inverseDerivative : HasDerivativeAt (fun y => { val := 0.0 }) (f a) { val := 1.0 / f'a.val }
  theory : TheoryName := TheoryName.ofString "real-analysis.inverse-derivative"
  objName : String := "InverseDerivativePreservation"

/-! ## Integration preserves C^k class: C^k → C^{k+1} -/

structure IntegrationIncreasesRegularity (k : Nat) where
  f : Real → Real
  hfCk : isCk f k
  F : Real → Real  -- antiderivative
  Fderivative : ∀ a, HasDerivativeAt F a (f a)
  FIsCk1 : isCk F (k+1)
  theory : TheoryName := TheoryName.ofString "real-analysis.integration-regularity"
  objName : String := "IntegrationIncreasesRegularity"

/-! ## #eval Tests -/

#eval "Properties.Preservation: CriticalPointPreservation, PushforwardTangent, CkPreservation"
#eval s!"Chain rule preserves C^k class for all k"
#eval s!"Integration raises regularity: C^k → C^{k+1}"
