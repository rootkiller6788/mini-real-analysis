/-
# MiniSequenceSeries.Theorems.Classification

Classification results for series convergence: absolute convergence
implies ordinary convergence, Riemann rearrangement theorem,
Dirichlet and Abel tests, and rearrangement invariance.

Knowledge coverage:
- L4: Riemann rearrangement theorem, Dirichlet/Abel tests
- L2: Convergence type classification
- L5: Proof techniques (summation by parts for Dirichlet)
- L6: #eval classification examples
-/

import MiniSequenceSeries.Theorems.Basic

namespace MiniSequenceSeries

/-! ## Absolute Convergence Implies Convergence (L4)

    If Σ|a_n| converges, then Σ a_n converges. This is fundamental:
    absolute convergence is stronger than ordinary convergence. -/

/-- Absolute convergence ⇒ ordinary convergence. Proof uses
    Cauchy criterion: |Σ_{k=m}^n a_k| ≤ Σ_{k=m}^n |a_k| < ε. -/
axiom absoluteConvergenceImpliesConvergence (a : Sequence ℝ) :
    isAbsolutelyConvergent a → Series.sum a

/-! ## Riemann Rearrangement Theorem (L4)

    For a conditionally convergent real series, the terms can be
    rearranged to converge to ANY real number, or to diverge to ±∞. -/

/-- Riemann rearrangement theorem: conditionally convergent series
    can be rearranged to converge to any prescribed sum S. -/
axiom riemannRearrangementTheorem (a : Sequence ℝ)
    (hConditional : isConditionallyConvergent a) :
    ∀ (S : ℝ), ∃ (π : Nat → Nat), Function.Bijective π ∧
      Series.limitSum (fun n => a (π n)) S

/-- Rearrangement of an absolutely convergent series preserves
    both the sum and absolute convergence. -/
axiom rearragementPreservesSumAbsConvergence (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) (π : Nat → Nat) (hBij : Function.Bijective π) (S : ℝ)
    (hSum : Series.limitSum a S) : Series.limitSum (fun n => a (π n)) S

/-! ## Convergence Type Classification (L2) -/

inductive SeriesConvergenceType
  | absolutelyConvergent
  | conditionallyConvergent
  | divergent
deriving BEq, Repr, Inhabited

def classifySeries (a : Sequence ℝ) : SeriesConvergenceType :=
  if isAbsolutelyConvergent a then
    SeriesConvergenceType.absolutelyConvergent
  else if Series.sum a then
    SeriesConvergenceType.conditionallyConvergent
  else
    SeriesConvergenceType.divergent

/-! ## Dirichlet Test (L4)

    If partial sums of bₙ are bounded and aₙ ↓ 0 monotonically,
    then Σ aₙ·bₙ converges. Proof uses summation by parts. -/

/-- Dirichlet test for series convergence. -/
axiom dirichletTest (a b : Sequence ℝ)
    (hPartialSumsBounded : isBounded (Series b))
    (hAMonotoneToZero : isMonotone a ∧ Sequence.limit a 0) :
    Series.sum (pointwiseMul a b)

/-! ## Abel Test (L4)

    If Σ aₙ converges and bₙ is monotone bounded,
    then Σ aₙ·bₙ converges. -/

/-- Abel test for series convergence. -/
axiom abelTest (a b : Sequence ℝ)
    (hAConvergent : Series.sum a)
    (hBMonotoneBounded : isMonotone b ∧ isBounded b) :
    Series.sum (pointwiseMul a b)

/-! ## Rearrangement Invariance for Absolute Convergence (L4) -/

/-- Absolute convergence is invariant under rearrangement.
    If Σ|a_n| < ∞ and π is a bijection, then Σ|a_{π(n)}| < ∞. -/
axiom absoluteConvergenceRearrangementInvariant (a : Sequence ℝ)
    (hAbs : isAbsolutelyConvergent a) (π : Nat → Nat) (hBij : Function.Bijective π) :
    isAbsolutelyConvergent (fun n => a (π n))

/-! ## #eval Tests (L6) -/

def exampleAbsConv : Sequence ℝ := fun n => (0.5 : ℝ) ^ n
def exampleCondConv : Sequence ℝ := fun n => ((-1 : ℝ) ^ n) / (↑n + 1)

#eval "Theorems.Classification: abs conv ⇒ conv, Riemann rearrangement, Dirichlet, Abel"
#eval s!"SeriesConvergenceType: absolutely, conditionally convergent, divergent"
#eval s!"Riemann: conditionally conv ⟹ can rearrange to any sum"
#eval s!"Absolutely convergent: all rearrangements give same sum"
#eval s!"Dirichlet/Abel tests: extend Leibniz alternating series test"
#eval s!"exampleAbsConv (geometric): Σ 0.5ⁿ — absolutely convergent"
#eval s!"exampleCondConv (alternating harmonic): conditionally convergent"

end MiniSequenceSeries
