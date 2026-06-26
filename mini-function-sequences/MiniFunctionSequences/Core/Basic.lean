/-
# Core: Basic Definitions

Defines `SequenceOfFunctions`, convergence modes, equicontinuity,
supremum norm, and pointwise/uniform limits.
-/

import MiniObjectKernel.Core.Basic

namespace MiniFunctionSequences

/-! ## Sequence of Functions -/

/-- A sequence of functions from α to ℝ, indexed by natural numbers. -/
abbrev SequenceOfFunctions (α : Type u) : Type u := Nat → (α → ℝ)

/-- The n-th term of a function sequence. -/
def SequenceOfFunctions.at (f_n : SequenceOfFunctions α) (n : Nat) (x : α) : ℝ := f_n n x

/-- Apply a sequence of functions to a point x, obtaining a sequence of real numbers. -/
def SequenceOfFunctions.eval (f_n : SequenceOfFunctions α) (x : α) : Nat → ℝ :=
  λ n => f_n n x

/-! ## Pointwise Convergence -/

/-- `f_n` converges pointwise to `f` if for every `x`, the real sequence `f_n(x) → f(x)`. -/
def pointwiseConverges (f_n : SequenceOfFunctions α) (f : α → ℝ) : Prop :=
  ∀ x : α, ∀ ε > 0, ∃ N : Nat, ∀ n ≥ N, |f_n n x - f x| < ε

/-- The pointwise limit of a sequence of functions. -/
noncomputable def PointwiseLimit (f_n : SequenceOfFunctions α) (x : α) : ℝ :=
  liminf (λ n => f_n n x) atTop

/-! ## Uniform Convergence -/

/-- `f_n` converges uniformly to `f` on a set `A` if the convergence rate is independent of `x ∈ A`. -/
def uniformlyConverges (f_n : SequenceOfFunctions α) (f : α → ℝ) (A : Set α) : Prop :=
  ∀ ε > 0, ∃ N : Nat, ∀ n ≥ N, ∀ x ∈ A, |f_n n x - f x| < ε

/-- Uniform convergence on the whole domain. -/
def uniformlyConvergesOnAll (f_n : SequenceOfFunctions α) (f : α → ℝ) : Prop :=
  ∀ ε > 0, ∃ N : Nat, ∀ n ≥ N, ∀ x : α, |f_n n x - f x| < ε

/-- The uniform limit of a sequence of functions (when it exists). -/
noncomputable def UniformLimit (f_n : SequenceOfFunctions α) : α → ℝ :=
  λ x => PointwiseLimit f_n x

/-! ## Uniform Cauchy Condition -/

/-- A sequence is uniformly Cauchy on a set `A` if the Cauchy condition holds uniformly for `x ∈ A`. -/
def uniformlyCauchy (f_n : SequenceOfFunctions α) (A : Set α) : Prop :=
  ∀ ε > 0, ∃ N : Nat, ∀ m n ≥ N, ∀ x ∈ A, |f_n m x - f_n n x| < ε

/-! ## Locally Uniform Convergence -/

/-- Locally uniform convergence: uniform convergence on each compact subset. -/
def locallyUniformlyConverges [TopologicalSpace α] (f_n : SequenceOfFunctions α) (f : α → ℝ) : Prop :=
  ∀ (K : Set α), IsCompact K → uniformlyConverges f_n f K

/-! ## Equicontinuity -/

/-- A family `F` of functions is equicontinuous at `x₀` if all functions share a common modulus of continuity. -/
def isEquicontinuousAt [TopologicalSpace α] (F : Set (α → ℝ)) (x₀ : α) : Prop :=
  ∀ ε > 0, ∃ U ∈ 𝓝 x₀, ∀ f ∈ F, ∀ x ∈ U, |f x - f x₀| < ε

/-- A family is equicontinuous if it is equicontinuous at every point. -/
def isEquicontinuous [TopologicalSpace α] (F : Set (α → ℝ)) : Prop :=
  ∀ x₀ : α, isEquicontinuousAt F x₀

/-- Uniform equicontinuity: a single δ works for all points. Requires a uniform space structure. -/
def isUniformlyEquicontinuous [PseudoMetricSpace α] (F : Set (α → ℝ)) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ f ∈ F, ∀ x y : α, dist x y < δ → |f x - f y| < ε

/-! ## Supremum Norm -/

/-- The supremum norm (uniform norm) of a bounded function. -/
noncomputable def supNorm (f : α → ℝ) : ℝ :=
  sSup { |f x| | x : α }

/-- Bounded function: a function with finite sup norm. -/
def isBounded (f : α → ℝ) : Prop :=
  ∃ M : ℝ, ∀ x : α, |f x| ≤ M

/-- The sup norm on a specific set. -/
noncomputable def supNormOn (f : α → ℝ) (A : Set α) : ℝ :=
  sSup { |f x| | x ∈ A }

/-! ## Tests -/

#eval "--- Core.Basic tests ---"

/-- p_n(x) = x^n on [0,1] — sequence of functions -/
def p_n : SequenceOfFunctions ℝ := λ n x => x ^ n

#eval p_n.at 3 0.5   -- 0.125
#eval p_n.at 5 0.5   -- 0.03125
#eval supNormOn (p_n.at 2) (Set.Ioo (0 : ℝ) 1)  -- sup of |x^2| on (0,1) = 1 (approx)

/-- g_n(x) = x / n on ℝ — locally uniform convergence to 0 -/
def g_n : SequenceOfFunctions ℝ := λ n x => x / (n : ℝ)

#eval g_n.at 10 5.0    -- 0.5
#eval g_n.at 100 5.0   -- 0.05

end MiniFunctionSequences
