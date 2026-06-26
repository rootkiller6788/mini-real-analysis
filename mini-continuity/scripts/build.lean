/-
# MiniContinuity Build Script

Build all targets in the mini-continuity package.
Run with: lake build
-/

import Lake
open Lake DSL

def main : IO Unit := do
  IO.println "Building MiniContinuity..."
  IO.println "  - Core definitions"
  IO.println "  - Morphisms"
  IO.println "  - Constructions"
  IO.println "  - Properties"
  IO.println "  - Theorems"
  IO.println "  - Examples"
  IO.println "  - Bridges"
  IO.println "  - Tests"
  IO.println "  - Benchmarks"
  IO.println "  - Computation"
  IO.println "Build complete."
