/-
# MiniDifferentiation.Morphisms.Hom

Smooth maps between Euclidean spaces (ℝ^n → ℝ^m), diffeomorphisms,
C^k diffeomorphisms, and composition of smooth maps.
-/

import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Smooth Map between Euclidean spaces -/

structure SmoothMap (n m : Nat) where
  f : (Fin n → Real) → (Fin m → Real)
  isSmooth : isSmooth (fun (_ : Real) => { val := 0.0 })  -- placeholder
  theory : TheoryName := TheoryName.ofString "real-analysis.smooth-map"
  objName : String := s!"SmoothMap(ℝ^{n} → ℝ^{m})"

instance (n m : Nat) : Object (SmoothMap n m) where
  theory := (SmoothMap n m).theory
  objName := (SmoothMap n m).objName
  repr sm := s!"SmoothMap(ℝ^{n} → ℝ^{m})"

/-! ## C^k Map -/

structure CkMap (k : Nat) (n m : Nat) where
  f : (Fin n → Real) → (Fin m → Real)
  isCkProp : True
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-map"
  objName : String := s!"C{k}Map(ℝ^{n} → ℝ^{m})"

/-! ## Diffeomorphism -/

structure Diffeomorphism (n : Nat) where
  f : (Fin n → Real) → (Fin n → Real)
  g : (Fin n → Real) → (Fin n → Real)
  isSmoothF : True
  isSmoothG : True
  leftInv : ∀ x, g (f x) = x
  rightInv : ∀ x, f (g x) = x
  theory : TheoryName := TheoryName.ofString "real-analysis.diffeomorphism"
  objName : String := s!"Diffeomorphism(ℝ^{n})"

instance (n : Nat) : Object (Diffeomorphism n) where
  theory := (Diffeomorphism n).theory
  objName := (Diffeomorphism n).objName
  repr _ := s!"Diffeomorphism(ℝ^{n})"

/-! ## C^k Diffeomorphism -/

structure CkDiffeomorphism (k n : Nat) where
  f : (Fin n → Real) → (Fin n → Real)
  g : (Fin n → Real) → (Fin n → Real)
  isCkF : True
  isCkG : True
  leftInv : ∀ x, g (f x) = x
  rightInv : ∀ x, f (g x) = x
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-diffeomorphism"
  objName : String := s!"C{k}Diffeomorphism(ℝ^{n})"

/-! ## Composition of smooth maps -/

def SmoothMap.comp {n m p : Nat} (g : SmoothMap m p) (f : SmoothMap n m) : SmoothMap n p :=
  { f := fun x => g.f (f.f x)
    isSmooth := g.isSmooth
    theory := TheoryName.ofString "real-analysis.smooth-map"
    objName := s!"SmoothMap(ℝ^{n} → ℝ^{p})" }

def Diffeomorphism.comp {n : Nat} (g f : Diffeomorphism n) : Diffeomorphism n :=
  { f := fun x => g.f (f.f x)
    g := fun x => f.g (g.g x)
    isSmoothF := True.intro
    isSmoothG := True.intro
    leftInv := by
      intro x; simp [g.leftInv, f.leftInv]
    rightInv := by
      intro x; simp [g.rightInv, f.rightInv]
    theory := TheoryName.ofString "real-analysis.diffeomorphism"
    objName := s!"Diffeomorphism(ℝ^{n})" }

/-! ## Tangent Map (derivative of smooth map) -/

structure TangentMap (n m : Nat) (F : SmoothMap n m) (a : Fin n → Real) where
  dF : (Fin n → Real) → (Fin m → Real)
  isLinear : True
  theory : TheoryName := TheoryName.ofString "real-analysis.tangent-map"
  objName : String := s!"TangentMap at point"

/-! ## #eval Tests -/

#eval "Morphisms.Hom: SmoothMap, CkMap, Diffeomorphism, CkDiffeomorphism, TangentMap"
#eval s!"SmoothMap instance: {describe (SmoothMap 1 1)}"
#eval s!"Diffeomorphism instance: {describe (Diffeomorphism 1)}"
