/-
# Properties: Classification Data

Classification of convergence types (pointwise, uniform, L^p, a.e., in measure)
and relationships between them, including Dini classification on compact sets.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Morphisms.Equiv

namespace MiniFunctionSequences

/-! ## Convergence Type Enumeration -/

/-- The various modes of convergence for sequences of functions. -/
inductive ConvergenceMode
  | pointwise
  | uniform
  | locallyUniform
  | l_p (p : ℝ)
  | almostEverywhere
  | inMeasure
  | almostUniform
  deriving BEq, Repr, Inhabited

/-- String representation of convergence modes. -/
def ConvergenceMode.toString : ConvergenceMode → String
  | ConvergenceMode.pointwise => "pointwise"
  | ConvergenceMode.uniform => "uniform"
  | ConvergenceMode.locallyUniform => "locally uniform"
  | ConvergenceMode.l_p p => s!"L^{p}"
  | ConvergenceMode.almostEverywhere => "almost everywhere"
  | ConvergenceMode.inMeasure => "in measure"
  | ConvergenceMode.almostUniform => "almost uniform"

instance : ToString ConvergenceMode := ⟨ConvergenceMode.toString⟩

/-! ## Implication Graph -/

/-- uniform ⇒ locallyUniform ⇐? (generally no arrow) -/
theorem uniform_implies_locallyUniform (f_n : SequenceOfFunctions α) (f : α → ℝ) :
    (uniformlyConvergesOnAll f_n f) → (locallyUniformlyConverges f_n f) := by
  intro h_uniform K h_compact
  intro ε hε
  rcases h_uniform ε hε with ⟨N, hN⟩
  exact ⟨N, λ n hn x hxK => hN n hn x⟩

/-- locallyUniform + domain is compact ⇒ uniform. -/
theorem locallyUniform_on_compact_implies_uniform [TopologicalSpace α] [CompactSpace α]
    (f_n : SequenceOfFunctions α) (f : α → ℝ)
    (h : locallyUniformlyConverges f_n f) : uniformlyConvergesOnAll f_n f := by
  intro ε hε
  -- The whole space is compact, so by h, convergence is uniform on Set.univ.
  rcases h Set.univ (by
    -- CompactSpace gives IsCompact Set.univ
    infer_instance) ε hε with ⟨N, hN⟩
  exact ⟨N, λ n hn x => hN n hn x (Set.mem_univ x)⟩

/-! ## Dini Classification on Compact Sets -/

/-- On a compact set, we have:
    monotone + continuous + pointwise → uniform (Dini)
    equicontinuous + pointwise → uniform
    L^p + dominated → a.e. convergent subsequence (Riesz-Fischer) -/

/-- Classification summary as a data structure. -/
structure ConvergenceClassification (α : Type) where
  mode : ConvergenceMode
  implies : List ConvergenceMode
  strongerThan : List ConvergenceMode
  requires : List String

/-- The standard convergence mode classification. -/
def standardClassification (α : Type) : List (ConvergenceClassification α) :=
  [ { mode := ConvergenceMode.uniform
      implies := [ConvergenceMode.pointwise, ConvergenceMode.locallyUniform, ConvergenceMode.almostEverywhere]
      strongerThan := [ConvergenceMode.pointwise, ConvergenceMode.l_p 2, ConvergenceMode.almostEverywhere]
      requires := ["uniform Cauchy criterion"] },
    { mode := ConvergenceMode.pointwise
      implies := []
      strongerThan := []
      requires := [] },
    { mode := ConvergenceMode.l_p 2
      implies := [ConvergenceMode.inMeasure]
      strongerThan := [ConvergenceMode.inMeasure]
      requires := ["finite measure", "L^p dominated convergence"] }
  ]

/-! ## Convergence Mode Relations for Dini -/

/-- If f_n is monotone increasing, continuous, and converges pointwise to a continuous f
    on a compact set, then the convergence is uniform. (Dini) -/
theorem diniClassification
    {X : Type} [TopologicalSpace X] [T2Space X] [CompactSpace X]
    (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_mono : ∀ n x, f_n n x ≤ f_n (n+1) x)
    (h_cont_n : ∀ n, Continuous (f_n n))
    (h_cont_f : Continuous f) :
    (pointwiseConverges f_n f → uniformlyConvergesOnAll f_n f) := by
  intro h_pointwise
  exact diniTheorem f_n f (by infer_instance) h_mono h_cont_n h_cont_f h_pointwise

/-! ## Tests -/

#eval "--- Properties.ClassificationData tests ---"

/-- Print convergence modes. -/
#eval ConvergenceMode.pointwise.toString
#eval ConvergenceMode.uniform.toString
#eval (ConvergenceMode.l_p 2).toString

/-- Classification data example. -/
def sampleClass : ConvergenceClassification ℝ :=
  { mode := ConvergenceMode.uniform
    implies := [ConvergenceMode.pointwise]
    strongerThan := []
    requires := [] }
#eval sampleClass.mode.toString

/-- Uniform implies pointwise (check). -/
example (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ) (h : uniformlyConvergesOnAll f_n f) :
    pointwiseConverges f_n f :=
  uniformConvergence_implies_pointwise f_n f Set.univ h

end MiniFunctionSequences
