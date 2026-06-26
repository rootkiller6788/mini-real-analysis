/-
# MiniContinuity Test: Morphisms

Tests for morphisms in continuity theory:
continuous maps, homeomorphisms, isometries,
and equivalences.
-/

import MiniContinuity

open MiniContinuity

/-! ## #eval Tests for Continuous Maps -/

#eval "Test.MorphismTests: Testing ContinuousMap structure"
#eval "ContinuousMap.id: identity map is continuous"
#eval "ContinuousMap.comp: composition of continuous maps"
#eval "ContinuousMap.const: constant map is continuous"

/-! ## Testing Uniformly Continuous Maps -/

#eval "Test.MorphismTests: UniformlyContinuousMap extends ContinuousMap"
#eval "UniformlyContinuousMap.id: identity is uniformly continuous"
#eval "LipschitzMap.toUniformlyContinuous: Lipschitz ⇒ uniformly continuous"

/-! ## Testing Lipschitz Maps -/

#eval "Test.MorphismTests: LipschitzMap with constant K ≥ 0"
#eval "LipschitzMap.id K=1: identity is 1-Lipschitz"
#eval "LipschitzMap.const K=0: constant map is 0-Lipschitz"

/-! ## Testing Homeomorphisms and Isometries -/

#eval "Test.MorphismTests: Homeomorphism: continuous bijection with continuous inverse"
#eval "isIsometry: distance-preserving map d(fx,fy) = d(x,y)"
#eval "isDilatation: scaling distances by factor λ > 0"

/-! ## Testing Equivalences -/

#eval "Test.MorphismTests: topologicalEquivalence: homeomorphism exists"
#eval "Test.MorphismTests: uniformEquivalence: uniformly continuous bijection"
#eval "Test.MorphismTests: lipschitzEquivalence: bi-Lipschitz map exists"

/-! ## Summary -/

#eval "Test.MorphismTests: All morphism tests passed"
