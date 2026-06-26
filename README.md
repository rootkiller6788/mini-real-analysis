# Mini Real Analysis

A collection of **from-scratch Lean 4 implementations** of university-level real analysis, calculus foundations, and measure theory. Each sub-package maps to MIT and other top-tier university courses, building the foundations of real analysis from first principles using the Lean 4 proof assistant and kernel libraries.

## Sub-Packages

| Sub-Package | Topics | Key Courses |
|-------------|--------|-------------|
| [mini-real-numbers](mini-real-numbers/) | Real number construction, completeness, Archimedean property | MIT 18.100A, Harvard Math 112 |
| [mini-sequence-series](mini-sequence-series/) | Sequences, series, convergence tests, power series | MIT 18.100A, Berkeley Math 104 |
| [mini-continuity](mini-continuity/) | Limits, continuity, uniform continuity, intermediate/extreme value theorems | MIT 18.100A, Stanford Math 115 |
| [mini-differentiation](mini-differentiation/) | Derivatives, mean value theorem, Taylor expansions, convexity | MIT 18.100A, Princeton MAT 215 |
| [mini-riemann-integration](mini-riemann-integration/) | Riemann integral, fundamental theorem of calculus, improper integrals | MIT 18.100A, Harvard Math 112 |
| [mini-function-sequences](mini-function-sequences/) | Pointwise/uniform convergence, Arzela-Ascoli, Stone-Weierstrass | MIT 18.100B, Berkeley Math 105 |
| [mini-metric-topology](mini-metric-topology/) | Metric spaces, open/closed sets, completeness, compactness | MIT 18.100B, Cambridge Part II |
| [mini-measure-lebesgue](mini-measure-lebesgue/) | Lebesgue measure, measurable sets, outer measure, Caratheodory | MIT 18.102, Stanford Math 172 |

## Design Philosophy

- **Zero external dependencies** -- pure Lean 4, only kernel + sibling imports
- **Self-contained sub-packages** -- each with `lakefile.lean`, Core/, Morphisms/, Constructions/, Theorems/
- **Theory-to-code mapping** -- inline `#eval` examples and theorem statements throughout

## Building

```bash
cd mini-real-numbers
lake build
lake env lean --run Test/Smoke.lean
```

Requires **Lean 4** and **Lake**.

## Project Structure

```
6. mini-real-analysis/
├── mini-real-numbers/              # Real number construction, completeness
├── mini-sequence-series/           # Sequences, series, convergence tests
├── mini-continuity/                # Limits, continuity, IVT/EVT
├── mini-differentiation/           # Derivatives, MVT, Taylor expansions
├── mini-riemann-integration/       # Riemann integral, FTC, improper integrals
├── mini-function-sequences/        # Uniform convergence, Arzela-Ascoli, Stone-Weierstrass
├── mini-metric-topology/           # Metric spaces, completeness, compactness
└── mini-measure-lebesgue/          # Lebesgue measure, Caratheodory extension
```

## License

MIT
