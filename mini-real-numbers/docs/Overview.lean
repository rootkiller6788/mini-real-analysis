/-
# Overview: The Real Numbers Theory Hierarchy

This document provides a high-level overview of the real numbers
formalization in the mini-real-numbers package.

## Structure

The package is organized into the following module groups:

### Core (3 modules)
Defines the basic structures: `RealNumbers`, `DedekindCut`,
`CauchySequence`, and the complete ordered field axioms.

### Morphisms (3 modules)
Maps between ordered fields: order-preserving maps, field homomorphisms,
isomorphisms, embeddings, and equivalences.

### Constructions (4 modules)
How to build new ordered fields from old: products, quotients,
subfields, and universal constructions.

### Properties (3 modules)
Invariant properties (characteristic, cardinality, separability),
preservation under morphisms, and classification data (real closed fields).

### Theorems (4 modules)
The main theorems: density of ℚ, uncountability (Cantor), nested intervals,
Bolzano-Weierstrass, Heine-Borel, IVT, EVT, classification of complete
ordered fields, and universal properties.

### Examples (2 modules)
Standard examples (ℚ, ℝ, ℚ(√2), ℝ(t)) and counterexamples
(ℚ incomplete, ℝ\{0} not a field, non-Archimedean fields).

### Bridges (4 modules)
Connections to algebra (Artin-Schreier, formally real fields),
topology (order topology, compactness), geometry (Euclidean space),
and computation (computable reals, decimal expansions).

### Computation (3 modules)
Algorithms (Newton's method, series for π and e), decision procedures
(Tarski's QE), and evaluation examples.

## Theory Dependencies

```
MiniObjectKernel
    ↓
MiniRealNumbers.Core.Basic
    ↓
MiniRealNumbers.Core.Laws
MiniRealNumbers.Core.Objects
    ↓
MiniRealNumbers.Morphisms.*
    ↓
MiniRealNumbers.Constructions.*
MiniRealNumbers.Properties.*
    ↓
MiniRealNumbers.Theorems.*
    ↓
MiniRealNumbers.Examples.*
MiniRealNumbers.Bridges.*
```

## Key Design Decisions

1. **Axiomatic approach**: ℝ is defined axiomatically as a complete
   ordered field rather than constructed (Dedekind cuts or Cauchy
   sequences). Both constructions are acknowledged as existence proofs.

2. **Structure-based**: `RealNumbers` is a structure with explicit field
   witnesses, not a typeclass. This allows multiple real number structures
   to coexist and be compared via isomorphisms.

3. **Kernel integration**: Uses `MiniObjectKernel` for the `Object`
   typeclass, `TheoryName`, and `Embedding` framework, situating ℝ
   within the broader mathematical ecosystem.

4. **Flat namespace**: All definitions are in `MiniRealNumbers` namespace,
   with the module hierarchy providing file organization only.

## Main Results

The package formalizes the following key results (with `sorry` for deep proofs):

- **Existence**: There exists a complete ordered field (axiom)
- **Uniqueness**: Any two complete Archimedean ordered fields are
  uniquely isomorphic
- **Completeness**: Dedekind completeness, Cauchy completeness, and the
  cut property are equivalent
- **Universal property**: ℝ is the Dedekind completion of ℚ and the
  terminal object in the category of complete Archimedean ordered fields
- **Uncountability**: Cantor's diagonal argument that ℝ is uncountable
- **Structure theorems**: Nested intervals, Bolzano-Weierstrass,
  Heine-Borel, Intermediate Value Theorem, Extreme Value Theorem

## Building

```bash
cd mini-real-numbers
lake build
lake env lean --run Test/Basic.lean
```

## Next Steps

- Fill in `sorry` proofs with actual constructions
- Implement Dedekind cuts on ℚ explicitly
- Prove completeness equivalence in full detail
- Add more #eval demonstrations with Lean's native ℝ
-/
