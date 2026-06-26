/-
# API Reference

Documentation of all public API names in the mini-function-sequences package.

## Core
- `SequenceOfFunctions` — `Nat → (α → ℝ)`
- `pointwiseConverges` — pointwise convergence
- `uniformlyConverges` — uniform convergence on a set
- `uniformlyConvergesOnAll` — uniform convergence on whole domain
- `uniformlyCauchy` — uniform Cauchy condition
- `locallyUniformlyConverges` — uniform on compact subsets
- `isEquicontinuous` — equicontinuous family
- `isUniformlyEquicontinuous` — uniformly equicontinuous family
- `supNorm` — supremum norm
- `supNormOn` — sup norm on a set
- `PointwiseLimit` — pointwise limit
- `UniformLimit` — uniform limit

## Morphisms
- `ConvergencePreservingMap` — preserves pointwise limits
- `UniformConvergencePreservingMap` — preserves uniform convergence
- `cesaroSum` — Cesàro mean of function sequence
- `abelSumSeq` — Abel summation of function sequence
- `ApproximateIdentity` — approximate identity structure

## Constructions
- `FunctionSequence` — function sequence as object
- `UniformLimitSpace` — metric space of bounded functions
- `BoundedFunctions` — B(X)
- `BoundedContinuousFunctions` — C_b(X)
- `CompactlySupportedContinuousFunctions` — C_c(X)
- `C0Functions` — C₀(X)
- `stoneCechCompactification` — βX via C_b(X)

## Theorems
- `arzelaAscoli` — relative compactness in C(X)
- `stoneWeierstrass` — density of subalgebras
- `stoneWeierstrassComplex` — complex version
- `diniTheorem` — monotone convergence to continuous is uniform
- `uniformBoundednessPrinciple` — pointwise bounded ⇒ uniformly bounded
- `bernsteinConvergence` — B_n(f) → f uniformly
- `weierstrassApproximationTheorem` — polynomials dense in C([0,1])
-/

namespace MiniFunctionSequences

#eval "API Reference: see file header for documentation"

end MiniFunctionSequences
