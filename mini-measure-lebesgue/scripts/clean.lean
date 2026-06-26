/-
# Clean Script: MiniMeasureLebesgue

Reports instructions for cleaning build artifacts.
-/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  MiniMeasureLebesgue: Clean Script"
  IO.println "============================================"
  IO.println ""
  IO.println "  To clean build artifacts:"
  IO.println "    lake clean"
  IO.println ""
  IO.println "  This removes:"
  IO.println "    - .lake/ directory (build outputs)"
  IO.println "    - lake-manifest.json (if present)"
  IO.println ""
  IO.println "  To do a full clean rebuild:"
  IO.println "    lake clean && lake build"
  IO.println ""
  IO.println "  To update dependencies:"
  IO.println "    lake update"
  IO.println ""
  IO.println "  Note: Source files and .gitkeep files are never removed."
  IO.println ""
  IO.println "============================================"
  IO.println "  Clean script complete."
  IO.println "============================================"
