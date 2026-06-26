/-
# Test: Morphism Tests

Tests for Arzela-Ascoli and Stone-Weierstrass applications,
Cesàro/Abel summation, and convergence-preserving maps.
-/

import MiniFunctionSequences.Theorems.Basic
import MiniFunctionSequences.Theorems.Main
import MiniFunctionSequences.Morphisms.Hom

namespace MiniFunctionSequences.Test

#eval "=== Test: Morphism Tests ==="

/-! ## Test 1: Bernstein polynomials for x^2 -/

noncomputable def f_x2 (x : ℝ) : ℝ := x ^ 2

#eval "Test 1: Bernstein B_3(x^2) at x=0.0"
#eval bernsteinPolynomial f_x2 3 (0.0 : ℝ)
#eval bernsteinPolynomial f_x2 3 (0.5 : ℝ)
#eval bernsteinPolynomial f_x2 3 (1.0 : ℝ)

/-! ## Test 2: Bernstein polynomials for sin(pi*x) -/

noncomputable def f_sinpi (x : ℝ) : ℝ := Real.sin (Real.pi * x)

#eval "Test 2: Bernstein B_5(sin(pi*x))"
#eval bernsteinPolynomial f_sinpi 5 (0.0 : ℝ)
#eval bernsteinPolynomial f_sinpi 5 (0.25 : ℝ)
#eval bernsteinPolynomial f_sinpi 5 (0.5 : ℝ)
#eval bernsteinPolynomial f_sinpi 5 (0.75 : ℝ)
#eval bernsteinPolynomial f_sinpi 5 (1.0 : ℝ)

/-! ## Test 3: Cesàro sum of function sequence -/

def geomSeq (n : Nat) (x : ℝ) : ℝ := x ^ n

#eval "Test 3: Cesàro sum of geometric sequence"
#eval cesaroSum geomSeq 5 0.5
#eval cesaroSum geomSeq 10 0.5
#eval cesaroSum geomSeq 20 0.5

/-! ## Test 4: Uniform convergence check for x/n → 0 -/

#eval "Test 4: linear sequence locally uniform"
example (f_n : SequenceOfFunctions ℝ) : locallyUniformlyConverges
    (λ n x => x / ((n:ℝ)+1)) (λ _ => 0) := by
  intro K hK ε hε
  -- Compact K is bounded, say |x| ≤ M for x ∈ K.
  -- Choose N > M/ε, then for n ≥ N, |x/(n+1)| ≤ M/N < ε.
  sorry

/-! ## Test 5: Object instance for FunctionSequence -/

#eval "Test 5: FunctionSequence Object"
def myFuncSeq : FunctionSequence ℝ := {
  terms := λ n x => x / (n+1 : ℝ)
  domain := Set.univ
}
#eval myFuncSeq.terms 0 3.0
#eval myFuncSeq.terms 5 3.0

/-! ## Test 6: Uniform equivalence of sequences -/

#eval "Test 6: uniform equivalence"
def seq_a : SequenceOfFunctions ℝ := λ n x => x / (n+1 : ℝ)
def seq_b : SequenceOfFunctions ℝ := λ n x => x / (n+1 : ℝ) + 1 / ((n+1 : ℝ) * (n+1 : ℝ))
example : uniformlyEquivalent seq_a seq_b Set.univ := by
  intro ε hε
  -- Need: |1/(n+1)²| < ε for large n. Choose N > 1/√ε.
  sorry

end MiniFunctionSequences.Test
