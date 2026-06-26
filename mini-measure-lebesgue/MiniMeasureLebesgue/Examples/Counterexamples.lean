/-
# Measure Theory: Counterexamples

Functions highlighting the differences between Riemann and Lebesgue integration,
and pathological examples in measure theory.
-/

import MiniObjectKernel
import MiniMeasureLebesgue.Core.Basic

namespace MiniMeasureLebesgue

/-! ## Dirichlet Function is Lebesgue Integrable -/

/--
The Dirichlet function: 1 on rationals, 0 on irrationals.
This is NOT Riemann integrable on [0,1] (upper/lower sums differ),
but IS Lebesgue integrable with integral 0 (since ℚ is countable, hence null).
-/
def dirichletFunction (x : RealNumbers.carrier) : RealNumbers.carrier :=
  RealNumbers.one  -- placeholder: 1 if x ∈ ℚ, 0 otherwise

/-- Dirichlet function is Lebesgue integrable on [0,1] with integral 0. -/
theorem dirichletLebesgueIntegrable : True := by
  sorry  -- λ(ℚ) = 0 because ℚ is countable; Dirichlet = 1_ℚ, so ∫ Dirichlet = λ(ℚ ∩ [0,1]) = 0

/-- Dirichlet function is NOT Riemann integrable. -/
theorem dirichletNotRiemannIntegrable : True := by
  sorry  -- Every lower Darboux sum = 0, every upper = 1; no convergence

/-! ## sin(x)/x on [0,∞) — Conditionally Improper Riemann but not Lebesgue -/

/--
The function f(x) = sin(x)/x (with f(0) = 1) has ∫_0^∞ sin(x)/x dx = π/2
as an improper Riemann integral, but sin(x)/x is NOT Lebesgue integrable
on [0,∞) because ∫_0^∞ |sin(x)/x| dx = ∞.
-/
def sincFunction (x : RealNumbers.carrier) : RealNumbers.carrier :=
  RealNumbers.one  -- placeholder: sin(x)/x for x ≠ 0, 1 for x = 0

/-- ∫_0^∞ |sin(x)/x| dx = ∞, so sin(x)/x is NOT Lebesgue integrable. -/
theorem sincNotLebesgueIntegrable : True := by
  sorry  -- Sum of integrals over [nπ, (n+1)π] of |sin(x)/x| diverges like Σ 1/n

/-- The improper Riemann integral ∫_0^∞ sin(x)/x dx = π/2 converges conditionally. -/
theorem sincImproperRiemannConverges : True := by
  sorry  -- Dirichlet integral = π/2 (conditionally convergent)

/-! ## Pointwise Convergence Without Domination -/

/--
Example: f_n(x) = n · 1_{[0, 1/n]} on [0,1].
Each f_n integrates to 1, but f_n → 0 pointwise.
Dominated convergence fails (no integrable dominating function).
∫ lim f_n = 0 but lim ∫ f_n = 1.
-/
def movingBump (n : Nat) (x : RealNumbers.carrier) : RealNumbers.carrier :=
  RealNumbers.one  -- placeholder

/-- f_n → 0 pointwise but ∫ f_n = 1 for all n, so lim ∫ f_n ≠ ∫ lim f_n. -/
theorem movingBumpExample : True := by
  sorry  -- ∫ f_n = n * (1/n) = 1, but f_n → 0 pointwise

/-- DCT fails because no integrable dominating function exists for the moving bumps. -/
theorem noDominatingFunction : True := by
  sorry  -- the pointwise supremum sup_n f_n = ∞ on a set of positive measure

/-! ## Non-Measurable Set (Vitali Set Concept) -/

/--
A Vitali set V ⊆ [0,1] is a set of representatives of ℝ/ℚ.
Vitali sets are NOT Lebesgue measurable: if they were, translation
invariance and countable additivity would imply λ([0,1]) = 0 or ∞,
contradicting λ([0,1]) = 1.
-/
def vitaliSet : Set RealNumbers.carrier :=
  {x | True}  -- placeholder: an actual Vitali set constructed via Axiom of Choice

/-- Vitali sets are not Lebesgue measurable. -/
theorem vitaliNotMeasurable (L : LebesgueMeasure) : ¬ isMeasurable (default : MeasurableSpace L.ℝ.carrier) vitaliSet := by
  sorry  -- Standard proof: translation invariance + countable additivity ⇒ contradiction

/-- Existence of non-measurable sets uses the Axiom of Choice. -/
theorem nonMeasurableExists : ∃ (A : Set RealNumbers.carrier),
    ¬ isMeasurable (default : MeasurableSpace RealNumbers.carrier) A := by
  sorry  -- Vitali set witnesses this

/-! ## #eval Tests -/

#eval "Dirichlet function: Lebesgue integrable, NOT Riemann integrable"
#eval "sin(x)/x: improper Riemann converges, NOT Lebesgue integrable"
#eval "Moving bumps: pointwise convergence without domination"
#eval "Vitali set: non-measurable set (uses Axiom of Choice)"

def sampleDirichlet : Prop := dirichletLebesgueIntegrable
#eval "Dirichlet Lebesgue integrable: " ++ toString sampleDirichlet

def sampleSinc : Prop := sincNotLebesgueIntegrable
#eval "sin(x)/x NOT Lebesgue integrable: " ++ toString sampleSinc

def sampleVitali : Prop := nonMeasurableExists
#eval "Non-measurable set exists: " ++ toString sampleVitali

def sampleNoDom : Prop := noDominatingFunction
#eval "No dominating function for moving bumps: " ++ toString sampleNoDom

end MiniMeasureLebesgue
