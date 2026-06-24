---
name: goal-spec-critic
description: Use as the final specialist in the goal-spec pipeline to review a full goal contract for missing evidence, weak verifier gates, missing traceability, process conflicts, premature completion paths, and over-constraint.
---

# Goal Spec Critic

## Purpose

Block incomplete or unsafe goal specs before they are handed to execution.

## Input

```yaml
full_goal_contract: required
raw_user_objective: required
goal_object_model: required
scope_contract: required
execution_discipline: required
```

## Output

```yaml
critic_result:
  verdict: APPROVE | REVISE
  blockers: []
  quality_gaps: []
  overconstraint_warnings: []
  missing_traceability: []
  revision_instructions: []
```

## Blocking Checks

Return `REVISE` if:

- Any story lacks success criteria or evidence requirements.
- Any hard constraint lacks a verifier check.
- Any required process is not reflected in story dependencies or checkpoint rules.
- The handoff permits completion from maker self-report.
- The handoff permits final completion before all active stories are complete or superseded.
- State/ledger writeback is missing for failures, blockers, decisions, evidence, or lessons.
- Plan steering can bypass verifier checks or the quality gate.
- The spec decomposes user-mentioned topics directly while failing to cover the declared primary goal object.
- The stories do not cover the declared completion surface, completion level, owning systems, or required capability chain.
- A user-excluded implementation surface is interpreted as excluding runtime, policy, audit, or contract surfaces that the goal object still requires.
- A completion-critical capability from the scope contract is missing from
  stories, verifier checks, ledger rules, or handoff.
- A completion-critical capability can be marked audit-only, follow-up-only, or
  deferred by the agent without user approval or not-applicable evidence.
- A required parity or coverage matrix lacks row-source rules, per-row evidence
  requirements, allowed statuses, or reject conditions.
- The final invocation prompt omits enough scope-contract detail that a future
  executor could legally complete a smaller goal.
- The spec permits completion without fresh verification evidence.
- The spec permits bug-fix completion without root-cause evidence when bug,
  regression, unexpected behavior, failing test, build failure, or performance
  anomaly work is in scope.
- The spec permits software behavior changes without test-first evidence and
  without an explicit exemption.
- The spec permits quality review to start before spec compliance review when
  both are required.
- The spec selects `bite_sized_steps` but does not include step contracts, or
  omits bite-sized steps when the execution discipline marks them required.
- The handoff drops or weakens concrete bite-sized steps produced by execution
  discipline.
- The review, handoff, or verifier path accepts rationalizations such as
  "simple enough", "defer for now", "verify later", "probably sufficient", or
  "audit only" as substitutes for evidence.

## Warning Checks

Warn, but do not automatically block, when:

- The spec over-constrains creative choices.
- A reference-only best practice has been promoted to a hard constraint without a strong reason.
- Unknowns remain but do not block safe execution.
- The goal object model uses broad completion surfaces that are valid but may need story splitting during execution.
- Unit-level micro-interviews found minor wording drift but no material scope,
  verifier, or handoff risk.

## Quality Bar

Only return `APPROVE` when the spec is ready to be handed to a goal executor with no hidden completion gaps, including no gap between mentioned topic coverage and real goal-object completion.
