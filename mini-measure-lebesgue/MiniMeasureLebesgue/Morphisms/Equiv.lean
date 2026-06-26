/-
# Measure Theory: Equivalences of Measures

Absolute continuity, mutual singularity, and equivalence of measures.
These concepts are central to the Radon-Nikodym and Lebesgue decomposition theorems.
-/

import MiniObjectKernel
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Absolute Continuity -/

/--
A measure ν is absolutely continuous with respect to μ (ν << μ) if
μ(A) = 0 implies ν(A) = 0 for all measurable A.
-/
def absolutelyContinuous {X : Type u} {ms : MeasurableSpace X}
    (ν : Measure X ms) (μ : Measure X ms) : Prop :=
  ∀ (A : Set X), isMeasurable ms A → μ.value A = RealNumbers.zero → ν.value A = RealNumbers.zero

/-- Notation: ν << μ. -/
notation:50 ν:max " ≪ " μ:max => absolutelyContinuous ν μ

/-- Absolute continuity is reflexive. -/
theorem absolutelyContinuous_refl {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) :
    μ ≪ μ := by
  intro A hA hμzero
  exact hμzero

/-- Absolute continuity is transitive. -/
theorem absolutelyContinuous_trans {X : Type u} {ms : MeasurableSpace X}
    (ρ ν μ : Measure X ms) (h1 : ρ ≪ ν) (h2 : ν ≪ μ) : ρ ≪ μ := by
  intro A hA hμzero
  apply h1 A hA
  apply h2 A hA
  exact hμzero

/-! ## Mutual Singularity -/

/--
Two measures μ and ν are mutually singular (μ ⟂ ν) if there exist
disjoint measurable sets A, B such that μ is concentrated on A and ν on B.
-/
def mutuallySingular {X : Type u} {ms : MeasurableSpace X}
    (μ ν : Measure X ms) : Prop :=
  ∃ (A B : Set X), isMeasurable ms A ∧ isMeasurable ms B ∧
    A ∩ B = ∅ ∧
    (∀ C, isMeasurable ms C → μ.value (C ∩ B) = RealNumbers.zero) ∧
    (∀ C, isMeasurable ms C → ν.value (C ∩ A) = RealNumbers.zero)

/-- Notation: μ ⟂ ν. -/
notation:50 μ:max " ⟂ " ν:max => mutuallySingular μ ν

/-- Mutual singularity is symmetric. -/
theorem mutuallySingular_symm {X : Type u} {ms : MeasurableSpace X} (μ ν : Measure X ms)
    (h : μ ⟂ ν) : ν ⟂ μ := by
  rcases h with ⟨A, B, hA, hB, hdisj, hμ, hν⟩
  exact ⟨B, A, hB, hA, by
    rw [Set.inter_comm]; exact hdisj, hν, hμ⟩

/-! ## Equivalent Measures -/

/--
Two measures μ and ν are equivalent if they are mutually absolutely continuous
(μ ≪ ν and ν ≪ μ). Equivalent measures have the same null sets.
-/
def equivalentMeasures {X : Type u} {ms : MeasurableSpace X} (μ ν : Measure X ms) : Prop :=
  μ ≪ ν ∧ ν ≪ μ

/-- Notation: μ ≈ ν. -/
notation:50 μ:max " ≈ " ν:max => equivalentMeasures μ ν

/-- Equivalence of measures is an equivalence relation. -/
theorem equivalentMeasures_refl {X : Type u} {ms : MeasurableSpace X} (μ : Measure X ms) : μ ≈ μ :=
  ⟨absolutelyContinuous_refl μ, absolutelyContinuous_refl μ⟩

theorem equivalentMeasures_symm {X : Type u} {ms : MeasurableSpace X} (μ ν : Measure X ms)
    (h : μ ≈ ν) : ν ≈ μ :=
  ⟨h.2, h.1⟩

theorem equivalentMeasures_trans {X : Type u} {ms : MeasurableSpace X} (μ ν ρ : Measure X ms)
    (hμν : μ ≈ ν) (hνρ : ν ≈ ρ) : μ ≈ ρ :=
  ⟨absolutelyContinuous_trans μ ν ρ hμν.1 hνρ.1,
   absolutelyContinuous_trans ρ ν μ hνρ.2 hμν.2⟩

/-! ## #eval Tests -/

#eval "ν ≪ μ: absolute continuity"
#eval "μ ⟂ ν: mutual singularity"
#eval "μ ≈ ν: equivalent measures (reflexive, symmetric, transitive)"

def sampleAbsCont : Prop :=
  (default : Measure Nat (default : MeasurableSpace Nat)) ≪
  (default : Measure Nat (default : MeasurableSpace Nat))
#eval "absolutelyContinuous holds for identical measures (reflexive)"

def sampleSing : Prop :=
  (default : Measure Nat (default : MeasurableSpace Nat)) ⟂
  (default : Measure Nat (default : MeasurableSpace Nat))
#eval "mutual singularity query (depends on actual measures)"

end MiniMeasureLebesgue
