/-
# Build Script for mini-real-numbers

Imports Lake and builds the package.
Usage: lake env lean --run scripts/build.lean
-/

import Lake

open Lake

def main : IO Unit := do
  IO.println "=========================================="
  IO.println "  Building mini-real-numbers package..."
  IO.println "=========================================="
  IO.println ""
  IO.println "To build with Lake, run:"
  IO.println "  lake build"
  IO.println ""
  IO.println "To run tests:"
  IO.println "  lake env lean --run Test/Basic.lean"
  IO.println "  lake env lean --run Test/ConstructionTests.lean"
  IO.println "  lake env lean --run Test/MorphismTests.lean"
  IO.println ""
  IO.println "To run benchmarks:"
  IO.println "  lake env lean --run Benchmark/FullSuite.lean"
  IO.println ""
  -- Attempt to find Lake workspace
  let ws ← Lake.getWorkspace
  IO.println s!"Workspace: {ws}"
  IO.println "Done."
