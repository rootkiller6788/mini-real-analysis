/-
# MiniMeasureLebesgue: Overview

A formalization of measure theory and Lebesgue integration in Lean 4,
with an emphasis on foundational concepts and connections to other areas
of mathematics.

## Architecture

The package follows the MiniMathKernel pattern:
- **Core** — types and definitions
- **Morphisms** — structure-preserving maps
- **Constructions** — building new objects from old
- **Properties** — invariants and preservation
- **Theorems** — the main results
- **Examples** — concrete instances
- **Bridges** — connections to other theories

## What is Formalized

### Measure Theory Foundations
- Sigma-algebras (with trivial, discrete, and empty examples)
- Measurable spaces
- Measures (countably additive, nonnegative set functions)
- Lebesgue measure on ℝ (translation-invariant)
- Null sets and "almost everywhere" quantification
- Measurable functions and simple functions
- The Lebesgue integral (supremum of simple function integrals)

### Convergence Theorems
- Monotone Convergence Theorem (MCT)
- Fatou's Lemma
- Dominated Convergence Theorem (DCT)
- Fubini-Tonelli Theorem
- Radon-Nikodym Theorem

### L^p Spaces
- L^1, L^2, L^∞ spaces
- L^p as complete metric spaces (Riesz-Fischer)
- Inclusions on finite measure spaces
- Conditional expectation

### Advanced Topics
- Lebesgue decomposition
- Radon-Nikodym derivative
- Riesz representation theorem
- Caratheodory extension
- Luzin and Egorov theorems

### Bridges
- **To Algebra** — L^1 as Banach algebra, measure algebra, Boolean algebra of measurable sets
- **To Topology** — L^p as complete metric spaces, weak convergence, Prokhorov
- **To Geometry** — Lebesgue measure as volume, Hausdorff measure, area/coarea formulas
- **To Computation** — Monte Carlo integration, rejection sampling, Gaussian quadrature

## Design Philosophy

1. **Kernel-based**: All structures inherit from MiniObjectKernel's Object typeclass
2. **Realistic code**: Theorems stated with correct hypotheses and conclusions
3. **Proof-by-sorry**: Deep proofs use `sorry`; the focus is on correct statements
4. **Connected**: Bridges connect measure theory to algebra, topology, geometry, computation
5. **Testable**: Every source file has #eval tests; full test suite available

## Usage

```bash
# Build
cd "F:\nano-everything\mini-everything-math\6. mini-real-analysis\mini-measure-lebesgue"
lake build

# Run main
lake env lean --run Main.lean

# Run tests
lake env lean --run Test/Basic.lean
lake env lean --run Test/ConstructionTests.lean
lake env lean --run Test/MorphismTests.lean

# Run benchmarks
lake env lean --run Benchmark/FullSuite.lean
```
-/
