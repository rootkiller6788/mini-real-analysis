/-
# MiniRiemannIntegration.Theorems.Basic

Fundamental Theorem of Calculus (both parts), integration by
parts, change of variables, mean value theorem for integrals,
Cauchy-Schwarz inequality, and continuous functions are Riemann integrable.
-/

import MiniRiemannIntegration.Properties.ClassificationData
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Fundamental Theorem of Calculus, Part 1 -/

theorem fundamentalTheoremOfCalculus_part1 (a b : ℝ) (F f : ℝ → ℝ) :
  (∀ (x : ℝ), a ≤ x → x ≤ b → True) →  -- placeholder: F' = f on [a,b]
  isRiemannIntegrable f a b →
  riemannIntegral f a b = F b - F a := by
  intro h_diff h_int
  sorry

/-! ## Fundamental Theorem of Calculus, Part 2 -/

theorem fundamentalTheoremOfCalculus_part2 (a b : ℝ) (f : ℝ → ℝ) (x : ℝ) :
  isRiemannIntegrable f a b →
  a ≤ x → x ≤ b →
  True := by  -- placeholder: d/dx ∫_a^x f(t)dt = f(x) at continuity points
  intro h_int ha hx
  sorry

/-! ## Integration by parts -/

theorem integrationByParts (a b : ℝ) (u v : ℝ → ℝ) (u' v' : ℝ → ℝ) :
  isRiemannIntegrable (fun x => u x * v' x) a b →
  isRiemannIntegrable (fun x => u' x * v x) a b →
  riemannIntegral (fun x => u x * v' x) a b =
    u b * v b - u a * v a - riemannIntegral (fun x => u' x * v x) a b := by
  intro h_int1 h_int2
  sorry

/-! ## Change of variables (substitution rule) -/

theorem changeOfVariables (a b : ℝ) (f φ : ℝ → ℝ) (φ' : ℝ → ℝ) :
  (∀ (x : ℝ), a ≤ x → x ≤ b → True) →  -- placeholder: φ is C¹ and monotone
  isRiemannIntegrable f (φ a) (φ b) →
  riemannIntegral (fun x => f (φ x) * φ' x) a b = riemannIntegral f (φ a) (φ b) := by
  intro h_φ h_int
  sorry

/-! ## Mean Value Theorem for Integrals -/

theorem meanValueTheoremForIntegrals (a b : ℝ) (f : ℝ → ℝ) :
  a < b →
  isRiemannIntegrable f a b →
  ∃ (ξ : ℝ), a ≤ ξ ∧ ξ ≤ b ∧
    riemannIntegral f a b = f ξ * (b - a) := by
  intro hlt hint
  sorry

/-! ## Cauchy-Schwarz inequality for integrals -/

theorem cauchySchwarzIntegral (a b : ℝ) (f g : ℝ → ℝ) :
  isRiemannIntegrable (fun x => f x * f x) a b →
  isRiemannIntegrable (fun x => g x * g x) a b →
  isRiemannIntegrable (fun x => f x * g x) a b →
  (riemannIntegral (fun x => f x * g x) a b) ^ 2 ≤
    (riemannIntegral (fun x => f x * f x) a b) * (riemannIntegral (fun x => g x * g x) a b) := by
  intro h_ff h_gg h_fg
  sorry

/-! ## Continuous functions are Riemann integrable -/

theorem continuousFunctionsAreRiemannIntegrable (a b : ℝ) (f : ℝ → ℝ) :
  (∀ (x : ℝ), a ≤ x → x ≤ b → True) →  -- placeholder: f continuous on [a,b]
  isRiemannIntegrable f a b := by
  intro h_cont
  sorry

/-! ## Riemann integrability of monotone functions -/

theorem monotoneFunctionsAreRiemannIntegrable (a b : ℝ) (f : ℝ → ℝ) :
  (∀ (x y : ℝ), a ≤ x → x ≤ y → y ≤ b → f x ≤ f y) → isRiemannIntegrable f a b := by
  intro h_mono
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Basic: fundamentalTheoremOfCalculus_part1 (sorry)"
#eval "Theorems.Basic: integrationByParts, changeOfVariables (sorry)"
#eval "Theorems.Basic: meanValueTheoremForIntegrals, cauchySchwarzIntegral (sorry)"

end MiniRiemannIntegration
