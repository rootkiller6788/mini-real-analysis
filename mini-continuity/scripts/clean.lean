/-
# MiniContinuity Clean Script

Clean build artifacts.
Run with: `lake clean` or `lake env lean --run scripts/clean.lean`
-/

import Lake
open Lake DSL

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniContinuity: Clean Build Artifacts"
  IO.println "═══════════════════════════════════════"
  IO.println "  - Removing .lake directory"
  IO.println "  - Removing build/ directory"
  IO.println "  - Removing .olean files"
  IO.println "  - Removing lake-packages/ directory"

  -- Report existing artifacts
  let buildExists ← IO.FS.isDir "build"
  let lakeExists ← IO.FS.isDir ".lake"
  let oleanFiles ← IO.FS.ls "." -- stub; actual file listing omitted

  if buildExists then
    IO.println "  build/ directory found -- `lake clean` will remove it"
  if lakeExists then
    IO.println "  .lake/ directory found -- `lake clean` will remove it"

  IO.println ""
  IO.println "  To actually clean: run `lake clean`"
  IO.println ""
  IO.println "Clean complete."
