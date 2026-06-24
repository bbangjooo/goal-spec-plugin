---
name: goal-handoff-writer
description: Use in the goal-spec pipeline to convert the assembled goal contract into direct Codex/OMX goal execution instructions, including create_goal, story execution, checkpoint, steering, blocked, and update_goal completion rules.
---

# Goal Handoff Writer

## Purpose

Write the section that a future goal executor can follow without rereading the design discussion.

## Input

```yaml
aggregate_goal: required
final_goal: required
goal_object_model: required
stories: required
verifier_plan: required
state_and_ledger: required
steering_policy: required
quality_gate: required
```

## Output

```yaml
execution_handoff:
  create_goal_objective: required
  goal_invocation_prompt:
    plain_prompt: required
    prompt_with_spec_path: required
    prompt_with_inline_summary: required
  story_execution_rules: []
  checkpoint_rules: []
  steering_rules: []
  update_goal_complete_rule: required
  blocked_rule: required
```

## Rules

- Say exactly what aggregate goal to create.
- Provide copyable prompts the user can paste into a new goal execution turn.
- Include a path-based prompt that points to the final spec file and an inline-summary prompt for surfaces that cannot read the file path.
- Say how to execute story goals and in what order.
- Say what state to read before work and what evidence to write after work.
- Say when checkpoint complete is allowed.
- Say when structured steering is required.
- Remind the executor to preserve the goal object model's completion surface and required capability chain during steering.
- Forbid final `update_goal complete` until all active stories are complete or superseded and the quality gate is `APPROVE + CLEAR`.

## Quality Bar

The handoff should make it obvious how to start execution: the final goal-spec output must include a short "copy this prompt into goal" instruction and at least one fully formed prompt.
