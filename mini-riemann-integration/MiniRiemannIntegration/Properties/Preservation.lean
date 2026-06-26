/-
# MiniRiemannIntegration.Properties.Preservation

Convergence theorems: uniform convergence preserves
Riemann integrability, monotone convergence (with
conditions), and dominated convergence for Riemann integral.
-/

import MiniRiemannIntegration.Properties.Invariants
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Uniform convergence preserves Riemann integrability -/

theorem uniform_convergence_preserves_integrability (a b : ℝ) (f : ℕ → ℝ → ℝ) (f_lim : ℝ → ℝ) :
  (∀ (ε : ℝ), ε > 0 → ∃ (N : ℕ), ∀ (n : ℕ), n ≥ N → ∀ (x : ℝ), a ≤ x → x ≤ b → |f n x - f_lim x| < ε) →
  (∀ (n : ℕ), isRiemannIntegrable (f n) a b) →
  isRiemannIntegrable f_lim a b := by
  intro h_unif h_int
  sorry

/-! ## Integral limit under uniform convergence -/

theorem uniform_convergence_integral_limit (a b : ℝ) (f : ℕ → ℝ → ℝ) (f_lim : ℝ → ℝ) :
  (∀ (ε : ℝ), ε > 0 → ∃ (N : ℕ), ∀ (n : ℕ), n ≥ N → ∀ (x : ℝ), a ≤ x → x ≤ b → |f n x - f_lim x| < ε) →
  (∀ (n : ℕ), isRiemannIntegrable (f n) a b) →
  isRiemannIntegrable f_lim a b ∧
  (∀ (ε : ℝ), ε > 0 → ∃ (N : ℕ), ∀ (n : ℕ), n ≥ N →
    |riemannIntegral (f n) a b - riemannIntegral f_lim a b| < ε) := by
  intro h_unif h_int
  constructor
  · apply uniform_convergence_preserves_integrability a b f f_lim h_unif h_int
  · intro ε hε
    sorry

/-! ## Monotone convergence for Riemann integral (with conditions) -/

theorem monotone_convergence_riemann (a b : ℝ) (f : ℕ → ℝ → ℝ) (f_lim : ℝ → ℝ) :
  (∀ (n : ℕ), isRiemannIntegrable (f n) a b) →
  (∀ (n : ℕ) (x : ℝ), a ≤ x → x ≤ b → f n x ≤ f (n+1) x) →
  (∀ (x : ℝ), a ≤ x → x ≤ b → f_lim x = 0) →  -- placeholder: limit exists
  (∃ (M : ℝ), ∀ (n : ℕ) (x : ℝ), a ≤ x → x ≤ b → |f n x| ≤ M) →
  isRiemannIntegrable f_lim a b := by
  intro h_int h_mono h_limit h_bounded
  sorry

/-! ## Dominated convergence for Riemann (statement with limitations) -/

theorem dominated_convergence_riemann (a b : ℝ) (f : ℕ → ℝ → ℝ) (f_lim g : ℝ → ℝ) :
  (∀ (n : ℕ), isRiemannIntegrable (f n) a b) →
  isRiemannIntegrable g a b →
  (∀ (n : ℕ) (x : ℝ), a ≤ x → x ≤ b → |f n x| ≤ g x) →
  (∀ (x : ℝ), a ≤ x → x ≤ b → f_lim x = 0) →  -- placeholder: pointwise limit
  isRiemannIntegrable f_lim a b := by
  intro h_int h_intg h_bound h_limit
  sorry

/-! ## Arzela dominated convergence theorem -/

def arzelaTheorem : Axiom :=
  Axiom.mk "arzelaDominatedConvergence" (Formula.pred 0 [])
    "If f_n are Riemann integrable on [a,b], f_n → f pointwise, and |f_n| ≤ M uniformly for some constant M, then f is Riemann integrable and ∫ f_n → ∫ f (provided f is bounded)"

/-! ## Preservation of integrability under Lipschitz maps -/

theorem lipschitz_preserves_integrability (a b : ℝ) (f φ : ℝ → ℝ) :
  isRiemannIntegrable f a b →
  (∃ (L : ℝ), ∀ (x y : ℝ), |φ x - φ y| ≤ L * |x - y|) →
  isRiemannIntegrable (fun x => f (φ x)) a b := by
  intro h_int h_lip
  sorry

/-! ## #eval Tests -/

#eval "Properties.Preservation: uniform_convergence_preserves_integrability (sorry)"
#eval "Properties.Preservation: monotone_convergence_riemann (sorry)"
#eval "Properties.Preservation: dominated_convergence_riemann, arzelaTheorem"

end MiniRiemannIntegration
