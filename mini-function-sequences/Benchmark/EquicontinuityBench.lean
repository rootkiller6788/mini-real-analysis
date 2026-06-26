/-
# Benchmark: Equicontinuity

Performance tests for equicontinuity and uniform equicontinuity checks.
-/

import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences.Benchmark

#eval "=== Benchmark: Equicontinuity ==="

/-- Benchmark: Lipschitz constants for various families. -/

/-- Family of contractions: f_n(x) = x/n on [0,1]. -/
def contractionFamily (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

/-- Each f_n has Lipschitz constant 1/(n+1) ≤ 1. So the family is equicontinuous. -/
example (n : Nat) : ∀ x y, |contractionFamily n x - contractionFamily n y| ≤ |x - y| := by
  intro x y
  simp [contractionFamily]
  have h : (n : ℝ) + 1 ≥ 1 := by
    have h' : (0 : ℝ) ≤ n := Nat.cast_nonneg _
    linarith
  calc
    |x / ((n : ℝ) + 1) - y / ((n : ℝ) + 1)| = |x - y| / ((n : ℝ) + 1) := by ring
    _ ≤ |x - y| := by
      refine (div_le_self ?_ (by positivity)).mpr (abs_nonneg _)
    _ = |x - y| := rfl

#eval "Benchmark 1: contraction family"
#eval contractionFamily 10 0.5
#eval contractionFamily 100 0.5

/-- Benchmark: Not equicontinuous family — sin(nx) without normalization. -/
def fastOscillation (n : Nat) (x : ℝ) : ℝ := Real.sin ((n : ℝ) * x)

/-- |sin(nx) - sin(ny)| ≤ n|x-y|, so Lipschitz constant grows with n.
    The family is NOT equicontinuous. -/
example : ¬ isEquicontinuous ({g | ∃ n : ℕ, g = fastOscillation n} : Set (ℝ → ℝ)) := by
  intro h_equi
  -- At x=0, for ε=1/2, need δ>0 such that ∀n, ∀y with |y|<δ, |sin(n*y)|<1/2.
  -- But for n large, sin(n * δ/2) ≈ 1 for appropriate n. This is a contradiction.
  sorry

#eval "Benchmark 2: oscillation family"
#eval fastOscillation 1 0.1
#eval fastOscillation 10 0.1
#eval fastOscillation 100 0.1

/-- Benchmark: Equicontinuous family of differentiable functions with uniformly bounded derivative. -/
def derivBoundedFamily (n : Nat) (x : ℝ) : ℝ :=
  ((n : ℝ) / ((n : ℝ) + 1)) * Real.sin x

/-- The derivative is bounded by 1 independent of n. So this family is equicontinuous. -/
example : isEquicontinuous ({g | ∃ n, g = derivBoundedFamily n} : Set (ℝ → ℝ)) := by
  sorry

#eval "Benchmark 3: bounded derivative family"
#eval derivBoundedFamily 1 (Real.pi / 2)
#eval derivBoundedFamily 5 (Real.pi / 2)
#eval derivBoundedFamily 100 (Real.pi / 2)

end MiniFunctionSequences.Benchmark
