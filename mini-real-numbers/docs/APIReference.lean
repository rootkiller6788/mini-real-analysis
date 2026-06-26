/-
# API Reference: mini-real-numbers

Module-by-module API reference for the real numbers package.

## Core Modules

### Core/Basic.lean
- `RealNumbers` — structure: carrier, field operations, order, completeness
- `isUpperBound`, `isLowerBound` — bound predicates
- `isSupremum`, `isInfimum` — supremum/infimum definitions
- `supremum`, `infimum` — partial functions for computing sup/inf
- `ArchimedeanProperty` — ∀x, ∃n:ℕ, n > x
- `DedekindCut` — structure with lower/upper sets
- `CauchySequence` — ε-N convergence condition
- `ConvergesTo` — limit of a sequence
- `CompleteOrderedField` — typeclass for COF

### Core/Laws.lean
- `completenessAxiom` — completeness as an axiom string
- `archimedeanAxiom` — Archimedean property as axiom string
- `fieldAxiom` — field laws as axiom string
- `orderAxiom` — order laws as axiom string
- `dedekindCompleteness` — Dedekind completeness axiom
- `completenessProp` — completeness as Prop
- `archimedeanProp` — Archimedean as Prop
- `cauchyCompleteness` — Cauchy completeness as Prop
- `AxiomSet` — structure bundling all axioms
- `canonicalAxiomSet` — standard axiom instance

### Core/Objects.lean
- `instance : Object RealNumbers` — kernel registration
- `realAnalysisTheory` — TheoryName "RealAnalysis"
- `registerRealNumbersTheory` — IO registration action
- `ℝType` — type alias for RealNumbers
- `mkRealNumbers` — constructor helper
- `isComplete` — typeclass predicate
- `isDedekindComplete` — Dedekind completeness predicate

## Morphism Modules

### Morphisms/Hom.lean
- `OrderPreservingMap` — structure with toFun and map_order
- `OrderPreservingMap.id` — identity
- `OrderPreservingMap.comp` — composition
- `FieldHomomorphism` — extends OrderPreservingMap, preserves ops
- `FieldHomomorphism.id` — identity
- `FieldHomomorphism.comp` — composition
- `isEmbedding` — injective field homomorphism

### Morphisms/Iso.lean
- `OrderedFieldIso` — bijective field homomorphism
- `OrderedFieldIso.id` — identity isomorphism
- `OrderedFieldIso.symm` — inverse isomorphism
- `OrderedFieldIso.trans` — composition
- `anyTwoCompleteOrderedFieldsAreIsomorphic` — uniqueness theorem
- `uniquenessOfRealNumbers` — ℝ is unique
- `OrderedFieldIso.toKernelIso` — conversion to kernel Iso

### Morphisms/Equiv.lean
- `isOrderIsomorphic` — Prop: bijective order-preserving bijection exists
- `isOrderIsomorphic.refl/.symm/.trans` — equivalence relation
- `dedekindCompleteness_iff_cauchyCompleteness` — equivalence theorem
- `dedekindCompleteness_implies_cut` — completeness ⇒ cut property
- `orderedFieldEquiv` — isomorphism equivalence relation

## Construction Modules

### Constructions/Products.lean
- `ProductOrderedStructure` — Cartesian product with pointwise ops
- `LexicographicLe` — lexicographic order
- `LexicographicProduct` — lexicographic ordered product

### Constructions/Quotients.lean
- `OrderFieldCongruence` — congruence on ordered field
- `QuotientOrderedField` — quotient by congruence
- `naturalProjection` — FieldHomomorphism to quotient

### Constructions/Subobjects.lean
- `Subfield` — structure: subset closed under operations
- `fullSubfield` — the entire carrier
- `Subfield.inter` — intersection of subfields
- `DenseSubfield` — predicate: between any two reals
- `rationalsAreDenseSubfield` — ℚ is dense
- `intermediateValueProperty` — IVP statement
- `generatedSubfield` — smallest subfield containing S

### Constructions/Universal.lean
- `universalPropertyOfRealNumbers` — ℚ → ℝ is universal
- `realNumbersIsTerminalObject` — ℝ terminal in complete fields
- `categoryArchField` — category description
- `rationalsInitial` — ℚ initial in Arch fields
- `realsTerminal` — ℝ terminal in Arch complete fields
- `rationalsEmbedding` — ℚ embeds in every COF
- `dedekindCompletionUniversal` — universal property of Dedekind completion

## Properties Modules

