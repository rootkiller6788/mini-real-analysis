/-
# MiniRiemannIntegration.Core.Laws

Axioms governing the Riemann integral: linearity, additivity on intervals,
monotonicity, triangle inequality, and the Fundamental Theorem of Calculus.
-/

import MiniRiemannIntegration.Core.Basic
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Linearity of the integral -/

def linearityOfIntegral : Axiom :=
  Axiom.mk "linearityOfIntegral" (Formula.pred 0 [])
    "∫_a^b (α·f(x) + β·g(x)) dx = α·∫_a^b f(x) dx + β·∫_a^b g(x) dx for integrable f, g"

/-! ## Additivity on intervals -/

def additivityOnIntervals : Axiom :=
  Axiom.mk "additivityOnIntervals" (Formula.pred 0 [])
    "∫_a^c f(x) dx = ∫_a^b f(x) dx + ∫_b^c f(x) dx for a ≤ b ≤ c"

/-! ## Monotonicity of the integral -/

def monotonicityOfIntegral : Axiom :=
  Axiom.mk "monotonicityOfIntegral" (Formula.pred 0 [])
    "If f(x) ≤ g(x) for all x ∈ [a,b], then ∫_a^b f(x) dx ≤ ∫_a^b g(x) dx"

/-! ## Triangle inequality for integrals -/

def triangleInequalityIntegral : Axiom :=
  Axiom.mk "triangleInequalityIntegral" (Formula.pred 0 [])
    "|∫_a^b f(x) dx| ≤ ∫_a^b |f(x)| dx for integrable f"

/-! ## Fundamental Theorem of Calculus, Part 1 -/

def fundamentalTheoremOfCalculus1 : Axiom :=
  Axiom.mk "fundamentalTheoremOfCalculus1" (Formula.pred 0 [])
    "If F is differentiable on [a,b] and F' = f is Riemann integrable on [a,b], then ∫_a^b f(x) dx = F(b) - F(a)"

/-! ## Fundamental Theorem of Calculus, Part 2 -/

def fundamentalTheoremOfCalculus2 : Axiom :=
  Axiom.mk "fundamentalTheoremOfCalculus2" (Formula.pred 0 [])
    "If f is Riemann integrable on [a,b], then the function G(x) = ∫_a^x f(t) dt is continuous on [a,b] and G'(x) = f(x) at every point x where f is continuous"

/-! ## Reversal of limits -/

def reversalOfLimits : Axiom :=
  Axiom.mk "reversalOfLimits" (Formula.pred 0 [])
    "∫_a^b f(x) dx = -∫_b^a f(x) dx"

/-! ## Integral of constant function -/

def integralOfConstant : Axiom :=
  Axiom.mk "integralOfConstant" (Formula.pred 0 [])
    "∫_a^b c dx = c·(b - a) for any constant c ∈ ℝ"

/-! ## Integration by substitution -/

def integrationBySubstitutionAxiom : Axiom :=
  Axiom.mk "integrationBySubstitution" (Formula.pred 0 [])
    "If φ is continuously differentiable on [a,b] and f is continuous on φ([a,b]), then ∫_a^b f(φ(x))·φ'(x) dx = ∫_{φ(a)}^{φ(b)} f(u) du"

/-! ## Integration by parts -/

def integrationByPartsAxiom : Axiom :=
  Axiom.mk "integrationByParts" (Formula.pred 0 [])
    "If u and v are differentiable on [a,b] with Riemann integrable derivatives, then ∫_a^b u(x)·v'(x) dx = u(b)·v(b) - u(a)·v(a) - ∫_a^b u'(x)·v(x) dx"

/-! ## Axiom system -/

def integrationLaws : AxiomSystem :=
  AxiomSystem.empty.addAxioms #[
    linearityOfIntegral,
    additivityOnIntervals,
    monotonicityOfIntegral,
    triangleInequalityIntegral,
    fundamentalTheoremOfCalculus1,
    fundamentalTheoremOfCalculus2,
    reversalOfLimits,
    integralOfConstant,
    integrationBySubstitutionAxiom,
    integrationByPartsAxiom
  ]

#eval s!"Core.Laws: {integrationLaws.axioms.length} integration axioms (expected: 10)"
#eval "Core.Laws: linearity, additivity, monotonicity, triangleIneq, FTC1, FTC2"
#eval "Core.Laws: reversalOfLimits, integralOfConstant, substitution, integrationByParts"

end MiniRiemannIntegration
