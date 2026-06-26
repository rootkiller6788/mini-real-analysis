/-
# MiniContinuity API Reference

## Core
- `limitOfFunction f a L` — ε-δ limit definition
- `isContinuousAt f a` — continuity at a point
- `isContinuousOn f A` — continuity on a set
- `isContinuous f` — continuity everywhere
- `isUniformlyContinuousOn f A` — uniform continuity
- `isLipschitzWith f K` — K-Lipschitz continuity
- `isHolderContinuousWith f C α` — α-Holder continuity
- `removableDiscontinuity f a` — removable discontinuity
- `jumpDiscontinuity f a` — jump discontinuity
- `essentialDiscontinuity f a` — essential discontinuity
- `leftHandLimit f a L` — left-hand limit
- `rightHandLimit f a L` — right-hand limit
- `isMonotoneIncreasing f` — monotone increasing
- `isMonotoneDecreasing f` — monotone decreasing

## Objects
- `ContinuousFn` — continuous function with proof
- `BoundedContinuousFn` — bounded continuous function
- `CompactSupportContinuousFn` — compactly supported continuous
- `VanishingAtInfinityContinuousFn` — vanishes at infinity

## Morphisms
- `ContinuousMap` — continuous map structure
- `UniformlyContinuousMap` — uniformly continuous map
- `LipschitzMap` — Lipschitz map with constant K
- `Homeomorphism` — continuous bijection with continuous inverse
- `isHomeomorphism f g` — homeomorphism pair
- `isIsometry f` — distance-preserving map
- `isDilatation f λ` — scaling map
- `topologicalEquivalence X Y` — homeomorphic spaces
- `uniformEquivalence X Y` — uniformly equivalent
- `lipschitzEquivalence X Y` — bi-Lipschitz equivalent

## Theorems
- `intermediateValueTheorem` — IVT
- `extremeValueTheorem` — EVT
- `heineCantorTheorem` — continuous on compact ⇒ uniform
- `darbouxTheorem` — derivatives have IVP
- `brouwerFixedPoint1D` — 1D Brower fixed point
- `continuousInverseTheorem` — continuous bijection on compact has continuous inverse
- `tietzeExtensionTheorem` — extension of continuous functions
- `banachFixedPoint` — contraction mapping fixed point
- `urysohnLemma` — Urysohn separation lemma
-/