### Properties/Invariants.lean
- `characteristicZero` — Prop: n·1 ≠ 0 for n > 0
- `torsionFree` — no nonzero torsion elements
- `charZero_implies_torsionFree` — theorem
- `isUncountable` — Prop: no ℕ → ℝ surjection
- `realsAreUncountable` — Cantor diagonal theorem
- `noEnumerationOfReals` — corollary
- `isSeparable` — has countable dense subset
- `rationalsAreCountableDense` — ℚ is countable dense
- `cardinalityOfReals` — "𝔠 = 2^ℵ₀"
- `realsHaveContinuumCardinality` — |ℝ| = |P(ℕ)|

### Properties/Preservation.lean
- `preservesSuprema` — predicate on order-preserving maps
- `iso_preservesSuprema` — isos preserve suprema
- `hom_preservesZero` / `hom_preservesOne` — theorems
- `hom_preservesCharacteristic` — char lifts along hom
- `completenessPreservedUnderIso` — completeness lifts
- `completeness_lifts_along_iso` — corollary
- `archimedean_lifts_along_iso` — Arch property lifts

### Properties/ClassificationData.lean
- `RealClosedField` — typeclass: sqrt + odd degree root
- `isRealClosed` — predicate
- `tarskiTheorem` — RCF is complete and decidable
- `rcfModelComplete` — RCF theory is model-complete
- `rcfElementarilyEquivalentToreals` — all RCFs ≡ ℝ
- `classificationOfCompleteOrderedFields` — classification theorem
- `onlyArchimedeanRCF_is_R` — Arch RCF = ℝ
- `realAlgebraicNumbers` — placeholder subfield
- `realAlgebraicsAreRCF` — theorem

## Theorems Modules

### Theorems/Basic.lean
- `rationalsAreDenseInReals` — ℚ dense in ℝ
- `everyOpenIntervalContainsRational` — corollary
- `realsAreUncountable` — Cantor diagonal
- `nestedIntervalTheorem` — ⋂[a_n,b_n] ≠ ∅
- `bolzanoWeierstrass` — bounded seq has convergent subseq
- `heineBorel` — closed bounded = compact
- `compactnessOfClosedInterval` — [a,b] compact
- `intermediateValueTheorem` — IVT
- `extremeValueTheorem` — EVT

### Theorems/Classification.lean
- `classificationTheorem` — Arch COF unique
- `uniquenessOfCompleteOrderedField` — string
- `realClosedFieldElementarilyEquivalentToReals` — RCF ≡ ℝ
- `archimedeanRCFIsomorphicToReals` — Arch RCF ≅ ℝ
- `rcf_sqrtUnique` — unique sqrt in RCF
- `noProperCompleteSubfield` — ℝ minimal complete
- `primeSubfieldIsRationals` — prime subfield ≅ ℚ
- `rcfCategoricity` — categoricity in powers

### Theorems/Main.lean
- `realNumbersExist` — axiom: COF exists
- `existsByDedekindCuts` — via Dedekind construction
- `existsByCauchySequences` — via Cauchy completion
- `realNumbersAreUnique` — unique up to unique iso
- `isomorphismIsUnique` — uniqueness of isomorphism
- `realNumbersAxioMatization` — axiomatization string
- `mainStructureTheorem` — structure theorem

### Theorems/UniversalProperties.lean
- `realNumbersIsDedekindCompletionOfRationals` — ℝ completes ℚ
- `universalPropertyDedekindCompletion` — universal arrow
- `rationalsToRealsEmbedding` — ℚ → ℝ embedding
- `rationalsToRealsIsEpimorphism` — ℚ → ℝ is epic
- `anyArchimedeanFieldEmbedsIntoReals` — every Arch field ⊆ ℝ
- `rationalsIsSmallestArchimedeanOrderedField` — ℚ minimal
- `realsIsLargestArchimedeanOrderedField` — ℝ maximal

## Examples Modules

### Examples/Standard.lean
- `rationalNumbersAsOrderedField` — ℚ as OF
- `rationalsAreArchimedean` — ℚ is Archimedean
- `rationalsNotComplete` — ℚ incomplete
- `realNumbersAsCOF` — ℝ as COF
- `realsAreComplete` — ℝ is complete
- `QAdjoinSqrt2` — ℚ(√2) elements
- `qAdjoinSqrt2AsOrderedField` — ℚ(√2) as OF
- `rationalFunctionsOverReals` — ℝ(t) as OF

