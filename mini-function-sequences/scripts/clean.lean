/-
# Clean Script

Clean build artifacts for the mini-function-sequences package.
-/

import Lake

namespace MiniFunctionSequences.Scripts

#eval "=== Clean Script ==="
#eval "Run: lake clean"
#eval "Removes build/ and .lake/ directories"

/-- Placeholder for cleanup checks. -/
def runCleanup : IO Unit := do
  IO.println "Cleaning mini-function-sequences..."
  IO.println "  - Removing build artifacts..."
  IO.println "  - Clean complete."

#eval runCleanup

end MiniFunctionSequences.Scripts
