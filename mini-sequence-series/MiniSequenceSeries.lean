/-
# MiniSequenceSeries

Sequences, series, and convergence theory — the second sub-package
of `mini-real-analysis`. Covers sequences (convergence, limits,
boundedness, monotonicity), series (partial sums, convergence tests,
power series), sequence spaces (c, c₀, ℓ¹, ℓ², ℓ∞), and their
morphisms, constructions, properties, and theorems.

This aggregator imports ALL submodules.
-/

import MiniSequenceSeries.Core.Basic
import MiniSequenceSeries.Core.Objects
import MiniSequenceSeries.Core.Laws
import MiniSequenceSeries.Morphisms.Hom
import MiniSequenceSeries.Morphisms.Iso
import MiniSequenceSeries.Morphisms.Equiv
import MiniSequenceSeries.Constructions.Products
import MiniSequenceSeries.Constructions.Quotients
import MiniSequenceSeries.Constructions.Subobjects
import MiniSequenceSeries.Constructions.Universal
import MiniSequenceSeries.Properties.ClassificationData
import MiniSequenceSeries.Properties.Invariants
import MiniSequenceSeries.Properties.Preservation
import MiniSequenceSeries.Theorems.Basic
import MiniSequenceSeries.Theorems.Classification
import MiniSequenceSeries.Theorems.Main
import MiniSequenceSeries.Theorems.UniversalProperties
import MiniSequenceSeries.Examples.Standard
import MiniSequenceSeries.Examples.Counterexamples
import MiniSequenceSeries.Bridges.ToAlgebra
import MiniSequenceSeries.Bridges.ToTopology
import MiniSequenceSeries.Bridges.ToGeometry
import MiniSequenceSeries.Bridges.ToComputation
