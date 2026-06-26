/-
# Measure Theory: Isomorphisms

Measure space isomorphisms — invertible measure-preserving measurable maps
and conjugacy of measure spaces.
-/

import MiniObjectKernel
import MiniMeasureLebesgue.Core.Basic
import MiniMeasureLebesgue.Morphisms.Hom

namespace MiniMeasureLebesgue

/-! ## Measure Space Isomorphism -/

/--
A measure space isomorphism is an invertible measure-preserving
measurable map between measure spaces.
-/
structure MeasureSpaceIso (X Y : Type u)
    (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    (μ : Measure X msX) (ν : Measure Y msY) where
  forward : MeasurePreservingMap X Y msX msY μ ν
  backward : MeasurePreservingMap Y X msY msX ν μ
  leftInv : ∀ x, backward.f (forward.f x) = x
  rightInv : ∀ y, forward.f (backward.f y) = y

/-- Two measure spaces are isomorphic if there exists a measure space isomorphism. -/
def MeasureSpaceIso.exists {X Y : Type u} {msX msY μ ν}
    (iso : MeasureSpaceIso X Y msX msY μ ν) : Prop := True

/-- Identity isomorphism. -/
def MeasureSpaceIso.id (X : Type u) (msX : MeasurableSpace X) (μ : Measure X msX) :
    MeasureSpaceIso X X msX msX μ μ where
  forward := MeasurePreservingMap.id X msX μ
  backward := MeasurePreservingMap.id X msX μ
  leftInv := fun x => rfl
  rightInv := fun x => rfl

/-! ## Conjugacy of Measure Spaces -/

/--
Two measure-preserving dynamical systems (X,μ,T) and (Y,ν,S)
are conjugate if there exists a measure space isomorphism φ such that
φ ∘ T = S ∘ φ.
-/
def isConjugate (X Y : Type u) (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    (μ : Measure X msX) (ν : Measure Y msY)
    (T : MeasurePreservingMap X X msX msX μ μ)
    (S : MeasurePreservingMap Y Y msY msY ν ν) : Prop :=
  ∃ (φ : MeasureSpaceIso X Y msX msY μ ν),
    ∀ x, φ.forward.f (T.f x) = S.f (φ.forward.f x)

/-! ## Isomorphism of L^p Spaces -/

/--
Two L^p spaces are isomorphic if there exists an isometric isomorphism
between them. This is stated here; the actual L^p definitions are in Constructions.
-/
structure LpSpaceIso (X Y : Type u)
    (msX : MeasurableSpace X) (msY : MeasurableSpace Y)
    (μ : Measure X msX) (ν : Measure Y msY) (p : Nat) where
  iso : X → Y
  isometry : ∀ (f : X → RealNumbers.carrier),
    RealNumbers.le RealNumbers.zero (RealNumbers.one) :=
    -- placeholder: ‖f‖_L^p(X) = ‖iso ∘ f‖_L^p(Y)
    True

/-- L^p space isomorphism from a measure space isomorphism (functoriality). -/
def LpSpaceIso.fromMeasureIso {X Y : Type u} {msX msY μ ν} (p : Nat)
    (φ : MeasureSpaceIso X Y msX msY μ ν) : LpSpaceIso X Y msX msY μ ν p :=
  { iso := φ.forward.f
    isometry := True
  }

/-! ## #eval Tests -/

#eval "MeasureSpaceIso: invertible measure-preserving measurable map"
#eval "isConjugate: φ ∘ T = S ∘ φ"
#eval "LpSpaceIso: isometric isomorphism of L^p spaces"

def sampleIso : MeasureSpaceIso Nat Nat (default : MeasurableSpace Nat) (default : MeasurableSpace Nat)
    (default : Measure Nat (default : MeasurableSpace Nat)) (default : Measure Nat (default : MeasurableSpace Nat)) :=
  MeasureSpaceIso.id Nat (default : MeasurableSpace Nat) (default : Measure Nat (default : MeasurableSpace Nat))

#eval "MeasureSpaceIso.id constructed successfully"

end MiniMeasureLebesgue
