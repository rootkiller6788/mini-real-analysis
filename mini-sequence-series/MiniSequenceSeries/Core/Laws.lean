/-
# MiniSequenceSeries.Core.Laws

Axioms and kernel laws for sequence and series convergence.
-/

import MiniSequenceSeries.Core.Basic
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Core Convergence Axioms -/

def monotoneBoundedConvergesAxiom : Axiom :=
  Axiom.mk "monotoneBoundedConverges" (Formula.pred 0 [])
    "Every monotone bounded sequence of real numbers converges"

def cauchyCriterionAxiom : Axiom :=
  Axiom.mk "cauchyCriterion" (Formula.pred 0 [])
    "A sequence of real numbers converges iff it is Cauchy"

def algebraOfLimitsAxiom : Axiom :=
  Axiom.mk "algebraOfLimits" (Formula.pred 0 [])
    "If a_n → A and b_n → B then a_n+b_n → A+B, a_n·b_n → A·B, and a_n/b_n → A/B (if B≠0)"

def squeezeTheoremAxiom : Axiom :=
  Axiom.mk "squeezeTheorem" (Formula.pred 0 [])
    "If a_n ≤ b_n ≤ c_n and a_n → L, c_n → L, then b_n → L"

/-! ## Series Convergence Tests -/

def comparisonTestAxiom : Axiom :=
  Axiom.mk "comparisonTest" (Formula.pred 0 [])
    "If 0 ≤ a_n ≤ b_n and Σ b_n converges, then Σ a_n converges"

def limitComparisonTestAxiom : Axiom :=
  Axiom.mk "limitComparisonTest" (Formula.pred 0 [])
    "If a_n,b_n > 0 and a_n/b_n → c with 0 < c < ∞, then Σ a_n and Σ b_n have same convergence behavior"

def ratioTestAxiom : Axiom :=
  Axiom.mk "ratioTest" (Formula.pred 0 [])
    "If lim |a_{n+1}/a_n| = L < 1 then Σ a_n converges absolutely; if L > 1 it diverges"

def rootTestAxiom : Axiom :=
  Axiom.mk "rootTest" (Formula.pred 0 [])
    "If limsup |a_n|^{1/n} = L < 1 then Σ a_n converges absolutely; if L > 1 it diverges"

def integralTestAxiom : Axiom :=
  Axiom.mk "integralTest" (Formula.pred 0 [])
    "If f is positive decreasing continuous on [1,∞), Σ f(n) converges iff ∫_1^∞ f(x)dx converges"

def alternatingSeriesTestAxiom : Axiom :=
  Axiom.mk "alternatingSeriesTest" (Formula.pred 0 [])
    "If a_n ↓ 0 (decreasing to 0), then Σ (-1)^n a_n converges"

/-! ## Axiom System -/

def sequenceConvergenceAxioms : AxiomSystem :=
  AxiomSystem.empty.addAxioms
    #[monotoneBoundedConvergesAxiom, cauchyCriterionAxiom,
      algebraOfLimitsAxiom, squeezeTheoremAxiom]

def seriesConvergenceAxioms : AxiomSystem :=
  AxiomSystem.empty.addAxioms
    #[comparisonTestAxiom, limitComparisonTestAxiom, ratioTestAxiom,
      rootTestAxiom, integralTestAxiom, alternatingSeriesTestAxiom]

def allSequenceSeriesAxioms : AxiomSystem :=
  AxiomSystem.empty
    |>.addAxioms sequenceConvergenceAxioms.axioms
    |>.addAxioms seriesConvergenceAxioms.axioms

/-! ## #eval Tests -/

#eval s!"Sequence convergence axioms: {sequenceConvergenceAxioms.axioms.length} (expected: 4)"
#eval s!"Series convergence axioms: {seriesConvergenceAxioms.axioms.length} (expected: 6)"
#eval s!"Total axioms: {allSequenceSeriesAxioms.axioms.length} (expected: 10)"
#eval s!"Axiom names: {allSequenceSeriesAxioms.axioms.map (·.name)}"

end MiniSequenceSeries
