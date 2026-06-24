---
name: goal-framing
description: Use as the first separate agent in the goal-spec pipeline to frame raw intent, design the final goal, and model the real goal object before downstream constraints or decomposition.
---

# Goal Framing

## Purpose

Run the framing slice of the goal-spec pipeline in one isolated agent context.
This agent turns raw user language into the stable goal object and scope
contract that all later agents must preserve.

## Internal Substeps

Execute these substeps sequentially inside this agent:

1. `goal-intent-extractor`
2. `goal-final-goal-designer`
3. `goal-object-modeler`
4. `goal-scope-contract-designer`

Do not spawn further agents by default. Preserve the substep names in the
output trace so the root orchestrator can audit what happened without loading
the full conversation.

## Input

```yaml
raw_user_objective: required
source_material: optional
known_constraints: optional
artifact_paths:
  intermediate_dir: required
  references_dir: required
```

## Output

Write these files:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/units/01-framing.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/01-intent.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/02-final-goal.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/03-goal-object-model.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/04-scope-contract.yaml
```

The unit output must include:

```yaml
unit_result:
  unit: goal-framing
  status: complete | revise | blocked
  summary: required
  files_written: []
  intent_summary: required
  final_goal_summary: required
  goal_object_summary: required
  scope_contract_summary: required
  downstream_contract:
    domain: required
    final_goal: required
    goal_object_model: required
    scope_contract: required
  open_questions: []
  repair_instructions: []
```

## Rules

- Keep the final goal state-shaped, not activity-shaped.
- Separate mentioned topics from the primary goal object.
- Name the completion surface that later stories and verifiers must preserve.
- Convert user priorities, exclusions, and discovered surfaces into an explicit
  scope/capability contract before downstream agents see the goal.
- Treat low-priority surfaces as sequencing guidance, not capability exclusion,
  unless the user explicitly excludes the capability itself.
- Escalate only when multiple plausible interpretations would materially change
  the final goal, completion surface, authority boundary, or non-goal.
- Return compact summaries to the root; write detailed substep outputs to files.

## Quality Bar

The next agent should be able to design constraints from `final_goal`,
`goal_object_model`, and `scope_contract` without reading the raw conversation.
