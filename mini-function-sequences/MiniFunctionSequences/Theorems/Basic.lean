/-
# Theorems: Basic

The major theorems: Arzela-Ascoli, Stone-Weierstrass (real and complex),
Dini's theorem (full statement), and the Uniform Boundedness Principle.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Core.Laws

namespace MiniFunctionSequences

/-! ## Arzela-Ascoli Theorem -/

/-- Arzela-Ascoli: A uniformly bounded and equicontinuous family in C(X)
    (for X compact) is relatively compact in the sup norm. -/
theorem arzelaAscoli
    {X : Type} [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (F : Set (X → ℝ))
    (h_bdd : ∃ M > 0, ∀ f ∈ F, ∀ x, |f x| ≤ M)
    (h_equi : isEquicontinuous F) :
    IsCompact (closure (F ∩ {f | Continuous f})) := by
  -- Proof outline:
  -- 1. Use separability of compact metric X to get a countable dense subset {x_k}.
  -- 2. Diagonal argument: extract a subsequence converging pointwise on {x_k}.
  -- 3. Equicontinuity upgrades pointwise convergence on the dense set to uniform convergence on all of X.
  sorry

/-- Corollary: Every sequence in an equicontinuous uniformly bounded family has a uniformly
    convergent subsequence. -/
theorem arzelaAscoli_subsequence
    {X : Type} [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (f_n : SequenceOfFunctions X)
    (h_bdd : ∃ M > 0, ∀ n x, |f_n n x| ≤ M)
    (h_equi : isEquicontinuous {g | ∃ n, g = f_n n})
    (h_cont : ∀ n, Continuous (f_n n)) :
    ∃ (n_k : Nat → Nat) (f : X → ℝ),
      StrictMono n_k ∧ Continuous f ∧ uniformlyConvergesOnAll (λ k => f_n (n_k k)) f := by
  sorry

/-! ## Stone-Weierstrass Theorem -/

/-- Stone-Weierstrass (real): A subalgebra A of C(X,ℝ) that separates points
    and contains the constant functions is dense in C(X,ℝ) in the sup norm. -/
theorem stoneWeierstrass
    {X : Type} [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (A : Set (X → ℝ))
    (h_alg : ∀ f g ∈ A, (λ x => f x + g x) ∈ A ∧ (λ x => f x * g x) ∈ A)
    (h_scalar : ∀ (c : ℝ) (f ∈ A), (λ x => c * f x) ∈ A)
    (h_separates : ∀ x y : X, x ≠ y → ∃ f ∈ A, f x ≠ f y)
    (h_const : ∀ c : ℝ, (λ _ => c) ∈ A) :
    ∀ f : X → ℝ, Continuous f →
    ∀ ε > 0, ∃ g ∈ A, supNorm (λ x => f x - g x) < ε := by
  -- Proof outline:
  -- 1. Show A is a lattice: if f ∈ A, then |f| ∈ closure(A).
  -- 2. For distinct x,y and reals a,b, construct f ∈ A with f(x)=a, f(y)=b.
  -- 3. For each x₀, use compactness and lattice property to approximate f by elements of A.
  sorry

/-- Stone-Weierstrass (complex): Add the condition that A is closed under complex conjugation. -/
theorem stoneWeierstrassComplex
    {X : Type} [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (A : Set (X → ℂ))
    (h_alg : ∀ f g ∈ A, (λ x => f x + g x) ∈ A ∧ (λ x => f x * g x) ∈ A)
    (h_scalar : ∀ (c : ℂ) (f ∈ A), (λ x => c * f x) ∈ A)
    (h_separates : ∀ x y : X, x ≠ y → ∃ f ∈ A, f x ≠ f y)
    (h_const : ∀ c : ℂ, (λ _ => c) ∈ A)
    (h_conj : ∀ f ∈ A, (λ x => conj (f x)) ∈ A) :
    ∀ f : X → ℂ, Continuous f →
    ∀ ε > 0, ∃ g ∈ A, supNorm (λ x => Complex.abs (f x - g x)) < ε := by
  sorry

/-! ## Dini's Theorem (Full Statement) -/

/-- Dini's Theorem: monotone pointwise convergence of continuous functions
    to a continuous function on a compact space is uniform. -/
theorem diniTheorem_full
    {X : Type} [TopologicalSpace X] [T2Space X] [CompactSpace X]
    (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_mono : (∀ n x, f_n n x ≤ f_n (n+1) x) ∨ (∀ n x, f_n n x ≥ f_n (n+1) x))
    (h_cont_n : ∀ n, Continuous (f_n n))
    (h_cont_f : Continuous f)
    (h_pointwise : pointwiseConverges f_n f) :
    uniformlyConvergesOnAll f_n f := by
  -- WLOG assume increasing (otherwise negate).
  rcases h_mono with (h_mono' | h_mono')
  · exact diniTheorem f_n f (by infer_instance) h_mono' h_cont_n h_cont_f h_pointwise
  · -- If decreasing, consider -f_n → -f (which is increasing)
    sorry

/-! ## Uniform Boundedness Principle -/

/-- Uniform Boundedness Principle (Banach-Steinhaus):
    If a family of bounded linear operators from a Banach space to a normed space
    is pointwise bounded, then it is uniformly bounded.

    For C(X): if every function in a family is bounded at each point, the family
    is uniformly bounded (assuming X is a Baire space). -/
theorem uniformBoundednessPrinciple
    {X : Type} [TopologicalSpace X] [BaireSpace X]
    (F : Set (X → ℝ))
    (h_cont : ∀ f ∈ F, Continuous f)
    (h_pointwise_bdd : ∀ x : X, ∃ M : ℝ, ∀ f ∈ F, |f x| ≤ M) :
    ∃ M : ℝ, ∀ f ∈ F, supNorm f ≤ M := by
  -- For each n, define A_n = {x | ∀ f ∈ F, |f(x)| ≤ n}.
  -- These are closed sets (by continuity) whose union is X (by pointwise boundedness).
  -- By Baire category, some A_N has nonempty interior, giving a uniform bound.
  sorry

/-! ## Tests -/

#eval "--- Theorems.Basic tests ---"

/-- Check Arzela-Ascoli hypotheses for a simple family. -/
def simpleFam : Set (ℝ → ℝ) := {λ x => Real.sin (n * x) | (n : ℕ) // True}
example : isEquicontinuous simpleFam := by
  sorry

/-- Constant function family is uniformly bounded. -/
example {X : Type} (c : ℝ) : ∃ M > 0, ∀ f ∈ ({λ _ : X => c} : Set (X → ℝ)), ∀ x, |f x| ≤ M := by
  refine ⟨|c| + 1, by linarith [abs_nonneg c], λ f hf x => ?_⟩
  have hf' : f = λ _ => c := by
    simpa using hf
  simp [hf']

end MiniFunctionSequences
