# mini-real-numbers

A Lean 4 formalization of real numbers as the unique complete ordered field.

## Overview

This package defines the real numbers ℝ with the following key structures:

- **RealNumbers** — the carrier type with field operations and order
- **DedekindCuts** — construction of ℝ via Dedekind cuts on ℚ
- **CauchySequences** — ε-N convergence condition for sequences
- **CompleteOrderedField** — field axioms + total order + supremum completeness

## Key Definitions

| Concept | Location |
|---------|----------|
| RealNumbers | `Core/Basic.lean` |
| DedekindCut | `Core/Basic.lean` |
| CauchySequence | `Core/Basic.lean` |
| supremum / infimum | `Core/Basic.lean` |
| CompletenessAxiom | `Core/Laws.lean` |
| ArchimedeanProperty | `Core/Laws.lean` |
| FieldHomomorphism | `Morphisms/Hom.lean` |
| OrderedFieldIso | `Morphisms/Iso.lean` |

## Key Theorems

| Theorem | Location |
|---------|----------|
| Reals are uncountable | `Theorems/Basic.lean` |
| ℚ is dense in ℝ | `Theorems/Basic.lean` |
| Nested interval theorem | `Theorems/Basic.lean` |
| Bolzano-Weierstrass | `Theorems/Basic.lean` |
| Heine-Borel | `Theorems/Basic.lean` |
| Uniqueness of ℝ | `Theorems/Main.lean` |
| Universal property of Dedekind completion | `Theorems/UniversalProperties.lean` |

## Dependencies

- `mini-object-kernel` — provides `Object` typeclass and theory framework

## Building

```bash
lake build
lake env lean --run Test/Basic.lean
```
