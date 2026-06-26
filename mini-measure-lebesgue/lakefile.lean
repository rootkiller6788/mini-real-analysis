import Lake
open Lake DSL
package «mini-measure-lebesgue» where
@[default_target]
lean_lib «MiniMeasureLebesgue» where
  roots := #[`MiniMeasureLebesgue]
require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
require «mini-sequence-series» from "../mini-sequence-series"
require «mini-riemann-integration» from "../mini-riemann-integration"
