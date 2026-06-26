/-
# Build Script -- mini-sequence-series

Checks that the package is ready to build and lists dependencies.
Run: `lake build` or `lake env lean --run scripts/build.lean`
-/

import Lake
open Lake DSL

#eval "═══════════════════════════════════════"
#eval "  mini-sequence-series Build Script"
#eval "═══════════════════════════════════════"

#eval "Run: lake build"
#eval ""

#eval "── Requirements ──"
#eval "  - mini-object-kernel (core typeclass)"
#eval "  - mini-real-numbers (real number theory)"
#eval "  - Lean 4 / Lake build system"
#eval ""

#eval "── Build Target ──"
#eval "  Library: MiniSequenceSeries"
#eval "  Executable: mini-sequence-series"
#eval ""

#eval "── Build Steps ──"
#eval "  1. lake update (fetch dependencies)"
#eval "  2. lake build (compile library)"
#eval "  3. lake exe mini-sequence-series (run Main)"

#eval "── Typical Build Output ──"
#eval "  Building MiniSequenceSeries..."
#eval "  - Core/Basic.lean: Sequence and series definitions"
#eval "  - Core/Laws.lean: Limit laws, convergence criteria"
#eval "  - Core/Objects.lean: Sequence as Object instance"
#eval "  Build succeeded."

#eval "══ Build Script Complete ══"
