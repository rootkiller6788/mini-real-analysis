/-
# Constructions: Products

Product of function sequences, component-wise convergence,
and diagonal sequence construction.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## Product of Function Sequences -/

/-- Product of two function sequences: (f_n, g_n) on the product domain. -/
def productSeq (f_n : SequenceOfFunctions α) (g_n : SequenceOfFunctions β)
    : SequenceOfFunctions (α × β) :=
  λ n p => f_n n p.1 * g_n n p.2

/-- Component-wise product: (f_n · g_n)(x) = f_n(x) · g_n(x) on the same domain. -/
def componentwiseProduct (f_n g_n : SequenceOfFunctions α) : SequenceOfFunctions α :=
  λ n x => f_n n x * g_n n x

/-- Component-wise sum: (f_n + g_n)(x) = f_n(x) + g_n(x). -/
def componentwiseSum (f_n g_n : SequenceOfFunctions α) : SequenceOfFunctions α :=
  λ n x => f_n n x + g_n n x

/-! ## Convergence of Products -/

/-- If f_n → f and g_n → g uniformly, then f_n · g_n → f · g uniformly on bounded sets. -/
theorem productOfUniformConvergence
    (f_n g_n : SequenceOfFunctions α) (f g : α → ℝ) (A : Set α)
    (h_f : uniformlyConverges f_n f A)
    (h_g : uniformlyConverges g_n g A)
    (h_bdd : isBounded f) (h_bdd_g : isBounded g) :
    uniformlyConverges (componentwiseProduct f_n g_n) (λ x => f x * g x) A := by
  sorry

/-- Component-wise sum preserves uniform convergence. -/
theorem sumOfUniformConvergence
    (f_n g_n : SequenceOfFunctions α) (f g : α → ℝ) (A : Set α)
    (h_f : uniformlyConverges f_n f A)
    (h_g : uniformlyConverges g_n g A) :
    uniformlyConverges (componentwiseSum f_n g_n) (λ x => f x + g x) A := by
  intro ε hε
  rcases h_f (ε/2) (by linarith) with ⟨N₁, hN₁⟩
  rcases h_g (ε/2) (by linarith) with ⟨N₂, hN₂⟩
  refine ⟨max N₁ N₂, λ n hn x hx => ?_⟩
  have hn₁ : n ≥ N₁ := by
    have := Nat.le_max_left N₁ N₂; exact Nat.le_of_ble_eq_true this hn
  sorry

/-! ## Diagonal Sequence Construction -/

/-- Given a double sequence f_{n,m}, the diagonal sequence is f_{n,n}. -/
def diagonalSequence (f_nm : Nat → SequenceOfFunctions α) : SequenceOfFunctions α :=
  λ n x => f_nm n n x

/-- If each row converges to a limit and the diagonal sequence converges,
    the diagonal limit equals the limit of the limits. -/
theorem diagonalConvergence
    (f_nm : Nat → SequenceOfFunctions α) (f_m : Nat → α → ℝ) (f : α → ℝ)
    (h_row : ∀ m, uniformlyConvergesOnAll (λ n => f_nm n m) (f_m m))
    (h_diag : uniformlyConvergesOnAll (diagonalSequence f_nm) f) :
    uniformlyConvergesOnAll (λ m => f_m m) f := by
  sorry

/-! ## Products of More Than Two -/

/-- Product of three function sequences. -/
def tripleProduct (f_n g_n h_n : SequenceOfFunctions α) : SequenceOfFunctions α :=
  componentwiseProduct f_n (componentwiseProduct g_n h_n)

/-! ## Tests -/

#eval "--- Constructions.Products tests ---"

/-- Component-wise sum example. -/
def seqA : SequenceOfFunctions ℝ := λ n x => x / (n+1 : ℝ)
def seqB : SequenceOfFunctions ℝ := λ n x => (x^2) / (n+1 : ℝ)

#eval (componentwiseSum seqA seqB) 1 2.0   -- 2/2 + 4/2 = 1 + 2 = 3
#eval (componentwiseSum seqA seqB) 5 2.0   -- 2/6 + 4/6 = 1/3 + 2/3 = 1

/-- Diagonal sequence of x^k / n (double sequence indexed by (n,k)). -/
def doubleSeq : Nat → SequenceOfFunctions ℝ := λ n k x => (x ^ k) / (n+1 : ℝ)
#eval diagonalSequence doubleSeq 3 0.5    -- 0.5^3 / 4 = 0.125 / 4

end MiniFunctionSequences
