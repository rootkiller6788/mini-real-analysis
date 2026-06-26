import Lake
open Lake DSL

package «mini-riemann-integration» where

@[default_target]
lean_lib «MiniRiemannIntegration» where
  roots := #[`MiniRiemannIntegration]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
require «mini-continuity» from "../mini-continuity"
