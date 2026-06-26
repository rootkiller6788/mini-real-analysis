/-
# Benchmark: Arzela-Ascoli

Performance tests for equicontinuity checks and compactness verification.
-/

import MiniFunctionSequences.Theorems.Basic

namespace MiniFunctionSequences.Benchmark

#eval "=== Benchmark: Arzela-Ascoli ==="

/-- Benchmark: Check equicontinuity of sin(nx)/n family. -/
noncomputable def sinOverN (n : Nat) (x : ℝ) : ℝ :=
  Real.sin ((n : ℝ) * x) / ((n : ℝ) + 1)

/-- The family {sin(nx)/(n+1)} is uniformly bounded by 1 and equicontinuous
    (since derivative is cos(nx) * n/(n+1) ≤ 1). -/

#eval "Benchmark 1: sinOverN values"
#eval sinOverN 1 0.0
#eval sinOverN 5 (Real.pi / 2)
#eval sinOverN 10 (Real.pi / 4)

/-- Benchmark: Lipschitz constant estimates. -/
def lipschitzBound (f : ℝ → ℝ) (L : ℝ) : Prop :=
  ∀ x y, |f x - f y| ≤ L * |x - y|

example : lipschitzBound (sinOverN 5) 1 := by
  intro x y
  sorry

/-- Benchmark: Uniform boundedness check. -/
def checkUniformBound (F : Set (ℝ → ℝ)) (M : ℝ) : Prop :=
  ∀ f ∈ F, ∀ x, |f x| ≤ M

example : checkUniformBound {g | ∃ n, g = sinOverN n} 1 := by
  intro f hf x
  rcases hf with ⟨n, rfl⟩
  have h : |Real.sin ((n : ℝ) * x)| ≤ 1 := Real.abs_sin_le_one _
  have hpos : (n : ℝ) + 1 > 0 := by
    have hn : (0 : ℝ) ≤ n := Nat.cast_nonneg _
    linarith
  calc
    |sinOverN n x| = |Real.sin ((n : ℝ) * x)| / |(n : ℝ) + 1| := by
      simp [sinOverN, abs_div]
    _ ≤ 1 / |(n : ℝ) + 1| := by
      refine (div_le_div_right (abs_pos.mpr (by linarith))).mpr h
    _ ≤ 1 := by
      have h' : |(n : ℝ) + 1| ≥ 1 := by
        have hn : (0 : ℝ) ≤ n := Nat.cast_nonneg _
        have h1 : (n : ℝ) + 1 ≥ 1 := by linarith
        exact le_trans (by norm_num) h1
      refine (div_le_one ?_).mpr h'
      exact abs_pos.mpr (by linarith [Nat.cast_nonneg n])

#eval "Benchmark 2: bound check passed"

/-- Benchmark: Compactness approximation test. -/
#eval "Benchmark 3: compactness approximation"
-- Check that the constant family is trivially compact
example : Set.Finite ({λ _ : ℝ => (0 : ℝ)} : Set (ℝ → ℝ)) := by
  refine Set.finite_singleton _

end MiniFunctionSequences.Benchmark
