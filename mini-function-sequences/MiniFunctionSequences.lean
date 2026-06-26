/-
# MiniFunctionSequences

Sequences of functions: pointwise convergence, uniform convergence,
equicontinuity, Arzela-Ascoli theorem, Stone-Weierstrass theorem,
and related topics in real analysis.

This package provides the theory of function sequences on ℝ-valued
functions, including multiple modes of convergence, compactness
in function spaces, and approximation theory.

## Sub-packages
- `Core`           — SequenceOfFunctions, convergence definitions, equicontinuity
- `Morphisms`      — Convergence-preserving maps, summation methods
- `Constructions`  — Products, quotients, subobjects, universal constructions
- `Properties`     — Invariants, preservation, classification data
- `Theorems`       — Arzela-Ascoli, Stone-Weierstrass, Dini, Uniform Boundedness
- `Examples`       — Standard examples and counterexamples
- `Bridges`        — Connections to algebra, topology, geometry, computation
-/

import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Core.Laws
import MiniFunctionSequences.Core.Objects
import MiniFunctionSequences.Morphisms.Hom
import MiniFunctionSequences.Morphisms.Iso
import MiniFunctionSequences.Morphisms.Equiv
import MiniFunctionSequences.Constructions.Products
import MiniFunctionSequences.Constructions.Quotients
import MiniFunctionSequences.Constructions.Subobjects
import MiniFunctionSequences.Constructions.Universal
import MiniFunctionSequences.Properties.Invariants
import MiniFunctionSequences.Properties.Preservation
import MiniFunctionSequences.Properties.ClassificationData
import MiniFunctionSequences.Theorems.Basic
import MiniFunctionSequences.Theorems.Classification
import MiniFunctionSequences.Theorems.Main
import MiniFunctionSequences.Theorems.UniversalProperties
import MiniFunctionSequences.Examples.Standard
import MiniFunctionSequences.Examples.Counterexamples
import MiniFunctionSequences.Bridges.ToAlgebra
import MiniFunctionSequences.Bridges.ToTopology
import MiniFunctionSequences.Bridges.ToGeometry
import MiniFunctionSequences.Bridges.ToComputation
