/-
# MiniMeasureLebesgue

Measure theory and Lebesgue integration — the foundation of modern analysis.
This package provides definitions, properties, constructions, and theorems
about measures, measurable functions, and the Lebesgue integral.

## Sub-packages
- `Core`           — Sigma-algebras, measures, measurable functions, simple functions
- `Morphisms`      — Measurable maps, measure-preserving maps, equivalence of measures
- `Constructions`  — Product measures, L^p quotients, subobjects, universal properties
- `Properties`     — Finite/sigma-finite/probability measures, regularity, preservation
- `Theorems`       — MCT, DCT, Fatou, Fubini, Radon-Nikodym, Luzin, Egorov
- `Examples`       — Standard integrable functions, counterexamples
- `Bridges`        — Connections to algebra, topology, geometry, computation
-/

import MiniMeasureLebesgue.Core.Basic
import MiniMeasureLebesgue.Core.Laws
import MiniMeasureLebesgue.Core.Objects
import MiniMeasureLebesgue.Morphisms.Hom
import MiniMeasureLebesgue.Morphisms.Iso
import MiniMeasureLebesgue.Morphisms.Equiv
import MiniMeasureLebesgue.Constructions.Products
import MiniMeasureLebesgue.Constructions.Quotients
import MiniMeasureLebesgue.Constructions.Subobjects
import MiniMeasureLebesgue.Constructions.Universal
import MiniMeasureLebesgue.Properties.Invariants
import MiniMeasureLebesgue.Properties.Preservation
import MiniMeasureLebesgue.Properties.ClassificationData
import MiniMeasureLebesgue.Theorems.Basic
import MiniMeasureLebesgue.Theorems.Classification
import MiniMeasureLebesgue.Theorems.Main
import MiniMeasureLebesgue.Theorems.UniversalProperties
import MiniMeasureLebesgue.Examples.Standard
import MiniMeasureLebesgue.Examples.Counterexamples
import MiniMeasureLebesgue.Bridges.ToAlgebra
import MiniMeasureLebesgue.Bridges.ToTopology
import MiniMeasureLebesgue.Bridges.ToGeometry
import MiniMeasureLebesgue.Bridges.ToComputation
