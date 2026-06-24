# Quant Trading Example

This example illustrates the general pattern. Do not assume quant rules apply to other domains.

## Aggregate Goal

Build a self-improving quant research and execution loop that ingests data, generates alpha ideas, researches them, backtests them, feeds results back into state, verifies candidates independently, executes only verified signals, and monitors risk continuously.

## Required Process

```yaml
required_process:
  - id: alpha_research_loop
    flow:
      - idea
      - research
      - backtest
      - feedback
      - refine_or_reject
    enforce: true
    reason: "Alpha discovery must preserve hypothesis, evidence, and feedback history."
```

## Guardrails

```yaml
guardrails:
  - id: no_lookahead_bias
    rule: "Do not use future information in features, labels, universe selection, or execution assumptions."
    verifier_check: "Inspect timestamps, splits, feature construction, and data joins."

  - id: transaction_costs
    rule: "Include fees, spread, slippage, and market impact assumptions where relevant."
    verifier_check: "Backtest report lists cost assumptions and applies them to returns."

  - id: out_of_sample_validation
    rule: "Do not approve in-sample performance alone."
    verifier_check: "Out-of-sample period and metrics are present."

  - id: overfitting_control
    rule: "Record parameter searches, rejected variants, and selection rationale."
    verifier_check: "Research ledger includes tried variants and selection basis."

  - id: risk_limits
    rule: "Position size, exposure, and drawdown limits must be explicit before execution."
    verifier_check: "Execution candidate includes risk limits and kill-switch conditions."
```

## Freedom Zones

```yaml
freedom_policy:
  freedom_zones:
    - alpha idea generation
    - feature candidates
    - model family
    - research implementation details
  hard_constraints:
    - no look-ahead bias
    - independent verification before execution
    - risk monitor remains active during execution
  required_sequences:
    - idea -> research -> backtest -> feedback -> refine_or_reject
```

## Example Stories

```yaml
stories:
  - id: G001
    title: "Ingest market data"
    success_criteria:
      - "Latest data is stored with timestamps and provenance."
    evidence_required:
      - "Data artifact path"
      - "Coverage report"

  - id: G002
    title: "Generate and research candidate signal"
    success_criteria:
      - "Hypothesis, data inputs, features, and expected effect are recorded."
    evidence_required:
      - "Research ledger entry"

  - id: G003
    title: "Backtest candidate"
    success_criteria:
      - "Backtest includes costs, split details, and risk metrics."
    evidence_required:
      - "Backtest report"

  - id: G004
    title: "Verify candidate independently"
    success_criteria:
      - "Checker approves or rejects using predefined thresholds."
    evidence_required:
      - "Verifier verdict with metrics"
```

