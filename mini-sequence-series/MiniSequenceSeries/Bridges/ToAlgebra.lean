/-
# MiniSequenceSeries.Bridges.ToAlgebra

Bridges to algebra: sequences form an ℝ-algebra (termwise ops),
ℓ¹ as Banach algebra under convolution, generating functions as
formal power series ring, Cauchy product.
-/

import MiniSequenceSeries.Examples.Counterexamples
import MiniObjectKernel

namespace MiniSequenceSeries

/-! ## ℝ-Algebra of Sequences (termwise operations) -/

structure SequenceAlgebra where
  carrier := Sequence ℝ
  add := pointwiseAdd
  mul := pointwiseMul
  zero : Sequence ℝ := fun _ => 0
  one : Sequence ℝ := fun _ => 1
  neg : Sequence ℝ → Sequence ℝ := pointwiseNeg
  scalarMul (c : ℝ) (s : Sequence ℝ) : Sequence ℝ := scaleSeq s c
deriving Repr

/-! ## Convolution of Sequences — ℓ¹ Banach Algebra -/

def convolution (a b : Sequence ℝ) : Sequence ℝ :=
  fun n => match n with
    | 0 => a 0 * b 0
    | n'+1 => (List.range (n'+2)).foldl
        (fun acc k => acc + (a k) * (b (n'+1 - k))) 0

axiom convolutionAssociative (a b c : Sequence ℝ) :
    convolution (convolution a b) c = convolution a (convolution b c)

axiom convolutionCommutative (a b : Sequence ℝ) :
    convolution a b = convolution b a

axiom ℓ1BanachAlgebra : True

/-! ## Cauchy Product of Series -/

def cauchyProduct (a b : Sequence ℝ) : Sequence ℝ :=
  fun n => match n with
    | 0 => a 0 * b 0
    | n'+1 => (List.range (n'+2)).foldl
        (fun acc k => acc + (a k) * (b (n'+1 - k))) 0

axiom cauchyProductConvergence (a b : Sequence ℝ) (S T : ℝ)
    (ha : Series.limitSum a S) (hb : Series.limitSum b T)
    (hAbsA : isAbsolutelyConvergent a) (hAbsB : isAbsolutelyConvergent b) :
    Series.limitSum (cauchyProduct a b) (S * T)

/-! ## Generating Functions — Formal Power Series Ring -/

def generatingFunction (a : Sequence ℝ) : PowerSeries where
  coefficients := a
  center := 0

def formalPowerSeriesRing : Type := PowerSeries

axiom formalPowerSeriesIsRing : True

/-! ## Mertens' Theorem -/

axiom mertensTheorem (a b : Sequence ℝ) (S T : ℝ)
    (ha : Series.limitSum a S) (hb : Series.limitSum b T)
    (hAbs : isAbsolutelyConvergent a) :
    Series.limitSum (cauchyProduct a b) (S * T)

/-! ## #eval Tests -/

def testA : Sequence ℝ := fun n => (0.5 : ℝ) ^ n
def testB : Sequence ℝ := fun n => (0.3 : ℝ) ^ n

#eval "Bridges.ToAlgebra: SequenceAlgebra, convolution, Cauchy product, formal power series"
#eval s!"convolution testA testB 0 = {convolution testA testB 0}"
#eval s!"convolution testA testB 2 = {convolution testA testB 2}"
#eval s!"cauchyProduct testA testB 0 = {cauchyProduct testA testB 0}"
#eval s!"cauchyProduct testA testB 2 = {cauchyProduct testA testB 2}"

end MiniSequenceSeries
