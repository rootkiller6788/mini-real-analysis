/-
# MiniDifferentiation.Core.Laws

Differentiation laws: sum rule, product rule, quotient rule,
chain rule, linearity. Theorems: Fermat, Rolle, Mean Value,
Cauchy Mean Value. Encoded as kernel Axiom values.
-/

import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Arithmetic of derivatives (as Axiom values) -/

def sumRuleAxiom : Axiom :=
  Axiom.mk "sumRule" (Formula.pred 0 [])
    "If f and g are differentiable at a, then (f+g)'(a) = f'(a) + g'(a)"

def productRuleAxiom : Axiom :=
  Axiom.mk "productRule" (Formula.pred 0 [])
    "If f and g are differentiable at a, then (fg)'(a) = f'(a)g(a) + f(a)g'(a)"

def quotientRuleAxiom : Axiom :=
  Axiom.mk "quotientRule" (Formula.pred 0 [])
    "If f and g are differentiable at a and g(a) ≠ 0, then (f/g)'(a) = (f'(a)g(a) - f(a)g'(a)) / g(a)^2"

def chainRuleAxiom : Axiom :=
  Axiom.mk "chainRule" (Formula.pred 0 [])
    "If f differentiable at a and g differentiable at f(a), then (g∘f)'(a) = g'(f(a)) · f'(a)"

def linearityOfDerivativeAxiom : Axiom :=
  Axiom.mk "linearityOfDerivative" (Formula.pred 0 [])
    "The derivative operator D: f ↦ f' is linear: (αf + βg)' = αf' + βg'"

def scalarMultipleRuleAxiom : Axiom :=
  Axiom.mk "scalarMultipleRule" (Formula.pred 0 [])
    "(c·f)'(a) = c·f'(a) for any constant c"

def powerRuleAxiom : Axiom :=
  Axiom.mk "powerRule" (Formula.pred 0 [])
    "d/dx(x^n) = n·x^{n-1} for n ∈ N"

def inverseFunctionRuleAxiom : Axiom :=
  Axiom.mk "inverseFunctionRule" (Formula.pred 0 [])
    "If f is invertible near a and f'(a) ≠ 0, then (f^{-1})'(f(a)) = 1/f'(a)"

def arithmeticAxioms : AxiomSystem :=
  AxiomSystem.empty.addAxioms #[sumRuleAxiom, productRuleAxiom, quotientRuleAxiom,
    chainRuleAxiom, linearityOfDerivativeAxiom, scalarMultipleRuleAxiom,
    powerRuleAxiom, inverseFunctionRuleAxiom]

/-! ## Fundamental theorems of differentiation (as Axiom values) -/

def fermatTheoremAxiom : Axiom :=
  Axiom.mk "fermatTheorem" (Formula.pred 0 [])
    "If f has a local maximum or minimum at an interior point a and f'(a) exists, then f'(a) = 0"

def rolleTheoremAxiom : Axiom :=
  Axiom.mk "rolleTheorem" (Formula.pred 0 [])
    "If f is continuous on [a,b], differentiable on (a,b), and f(a)=f(b), then ∃ c∈(a,b): f'(c)=0"

def meanValueTheoremAxiom : Axiom :=
  Axiom.mk "meanValueTheorem" (Formula.pred 0 [])
    "If f is continuous on [a,b] and differentiable on (a,b), then ∃ c∈(a,b): f'(c) = (f(b)-f(a))/(b-a)"

def cauchyMeanValueTheoremAxiom : Axiom :=
  Axiom.mk "cauchyMeanValueTheorem" (Formula.pred 0 [])
    "If f,g continuous on [a,b], differentiable on (a,b), and g'(x)≠0, then ∃ c∈(a,b): (f(b)-f(a))/(g(b)-g(a)) = f'(c)/g'(c)"

def darbouxTheoremAxiom : Axiom :=
  Axiom.mk "darbouxTheorem" (Formula.pred 0 [])
    "Derivatives have the intermediate value property (Darboux property)"

def differentiationAxioms : AxiomSystem :=
  AxiomSystem.empty.addAxioms #[fermatTheoremAxiom, rolleTheoremAxiom,
    meanValueTheoremAxiom, cauchyMeanValueTheoremAxiom, darbouxTheoremAxiom]

/-! ## Total axiom system -/

def allDerivativeAxioms : AxiomSystem :=
  AxiomSystem.empty
    |>.addAxioms arithmeticAxioms.axioms
    |>.addAxioms differentiationAxioms.axioms

/-! ## #eval Tests -/

#eval s!"Arithmetic axioms: {arithmeticAxioms.axioms.length} (expected: 8)"
#eval s!"Differentiation axioms: {differentiationAxioms.axioms.length} (expected: 5)"
#eval s!"Total derivative axioms: {allDerivativeAxioms.axioms.length} (expected: 13)"
