# MiniMetricTopology

Metric spaces: sets equipped with a distance function satisfying positivity,
symmetry, and the triangle inequality. The topology induced by a metric.

## Package Structure

```
mini-metric-topology/
  MiniMetricTopology/    -- Source library (23 modules)
    Core/                -- MetricSpace type, open/closed sets, balls
    Morphisms/           -- Isometry, contraction, Lipschitz, continuous maps
    Constructions/       -- Products, quotients, subspaces, completion
    Properties/          -- Invariants, preservation, classification
    Theorems/            -- Main structural and classification theorems
    Examples/            -- Standard examples and counterexamples
    Bridges/             -- Connections to algebra, topology, geometry, computation
  Test/                  -- Test files with #eval checks
  Benchmark/             -- Performance benchmarks
  Computation/           -- Algorithms and decision procedures
  docs/                  -- Documentation
  scripts/               -- Build and maintenance scripts
```

## Dependencies

- `mini-object-kernel`: Object typeclass from mini-math-kernel
- `mini-real-numbers`: Real numbers from mini-real-analysis

## Build

```bash
lake build
```
