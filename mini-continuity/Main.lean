import MiniContinuity

open MiniContinuity

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniContinuity v0.1.0"
  IO.println "  Continuity Theory Package"
  IO.println "  Part of the mini-real-analysis collection"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  Limit of functions, continuity, uniform continuity"
  IO.println s!"  Lipschitz and Hölder continuity"
  IO.println s!"  Classification of discontinuities"
  IO.println s!"  Theorems: IVT, EVT, Heine-Cantor, Tietze extension"
  IO.println s!"  Function spaces: C(X), C_b(X), C_c(X)"
  IO.println s!"  Bridges to algebra, topology, geometry, computation"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
