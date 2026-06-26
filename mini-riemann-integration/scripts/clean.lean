/-
# scripts.clean

Clean script for the mini-riemann-integration package.
Lists instructions for cleaning build artifacts.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Clean commands -/

def cleanCommands : List String := [
  "lake clean",
  "Remove .lake directory (optional): rm -rf .lake",
  "Remove build directory: rm -rf build"
]

/-! ## Files to preserve during clean -/

def preserveFiles : List String := [
  "lakefile.lean",
  "lean-toolchain",
  "Main.lean",
  "MiniRiemannIntegration.lean",
  "README.md",
  "All .lean source files",
  "Test/, Benchmark/, Computation/, docs/, scripts/ directories"
]

/-! ## Clean report -/

def reportCleanInstructions : IO Unit := do
  IO.println "Clean script for MiniRiemannIntegration"
  IO.println "====================================="
  IO.println ""
  IO.println "  To clean build artifacts:"
  IO.println "    lake clean"
  IO.println ""
  IO.println "  To also remove Lake's cache:"
  IO.println "    Remove-Item -Recurse -Force .lake"
  IO.println ""
  IO.println "  Files preserved:"
  for file in preserveFiles do
    IO.println s!"    - {file}"
  IO.println ""
  IO.println "  After clean, rebuild with:"
  IO.println "    lake build"

#eval "scripts.clean: clean commands and preservation list"
#eval "scripts.clean: Run `reportCleanInstructions` or `lake clean`"

def main : IO Unit := reportCleanInstructions
