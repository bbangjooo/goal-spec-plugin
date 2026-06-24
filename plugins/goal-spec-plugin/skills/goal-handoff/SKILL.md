---
name: goal-handoff
description: Use as a separate maker agent in the goal-spec pipeline to write the execution handoff and copyable goal invocation prompts from the assembled contract.
---

# Goal Handoff

## Purpose

Run the handoff slice of the goal-spec pipeline in one isolated maker context.
This agent turns the assembled contract into direct execution instructions and
copyable prompts for starting a goal execution turn.

## Internal Substeps

Execute this substep inside this agent:

1. `goal-handoff-writer`

Do not perform final review here. Review belongs to `goal-review`.

## Input

```yaml
final_goal: required
goal_object_model: required
scope_contract: required
aggregate_goal: required
stories: required
verifier_plan: required
state_and_ledger: required
steering_policy: required
quality_gate: required
spec_file: required
artifact_paths:
  intermediate_dir: required
```

## Output

Write these files:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/units/05-handoff.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/11-execution-handoff.yaml
```

The unit output must include:

```yaml
unit_result:
  unit: goal-handoff
  status: complete | revise | blocked
  summary: required
  files_written: []
  execution_handoff_summary: required
  goal_invocation_prompt:
    plain_prompt: required
    prompt_with_spec_path: required
    prompt_with_inline_summary: required
  downstream_contract:
    execution_handoff: required
    goal_invocation_prompt: required
    scope_contract: required
  repair_instructions: []
```

## Rules

- Write prompts the user can paste into a new goal execution turn.
- Include a path-based prompt and an inline fallback prompt.
- Require loop documentation in the execution handoff.
- Include the scope contract summary in both path-based and inline prompts.
- Forbid final completion until the quality gate is `APPROVE + CLEAR`.
- Do not critique your own handoff; leave that to `goal-review`.

## Quality Bar

The user should immediately know exactly what prompt to give the goal executor.
