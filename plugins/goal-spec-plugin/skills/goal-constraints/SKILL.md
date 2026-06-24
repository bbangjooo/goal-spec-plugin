---
name: goal-constraints
description: Use as a separate agent in the goal-spec pipeline to map required domain processes and design the freedom policy from a framed goal.
---

# Goal Constraints

## Purpose

Run the constraint slice of the goal-spec pipeline in one isolated agent
context. This agent decides what process must be enforced and where execution
should remain free.

## Internal Substeps

Execute these substeps sequentially inside this agent:

1. `goal-domain-process-mapper`
2. `goal-freedom-policy-designer`

Do not spawn further agents by default.

## Input

```yaml
intent_summary: required
domain: required
final_goal: required
goal_object_model: required
scope_contract: required
authority_boundaries: required
source_material: optional
domain_references: optional
artifact_paths:
  intermediate_dir: required
```

## Output

Write these files:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/units/02-constraints.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/05-domain-process.yaml
.goal-specs/intermediate/YYYY-MM-DD-<slug>/06-freedom-policy.yaml
```

The unit output must include:

```yaml
unit_result:
  unit: goal-constraints
  status: complete | revise | blocked
  summary: required
  files_written: []
  required_process_summary: required
  freedom_policy_summary: required
  hard_constraints: []
  required_sequences: []
  freedom_zones: []
  escalation_points: []
  downstream_contract:
    required_processes: required
    domain_failure_modes: required
    freedom_policy: required
    guardrail_candidates: []
  repair_instructions: []
```

## Rules

- Mark a process required only when order affects correctness, validation
  integrity, safety, compliance, or irreversible external effects.
- Keep optional best practices as reference-only guidance.
- Preserve high freedom inside stages while keeping hard gates explicit.
- Every hard constraint must be externally checkable.
- Preserve the scope contract: low-priority surfaces may remain evidence
  sources, and completion-critical capabilities may not be downgraded to
  reference-only guidance or agent-deferred work.

## Quality Bar

The next agent should know exactly which sequences are mandatory, which choices
are free, and where escalation is required.
