/-
# Build Script: MiniMeasureLebesgue

Instructs Lake to build the entire package including dependencies.
-/

/- Usage:
   lake env lean --run scripts/build.lean

   This script simply reports the Lake build commands.
   Actual builds should be done via `lake build`.
-/

def main : IO Unit := do
  IO.println "============================================"
  IO.println "  MiniMeasureLebesgue: Build Script"
  IO.println "============================================"
  IO.println ""
  IO.println "  To build the package:"
  IO.println "    lake build"
  IO.println ""
  IO.println "  To run the main program:"
  IO.println "    lake env lean --run Main.lean"
  IO.println ""
  IO.println "  To run tests:"
  IO.println "    lake env lean --run Test/Basic.lean"
  IO.println "    lake env lean --run Test/ConstructionTests.lean"
  IO.println "    lake env lean --run Test/MorphismTests.lean"
  IO.println ""
  IO.println "  To run benchmarks:"
  IO.println "    lake env lean --run Benchmark/FullSuite.lean"
  IO.println ""
  IO.println "  Dependencies:"
  IO.println "    - mini-object-kernel"
  IO.println "    - mini-real-numbers"
  IO.println "    - mini-sequence-series"
  IO.println "    - mini-riemann-integration"
  IO.println ""
  IO.println "============================================"
  IO.println "  Build script complete."
  IO.println "============================================"
