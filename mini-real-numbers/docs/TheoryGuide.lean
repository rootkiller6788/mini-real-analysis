/-
# Theory Guide: Completeness, Dedekind Cuts, and Cauchy Sequences

A guide to the theory of real numbers formalized in this package.

## Three Equivalent Formulations of Completeness

The completeness of ℝ can be expressed in three equivalent ways.
All three are defined in this package and their equivalence is stated
(with `sorry` for proofs) in `Morphisms/Equiv.lean`.

### 1. Supremum Completeness

Every nonempty subset of ℝ that is bounded above has a least upper bound
(supremum) in ℝ.

```lean
def completenessProp (ℝ : RealNumbers) : Prop :=
  ∀ (S : Set ℝ.carrier),
    (∃ x, x ∈ S) → (∃ M, isUpperBound ℝ.le S M) →
    ∃ s, isSupremum ℝ.le S s
```

This is the standard "Dedekind completeness" used in most textbooks.

### 2. Dedekind Cut Property

Every Dedekind cut (a partition of ℝ into a lower set L with no maximum
and an upper set U) has a cut point c: either L has a maximum or U has
a minimum.

```lean
structure DedekindCut (ℝ : RealNumbers) where
  lowerSet : Set ℝ.carrier
  upperSet : Set ℝ.carrier
  lowerHasNoMax : ∀ x ∈ lowerSet, ∃ y ∈ lowerSet, ℝ.lt x y
  partition : ∀ x y, x ∈ lowerSet → y ∈ upperSet → ℝ.lt x y
  covered : ∀ x, x ∈ lowerSet ∨ x ∈ upperSet
```

The Dedekind cut property says: for every cut (L, U), ∃ c such that
∀ x ∈ L, x ≤ c and ∀ y ∈ U, c ≤ y.

### 3. Cauchy Completeness

Every Cauchy sequence of real numbers converges to a real number.

```lean
def CauchySequence (ℝ : RealNumbers) (a : ℕ → ℝ.carrier) : Prop :=
  ∀ (ε : ℝ.carrier), ℝ.lt ℝ.zero ε →
    ∃ N : ℕ, ∀ m n : ℕ, m ≥ N → n ≥ N →
      ℝ.lt (ℝ.add (a m) (ℝ.neg (a n))) ε ∧ ...

def cauchyCompleteness (ℝ : RealNumbers) : Prop :=
  ∀ (a : ℕ → ℝ.carrier), CauchySequence ℝ a → ∃ L, ConvergesTo ℝ a L
```

## The Archimedean Property

An ordered field F is Archimedean if for every x ∈ F there exists
a natural number n such that x < n (where n is interpreted as 1+1+...+1).

```lean
def ArchimedeanProperty (ℝ : RealNumbers) : Prop :=
  ∀ x : ℝ.carrier, ∃ n : ℕ, ℝ.lt x (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc ℝ.one) n)
```

Key facts:
- Every complete ordered field is Archimedean (proof via completeness)
- Non-Archimedean ordered fields exist (e.g., ℝ(t), hyperreals)
- The Archimedean property is essential for the uniqueness of ℝ

## Constructions of ℝ

The package takes an axiomatic approach but acknowledges two classical
constructions:

### Dedekind Cuts on ℚ

ℝ is the set of all Dedekind cuts of ℚ. A cut is a pair (L, U) where
L has no maximum and every rational is in exactly one of L, U (except
the cut point if it exists).

### Cauchy Completion of ℚ

ℝ is the set of equivalence classes of Cauchy sequences of rationals,
where two sequences are equivalent if their difference converges to 0.

Both constructions yield isomorphic complete ordered fields.

## Key Theorems

### Uniqueness of ℝ

Any two complete Archimedean ordered fields are connected by a unique
order-preserving field isomorphism.

This is one of the most important theorems about ℝ: the axioms
characterize ℝ uniquely. Unlike most algebraic structures, ℝ has
no "nonstandard" complete Archimedean models.

### Cantor's Uncountability

ℕ is countable. ℝ is uncountable. There is no bijection ℕ → ℝ.

Proof sketch (Cantor's diagonal argument):
1. Assume f : ℕ → ℝ is surjective
2. Construct nested intervals [a_n, b_n] avoiding f(n)
3. Take the intersection point x ∈ ⋂[a_n, b_n]
4. x ≠ f(n) for all n, contradiction

### Bolzano-Weierstrass

Every bounded sequence in ℝ has a convergent subsequence.

This is equivalent to the compactness of closed bounded intervals
(Heine-Borel theorem), which in turn is equivalent to completeness.

### Intermediate Value Theorem

If f is continuous on [a, b] and f(a) < 0 < f(b), then ∃ c ∈ (a, b)
such that f(c) = 0.

This is a consequence of completeness: the set {x | f(x) < 0} has a
supremum which must be a root.

### Nested Interval Theorem

If [a_n, b_n] are nested (a_n ≤ a_{n+1} ≤ b_{n+1} ≤ b_n) and
their lengths converge to 0, then the intersection contains exactly
one point.

## The Category of Complete Ordered Fields

The package situates ℝ in a categorical context:

- **Initial object**: ℚ (Archimedean ordered fields with embeddings)
- **Terminal object**: ℝ (complete Archimedean ordered fields with homomorphisms)
- **Universal property**: ℝ is the Dedekind completion of ℚ

This perspective unifies many theorems about ℝ as consequences of
universal properties.

## Real Closed Fields (Tarski)

ℝ is a real closed field. The theory RCF is:
- Complete: every sentence or its negation is provable
- Decidable: there is an algorithm to decide truth of any sentence
- Model-complete: all embeddings between RCFs are elementary

Non-Archimedean RCFs exist (e.g., real Puiseux series), showing that
the Archimedean property is what distinguishes ℝ from other RCFs.

## References

- Rudin, "Principles of Mathematical Analysis"
- Lang, "Algebra" (for Artin-Schreier theory)
- Marker, "Model Theory: An Introduction" (for RCF and QE)
- Bridges, "Constructive Analysis" (for computable reals)
-/
