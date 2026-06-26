/-
# MiniRiemannIntegration

Riemann integration theory: partitions, Darboux sums, Riemann sums,
Riemann integrability, the Fundamental Theorem of Calculus,
improper integrals, L¹ spaces, and bridges to computation and geometry.

This is a sub-package of the `mini-real-analysis` collection.

## Sub-packages
- `Core`           — Partitions, Darboux sums, Riemann integral, Improper integrals
- `Morphisms`      — Integral-preserving maps, isomorphisms, equivalences
- `Constructions`  — Products (Fubini), quotients (L¹), subobjects, universal properties
- `Properties`     — Invariants (norms, oscillation, variation), preservation, classification
- `Theorems`       — FTC, integration by parts, substitution, mean value, Cauchy-Schwarz
- `Examples`       — Standard integrals and counterexamples
- `Bridges`        — To algebra, topology, geometry, computation
-/

import MiniRiemannIntegration.Core.Basic
import MiniRiemannIntegration.Core.Laws
import MiniRiemannIntegration.Core.Objects
import MiniRiemannIntegration.Morphisms.Hom
import MiniRiemannIntegration.Morphisms.Iso
import MiniRiemannIntegration.Morphisms.Equiv
import MiniRiemannIntegration.Constructions.Products
import MiniRiemannIntegration.Constructions.Quotients
import MiniRiemannIntegration.Constructions.Subobjects
import MiniRiemannIntegration.Constructions.Universal
import MiniRiemannIntegration.Properties.Invariants
import MiniRiemannIntegration.Properties.Preservation
import MiniRiemannIntegration.Properties.ClassificationData
import MiniRiemannIntegration.Theorems.Basic
import MiniRiemannIntegration.Theorems.Classification
import MiniRiemannIntegration.Theorems.Main
import MiniRiemannIntegration.Theorems.UniversalProperties
import MiniRiemannIntegration.Examples.Standard
import MiniRiemannIntegration.Examples.Counterexamples
import MiniRiemannIntegration.Bridges.ToAlgebra
import MiniRiemannIntegration.Bridges.ToTopology
import MiniRiemannIntegration.Bridges.ToGeometry
import MiniRiemannIntegration.Bridges.ToComputation