### Examples/Counterexamples.lean
- `rationalsNotComplete_explicit` — proof ℚ incomplete
- `rationals_cauchyIncomplete` — Cauchy incomplete
- `realsMinusZeroNotField` — ℝ\{0} not a field
- `rationalFunctionsNotArchimedean` — ℝ(t) non-Arch
- `nonArchimedeanFieldsExist` — existence theorem
- `finiteDecimalsCounterexample` — finite decimals incomplete

## Bridges Modules

### Bridges/ToAlgebra.lean
- `realsIsTerminalInArchimedeanOF` — ℝ terminal
- `rationalsIsInitialInArchimedeanOF` — ℚ initial
- `isFormallyReal` — -1 not a sum of squares
- `orderedField_isFormallyReal` — OF ⇒ formally real
- `artinSchreier` — Artin-Schreier theorem
- `realClosureOfQ` — real algebraic numbers
- `realsIsRCF` — ℝ is RCF
- `rcf_iff_ivt` — RCF ⇔ IVT for polynomials

### Bridges/ToTopology.lean
- `openRay`, `closedRay` — open/closed rays
- `openInterval`, `closedInterval` — intervals
- `isOpen`, `isClosed` — topological predicates
- `intervalTopologyBasicOpens` — interval topology basis
- `closedIntervalCompact_iff_complete` — completeness equivalence
- `finiteIntersectionProperty` — FIP
- `realsIsConnected` — ℝ connected
- `connectedSubsetsAreIntervals` — classification
- `sequentialCompactness_iff_closedBounded` — sequential compactness
- `bolzanoWeierstrass_sequentialCompactness` — BW theorem

### Bridges/ToGeometry.lean
- `euclideanSpace` — ℝ^n
- `euclideanInnerProduct` — dot product
- `euclideanDistance` — metric
- `triangleInequality` — triangle inequality
- `realLineChart` — identity chart
- `realLineManifoldStructure` — ℝ as manifold
- `EuclideanPoint` — point structure
- `ParametricLine` — line structure
- `areParallel` / `areIntersecting` — line relations
- `twoPointsDetermineLine` — uniqueness of line
- `AffineTransformation` — T(x) = Ax + b
- `euclideanMotionGroup` — E(n) group
- `euclideanMotionPreservesDistance` — invariance

### Bridges/ToComputation.lean
- `equalityOnRealsIsUndecidable` — undecidable equality
- `noDecidableEquality` — ¬ DecidableEq ℝ
- `ComputableReal` — computable real structure
- `computableRealsAreCountableSubfield` — computable reals form field
- `nonComputableRealsExist` — existence theorem
- `computableNumberExamples` — list of examples
- `DecimalExpansion` — decimal expansion structure
- `everyRealHasDecimalExpansion` — existence theorem
- `doubleExpansionExample` — 0.999... = 1.000...
- `decimalApproximation` — rounding function
- `decimalApproximationError` — error bound

## Computation Modules

### Computation/Algorithms.lean
- `newtonSqrt` — Newton's method for √a
- `sqrt2NewtonSequence` — Newton for √2
- `gregoryLeibniz` — Gregory-Leibniz series for π
- `machinPiFormula` — Machin's formula
- `arctanSeries` — Taylor series for arctan
- `eSequence` — (1+1/n)^n for e
- `bisectionMethod` — root finding
- `decimalDigit` — nth digit computation

### Computation/DecisionProcedures.lean
- `tarskiQEDescription` — Tarski's QE
- `qeAlgorithm` — algorithm overview
- `sturmSequence` — Sturm sequences
- `signChangesAt` — sign change counting
- `sturmTheorem` — Sturm's theorem
- `cadDescription` — CAD description
- `cadQe` — CAD-based QE
- `qeComplexity` — complexity bounds

### Computation/Evaluate.lean
- `constantSequence` / `constantSequenceLimit`
- `reciprocalSequence` / `reciprocalLimit`
- `geometricSequence` / `geometricLimit`
- `harmonicSequence` / `harmonicDiverges`
- `eulerSequence` / `eulerLimit`
- `wallisProduct` / `wallisConverges`

## Test Modules

### Test/Basic.lean
- 8 #eval tests on core definitions

### Test/ConstructionTests.lean
- 6 #eval tests on constructions

### Test/MorphismTests.lean
- 6 #eval tests on morphisms

## Benchmark Modules

### Benchmark/FieldOps.lean — 15 targets
### Benchmark/OrderBench.lean — 12 targets
### Benchmark/SupremumBench.lean — 10 targets
### Benchmark/DedekindBench.lean — 10 targets
### Benchmark/CauchyBench.lean — 10 targets
### Benchmark/FullSuite.lean — aggregate

This concludes the API reference for mini-real-numbers.
-/
