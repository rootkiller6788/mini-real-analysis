/-
# Examples: Counterexamples

Classic counterexamples in function sequence theory:
pointwise limit of continuous need not be continuous,
uniform limit of differentiable need not be differentiable,
Dini theorem fails without monotonicity,
equicontinuity without boundedness doesn't give compactness.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Examples.Standard

namespace MiniFunctionSequences

/-! ## Counterexample 1: Pointwise Limit of Continuous ≠ Continuous -/

/-- f_n(x) = x^n on [0,1]: each f_n is continuous, but the pointwise limit is
    discontinuous (0 on [0,1), 1 at 1). -/
theorem pointwiseLimitOfContinuousNotContinuous :
    ∃ (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ),
      (∀ n, Continuous (f_n n)) ∧ pointwiseConverges f_n f ∧ ¬ Continuous f := by
  refine ⟨powerSeq, powerSeqLimit, ?_, powerSeq_pointwise, ?_⟩
  · intro n
    -- x^n is continuous
    exact continuous_pow n
  · -- powerSeqLimit is not continuous at x = 1
    sorry

/-- Explicit check: powerSeqLimit is discontinuous at 1. -/
theorem powerSeqLimit_discontinuous_at_one : ¬ ContinuousAt powerSeqLimit 1 := by
  sorry

/-! ## Counterexample 2: Uniform Limit of Differentiable ≠ Differentiable -/

/-- f_n(x) = √(x² + 1/n): each f_n is differentiable everywhere,
    uniform limit f(x) = |x| is not differentiable at 0. -/
noncomputable def sqrtSeq (n : Nat) (x : ℝ) : ℝ :=
  Real.sqrt (x ^ 2 + 1 / ((n : ℝ) + 1))

/-- The uniform limit is |x|. -/
theorem sqrtSeq_uniform_limit : uniformlyConvergesOnAll sqrtSeq (λ x => |x|) := by
  sorry

/-- |x| is not differentiable at 0. -/
theorem abs_not_differentiable_at_zero : ¬ DifferentiableAt ℝ (λ x : ℝ => |x|) 0 := by
  sorry

/-! ## Counterexample 3: Dini Theorem Fails Without Monotonicity -/

/-- f_n(x) = n x on [0, 1/n], f_n(x) = 2 - n x on [1/n, 2/n], f_n(x) = 0 elsewhere
    (tent functions). Continuous, converge pointwise to 0, but NOT uniformly. -/
noncomputable def tentSeq (n : Nat) (x : ℝ) : ℝ :=
  if x ≤ 0 then 0
  else if x ≤ 1 / ((n : ℝ) + 1) then (n : ℝ) * x
  else if x ≤ 2 / ((n : ℝ) + 1) then 2 - (n : ℝ) * x
  else 0

/-- Each tent function is continuous. -/
theorem tentSeq_continuous (n : Nat) : Continuous (tentSeq n) := by
  sorry

/-- The tent sequence converges pointwise to 0. -/
theorem tentSeq_pointwise : pointwiseConverges tentSeq (λ _ => 0) := by
  sorry

/-- But NOT uniformly (the peak height is always 1). -/
theorem tentSeq_not_uniform : ¬ uniformlyConvergesOnAll tentSeq (λ _ => 0) := by
  sorry

/-! ## Counterexample 4: Equicontinuity Without Uniform Boundedness -/

/-- f_n(x) = n (constant function n). The family {f_n} is equicontinuous
    (all constant, so trivially equicontinuous), pointwise bounded? No,
    it is not pointwise bounded (f_n(x) = n → ∞). Therefore it is not
    uniformly bounded and not relatively compact in C(X). -/
def constSeqFamily (n : Nat) (x : ℝ) : ℝ := (n : ℝ)

/-- Constant functions are equicontinuous. -/
theorem constSeqFamily_equicontinuous : isEquicontinuous {g | ∃ n, g = constSeqFamily n} := by
  -- Constant functions: for any ε > 0, any δ works
  intro x₀ ε hε
  refine ⟨Set.univ, Filter.univ_mem, λ f hf x hx => ?_⟩
  rcases hf with ⟨m, rfl⟩
  simp

/-- But not uniformly bounded (or even pointwise bounded). -/
theorem constSeqFamily_not_bounded : ¬ ∃ M, ∀ f ∈ {g | ∃ n, g = constSeqFamily n}, ∀ x, |f x| ≤ M := by
  intro h
  rcases h with ⟨M, hM⟩
  have hN := hM (constSeqFamily (Nat.floor (M + 1))) (by
    refine ⟨Nat.floor (M + 1), rfl⟩) 0
  simp [constSeqFamily] at hN
  -- (Nat.floor (M+1) : ℝ) ≤ M, contradiction
  linarith

/-! ## Counterexample 5: Equicontinuity on Non-Compact Domain -/

/-- f_n(x) = sin(nx) on ℝ. The family {sin(nx) : n ∈ ℕ} is uniformly bounded (by 1)
    and equicontinuous (all have Lipschitz constant ≤ n, so NOT equicontinuous as a family).
    Actually, |sin(nx) - sin(ny)| ≤ n|x-y|, which depends on n, so the family is NOT
    equicontinuous. This shows that uniform boundedness alone does not suffice. -/
def sinFamily (n : Nat) (x : ℝ) : ℝ := Real.sin ((n : ℝ) * x)

/-- sin(nx) family is uniformly bounded but not equicontinuous. -/
theorem sinFamily_bounded_not_equicontinuous :
    (∃ M > 0, ∀ n x, |sinFamily n x| ≤ M) ∧
    ¬ isEquicontinuous {g | ∃ n, g = sinFamily n} := by
  constructor
  · refine ⟨1, by norm_num, λ n x => ?_⟩
    have h := Real.abs_sin_le_one ((n : ℝ) * x)
    simpa [sinFamily] using h
  · -- Not equicontinuous: at x=0, for ε=1/2, no δ works for all n
    sorry

/-! ## Tests -/

#eval "--- Examples.Counterexamples tests ---"

/-- sqrtSeq approximating |x|. -/
#eval sqrtSeq 10 (-3.0)   -- √(9 + 1/11) ≈ 3.015
#eval sqrtSeq 1000 0.0    -- √(1/1001) ≈ 0.0316

/-- Tent function values. -/
#eval tentSeq 3 0.0       -- 0
#eval tentSeq 3 0.25      -- peak: 3 * 0.25 = 0.75
#eval tentSeq 3 1.0       -- 0 (outside support)

/-- sinFamily example. -/
#eval sinFamily 5 (Real.pi / 2)  -- sin(5π/2) = sin(π/2) = 1

end MiniFunctionSequences
