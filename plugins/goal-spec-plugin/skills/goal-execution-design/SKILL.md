---
name: goal-execution-design
description: Use as a separate agent in the goal-spec pipeline to decompose a framed and constrained goal into story goals and verifier checks.
---

# Goal Execution Design

## Purpose

Run the execution-design slice of the goal-spec pipeline in one isolated agent
context. This agent turns the framed goal and constraints into checkpointable
stories plus independent verifier checks.

## Internal Substeps

Execute these substeps sequentially inside this agent:

1. `goal-decomposer`
2. `goal-verifier-designer`

Do not spawn further agents by default.

## Input

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
scope_contract: required
required_processes: required
freedom_policy: required
domain_failure_modes: required
guardrail_candidates: required
artifact_paths:
  intermediate_dir: required
```

## Output

Write these files:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/units/03-execution-design.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/07-decomposition.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/08-verifier-plan.yaml
```

The unit output must include:

```yaml
unit_result:
  unit: goal-execution-design
  status: complete | revise | blocked
  summary: required
  files_written: []
  aggregate_goal_summary: required
  story_summary: []
  verifier_summary: required
  downstream_contract:
    aggregate_goal: required
    stories: required
    verifier_plan: required
  repair_instructions: []
```

## Rules

- Decompose from `goal_object_model.decomposition_basis`, not from mentioned
  topics alone.
- Preserve required process order in story dependencies.
- Every story must be independently checkpointable.
- Maker self-report is never sufficient evidence.
- Every hard constraint must map to at least one verifier check.
- Every completion-critical capability in the scope contract must be covered by
  a story, success criterion, verifier check, or explicit user-approved deferral.
- Required parity or coverage matrices must have story ownership and per-row
  evidence requirements.

## Quality Bar

The next agent should receive stories and verifier gates that can drive real
execution without reopening the framing debate.
