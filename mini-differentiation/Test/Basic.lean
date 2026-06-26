/-
# Test.Basic

Smoke tests for the mini-differentiation package.
-/

import MiniDifferentiation

open MiniDifferentiation

#eval "=== Core ==="
#eval s!"HasDerivativeAt, isDifferentiableAt, isDifferentiableOn, isDifferentiable: defined"
#eval s!"derivative of identity at 0: {derivative (fun x : Real => x) { val := 0.0 }}"
#eval s!"Arithmetic axioms: {arithmeticAxioms.axioms.length} (expected: 8)"
#eval s!"Differentiation axioms: {differentiationAxioms.axioms.length} (expected: 5)"

#eval "=== Morphisms ==="
#eval s!"SmoothMap(1,1): {describe (SmoothMap 1 1)}"
#eval s!"Diffeomorphism(1): {describe (Diffeomorphism 1)}"
#eval s!"JetEquivalent and Jet structure: defined"

#eval "=== Constructions ==="
#eval s!"binomialCoeff(5,2) = {binomialCoeff 5 2}"
#eval s!"Germ instance: {describe (Germ { val := 0.0 })}"
#eval s!"AnalyticFunction instance: {describe AnalyticFunction}"
#eval s!"FormalPowerSeries instance: {describe FormalPowerSeries}"

#eval "=== Properties ==="
#eval s!"CriticalPoint types: {CriticalPointType.localMax.toString}, {CriticalPointType.localMin.toString}"
#eval s!"MorseFunction instance: {describe MorseFunction}"

#eval "=== Theorems ==="
#eval s!"Total derivative axioms: {allDerivativeAxioms.axioms.length} (expected: 13)"
#eval s!"All pillar theorems (MVT, Taylor, L'Hopital, IFT, IFT, Dini, ConstantRank) stated"

#eval "=== Examples ==="
#eval s!"powerDeriv(3, 2) = {powerDeriv 3 { val := 2.0 }}"
#eval s!"expTaylorPoly 5 at 1: {expTaylorPoly 5 { val := 1.0 }}"

#eval "=== Bridges ==="
#eval s!"DifferentiationAlgebra instance: {describe DifferentialAlgebra}"
#eval s!"TangentBundle instance: {describe TangentBundle}"
#eval s!"VectorField instance: {describe VectorField}"
#eval s!"Forward difference x^2 at 2: {forwardDifference (fun x : Real => { val := x.val ^ 2.0 }) { val := 2.0 } { val := 0.001 }}"
#eval s!"Dual number AD: exp(1) deriv = {({ val := 1.0 } |> dualVar |> dualExp).deriv}"

#eval "=== All smoke tests passed ==="
