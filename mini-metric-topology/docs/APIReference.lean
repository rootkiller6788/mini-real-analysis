/-
# API Reference: MiniMetricTopology

Core types and functions available in the mini-metric-topology package.

## Core Types
- `MetricSpace α`          — metric space typeclass
- `ball x r`               — open ball of radius r around x
- `closedBall x r`         — closed ball of radius r around x
- `sphere x r`             — sphere of radius r around x
- `isOpen A`               — A is open in the metric topology
- `isClosed A`             — A is closed in the metric topology
- `interior A`, `closure A`, `boundary A`
- `isDense A`              — A is dense
- `isSeparable`            — space has countable dense subset
- `isBounded A`            — A is bounded
- `diameter A`             — diameter of A

## Morphisms
- `Isometry α β`           — distance-preserving map
- `ContractionMapping α`   — map with Lipschitz constant < 1
- `UniformlyContinuous α β`
- `LipschitzMap α β`       — with Lipschitz constant K
- `ContinuousMap α β`
- `IsometricIsomorphism α β`
- `BiLipschitzEquivalence α β`
- `Homeomorphism α β`

## Constructions
- `productMetric α β`      — ℓ¹ product metric
- `maxProductMetric α β`   — ℓ∞ product metric
- `subspaceMetric α S`     — restriction to subset
- `inducedMetric α β f hf` — metric induced by an injection
- `Completion α`           — completion as Cauchy sequences / ~
- `hausdorffDistance A B`  — Hausdorff distance between sets

## Properties
- `isComplete`             — all Cauchy sequences converge
- `isCompact`              — every open cover has finite subcover
- `sequentiallyCompact`    — every sequence has convergent subsequence
- `totallyBounded`         — ∀ ε > 0, finite cover by ε-balls
- `isConnected`, `isPathConnected`
- `isProper`               — closed balls are compact
- `isPolish`               — separable, completely metrizable
- `isLengthSpace`, `isGeodesic`
- `isSeparable`            — countable dense subset
- `isSecondCountable`      — countable basis of open sets

## Key Theorems
- Compact ⇔ complete + totally bounded
- Heine-Borel (in ℝ^n)
- Baire Category Theorem
- Banach Fixed Point Theorem
- Cantor's Intersection Theorem
- Urysohn Metrization Theorem
- Nagata-Smirnov Metrization Theorem
- Tietze Extension Theorem

## Usage

```lean
import MiniMetricTopology
open MiniMetricTopology

#eval d (3 : ℝ) (7 : ℝ)
#eval ball (0 : ℝ) 1
```
-/

namespace MiniMetricTopology

def apiQuickRef : IO Unit := do
  IO.println "MiniMetricTopology API quickly loaded."

#eval apiQuickRef
