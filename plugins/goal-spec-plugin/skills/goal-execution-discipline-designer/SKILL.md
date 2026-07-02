---
name: goal-execution-discipline-designer
description: "Use in the goal-spec pipeline to design execution discipline policies: iron-law gates, two-stage review, plan granularity, and rationalization red-flag checks."
---

# Goal Execution Discipline Designer

## Purpose

Design the discipline layer that keeps goal execution honest. This specialist
does not redefine the goal. It decides which execution rules must be hard gates
for this goal, which are conditional, and how those gates are verified.

The default philosophy:

- Completion claims require fresh evidence.
- Bug fixes require root-cause investigation before fixes.
- Software behavior changes require test-first evidence unless explicitly
  exempted.
- Spec compliance review comes before implementation quality review.
- Bite-sized execution steps are required only when they materially improve
  reproducibility or reduce risk.
- Rationalizations like "simple enough", "defer for now", "verify later", or
  "probably sufficient" are not evidence.

## Input

```yaml
intent_summary: required
domain: required
final_goal: required
goal_object_model: required
scope_contract: required
stories: required
verifier_plan: required
freedom_policy: required
domain_failure_modes: required
authority_boundaries: required
```

## Output

```yaml
execution_discipline:
  iron_laws:
    - id: fresh-evidence-before-completion
      rule: "No completion claim or checkpoint without fresh verification evidence."
      applies_when: always
      required_evidence: []
      verifier_mapping: []
      exemptions: []
      violation_action: block_completion
    - id: root-cause-before-bug-fix
      rule: "No bug fix without root-cause investigation first."
      applies_when: "bug, regression, unexpected behavior, failing test, performance anomaly"
      required_evidence:
        - reproduction_or_observed_failure
        - root_cause_hypothesis
        - evidence_supporting_root_cause
        - fix_targets_root_cause
      verifier_mapping: []
      exemptions: []
      violation_action: return_to_investigation
    - id: test-first-for-behavior-change
      rule: "No software behavior change without failing test evidence first unless explicitly exempted."
      applies_when: "software behavior change"
      required_evidence:
        - failing_test_or_equivalent_repro_before_change
        - passing_test_after_change
      verifier_mapping: []
      exemptions:
        - generated_code
        - config_only
        - throwaway_prototype
        - user_approved_exemption
      violation_action: block_story_completion
  review_policy:
    required_reviews:
      - id: spec_compliance_review
        order: 1
        purpose: "Verify the result satisfies the goal spec, scope contract, stories, and verifier plan."
        required_when: "implementation, migration, refactor, production-affecting change, or user-visible deliverable"
        reviewer_focus: []
        approval_required_before: quality_review
      - id: quality_review
        order: 2
        purpose: "Verify implementation quality after spec compliance passes."
        required_when: "spec_compliance_review is required"
        reviewer_focus: []
        may_start_only_after: "spec_compliance_review APPROVE"
  plan_granularity:
    selected_mode: story_level | checkpoint_level | bite_sized_steps
    selection_reason: required
    bite_sized_required_when: []
    bite_sized_step_contract:
      required: false
      each_step_requires:
        - action
        - expected_result_or_evidence
      coding_step_requires_when_applicable:
        - failing_test_command
        - expected_failure
        - minimal_implementation_step
        - passing_verification_command
    story_execution_steps:
      G001:
        granularity: story_level | checkpoint_level | bite_sized_steps
        steps:
          - id: G001-S001
            action: required
            expected_result_or_evidence: required
            command: optional
            expected_output: optional
  rationalization_checks:
    red_flags:
      - phrase: "too simple to test"
        normalized_risk: "test discipline bypass"
        action: "require test evidence or explicit exemption"
      - phrase: "defer for now"
        normalized_risk: "unapproved scope shrink"
        action: "check scope_contract.defer_policy"
      - phrase: "verify later"
        normalized_risk: "completion without evidence"
        action: "block checkpoint"
      - phrase: "probably enough"
        normalized_risk: "weak evidence"
        action: "require concrete verifier evidence"
      - phrase: "audit only"
        normalized_risk: "capability not delivered"
        action: "require implementation, already-satisfied evidence, not-applicable evidence, or user-approved deferral"
  verifier_integration:
    aggregate_checks_to_add: []
    story_checks_to_add: []
    quality_gate_requirements: []
```

## Rules

- Fresh evidence before completion is almost always hard. Only weaken it when
  the goal is purely conversational and has no external artifact or claim.
- Root-cause-before-fix is hard for bugs, regressions, unexpected behavior,
  failing tests, build failures, performance anomalies, and integration issues.
- Test-first is hard for software behavior changes unless the output is
  generated, config-only, a throwaway prototype, or the user explicitly approves
  an exemption.
- Two-stage review is hard for implementation, migration, refactor,
  production-affecting, or user-visible deliverable goals. Spec compliance comes
  first; quality review must not begin before spec compliance approval.
- Select `bite_sized_steps` only when it materially improves reproducibility:
  high regression risk, multi-file migration, separate executors, strict test
  order, or user asks for repeatable execution quality.
- When selecting `bite_sized_steps`, write concrete `story_execution_steps` for
  each affected story. Do not leave the handoff writer to invent them later.
- Keep `story_level` for research, strategy, exploratory, or creative goals
  where over-specified steps would reduce quality.
- Red-flag checks must be short, memorable, and enforceable by the final critic
  and execution handoff.

## Quality Bar

A future executor should be unable to checkpoint or complete work by relying on
confidence, convenience, audit-only wording, unapproved deferral, stale
verification, or quality review that skipped spec compliance.
