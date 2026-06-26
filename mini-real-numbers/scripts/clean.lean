/-
# Clean Script for mini-real-numbers

Imports Lake and cleans build artifacts.
Usage: lake env lean --run scripts/clean.lean
-/

import Lake

open Lake

def main : IO Unit := do
  IO.println "=========================================="
  IO.println "  Cleaning mini-real-numbers build..."
  IO.println "=========================================="
  IO.println ""
  IO.println "To clean with Lake, run:"
  IO.println "  lake clean"
  IO.println ""
  IO.println "This removes:"
  IO.println "  - .lake/ build directory"
  IO.println "  - build/ output directory"
  IO.println "  - *.olean compiled files"
  IO.println "  - *.ilean info files"
  IO.println "  - *.trace timing files"
  IO.println ""
  IO.println "To do a full clean and rebuild:"
  IO.println "  lake clean && lake build"
  IO.println ""
  IO.println "Done."

  -- Lake workspace detection
  let ws ← Lake.getWorkspace
  IO.println s!"Cleaned workspace: {ws}"
