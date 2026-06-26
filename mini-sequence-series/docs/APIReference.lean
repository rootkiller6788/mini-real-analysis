/-
# API Reference — mini-sequence-series

Module-by-module reference of all exported definitions.

## Core
### Core/Basic
- `Sequence α`              : ℕ → α
- `Sequence.limit s L`     : ε-N definition
- `isConvergent s`         : ∃ L, limit s L
- `isBounded s`            : ∃ M, ∀ n, |s n| ≤ M
- `isMonotone / isIncreasing / isDecreasing`
- `Subsequence`            : parent · indexMap
- `Series a`               : partial sums
- `Series.sum / limitSum`
- `isAbsolutelyConvergent / isConditionallyConvergent`
- `PowerSeries`            : Σ a_n (x-c)^n
- `radiusOfConvergence`
- `isCauchy`               : ε-N criterion

### Core/Objects
- `Object` instances for Sequence, Series, PowerSeries
- `LimSeq`, `SumSeq`, `AbsSumSeq`
- TheoryNodes: `sequenceNode`, `seriesNode`, `convergenceNode`

### Core/Laws
- 4 sequence axioms + 6 series axioms = 10 total
- `sequenceConvergenceAxioms`, `seriesConvergenceAxioms`

## Morphisms
### Morphisms/Hom
- `SequenceMap` — limit-preserving transformation
- `cesaroMean` — partial sum averaging
- `shiftSeq`, `scaleSeq`, `pointwiseAdd/Mul/Neg`

### Morphisms/Iso
- `isAsymptoticallyEquivalent`
- `RateOfConvergence` (sublinear, linear, quadratic, exponential)
- `SequenceIsomorphism`

### Morphisms/Equiv
- Cauchy ↔ monotone bounded convergence
- Ratio ↔ root test equivalence
- p-series convergence/divergence

## Constructions
### Constructions/Products
- `productSeq`, `ProductSeqSpace`

### Constructions/Quotients
- `c0Space`, `cSpace`, `cQuotientc0`
- `nullSeqRelation`, `QuotientSeqSpace`

### Constructions/Subobjects
- `ℓ1Space`, `ℓ2Space`, `ℓ∞Space`
- Inclusion chain: ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞

### Constructions/Universal
- `ℓ1FreeBanachOnℕ`, `c0IsUniversal`
- `SeqCompletion`, `completeSequenceSpace`

## Properties
### Properties/Invariants
- `RateEstimate`, `OrderOfGrowth`, `asymptoticDensity`
- Convergence/boundedness invariant under subsequence

### Properties/Preservation
- Limits preserved by continuous functions
- Convergence preserved by subsequence
- Boundedness under scaling, addition, multiplication

### Properties/ClassificationData
- `SequenceClassification`
- `isCesaroSummable`, `AbelSum`, `isTauberianCondition`
- `SummationMethod` hierarchy

## Theorems
### Theorems/Basic
- `bolzanoWeierstrassSequence`
- `monotoneConvergenceTheorem`
- `cauchyCompletenessOfReals`
- `ratioTestTheorem`, `rootTestTheorem`
- `alternatingSeriesTest`, `integralTest`
- `comparisonTestPrecise`

### Theorems/Classification
- `absoluteConvergenceImpliesConvergence`
- `riemannRearrangementTheorem`
- `dirichletTest`, `abelTest`

### Theorems/Main
- `everyCauchySequenceConvergesInReals`
- `powerSeriesHasRadiusOfConvergence`
- `abelTheorem`

### Theorems/UniversalProperties
- `ℓ1UniversalPropertyFully`
- `completionUniversalProperty`
- `c0UniversalProperty`

## Examples
### Examples/Standard
- `harmonicSeq`, `geometricSeq`, `geometricSeries`
- `exponentialSeries`, `fac`
- `pSeries`, `pSeriesSum`
- `alternatingHarmonicSeq`, `alternatingHarmonicSeries`
- `constantSeq`

### Examples/Counterexamples
- Harmonic series diverges
- Σ 1/(n log n) diverges
- Rearrangement changes sum of conditionally convergent series
- Ratio test inconclusive example
- nth term test insufficient
-/

#eval "APIReference: Full module-by-module documentation"
