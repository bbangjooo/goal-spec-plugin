---
name: goal-decomposer
description: Use in the goal-spec pipeline to convert the final aggregate goal into checkpointable story goals with dependencies, inputs, outputs, success criteria, evidence requirements, and allowed freedom zones.
---

# Goal Decomposer

## Purpose

Split the already-designed final goal into story goals that can be executed, checkpointed, and verified independently.

## Input

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
required_processes: required
freedom_policy: required
guardrail_candidates: required
```

## Output

```yaml
aggregate_goal:
  title: required
  objective: required
  derived_from_final_goal: required
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
- Preserve the final goal; do not reinterpret or narrow it.
- Decompose according to `goal_object_model.decomposition_basis`, not merely according to the user's mentioned topics.
- Stories must cover the declared completion surface and required capability chain. If a mentioned topic is not itself a completion surface, make it a sub-part of the relevant capability/workflow/artifact story.
- Add a story or success criterion for each `missing_surface_risks` item unless the risk is explicitly superseded with rationale.
- Do not design verifier checks beyond naming evidence requirements.

## Quality Bar

Every story should be small enough that a later verifier can approve or reject it without re-planning the whole goal.
