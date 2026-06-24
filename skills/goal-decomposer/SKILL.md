---
name: goal-decomposer
description: Use in the goal-spec pipeline to convert an aggregate target outcome into checkpointable story goals with dependencies, inputs, outputs, success criteria, evidence requirements, and allowed freedom zones.
---

# Goal Decomposer

## Purpose

Split the aggregate goal into story goals that can be executed, checkpointed, and verified independently.

## Input

```yaml
intent_summary: required
target_outcome: required
required_processes: required
freedom_policy: required
guardrail_candidates: required
```

## Output

```yaml
aggregate_goal:
  title: required
  objective: required
  completion_requires: []
stories:
  - id: G001
    title: required
    objective: required
    depends_on: []
    inputs: []
    outputs: []
    success_criteria: []
    evidence_required: []
    allowed_freedom_zone: []
```

## Rules

- Every story must be checkpointable.
- A story is too large if it needs several unrelated verifier scopes.
- Success criteria must be observable or evidence-backed.
- Dependencies must preserve required process order.
- Include the freedom zone each story may use.
- Do not design verifier checks beyond naming evidence requirements.

## Quality Bar

Every story should be small enough that a later verifier can approve or reject it without re-planning the whole goal.

