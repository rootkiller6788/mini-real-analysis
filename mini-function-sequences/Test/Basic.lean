/-
# Test: Basic

Tests for pointwise and uniform convergence definitions.
-/

import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Core.Laws

namespace MiniFunctionSequences.Test

#eval "=== Test: Basic ==="

/-! ## Test 1: Pointwise convergence of x^n to 0 on (0,1) -/

#eval "Test 1: powerSeq pointwise"
#eval powerSeq 3 0.5
#eval powerSeq 5 0.5
#eval powerSeq 10 0.5

/-! ## Test 2: Uniform convergence of x/n to 0 on bounded sets -/

def linearDivSeq (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

#eval "Test 2: linearDivSeq"
#eval linearDivSeq 10 5.0
#eval linearDivSeq 100 5.0
#eval linearDivSeq 1000 5.0

/-! ## Test 3: Sup norm computation -/

#eval "Test 3: supNorm"
#eval supNormOn (λ x : ℝ => Real.sin x) (Set.Icc 0 (2 * Real.pi))

/-! ## Test 4: Uniform Cauchy check -/

def constantSeq (c : ℝ) : SequenceOfFunctions ℝ := λ _ _ => c

#eval "Test 4: constantSeq uniform Cauchy"
example : uniformlyCauchy (constantSeq 3) Set.univ := by
  intro ε hε
  refine ⟨0, λ m hm n hn x hx => ?_⟩
  simp

/-! ## Test 5: Cesàro mean -/

def altSeq : Nat → ℝ
  | 0 => 1
  | n+1 => (-1 : ℝ) ^ (n+1)

#eval "Test 5: Cesàro mean of alternating sequence"
#eval cesaroMean altSeq 5
#eval cesaroMean altSeq 10
#eval cesaroMean altSeq 100

/-! ## Test 6: Uniform convergence of zero sequence -/

#eval "Test 6: zero sequence uniform"
example : uniformlyConvergesOnAll (λ n _ : ℝ => (0 : ℝ)) (λ _ => 0) := by
  intro ε hε; refine ⟨0, λ n hn x => ?_⟩; simp

/-! ## Test 7: Function sequences as Objects -/

#eval "Test 7: FunctionSequence Object"
#eval MiniObjectKernel.describe (FunctionSequence ℕ)

/-! ## Test 8: Theory name -/

#eval "Test 8: theoryName"
#eval theoryName.toString

end MiniFunctionSequences.Test
