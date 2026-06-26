/-
# API Reference: MiniMeasureLebesgue

## Modules

### Core
- `Core/Basic` — SigmaAlgebra, MeasurableSpace, Measure, LebesgueMeasure,
  nullSet, almostEverywhere, MeasurableFunction, SimpleFunction, lebesgueIntegral
- `Core/Laws` — countableAdditivity, monotonicityOfMeasure, countableSubadditivity,
  continuityFromBelow/Above, lebesgueMeasureIsTranslationInvariant,
  lebesgueMeasureOfInterval
- `Core/Objects` — Object instances for all measure-theoretic structures,
  LebesgueIntegral as functional

### Morphisms
- `Morphisms/Hom` — MeasurableMap, MeasurePreservingMap, ErgodicMap, IntegralPreservingMap
- `Morphisms/Iso` — MeasureSpaceIso, isConjugate, LpSpaceIso
- `Morphisms/Equiv` — absolutelyContinuous (≪), mutuallySingular (⟂), equivalentMeasures (≈)

### Constructions
- `Constructions/Products` — ProductSigmaAlgebra, ProductMeasure, Fubini-Tonelli
- `Constructions/Quotients` — setEqModNull, LpSpace, essentialSup, LinfinitySpace
- `Constructions/Subobjects` — L1Space, L2Space, LinfSpace, SubSigmaAlgebra, ConditionalExpectation
- `Constructions/Universal` — RadonMeasure, rieszRepresentation, UniversalLebesgueIntegral,
  CaratheodoryExtension

### Properties
- `Properties/Invariants` — isFiniteMeasure, isSigmaFinite, isProbabilityMeasure,
  isComplete, RegularMeasure
- `Properties/Preservation` — measurability preserved by composition, integrability
  under absolute continuity, L^p norm preservation, Young's inequality
- `Properties/ClassificationData` — isDiscreteMeasure, isAbsolutelyContinuousMeasure,
  isSingularMeasure, LebesgueDecomposition, RadonNikodymDerivative,
  measureTrichotomy

### Theorems
- `Theorems/Basic` — monotoneConvergenceTheorem, fatouLemma,
  dominatedConvergenceTheorem, fubiniTheorem, tonelliTheorem,
  radonNikodymTheorem
- `Theorems/Classification` — lebesgueDecompositionTheorem,
  riemannIntegrabilityCharacterization, lpInclusionsFiniteMeasure,
  lpIsComplete
- `Theorems/Main` — lebesgueIntegralExtendsRiemann, luzinTheorem,
  egorovTheorem
- `Theorems/UniversalProperties` — l1IsCompletionOfCc,
  rieszRepresentationCcStar, daniellEquivalence

### Examples
- `Examples/Standard` — Lebesgue measure examples, elementary integrals,
  convergence theorem applications
- `Examples/Counterexamples` — Dirichlet function, sin(x)/x,
  pointwise convergence without domination, Vitali set

### Bridges
- `Bridges/ToAlgebra` — BanachAlgebraL1, MeasureAlgebra, MeasurableSetsModNull,
  LinftyAlgebra
- `Bridges/ToTopology` — LpCompleteMetricSpace, weakConvergence,
  prokhorovTheorem, WassersteinDistance
- `Bridges/ToGeometry` — LebesgueMeasureNd, HausdorffMeasure,
  Area/Coarea formulas, isoperimetricInequality
- `Bridges/ToComputation` — MonteCarloIntegration, RejectionSampling,
  NumericalLebesgueIntegration, GaussianQuadrature
-/

/-
## Quick reference

```lean
import MiniMeasureLebesgue
open MiniMeasureLebesgue

-- Create a sigma-algebra
let sigma : SigmaAlgebra X := SigmaAlgebra.trivial X

-- Create a measure space
example : MeasureSpace := default

-- Check absolute continuity
example : ν ≪ μ := by ...

-- Apply MCT
example : True := monotoneConvergenceTheorem ...

-- Use Luzin's theorem
example : True := luzinTheorem ...
```
-/
