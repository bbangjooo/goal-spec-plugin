---
name: goal-final-goal-designer
description: Use in the goal-spec pipeline after intent extraction to design the final aggregate goal as a verifiable desired end state before story decomposition begins.
---

# Goal Final Goal Designer

## Purpose

Design the final goal itself. This skill turns the extracted intent into one clear aggregate goal that later specialists must preserve.

## Input

```yaml
intent_summary: required
domain: required
target_outcome: required
success_shape: required
non_goals: []
authority_boundaries: []
assumptions: []
unknowns: []
source_material: optional
```

## Output

```yaml
final_goal:
  title: required
  objective: required
  desired_end_state: required
  success_shape: required
  completion_requires: []
  failure_definition: required
  non_goals: []
  decision_boundaries: []
  tradeoff_priority: []
  completion_critical_axes: []
  goal_quality_checks: []
```

## Rules

- The final goal must describe a state, not an activity.
- Keep it broad enough to preserve the user's intent and narrow enough to execute.
- Completion requirements must be verifiable by evidence or a verifier.
- Convert user phrases like "main changes", "major axes", "must preserve",
  "same behavior", "compatible", "migration", "parity", and "complete" into
  `completion_critical_axes` unless clearly optional.
- Include non-goals and decision boundaries so story decomposition cannot expand scope silently.
- Non-goals must be surface-specific. Do not write a non-goal that can be read
  as excluding a capability unless the user explicitly excluded that capability.
- Name what failure means. A goal without a failure definition is too vague.
- Do not treat the user's mentioned topics as the final goal unless they are truly the completion object.
- Write the desired end state clearly enough that `goal-object-modeler` can classify the primary goal object, completion surface, owning systems, and decomposition basis.
- Do not decompose into story goals. Stop at final goal design.

## Quality Bar

Another specialist should be able to model the goal object and then decompose the final goal into stories without reinterpreting the user's original request.
