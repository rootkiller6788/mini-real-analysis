/-
# Clean script for mini-differentiation

Run with: lake env lean --run scripts/clean.lean
-/

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniDifferentiation Clean Script"
  IO.println "═══════════════════════════════════════"
  IO.println ""
  IO.println "  To clean build artifacts, run:"
  IO.println "    lake clean"
  IO.println ""
  IO.println "  To rebuild from scratch:"
  IO.println "    lake clean && lake build"
  IO.println ""
  IO.println "  To run all tests:"
  IO.println "    lake env lean --run Test/Basic.lean"
  IO.println "    lake env lean --run Test/ConstructionTests.lean"
  IO.println "    lake env lean --run Test/MorphismTests.lean"
  IO.println ""
  IO.println "  Clean script complete."
