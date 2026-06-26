/-
# docs.TheoryGuide

Theory guide for Riemann integration: historical context,
theoretical development, and connections to modern analysis.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Historical Development -/

def historicalTimeline : List (String × String) := [
  ("Ancient", "Archimedes: method of exhaustion, area under parabola"),
  ("1670s", "Newton & Leibniz: calculus, antiderivatives"),
  ("1823", "Cauchy: first rigorous definition (continuous functions)"),
  ("1854", "Riemann: definition for general bounded functions"),
  ("1875", "Darboux: upper/lower sums reformulation"),
  ("1902", "Lebesgue: measure-theoretic criterion for Riemann integrability"),
  ("1912", "Daniell: integral via linear functionals"),
  ("1950s", "Henstock-Kurzweil: generalizes both Riemann and Lebesgue")
]

/-! ## Riemann vs Darboux -/

def riemannVsDarboux : List String := [
  "Riemann: choose tags t_i ∈ [x_i, x_{i+1}], sum Σ f(t_i)Δx_i",
  "Darboux: upper sum uses sup f, lower sum uses inf f on each subinterval",
  "Theorem: Riemann integrable iff Darboux integrable (upper = lower integral)",
  "Advantage of Darboux: upper/lower integrals always exist as inf/sup",
  "Riemann criterion: ∀ ε > 0 ∃ P: U(f,P) - L(f,P) < ε"
]

/-! ## Lebesgue Criterion -/

def lebesgueCriterionGuide : List String := [
  "Theorem (Lebesgue, 1902): A bounded function f on [a,b] is Riemann integrable",
  "iff the set of discontinuities of f has Lebesgue measure zero.",
  "Examples:",
  "  Dirichlet function: discontinuous everywhere (measure 1) → NOT integrable",
  "  Thomae function: discontinuous on ℚ (measure 0) → INTEGRABLE (∫ = 0)",
  "  Monotone functions: at most countably many discontinuities → INTEGRABLE",
  "  Continuous functions: 0 discontinuities → INTEGRABLE"
]

/-! ## Fundamental Theorem of Calculus -/

def ftcGuide : List String := [
  "FTC bridges differentiation and integration:",
  "  Part 1: ∫_a^b F'(x)dx = F(b) - F(a) (for F' integrable)",
  "  Part 2: d/dx ∫_a^x f(t)dt = f(x) (at continuity points of f)",
  "",
  "Caution: Not all derivatives are Riemann integrable!",
  "  Volterra (1881): A differentiable function whose derivative",
  "  exists everywhere but is not Riemann integrable.",
  "  The Henstock-Kurzweil integral fixes this: F' is always HK integrable."
]

/-! ## L¹ Completion -/

def L1CompletionGuide : List String := [
  "R([a,b]) with semimetric d(f,g) = ∫|f-g| is NOT complete.",
  "Its completion is L¹([a,b]), the space of Lebesgue integrable functions.",
  "",
  "Construction:",
  "  1. Start with semi-normed space (R([a,b]), ||·||₁)",
  "  2. Quotient by nullspace: N = {f : ∫|f| = 0}",
  "  3. Complete the resulting normed space → L¹([a,b])",
  "",
  "Key properties:",
  "  - L¹([a,b]) is a Banach space",
  "  - Step functions are dense in L¹",
  "  - Continuous functions are dense in L¹",
  "  - Dominated and monotone convergence hold in L¹"
]

/-! ## Connection to Modern Analysis -/

def connectionsToModernAnalysis : List String := [
  "Riemann integral → Lebesgue integral → abstract measure theory",
  "R([a,b]) → L¹([a,b]) → L^p spaces → functional analysis",
  "Riemann-Stieltjes → Riesz representation → Radon measures",
  "Daniell integral → Stone's theorem → abstract integration",
  "Numerical integration → quadrature rules → spectral methods"
]

#eval "docs.TheoryGuide: Historical timeline (8 entries)"
#eval "docs.TheoryGuide: Riemann vs Darboux, Lebesgue criterion"
#eval "docs.TheoryGuide: FTC guide, L¹ completion, modern analysis connections"
