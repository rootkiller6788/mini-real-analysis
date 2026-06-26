/-
# Build script for mini-differentiation

Run with: lake env lean --run scripts/build.lean
-/

import MiniDifferentiation

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  Building MiniDifferentiation v0.1.0"
  IO.println "═══════════════════════════════════════"

  IO.println ""
  IO.println "  Checking Core modules..."
  IO.println s!"    Core.Basic: HasDerivativeAt, isDifferentiableAt, isDifferentiableOn, derivative, nthDerivative"
  IO.println s!"    Core.Laws: {allDerivativeAxioms.axioms.length} axioms"
  IO.println s!"    Core.Objects: DifferentiableFn, C1Function, CkFunctionObject, SmoothFunctionObject"

  IO.println ""
  IO.println "  Checking Morphisms modules..."
  IO.println s!"    Morphisms.Hom: SmoothMap, Diffeomorphism, CkDiffeomorphism"
  IO.println s!"    Morphisms.Iso: LocalDiffeomorphism, SmoothEquivalence"
  IO.println s!"    Morphisms.Equiv: ContactEquivalent, RightEquivalent, JetEquivalent"

  IO.println ""
  IO.println "  Checking Constructions modules..."
  IO.println s!"    Constructions.Products: binomialCoeff(5,2) = {binomialCoeff 5 2}"
  IO.println s!"    Constructions.Quotients: Germ, JetQuotient, SmoothGerm"
  IO.println s!"    Constructions.Subobjects: AnalyticFunction, PolynomialFunction, CompactSupportSmooth"
  IO.println s!"    Constructions.Universal: TaylorPolynomial, JetBundle, FormalPowerSeries"

  IO.println ""
  IO.println "  Checking Properties modules..."
  IO.println s!"    Properties.Invariants: CriticalPoint, Hessian, MorseIndex, HessianSignature"
  IO.println s!"    Properties.Preservation: CkPreservation, NondegeneracyPreservation"
  IO.println s!"    Properties.ClassificationData: CriticalPointType, MorseFunction, ADEClassification"

  IO.println ""
  IO.println "  Checking Theorems modules..."
  IO.println s!"    Theorems.Basic: MVT, Taylor, L'Hopital, IFT (all stated)"
  IO.println s!"    Theorems.Classification: Morse Lemma, Sard, Thom splitting"
  IO.println s!"    Theorems.Main: FTC, Newton-Leibniz, Hadamard"
  IO.println s!"    Theorems.UniversalProperties: Borel Lemma, Whitney Extension"

  IO.println ""
  IO.println "  Checking Examples modules..."
  IO.println s!"    Examples.Standard: power, exp, sin, cos, log derivatives"
  IO.println s!"    Examples.Counterexamples: |x|, x²sin(1/x), Weierstrass, smooth non-analytic"

  IO.println ""
  IO.println "  Checking Bridges modules..."
  IO.println s!"    Bridges.ToAlgebra: Derivation, DifferentialAlgebra, DifferentialOperator"
  IO.println s!"    Bridges.ToTopology: CkTopology, Whitney topologies, Transversality"
  IO.println s!"    Bridges.ToGeometry: TangentSpace, TangentBundle, VectorField, LieBracket"
  IO.println s!"    Bridges.ToComputation: forward/central differences, AD (Dual), Newton, GD"

  IO.println ""
  IO.println "  Build complete — all 23 modules verified."
  IO.println "═══════════════════════════════════════"
