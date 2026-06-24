---
name: goal-intent-extractor
description: Use as the first specialist in the goal-spec pipeline to turn a raw user objective into a stable intent frame with domain, target outcome, success shape, constraints, non-goals, authority boundaries, assumptions, and unknowns.
---

# Goal Intent Extractor

## Purpose

Extract the user's intended outcome so downstream goal-spec specialists do not optimize the wrong target.

## Input

```yaml
raw_user_objective: required
source_material: optional
known_constraints: optional
```

## Output

```yaml
intent_summary: required
domain: required
target_outcome: required
success_shape: required
non_goals: []
authority_boundaries: []
assumptions: []
unknowns: []
high_risk_ambiguities: []
```

## Rules

- Write the target outcome as a desired state change, not an activity.
- Capture constraints and non-goals separately.
- Authority boundaries must include external, destructive, financial, legal, production, credentialed, or irreversible actions when relevant.
- Unknowns should not block progress unless they materially affect safety, authority, or scope.
- Do not design the full goal plan. Stop at intent extraction.

## Quality Bar

The next specialist should be able to understand what success means without rereading the full conversation.

