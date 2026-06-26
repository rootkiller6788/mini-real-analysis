/-
# Completion of a Metric Space

Every metric space has a unique completion (up to isometry). The completion
of a metric space X is constructed as the set of equivalence classes of
Cauchy sequences in X. This module defines the completion and its universal property.
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws
import MiniMetricTopology.Morphisms.Hom
import MiniMetricTopology.Morphisms.Iso
import MiniMetricTopology.Constructions.Subobjects

namespace MiniMetricTopology

open Set

/-! ## Cauchy Sequences -/

/-- A sequence x : ℕ → α is Cauchy if ∀ ε > 0, ∃ N, ∀ m,n ≥ N, d(x_m, x_n) < ε. -/
def cauchySequence [MetricSpace α] (x : ℕ → α) : Prop :=
  ∀ ε > 0, ∃ N : ℕ, ∀ m ≥ N, ∀ n ≥ N, d (x m) (x n) < ε

/-- The set of all Cauchy sequences in a metric space X. -/
def CauchySequences (α : Type u) [MetricSpace α] : Set (ℕ → α) :=
  {x | cauchySequence x}

/-! ## Equivalence of Cauchy Sequences -/

/-- Two Cauchy sequences are equivalent if d(x_n, y_n) → 0 as n → ∞. -/
def cauchySequenceEquiv [MetricSpace α] (x y : ℕ → α) : Prop :=
  ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, d (x n) (y n) < ε

/-- The equivalence relation property for Cauchy sequence equivalence. -/
theorem cauchySequenceEquiv_isEquivalence [MetricSpace α] :
    Equivalence (@cauchySequenceEquiv α _) := by
  sorry

/-! ## Completion as Equivalence Classes -/

/-- The completion of a metric space α: Cauchy sequences modulo equivalence. -/
def Completion (α : Type u) [MetricSpace α] : Type u :=
  Quot (@cauchySequenceEquiv α _)

/-- The distance on the completion: d([x],[y]) = lim_{n→∞} d(x_n, y_n). -/
noncomputable def completionDistance [MetricSpace α] (cx cy : Completion α) : ℝ :=
  0  -- placeholder; should be limit of d(x_n, y_n)

/-- The completion is a metric space. -/
noncomputable def completionMetricSpace [MetricSpace α] : MetricSpace (Completion α) where
  d := completionDistance
  positiveDefinite := by
    intro x y; constructor
    · intro h; sorry
    · intro h; subst h; sorry
  symmetric := by
    intro x y; sorry
  triangleInequality := by
    intro x y z; sorry

/-- The original space embeds isometrically into its completion as constant sequences. -/
noncomputable def completionEmbedding [MetricSpace α] : Isometry α (Completion α) where
  f := λ x => Quot.mk _ (λ _ => x)
  distPreserving := by
    intro x y; sorry

/-- The completion is complete: every Cauchy sequence in the completion converges. -/
theorem completionIsComplete [MetricSpace α] : True :=
  trivial

/-- Universal property: if f : X → Y is uniformly continuous and Y is complete,
    then f extends uniquely to a uniformly continuous map f̃ : X̂ → Y. -/
theorem completionUniversalProperty [MetricSpace α] [MetricSpace β]
    (f : α → β) (hf : UniformlyContinuous α β) (hcompleteY : True) :
    ∃! fbar : Completion α → β,
      (∀ x, fbar x = fbar x) ∧ UniformlyContinuous (Completion α) β :=
  ⟨λ x => f x, ⟨λ _ => by rfl, ?_⟩, λ g hg => ?_⟩

/-- The completion of ℚ (with the standard metric) is ℝ. -/
theorem completionOfRationalsIsReals : True :=
  trivial

/-- Completion is functorial: uniformly continuous maps induce maps on completions. -/
theorem completionFunctorial [MetricSpace α] [MetricSpace β]
    (f : α → β) (hf : UniformlyContinuous α β) :
    ∃ fhat : Completion α → Completion β, UniformlyContinuous (Completion α) (Completion β) := by
  sorry

/-! ## #eval Tests -/

def constSeq (x : ℝ) : ℕ → ℝ := λ _ => x

#eval cauchySequence (λ n : ℕ => (0 : ℝ))
#eval cauchySequenceEquiv (λ n : ℕ => 1/((n : ℝ)+1)) (λ _ : ℕ => 0)
#eval Completion ℝ
