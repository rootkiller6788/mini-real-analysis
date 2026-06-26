/-
# Clean Script -- mini-sequence-series

Removes build artifacts. Run: `lake clean`
-/

import Lake
open Lake DSL

#eval "═══════════════════════════════════════"
#eval "  mini-sequence-series Clean Script"
#eval "═══════════════════════════════════════"

#eval "Run: lake clean"

#eval "── Removes ──"
#eval "  - build/ (compiled .olean / .ilean files)"
#eval "  - lake-packages/ (cached dependency sources)"
#eval "  - .lake/ (Lake package state)"

#eval "── Preserves ──"
#eval "  - Source files (.lean)"
#eval "  - lakefile.lean (package manifest)"
#eval "  - lean-toolchain (Lean version pin)"

#eval "── After Cleaning ──"
#eval "  Run `lake build` to rebuild from scratch"
#eval "  First build will be slower (no cache)"

#eval "══ Clean Script Complete ══"
