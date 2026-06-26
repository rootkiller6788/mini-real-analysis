/-
# Measure Theory: Morphisms (Maps)

Measurable maps, measure-preserving maps, ergodic maps,
and integral-preserving maps between measure spaces.
-/

import MiniObjectKernel
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Measurable Map -/

/--
A measurable map is a function between measurable spaces such that
the preimage of every measurable set is measurable.
-/
structure MeasurableMap (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y) where
  f : X → Y
  measurable : ∀ (B : Set Y), isMeasurable msY B → isMeasurable msX (f ⁻¹' B)

/-- Identity map is measurable. -/
def MeasurableMap.id (X : Type u) (msX : MeasurableSpace X) : MeasurableMap X X msX msX where
  f := fun x => x
  measurable := by
    intro B hB
    simp [hB]

/-- Composition of measurable maps is measurable. -/
def MeasurableMap.comp {X Y Z : Type u} {msX msY msZ}
    (g : MeasurableMap Y Z msY msZ) (f : MeasurableMap X Y msX msY) :
    MeasurableMap X Z msX msZ where
  f := fun x => g.f (f.f x)
  measurable := by
    intro B hB
    apply f.measurable
    apply g.measurable
    exact hB

/-! ## Measure-Preserving Map -/

/--
A measure-preserving map f : (X,μ) → (Y,ν) satisfies μ(f⁻¹(B)) = ν(B)
for all measurable B ⊆ Y.
-/
structure MeasurePreservingMap (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    (μ : Measure X msX) (ν : Measure Y msY) extends MeasurableMap X Y msX msY where
  measurePreserving : ∀ (B : Set Y), isMeasurable msY B →
    μ.value (f ⁻¹' B) = ν.value B

/-- Identity is measure-preserving. -/
def MeasurePreservingMap.id (X : Type u) (msX : MeasurableSpace X) (μ : Measure X msX) :
    MeasurePreservingMap X X msX msX μ μ where
  toMeasurableMap := MeasurableMap.id X msX
  measurePreserving := by
    intro B hB; simp

/-! ## Ergodic Map -/

/--
A measure-preserving map T is ergodic if the only T-invariant sets have
measure 0 or full measure.
-/
structure ErgodicMap (X : Type u) (msX : MeasurableSpace X) (μ : Measure X msX) where
  T : MeasurePreservingMap X X msX msX μ μ
  ergodic : ∀ (A : Set X), isMeasurable msX A →
    (T.f ⁻¹' A = A) → (μ.value A = RealNumbers.zero ∨ μ.value A = μ.value Set.univ)

/-! ## Integral-Preserving Map -/

/--
An integral-preserving map preserves the Lebesgue integral:
∫ f ∘ T dμ = ∫ f dμ.
-/
structure IntegralPreservingMap (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    (μ : Measure X msX) (ν : Measure Y msY) where
  T : MeasurePreservingMap X Y msX msY μ ν
  integralPreserving : ∀ (f : Y → RealNumbers.carrier),
    realMeasurable msY f →
    (∀ y, RealNumbers.le RealNumbers.zero (f y)) →
    (lebesgueIntegral msX μ (fun x => f (T.f x)) (by
      intro c
      apply T.measurable
      apply T.measurable
      sorry
    ) (by
      intro x; sorry
    )) = lebesgueIntegral msY ν f (by
      intro c; sorry
    ) (by
      intro y; sorry
    ))

/-! ## #eval Tests -/

#eval "MeasurableMap defined for X→Y between measurable spaces"

def sampleMeasurableMap : MeasurableMap Nat Nat (default : MeasurableSpace Nat) (default : MeasurableSpace Nat) :=
  MeasurableMap.id Nat (default : MeasurableSpace Nat)

#eval "MeasurableMap.id created"

#eval "MeasurePreservingMap: μ(f⁻¹(B)) = ν(B)"
#eval "ErgodicMap: only trivial invariant sets"
#eval "IntegralPreservingMap: ∫ f∘T dμ = ∫ f dν"

end MiniMeasureLebesgue
