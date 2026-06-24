---
name: goal-runtime-policy
description: Use as a separate agent in the goal-spec pipeline to design durable state, ledger, loop documentation, and steering policies for execution.
---

# Goal Runtime Policy

## Purpose

Run the runtime-policy slice of the goal-spec pipeline in one isolated agent
context. This agent defines how execution remembers, verifies, adapts, and
documents each loop.

## Internal Substeps

Execute these substeps sequentially inside this agent:

1. `goal-state-ledger-architect`
2. `goal-steering-policy-designer`

Do not spawn further agents by default.

## Input

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
stories: required
verifier_plan: required
required_processes: required
freedom_policy: required
authority_boundaries: required
artifact_paths:
  intermediate_dir: required
  ledger_dir: required
```

## Output

Write these files:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/units/04-runtime-policy.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/08-state-ledger.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/09-steering-policy.yaml
```

The unit output must include:

```yaml
unit_result:
  unit: goal-runtime-policy
  status: complete | revise | blocked
  summary: required
  files_written: []
  state_and_ledger_summary: required
  steering_policy_summary: required
  loop_document_policy_summary: required
  downstream_contract:
    state_and_ledger: required
    steering_policy: required
  repair_instructions: []
```

## Rules

- Every repeated loop must read prior state before acting.
- Every repeated loop must write a loop document.
- State writes must include decisions, failures, blockers, evidence, steering
  mutations, and lessons learned.
- Steering must allow learning without silent scope drift.
- Plan mutation must never bypass verifier checks or quality gates.

## Quality Bar

The next agent should be able to write an execution handoff that is resumable,
auditable, and verifier-gated.
