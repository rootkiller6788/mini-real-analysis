/-
# Theory Guide: Metric Topology

A structured guide to the theory of metric spaces as implemented
in MiniMetricTopology.

## Chapter 1: Basic Definitions
- `MetricSpace` typeclass
- Open/closed balls
- The metric topology: open sets, closed sets
- Interior, closure, boundary, limit points
- Hausdorff and first-countable properties

## Chapter 2: Morphisms
- Isometries: the "right" notion of sameness
- Contractions: maps that bring points closer together
- Uniform continuity vs. pointwise continuity
- Lipschitz maps interpolate between uniform continuity and contractions

## Chapter 3: Constructions
- Product metrics: ℓ¹, ℓ², ℓ∞ — all induce the product topology
- Subspace metric = subspace topology
- Quotient pseudometrics
- Completion: the universal way to make a space complete

## Chapter 4: Topological Invariants
- Completeness: Cauchy sequences converge
- Compactness: open cover → finite subcover
- Sequential compactness = compactness (in metric spaces)
- Total boundedness: finite ε-nets
- Connectedness and path-connectedness

## Chapter 5: Classification
- Compact metric spaces are complete + totally bounded
- Separable metric spaces embed in the Hilbert cube
- Urysohn metrization: second-countable regular → metrizable
- Nagata-Smirnov: σ-locally finite basis → metrizable

## Chapter 6: Deep Theorems
- Baire Category: complete metric spaces are Baire spaces
- Banach Fixed Point: contractions have unique fixed points
- Cantor's Intersection: nested closed sets with diam → 0
- Heine-Borel for ℝ^n

## Chapter 7: Connections
- To Algebra: normed spaces, Banach spaces, metric groups
- To Topology: metrizability conditions
- To Geometry: Riemannian manifolds, CAT(k) spaces
- To Computation: finite metrics, distance matrices, algorithms
-/

namespace MiniMetricTopology

def theoryGuideLoaded : IO Unit := do
  IO.println "MiniMetricTopology theory guide loaded."

#eval theoryGuideLoaded
