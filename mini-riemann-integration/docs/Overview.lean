/-
# docs.Overview

Overview of the MiniRiemannIntegration package:
structure, key definitions, and usage guide.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Package Overview -/

def packageOverview : List (String × String) := [
  ("Name", "MiniRiemannIntegration"),
  ("Version", "0.1.0"),
  ("Domain", "Real Analysis — Riemann Integration"),
  ("Parent", "mini-real-analysis"),
  ("Kernel", "MiniMathKernel (mini-object-kernel)"),
  ("Dependencies", "mini-object-kernel, mini-real-numbers, mini-continuity")
]

/-! ## Module Structure -/

def moduleStructure : List (String × String) := [
  ("Core", "Basic definitions: Partition, Darboux/Riemann sums, integrals"),
  ("Morphisms", "Integral-preserving maps, transforms, equivalences"),
  ("Constructions", "Products (Fubini), quotients (L¹), subobjects, universals"),
  ("Properties", "Norms, convergence, Lebesgue criterion, classification"),
  ("Theorems", "FTC, integration by parts, substitution, MVT, Cauchy-Schwarz"),
  ("Examples", "Standard integrals and pathological counterexamples"),
  ("Bridges", "Connections to algebra, topology, geometry, computation")
]

/-! ## Quick Start -/

def quickStart : List String := [
  "1. Build: `lake build`",
  "2. Test: `lake env lean --run Test/Basic.lean`",
  "3. Import in your file: `import MiniRiemannIntegration`",
  "4. Open namespace: `open MiniRiemannIntegration`",
  "5. Create a uniform partition: `let P := uniformPartition 0 1 100 (by omega)`",
  "6. Compute Riemann sums: `riemannSumValue f P tags`",
  "7. Use numerical integration: `trapezoidalRule f a b n (by omega)`"
]

/-! ## Key Types -/

def keyTypes : List String := [
  "Partition — a finite list of points a = x₀ < x₁ < ... < xₙ = b",
  "RiemannSum — a sum Σ f(t_i)·(x_{i+1} - x_i) with sample points t_i",
  "IntegrableFunction — a function bundled with its integrability proof",
  "StepFunction — a piecewise-constant function",
  "ImproperIntegral — an improper integral with convergence classification"
]

/-! ## Key Theorems -/

def keyTheorems : List String := [
  "FTC Part 1: ∫_a^b f = F(b) - F(a) when F' = f",
  "FTC Part 2: d/dx ∫_a^x f(t)dt = f(x) at continuity points",
  "Lebesgue criterion: f is Riemann integrable iff bounded and a.e. continuous",
  "Linear + positive: the Riemann integral is a linear positive functional",
  "C([a,b]) ⊆ R([a,b]): continuous functions on compact intervals are integrable"
]

#eval "docs.Overview: package overview, module structure, quick start"
#eval "docs.Overview: key types (5), key theorems (5)"
