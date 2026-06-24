---
name: goal-verifier-designer
description: Use in the goal-spec pipeline to design independent verifier checks, reject conditions, required evidence, and failure writeback for each story and aggregate goal.
---

# Goal Verifier Designer

## Purpose

Design maker/checker separation so goal completion depends on evidence, not self-report.

## Input

```yaml
stories: required
final_goal: required
goal_object_model: required
scope_contract: required
execution_discipline: optional
hard_constraints: required
required_sequences: required
domain_failure_modes: required
```

## Output

```yaml
verifier_plan:
  aggregate_checks: []
  story_checks:
    G001:
      verifier_role: required
      checks: []
      reject_if: []
      required_evidence: []
      failure_writeback: []
```

## Rules

- Every hard constraint must map to at least one verifier check.
- Every story needs at least one artifact, command result, observed state, metric, or reviewer verdict as evidence.
- Maker self-report is never sufficient evidence.
- Checks should name pass/fail criteria. If qualitative judgment is unavoidable, define the reviewer perspective.
- Verification failures must specify what gets written back to state or ledger.
- Aggregate checks must prove the `goal_object_model.completion_surface`, not just completion of named implementation topics.
- Reject completion when the stories satisfy mentioned topics but leave a required owning system, capability-chain step, audit/provenance surface, runtime workflow, or policy surface uncovered.
- Aggregate checks must prove every `scope_contract.capability_contracts`
  obligation using evidence, not merely presence in a plan.
- Reject completion when a completion-critical capability is audit-only,
  follow-up-only, broadly grouped without per-item evidence, or deferred without
  user approval.
- Required parity or coverage matrices must reject missing rows, missing
  evidence, and row statuses outside the allowed status set.
- If execution discipline is available, verifier checks must enforce fresh
  evidence before completion, root-cause evidence before bug-fix completion,
  test-first evidence for software behavior changes unless exempted, and
  spec-compliance review before quality review.
- Reject story completion when it relies on rationalizations such as "simple
  enough", "defer for now", "verify later", "probably sufficient", or
  "audit-only" instead of required evidence or approved deferral.

## Quality Bar

A goal executor should be unable to mark a story complete without producing evidence the verifier can inspect.
