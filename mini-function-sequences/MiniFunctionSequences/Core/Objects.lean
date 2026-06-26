/-
# Core: Objects

Defines `FunctionSequence` as a mathematical object, the
`UniformLimitSpace` metric space under the sup norm, and
the Object typeclass instance.
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## FunctionSequence as Object -/

/-- A function sequence as a structured object. -/
structure FunctionSequence (α : Type u) where
  terms : SequenceOfFunctions α
  domain : Set α
  target : α → ℝ := λ _ => 0
  isBoundedSeq : Prop := True
  deriving Inhabited

/-- Object instance for FunctionSequence. -/
instance (α : Type u) : MiniObjectKernel.Object (FunctionSequence α) where
  theory := MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"
  objName := "FunctionSequence"
  repr fs := s!"FunctionSequence({fs.terms} → {fs.target})"

/-- The trivial zero sequence. -/
def FunctionSequence.zero (α : Type u) : FunctionSequence α :=
  { terms := λ _ _ => 0
    domain := Set.univ
    isBoundedSeq := True }

#eval MiniObjectKernel.describe (FunctionSequence ℕ)

/-! ## Uniform Limit Space -/

/-- The space of bounded functions under the sup norm, forming a metric space. -/
def UniformLimitSpace (α : Type u) : Type u :=
  { f : α → ℝ // isBounded f }

/-- Metric on the uniform limit space via sup norm. -/
noncomputable def UniformLimitSpace.metric (α : Type u) : UniformLimitSpace α → UniformLimitSpace α → ℝ :=
  λ f g => supNorm (λ x => (f.1 x) - (g.1 x))

/-- Distance in the uniform limit space. -/
noncomputable def UniformLimitSpace.dist (f g : UniformLimitSpace α) : ℝ :=
  supNorm (λ x => |f.1 x - g.1 x|)

/-! ## Convergence in the Uniform Limit Space -/

/-- A sequence in the UniformLimitSpace converges iff its terms converge uniformly. -/
theorem uniformLimitSpaceConvergence_iff_uniformConvergence
    {α : Type} (fs : Nat → UniformLimitSpace α) (f : UniformLimitSpace α) :
    (Filter.Tendsto fs Filter.atTop (𝓝 f)) ↔
    uniformlyConvergesOnAll (λ n => (fs n).1) f.1 := by
  sorry

/-! ## Tests -/

#eval "--- Core.Objects tests ---"

/-- Construct a function sequence object. -/
def mySeq : FunctionSequence ℝ :=
  { terms := λ n x => x / (n+1 : ℝ)
    domain := Set.univ }

#eval mySeq.terms 0 1.0  -- 1.0
#eval mySeq.terms 9 1.0  -- 0.1

/-- Uniform limit space for constant-zero functions. -/
def zeroBounded : UniformLimitSpace ℝ := ⟨λ _ => (0 : ℝ), by
  refine ⟨1, λ x => ?_⟩; simp⟩

#eval zeroBounded.1 42.0  -- 0.0

end MiniFunctionSequences
