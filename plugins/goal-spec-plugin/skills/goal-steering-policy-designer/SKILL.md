---
name: goal-steering-policy-designer
description: Use in the goal-spec pipeline to define safe plan mutation rules for adding, splitting, reordering, revising, annotating, blocking, or superseding story goals during execution.
---

# Goal Steering Policy Designer

## Purpose

Allow goal execution to adapt without silent drift.

## Input

```yaml
stories: required
final_goal: required
goal_object_model: required
scope_contract: required
freedom_policy: required
state_and_ledger: required
authority_boundaries: required
```

## Output

```yaml
steering_policy:
  allowed_mutations:
    - add_subgoal
    - split_subgoal
    - reorder_pending
    - revise_pending_wording
    - annotate_ledger
    - mark_blocked_superseded
  mutation_requirements:
    evidence: required
    rationale: required
    target_goal_id_when_applicable: required
  reject:
    - silent_plan_drift
    - broad_unstructured_mutation
    - mutation_that_bypasses_verifier_or_quality_gate
```

## Rules

- Every mutation needs evidence and rationale.
- Superseding a story requires evidence that it is invalid, obsolete, duplicate, or externally blocked.
- Reordering must not violate required sequences unless the sequence itself is revised with rationale.
- Steering must never bypass verifier checks or the final quality gate.
- User escalation is required only at authority boundaries.
- Steering may split or add stories to preserve the goal object model's completion surface when execution reveals a missing owning system or capability-chain step.
- Steering must reject mutations that narrow the goal to mentioned-topic implementation while leaving the primary goal object incomplete.
- Steering may split or add stories to preserve the scope contract, but it may
  not delete, silently defer, or weaken a completion-critical capability.
- Superseding a capability obligation requires user-approved deferral or
  evidence-backed not-applicable status recorded in the ledger.

## Quality Bar

The plan can learn during execution, but every change remains auditable.
