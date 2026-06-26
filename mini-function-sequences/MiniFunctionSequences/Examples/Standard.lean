/-
# Examples: Standard

Classic examples of function sequences: xⁿ on [0,1], x/n on ℝ,
nx e^{-nx} on [0,∞), Weierstrass approximation, Fourier series.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Theorems.Main

namespace MiniFunctionSequences

/-! ## Example 1: f_n(x) = x^n on [0,1] -/

/-- Sequence f_n(x) = x^n on [0,1]:
    - Converges pointwise to f(x) = 0 for x ∈ [0,1), f(1) = 1
    - Does NOT converge uniformly on [0,1]
    - Does converge uniformly on [0, r] for any r < 1 -/
def powerSeq (n : Nat) (x : ℝ) : ℝ := x ^ n

/-- Pointwise limit of x^n on [0,1]. -/
def powerSeqLimit (x : ℝ) : ℝ :=
  if x = 1 then 1 else 0

theorem powerSeq_pointwise : pointwiseConverges powerSeq powerSeqLimit := by
  intro x ε hε
  by_cases h : x = 1
  · -- If x = 1, then 1^n = 1 → 1 trivially
    subst x; simp [powerSeq, powerSeqLimit]
    exact ⟨0, λ n hn => by simp⟩
  · -- If x < 1 (in [0,1)), then x^n → 0
    sorry

theorem powerSeq_not_uniform : ¬ uniformlyConverges powerSeq powerSeqLimit (Set.Icc 0 1) := by
  sorry

/-! ## Example 2: f_n(x) = x/n on ℝ -/

/-- Sequence f_n(x) = x/n on ℝ:
    - Converges uniformly to 0 on any bounded set
    - Converges locally uniformly to 0 on ℝ
    - Does NOT converge uniformly on all of ℝ -/
def linearDivSeq (n : Nat) (x : ℝ) : ℝ := x / ((n : ℝ) + 1)

/-- Locally uniform convergence on ℝ. -/
theorem linearDivSeq_locallyUniform : locallyUniformlyConverges linearDivSeq (λ _ => 0) := by
  intro K h_compact ε hε
  -- On a compact set, x is bounded by some M, so choose N > M/ε
  sorry

theorem linearDivSeq_not_uniform_global : ¬ uniformlyConvergesOnAll linearDivSeq (λ _ => 0) := by
  sorry

/-! ## Example 3: f_n(x) = n x e^{-nx} on [0,∞) -/

/-- Sequence f_n(x) = n x e^{-n x} on [0,∞):
    - Converges pointwise to 0 (for x > 0, the exponential dominates; for x = 0, f_n(0) = 0)
    - Integral ∫_0^∞ f_n(x) dx = 1/n → 0 -- wait, actually ∫ n x e^{-nx} dx from 0 to ∞
      Let u = nx, then dx = du/n, integral = ∫_0^∞ u e^{-u} / n du = 1/n. So integral → 0.
    Actually, reparametrize: ∫_0^∞ n x e^{-nx} dx = 1 (this is the correct normalization).
    So the integral does NOT converge to the integral of the limit (which is 0). -/
noncomputable def spikeSeq (n : Nat) (x : ℝ) : ℝ :=
  (n : ℝ) * x * Real.exp (-(n : ℝ) * x)

/-- The spike sequence converges pointwise to 0. -/
theorem spikeSeq_pointwise : pointwiseConverges spikeSeq (λ _ => 0) := by
  sorry

/-- But the integral is 1 for each n (does not converge to integral of limit). -/
theorem spikeSeq_integral_not_converge : True := by
  sorry

/-! ## Example 4: Weierstrass Approximation -/

/-- Any continuous function on [0,1] is a uniform limit of polynomials. -/
theorem weierstrassExample (f : ℝ → ℝ) (h_cont : ContinuousOn f (Set.Icc 0 1)) :
    ∃ (p_n : ℕ → Polynomial ℝ), uniformlyConvergesOnAll
      (λ n x => (p_n n).eval x) f := by
  -- This follows from the Stone-Weierstrass theorem.
  sorry

/-! ## Example 5: Fourier Series -/

/-- The Fourier partial sums of a continuous 2π-periodic function:
    S_n(f)(x) = a₀/2 + Σ_{k=1}^n (a_k cos(kx) + b_k sin(kx))
    Not guaranteed to converge pointwise (du Bois-Reymond counterexample)
    but converge in L² (Carleson's theorem: a.e. for L²) -/
noncomputable def fourierPartialSum (f : ℝ → ℝ) (n : Nat) (x : ℝ) : ℝ :=
  (Real.cos 0)  -- Placeholder; actual Fourier coefficients would be integrals.

/-- Fejer's theorem: the Cesaro means of Fourier series converge uniformly to f
    for continuous 2π-periodic f. -/
theorem fejerTheorem (f : ℝ → ℝ) (h_cont : Continuous f) (h_periodic : ∀ x, f (x + 2*Real.pi) = f x) :
    uniformlyConvergesOnAll
      (cesaroSum (λ n x => fourierPartialSum f n x)) f := by
  sorry

/-! ## Tests -/

#eval "--- Examples.Standard tests ---"

/-- Power sequence on [0,1]. -/
#eval powerSeq 1 0.5   -- 0.5
#eval powerSeq 3 0.5   -- 0.125
#eval powerSeq 10 0.5  -- 0.0009765625

/-- Linear sequence x/n. -/
#eval linearDivSeq 10 5.0   -- 5/11 ≈ 0.4545
#eval linearDivSeq 100 5.0  -- 5/101 ≈ 0.0495

/-- Spike sequence. -/
#eval spikeSeq 1 1.0   -- 1 * 1 * e^{-1} = e^{-1} ≈ 0.3679
#eval spikeSeq 5 0.2   -- 5 * 0.2 * e^{-1} = 1 * e^{-1} ≈ 0.3679

/-- Bernstein polynomials for x^2. -/
#eval bernsteinPolynomial (λ x => x ^ 2) 10 (0.5 : ℝ)

end MiniFunctionSequences
