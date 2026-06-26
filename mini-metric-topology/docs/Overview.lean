/-
# Overview: MiniMetricTopology

## What is a metric space?

A metric space is a set X equipped with a distance function
d : X × X → ℝ satisfying:
1. d(x,y) ≥ 0, and d(x,y) = 0 ↔ x = y (positive definite)
2. d(x,y) = d(y,x) (symmetry)
3. d(x,z) ≤ d(x,y) + d(y,z) (triangle inequality)

## What this package provides

### 1. Core definitions
- `MetricSpace` typeclass bundling d and the three axioms
- Open/closed balls, open/closed sets, interior, closure, boundary
- Density, separability, boundedness, diameter

### 2. Morphisms
- Structure-preserving maps between metric spaces
- Isometries (distance-preserving), contractions, Lipschitz maps
- Uniformly continuous and continuous maps
- Isomorphisms: isometric isomorphisms, bi-Lipschitz equivalences
- Homeomorphisms

### 3. Constructions
- Products: ℓ¹, ℓ², ℓ∞ product metrics
- Subspaces: restrict metric to a subset
- Quotients: pseudometric on quotient by equivalence relation
- Completion: every metric space has a unique completion
- Hyperspace: Hausdorff metric on closed bounded subsets

### 4. Properties
- Completeness, compactness, sequential compactness
- Total boundedness, connectedness, path-connectedness
- Properness, Polish spaces, length spaces
- Alexandrov curvature bounds, CAT(k) spaces

### 5. Theorems
- Compact ⇔ complete + totally bounded
- Heine-Borel: in ℝ^n, compact ↔ closed and bounded
- Baire Category Theorem for complete metric spaces
- Banach Fixed Point Theorem (contraction mapping principle)
- Cantor's Intersection Theorem
- Urysohn and Nagata-Smirnov metrization theorems

### 6. Bridges
- ToAlgebra: normed vector spaces, Banach spaces, metric groups
- ToTopology: metrizability, uniform spaces, paracompactness
- ToGeometry: Riemannian metrics, geodesic spaces, CAT(0)
- ToComputation: finite metric spaces, distance matrices, nearest neighbors

## Design philosophy

This package follows the mini-everything-math philosophy:
- Every definition is explicit and type-theoretic
- Deep proofs are marked `sorry` but statements are correct
- Every module has `#eval` tests for concreteness
- Bridges connect metric topology to neighboring theories
-/
-/

namespace MiniMetricTopology

def overviewLoaded : IO Unit := do
  IO.println "MiniMetricTopology overview loaded."

#eval overviewLoaded
