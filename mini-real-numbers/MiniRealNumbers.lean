/-
# MiniRealNumbers

Real numbers: the unique complete ordered field.
This package provides definitions, properties, constructions,
and theorems about the real numbers ℝ, including Dedekind cuts,
Cauchy sequences, completeness, and the universal property
of ℝ as the unique complete ordered field.

## Sub-packages
- `Core`           — RealNumbers structure, Dedekind Cuts, Cauchy Sequences
- `Morphisms`      — Order-preserving maps, field homomorphisms, isomorphisms
- `Constructions`  — Products, quotients, subfields, universal constructions
- `Properties`     — Invariants (characteristic, cardinality), preservation, classification
- `Theorems`       — Density of ℚ, uncountability, nested intervals, Bolzano-Weierstrass
- `Examples`       — ℚ as non-complete field, ℝ(t), counterexamples
- `Bridges`        — Connections to algebra, topology, geometry, computation
-/

import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Core.Laws
import MiniRealNumbers.Core.Objects
import MiniRealNumbers.Morphisms.Hom
import MiniRealNumbers.Morphisms.Iso
import MiniRealNumbers.Morphisms.Equiv
import MiniRealNumbers.Constructions.Products
import MiniRealNumbers.Constructions.Quotients
import MiniRealNumbers.Constructions.Subobjects
import MiniRealNumbers.Constructions.Universal
import MiniRealNumbers.Properties.ClassificationData
import MiniRealNumbers.Properties.Invariants
import MiniRealNumbers.Properties.Preservation
import MiniRealNumbers.Theorems.Basic
import MiniRealNumbers.Theorems.Classification
import MiniRealNumbers.Theorems.Main
import MiniRealNumbers.Theorems.UniversalProperties
import MiniRealNumbers.Examples.Standard
import MiniRealNumbers.Examples.Counterexamples
import MiniRealNumbers.Bridges.ToAlgebra
import MiniRealNumbers.Bridges.ToTopology
import MiniRealNumbers.Bridges.ToGeometry
import MiniRealNumbers.Bridges.ToComputation
