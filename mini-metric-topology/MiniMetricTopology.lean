/-
# MiniMetricTopology

Metric spaces: sets equipped with a distance function satisfying positivity,
symmetry, and the triangle inequality. The topology induced by a metric.

## Sub-packages
- `Core`           — MetricSpace typeclass, balls, open/closed sets
- `Morphisms`      — Isometries, contractions, Lipschitz, continuous maps
- `Constructions`  — Products, quotients, subspaces, completion
- `Properties`     — Invariants, preservation, classification data
- `Theorems`       — Main structural and classification theorems
- `Examples`       — Standard examples and counterexamples
- `Bridges`        — Connections to algebra, topology, geometry, computation
-/

import MiniMetricTopology.Core.Basic
import MiniMetricTopology.Core.Laws
import MiniMetricTopology.Core.Objects
import MiniMetricTopology.Morphisms.Hom
import MiniMetricTopology.Morphisms.Iso
import MiniMetricTopology.Morphisms.Equiv
import MiniMetricTopology.Constructions.Products
import MiniMetricTopology.Constructions.Quotients
import MiniMetricTopology.Constructions.Subobjects
import MiniMetricTopology.Constructions.Universal
import MiniMetricTopology.Properties.Invariants
import MiniMetricTopology.Properties.Preservation
import MiniMetricTopology.Properties.ClassificationData
import MiniMetricTopology.Theorems.Basic
import MiniMetricTopology.Theorems.Classification
import MiniMetricTopology.Theorems.Main
import MiniMetricTopology.Theorems.UniversalProperties
import MiniMetricTopology.Examples.Standard
import MiniMetricTopology.Examples.Counterexamples
import MiniMetricTopology.Bridges.ToAlgebra
import MiniMetricTopology.Bridges.ToTopology
import MiniMetricTopology.Bridges.ToGeometry
import MiniMetricTopology.Bridges.ToComputation
