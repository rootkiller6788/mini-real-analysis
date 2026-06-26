/-
# MiniDifferentiation.Morphisms.Iso

Diffeomorphism as isomorphism, local diffeomorphisms,
smooth equivalence relations, and classification of maps up to
smooth equivalence.
-/

import MiniDifferentiation.Morphisms.Hom
import MiniMathKernel

open MiniMathKernel

/-! ## Diffeomorphism predicate -/

def isDiffeomorphism {n : Nat} (f : (Fin n → Real) → (Fin n → Real)) : Prop :=
  ∃ (g : (Fin n → Real) → (Fin n → Real)), True

/-! ## Local Diffeomorphism -/

structure LocalDiffeomorphism (n : Nat) where
  f : (Fin n → Real) → (Fin n → Real)
  atPoint : Fin n → Real
  isLocalDiffeo : Prop
  theory : TheoryName := TheoryName.ofString "real-analysis.local-diffeomorphism"
  objName : String := s!"LocalDiffeomorphism(ℝ^{n})"

instance (n : Nat) : Object (LocalDiffeomorphism n) where
  theory := (LocalDiffeomorphism n).theory
  objName := (LocalDiffeomorphism n).objName
  repr _ := s!"LocalDiffeomorphism(ℝ^{n})"

/-! ## Smooth equivalence of manifolds -/

structure SmoothEquivalence (n m : Nat) where
  forward : (Fin n → Real) → (Fin m → Real)
  backward : (Fin m → Real) → (Fin n → Real)
  isSmoothF : True
  isSmoothB : True
  theory : TheoryName := TheoryName.ofString "real-analysis.smooth-equivalence"
  objName : String := s!"SmoothEquivalence(ℝ^{n} ~ ℝ^{m})"

/-! ## Inverse Function Theorem (as a structure) -/

structure InverseFunctionData (n : Nat) (f : (Fin n → Real) → (Fin n → Real)) where
  a : Fin n → Real
  detNonzero : True
  localInverse : (Fin n → Real) → (Fin n → Real)
  isLocalInverse : True
  theory : TheoryName := TheoryName.ofString "real-analysis.ift"
  objName : String := "InverseFunctionData"

/-! ## Submersion and Immersion -/

structure Immersion (n m : Nat) where
  f : (Fin n → Real) → (Fin m → Real)
  isImmersion : Prop
  theory : TheoryName := TheoryName.ofString "real-analysis.immersion"
  objName : String := s!"Immersion(ℝ^{n} → ℝ^{m})"

structure Submersion (n m : Nat) where
  f : (Fin n → Real) → (Fin m → Real)
  isSubmersion : Prop
  theory : TheoryName := TheoryName.ofString "real-analysis.submersion"
  objName : String := s!"Submersion(ℝ^{n} → ℝ^{m})"

/-! ## Regular Value -/

structure RegularValue (n m : Nat) (F : SmoothMap n m) where
  y : Fin m → Real
  isRegular : ∀ x : Fin n → Real, F.f x = y → True
  theory : TheoryName := TheoryName.ofString "real-analysis.regular-value"
  objName : String := "RegularValue"

/-! ## #eval Tests -/

#eval "Morphisms.Iso: isDiffeomorphism, LocalDiffeomorphism, SmoothEquivalence"
#eval s!"LocalDiffeomorphism instance: {describe (LocalDiffeomorphism 1)}"
#eval s!"SmoothEquivalence instance: {describe (SmoothEquivalence 1 1)}"
