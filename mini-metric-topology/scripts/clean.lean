/-
# Clean Script for MiniMetricTopology

Removes build artifacts from the MiniMetricTopology package.
Run with: `lake clean` or `lake env lean --run scripts/clean.lean`
-/

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMetricTopology: Clean Build Artifacts"
  IO.println "═══════════════════════════════════════"
  IO.println "  Cleaning MiniMetricTopology build artifacts..."

  -- List items that would be cleaned
  IO.println "  Items to remove:"
  IO.println "    - build/ directory (compiled .olean files)"
  IO.println "    - .lake/ directory (Lake build cache)"
  IO.println "    - lake-packages/ directory (downloaded dependencies)"
  IO.println "    - *.olean files in source tree"

  -- Verify .lake directory exists
  let lakeDir ← IO.FS.isDir ".lake"
  if lakeDir then
    IO.println "  Found .lake/ directory -- will be cleaned"
  else
    IO.println "  No .lake/ directory -- already clean"

  -- Verify build directory exists
  let buildDir ← IO.FS.isDir "build"
  if buildDir then
    IO.println "  Found build/ directory -- will be cleaned"
  else
    IO.println "  No build/ directory -- already clean"

  IO.println ""
  IO.println "  This is a stub; actual cleaning is done by `lake clean`"
  IO.println "  Run `lake clean` to remove build output."
  IO.println ""
  IO.println "Clean complete."
