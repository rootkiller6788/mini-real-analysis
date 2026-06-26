/-
# MiniDifferentiation

Differentiation theory — derivatives, smooth functions, Taylor expansions,
critical point theory, Morse theory, and connections to algebra, topology,
geometry, and computation.

## Sub-packages
- `Core`          — hasDerivativeAt, isDifferentiableAt, derivative, laws
- `Morphisms`     — SmoothMap, Diffeomorphism, C^k diffeomorphism
- `Constructions` — Products, Quotients (jet spaces), Subobjects, Universal
- `Properties`    — Critical points, Hessian, Morse index, signature
- `Theorems`      — MVT, Taylor, L'Hopital, Inverse/Implicit Function, Morse, Sard
- `Examples`      — Standard derivatives, counterexamples
- `Bridges`       — ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniDifferentiation.Core.Basic
import MiniDifferentiation.Core.Objects
import MiniDifferentiation.Core.Laws
import MiniDifferentiation.Morphisms.Hom
import MiniDifferentiation.Morphisms.Iso
import MiniDifferentiation.Morphisms.Equiv
import MiniDifferentiation.Constructions.Products
import MiniDifferentiation.Constructions.Quotients
import MiniDifferentiation.Constructions.Subobjects
import MiniDifferentiation.Constructions.Universal
import MiniDifferentiation.Properties.Invariants
import MiniDifferentiation.Properties.Preservation
import MiniDifferentiation.Properties.ClassificationData
import MiniDifferentiation.Theorems.Basic
import MiniDifferentiation.Theorems.Classification
import MiniDifferentiation.Theorems.Main
import MiniDifferentiation.Theorems.UniversalProperties
import MiniDifferentiation.Examples.Standard
import MiniDifferentiation.Examples.Counterexamples
import MiniDifferentiation.Bridges.ToAlgebra
import MiniDifferentiation.Bridges.ToTopology
import MiniDifferentiation.Bridges.ToGeometry
import MiniDifferentiation.Bridges.ToComputation
import MiniDifferentiation.PolynomialDeriv
import MiniDifferentiation.DiscreteDeriv
import MiniDifferentiation.TaylorPoly
