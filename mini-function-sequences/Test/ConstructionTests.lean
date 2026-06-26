/-
# Test: Construction Tests

Tests for function spaces C_b(X), C_c(X), C₀(X), B(X)
and related constructions.
-/

import MiniFunctionSequences.Constructions.Subobjects
import MiniFunctionSequences.Constructions.Products
import MiniFunctionSequences.Constructions.Quotients

namespace MiniFunctionSequences.Test

#eval "=== Test: Construction Tests ==="

/-! ## Test 1: Bounded Functions B(ℝ) -/

def boundedSin : BoundedFunctions ℝ :=
  ⟨Real.sin, ⟨1, λ x => Real.abs_sin_le_one x⟩⟩

#eval "Test 1: boundedSin"
#eval boundedSin.1 (Real.pi / 2)
#eval boundedSin.1 0

/-! ## Test 2: Bounded Continuous Functions C_b(ℝ) -/

def sinBCF : BoundedContinuousFunctions ℝ :=
  ⟨Real.sin, ⟨⟨1, λ x => Real.abs_sin_le_one x⟩, Real.continuous_sin⟩⟩

#eval "Test 2: sinBCF"
#eval sinBCF.1 (Real.pi / 4)
#eval sinBCF.1 (Real.pi / 2)

/-! ## Test 3: Product of function sequences -/

def seq1 : SequenceOfFunctions ℝ := λ n x => x / (n+1 : ℝ)
def seq2 : SequenceOfFunctions ℝ := λ n x => (-1 : ℝ)^n * x

#eval "Test 3: componentwiseProduct"
#eval (componentwiseProduct seq1 seq2) 3 2.0

/-! ## Test 4: Component-wise sum -/

#eval "Test 4: componentwiseSum"
#eval (componentwiseSum seq1 seq2) 3 2.0

/-! ## Test 5: Diagonal sequence -/

def doubleSeq : Nat → SequenceOfFunctions ℝ := λ n m x => (x ^ n) / (m+1 : ℝ)

#eval "Test 5: diagonalSequence"
#eval diagonalSequence doubleSeq 3 0.5

/-! ## Test 6: Quotient by uniform equivalence -/

#eval "Test 6: uniformEquivalenceQuotient"
def myQuotient : uniformEquivalenceQuotient ℝ Set.univ :=
  uniformEquivalenceQuotient.mk ℝ Set.univ (λ n x => x / (n+1 : ℝ))
#eval "Quotient created successfully"

end MiniFunctionSequences.Test
