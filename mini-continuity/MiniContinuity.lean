/-
# MiniContinuity

Continuity theory: limits of functions, continuity, uniform continuity,
Lipschitz and Holder continuity, classification of discontinuities,
function spaces, and the main theorems of continuous functions.

This is a sub-package of the mini-real-analysis collection in the
mini-everything-math ecosystem.

## Sub-packages
- `Core`         — Limit of function, continuity types, one-sided limits
- `Morphisms`    — Continuous/Lipschitz/Uniform maps, homeomorphisms, isometries
- `Constructions` — Products, quotients, subobjects, universal properties
- `Properties`   — Invariants, preservation, classification data
- `Theorems`     — IVT, EVT, Heine-Cantor, Tietze extension
- `Examples`     — Standard continuous functions and counterexamples
- `Bridges`      — ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Core.Objects
import MiniContinuity.Core.Laws
import MiniContinuity.Morphisms.Hom
import MiniContinuity.Morphisms.Iso
import MiniContinuity.Morphisms.Equiv
import MiniContinuity.Constructions.Products
import MiniContinuity.Constructions.Quotients
import MiniContinuity.Constructions.Subobjects
import MiniContinuity.Constructions.Universal
import MiniContinuity.Properties.Invariants
import MiniContinuity.Properties.Preservation
import MiniContinuity.Properties.ClassificationData
import MiniContinuity.Theorems.Basic
import MiniContinuity.Theorems.UniversalProperties
import MiniContinuity.Theorems.Classification
import MiniContinuity.Theorems.Main
import MiniContinuity.Examples.Standard
import MiniContinuity.Examples.Counterexamples
import MiniContinuity.Bridges.ToAlgebra
import MiniContinuity.Bridges.ToTopology
import MiniContinuity.Bridges.ToGeometry
import MiniContinuity.Bridges.ToComputation
