/-
# docs.APIReference

API reference for MiniRiemannIntegration package.
Documents all public structures, functions, and axioms.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Core API -/

def apiCoreBasic : List String := [
  "Partition — partition of [a,b] with points list",
  "Partition.mesh — maximum subinterval width",
  "upperSum f P — upper Darboux sum",
  "lowerSum f P — lower Darboux sum",
  "upperIntegral f a b — infimum of upper sums",
  "lowerIntegral f a b — supremum of lower sums",
  "isRiemannIntegrable f a b — Darboux integrability",
  "riemannIntegral f a b — value of the Riemann integral",
  "isDarbouxIntegrable f a b — ε-partition criterion",
  "RiemannSum f P — Riemann sum with tags",
  "riemannSumValue f P tags — evaluate Riemann sum",
  "ImproperIntegral — improper integral structure",
  "uniformPartition a b n hn — uniform partition"
]

/-! ## Core Objects API -/

def apiCoreObjects : List String := [
  "IntegrableFunction a b — function with integrability proof",
  "RiemannIntegralFunctional a b — integral as functional",
  "RiemannSpace a b — R([a,b]) notation",
  "StepFunction a b — piecewise constant function"
]

/-! ## Morphisms API -/

def apiMorphisms : List String := [
  "IntegralPreservingMap — map preserving integrals",
  "MeasurePreservingMap — length-preserving transformations",
  "ChangeOfVariables — substitution morphism",
  "FourierTransform — Fourier integral transform",
  "LaplaceTransform — Laplace integral transform",
  "ConvolutionOperator — convolution operator",
  "RiemannDarbouxEquivalence — equivalence proof structure",
  "SubstitutionIsomorphism — substitution as isomorphism",
  "L1Isometry — isometry between L¹ spaces"
]

/-! ## Theorems API -/

def apiTheorems : List String := [
  "fundamentalTheoremOfCalculus_part1 — FTC part 1 (theorem)",
  "fundamentalTheoremOfCalculus_part2 — FTC part 2 (theorem)",
  "integrationByParts — integration by parts",
  "changeOfVariables — substitution rule",
  "meanValueTheoremForIntegrals — MVT for integrals",
  "cauchySchwarzIntegral — Cauchy-Schwarz on R([a,b])",
  "continuousFunctionsAreRiemannIntegrable",
  "lebesgueCriterion — Lebesgue's integrability criterion",
  "riemannCriterion — ε-partition criterion"
]

/-! ## Numerical Integration API -/

def apiComputation : List String := [
  "rectangleRule f a b n — left-endpoint rectangle rule",
  "trapezoidalRule f a b n — trapezoidal rule",
  "simpsonRule f a b n — Simpson's rule",
  "midpointRule f a b n — midpoint rule",
  "rombergTable f a b — Romberg integration table",
  "adaptiveQuadrature f a b ε — adaptive quadrature",
  "refinePartition P — bisect subintervals",
  "checkRiemannCriterion f a b ε — heuristic integrability check"
]

#eval "docs.APIReference: Core.Basic (13 entries)"
#eval "docs.APIReference: Core.Objects (4 entries)"
#eval "docs.APIReference: Morphisms (9 entries)"
#eval "docs.APIReference: Theorems (9 entries)"
#eval "docs.APIReference: Computation (8 entries)"
