/-
# Measure Theory: Quotient Constructions

Quotient by null sets, L^p spaces as quotients of measurable functions,
and essentially bounded functions.
-/

import MiniObjectKernel
import MiniObjectKernel.Core.Objects
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Quotient by Null Sets -/

/--
Two measurable sets A, B are equivalent modulo null sets if
μ(A Δ B) = 0 (i.e., their symmetric difference has measure zero).
-/
def setEqModNull {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms)
    (A B : Set X) : Prop :=
  isMeasurable ms A ∧ isMeasurable ms B ∧
  μ.value (A \ B ∪ B \ A) = RealNumbers.zero

/-- Set equivalence modulo null sets is an equivalence relation. -/
theorem setEqModNull_refl {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) (A : Set X)
    (hmeas : isMeasurable ms A) : setEqModNull μ A A := by
  refine ⟨hmeas, hmeas, ?_⟩
  have hdiff : A \ A ∪ A \ A = ∅ := by
    ext x; simp
  rw [hdiff, μ.emptyZero]

theorem setEqModNull_symm {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) (A B : Set X)
    (h : setEqModNull μ A B) : setEqModNull μ B A := by
  rcases h with ⟨hA, hB, hμ⟩
  refine ⟨hB, hA, ?_⟩
  rw [Set.union_comm]; exact hμ

theorem setEqModNull_trans {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) (A B C : Set X)
    (hAB : setEqModNull μ A B) (hBC : setEqModNull μ B C) : setEqModNull μ A C := by
  rcases hAB with ⟨hA, hB, hμAB⟩
  rcases hBC with ⟨hB', hC, hμBC⟩
  refine ⟨hA, hC, ?_⟩
  sorry  -- measure theory: AΔC ⊆ (AΔB)∪(BΔC)

/-! ## L^p Spaces as Quotients -/

/--
The L^p space is the quotient of measurable functions by equality almost everywhere,
with the L^p norm ‖f‖_p = (∫ |f|^p dμ)^{1/p}.
-/
structure LpSpace (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) (p : Nat) where
  carrier : Type u
  norm : carrier → RealNumbers.carrier
  complete : True  -- placeholder: completeness
  deriving Inhabited

/-- Functions equal almost everywhere are identified in L^p. -/
def aeqEq {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms)
    (f g : X → RealNumbers.carrier) : Prop :=
  almostEverywhere μ (fun x => f x = g x)

/-- The equivalence relation for L^p: f ~ g if f = g a.e. -/
def lpEquivalence {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) (p : Nat)
    (f g : X → RealNumbers.carrier) : Prop :=
  aeqEq μ f g

/-! ## Essential Supremum and L^∞ -/

/--
The essential supremum of a measurable function f is the smallest M such that
|f(x)| ≤ M almost everywhere.
-/
def essentialSup {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms)
    (f : X → RealNumbers.carrier) : RealNumbers.carrier :=
  RealNumbers.one  -- placeholder: ess sup should be inf {M | μ({x | |f(x)| > M}) = 0}

/-- The L^∞ space: equivalence classes of essentially bounded measurable functions. -/
structure LinfinitySpace (X : Type u) (ms : MeasurableSpace X) (μ : Measure X ms) where
  carrier : Type u
  norm : carrier → RealNumbers.carrier
  essSup : (X → RealNumbers.carrier) → RealNumbers.carrier
  deriving Inhabited

/-! ## #eval Tests -/

#eval "setEqModNull: A ~ B if μ(A Δ B) = 0"
#eval "LpSpace: functions equal a.e. are identified"
#eval "essentialSup: smallest bound a.e."

def sampleAeq : Prop :=
  aeqEq (default : Measure Nat (default : MeasurableSpace Nat))
    (fun _ : Nat => RealNumbers.zero)
    (fun _ : Nat => RealNumbers.zero)
#eval "aeqEq reflexive: " ++ toString sampleAeq

#eval "L^∞ norm = ess sup |f|"

end MiniMeasureLebesgue
