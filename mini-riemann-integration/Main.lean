import MiniRiemannIntegration

open MiniRiemannIntegration

def main : IO Unit := do
  IO.println "════════════════════════════════════════"
  IO.println "  MiniRiemannIntegration v0.1.0"
  IO.println "  Riemann Integration Theory"
  IO.println "════════════════════════════════════════"
  IO.println s!"  Partitions, Darboux sums, Riemann sums"
  IO.println s!"  Riemann integrability criterion"
  IO.println s!"  Fundamental Theorem of Calculus"
  IO.println s!"  Improper integrals, L¹ spaces"
  IO.println s!"  Bridges to computation and geometry"
  IO.println ""
  IO.println "  Run `lake build` to compile."
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
