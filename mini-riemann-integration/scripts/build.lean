/-
# scripts.build

Build script for the mini-riemann-integration package.
Runs `lake build` and reports status.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Build configuration -/

def buildConfig : List (String × String) := [
  ("Package", "mini-riemann-integration"),
  ("Library", "MiniRiemannIntegration"),
  ("Lean version", "v4.7.0"),
  ("Target", "default (lean_lib)")
]

/-! ## Build commands -/

def buildInstructions : List String := [
  "1. Ensure Lake is installed (comes with Lean 4)",
  "2. Navigate to the package root:",
  "   cd 'F:/nano-everything/mini-everything-math/6. mini-real-analysis/mini-riemann-integration'",
  "3. Run: lake build",
  "4. For verbose output: lake build -v",
  "5. For clean rebuild: lake clean && lake build"
]

/-! ## Dependency check -/

def checkDependencies : List (String × String) := [
  ("mini-object-kernel", "../../0. mini-math-kernel/mini-object-kernel"),
  ("mini-real-numbers", "../mini-real-numbers"),
  ("mini-continuity", "../mini-continuity")
]

/-! ## Build status reporter -/

def reportBuildStatus : IO Unit := do
  IO.println "Build script for MiniRiemannIntegration"
  IO.println "====================================="
  IO.println "  Package: mini-riemann-integration"
  IO.println "  Library: MiniRiemannIntegration"
  IO.println "  Lean: v4.7.0"
  IO.println ""
  IO.println "  Dependencies:"
  for (name, path) in checkDependencies do
    IO.println s!"    {name}: {path}"
  IO.println ""
  IO.println "  To build: `lake build`"
  IO.println "  To test:  `lake env lean --run Test/Basic.lean`"

#eval "scripts.build: dependency list and build instructions"
#eval "scripts.build: Run `reportBuildStatus` or `lake build`"

def main : IO Unit := reportBuildStatus
