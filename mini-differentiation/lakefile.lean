import Lake
open Lake DSL
package «mini-differentiation» where
@[default_target]
lean_lib «MiniDifferentiation» where
  roots := #[`MiniDifferentiation]
require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
require «mini-continuity» from "../mini-continuity"
