/-
# API Reference — mini-differentiation

## Core.Basic
- `HasDerivativeAt f a f'` — ε-δ definition of derivative
- `isDifferentiableAt f a` — ∃ f', HasDerivativeAt f a f'
- `isDifferentiableOn f A` — differentiable on a set A
- `derivative f a` — returns the derivative value if it exists
- `nthDerivative f n a` — n-th order derivative
- `isCk f k` — f is C^k
- `isSmooth f` — f is C^∞
- `isAnalytic f a` — f is analytic at a
- `partialDerivative f i a` — ∂f/∂x_i
- `directionalDerivative f v a` — derivative in direction v
- `gradient f a` — gradient vector
- `jacobianMatrix f a` — Jacobian matrix

## Core.Laws (as Axiom values)
- `sumRuleAxiom`, `productRuleAxiom`, `quotientRuleAxiom`, `chainRuleAxiom`
- `linearityOfDerivativeAxiom`, `scalarMultipleRuleAxiom`, `powerRuleAxiom`
- `fermatTheoremAxiom`, `rolleTheoremAxiom`, `meanValueTheoremAxiom`
- `cauchyMeanValueTheoremAxiom`, `darbouxTheoremAxiom`

## Core.Objects
- `DifferentiableFn` — function + differentiability proof (Object instance)
- `C1Function` — C^1 function structure
- `CkFunctionObject k` — C^k function object
- `SmoothFunctionObject` — C^∞ function object
- `DerivativeOperator` — bounded linear operator on C^1

## Theorems
- `meanValueTheorem`, `taylorTheoremLagrange`, `taylorTheoremCauchy`
- `lHopitalRule_00`, `lHopitalRule_infInf`
- `inverseFunctionTheorem1D`, `inverseFunctionTheoremND`
- `implicitFunctionTheorem`, `diniImplicitFunction`
- `morseLemma1D`, `morseLemmaND`, `sardTheorem1D`, `sardTheorem`
- `fundamentalTheoremOfCalculus1`, `newtonLeibnizFormula`
- `hadamardLemma`, `borelLemma`, `whitneyExtensionTheorem`

## Computation
- `forwardDifference`, `backwardDifference`, `centralDifference`
- `richardsonExtrapolation`
- `Dual` numbers (forward-mode AD)
- `newtonStep`, `newtonIteration`
- `gradientDescentStep`, `gradientDescent`
-/

#eval "APIReference: complete documentation of all public types, theorems, and functions"
