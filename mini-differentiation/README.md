# mini-differentiation

A Lean 4 Lake package for differentiation theory — part of the
`mini-everything-math` ecosystem.

## Overview

This package covers differentiation in single and several variables:

- **Core**: Derivatives (Frechet, Gateaux, directional, partial), differentiability,
  C^k and smooth (C^inf) functions, Taylor polynomials
- **Morphisms**: Smooth maps, diffeomorphisms, C^k diffeomorphisms
- **Constructions**: Products, quotients (jet spaces), subobjects (C^k hierarchies),
  universal properties (Taylor approximations)
- **Properties**: Critical points, Hessians, Morse index, signature
- **Theorems**: Mean Value Theorem, Taylor Theorem, L'Hopital's Rule,
  Inverse Function Theorem, Implicit Function Theorem, Morse Lemma,
  Sard's Theorem
- **Examples**: Standard derivatives (x^n, exp, sin, cos, log),
  counterexamples (Weierstrass function, smooth non-analytic)
- **Bridges**: To algebra (derivations, differential algebra),
  topology (C^k topologies, transversality),
  geometry (tangent spaces, vector fields),
  computation (numerical diff, automatic diff, Newton's method)

## Building

```bash
lake build
```

## Testing

```bash
lake env lean --run Test/Basic.lean
```
