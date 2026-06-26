/-
# mini-differentiation

Differentiation in single and several variables: derivatives,
smooth functions, Taylor expansions, critical point theory,
Morse theory, jet spaces, and connections to algebra, topology,
geometry, and computation.

This is a sub-package of the `mini-real-analysis` collection
in the mini-everything-math ecosystem.
-/

import MiniDifferentiation

open MiniDifferentiation

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniDifferentiation v0.1.0"
  IO.println "  Differentiation Theory Package"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  Derivatives, smooth functions, Taylor expansions"
  IO.println s!"  Critical point theory and Morse theory"
  IO.println s!"  Jet spaces and connections to algebra, topology, geometry"
  IO.println ""
  IO.println s!"  Run `lake env lean --run Test/Basic.lean` for tests."
