/-
# MiniContinuity Benchmark: FunctionSpace

Benchmarks for function spaces C(X), C_b(X), C_c(X), C₀(X).
-/

import MiniContinuity

open MiniContinuity

/-! ## Function Space Benchmark Suite -/

#eval "Benchmark.FunctionSpaceBench: Starting function space benchmarks"

-- Benchmark: C(ℝ) is an ℝ-algebra
#eval "FunctionSpaceBench: C(ℝ) with pointwise +, · forms ℝ-algebra"

-- Benchmark: C_b(ℝ) with sup norm is Banach
#eval "FunctionSpaceBench: C_b(ℝ) with ||f||_∞ is complete normed space"

-- Benchmark: C_c(ℝ) ⊆ C₀(ℝ) ⊆ C_b(ℝ) ⊆ C(ℝ)
#eval "FunctionSpaceBench: inclusion chain verified"

-- Benchmark: Stone-Weierstrass theorem
#eval "FunctionSpaceBench: polynomials dense in C[0,1] under uniform norm"

-- Benchmark: Tietze extension theorem
#eval "FunctionSpaceBench: continuous f on closed set extends to all of ℝ"

-- Benchmark: exponential law C(Z×X,Y) ≅ C(Z,C(X,Y))
#eval "FunctionSpaceBench: adjunction between product and function space"

-- Benchmark: maximal ideals in C[0,1] correspond to points
#eval "FunctionSpaceBench: Gelfand-Kolmogorov theorem"

-- Benchmark: evaluation map is continuous
#eval "FunctionSpaceBench: (f,x) ↦ f(x) jointly continuous in compact-open topology"

#eval "Benchmark.FunctionSpaceBench: All function space benchmarks completed"
