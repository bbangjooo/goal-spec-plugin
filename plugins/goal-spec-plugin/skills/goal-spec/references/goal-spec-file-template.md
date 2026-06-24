# Goal Spec File Template

Create one Markdown file from this template. It is the artifact that can be handed to a future Codex goal executor.

````markdown
---
goal_spec_version: 1
status: ready_for_goal_execution
goal_mode: aggregate
title: "<title>"
domain: "<domain>"
created_at: "<YYYY-MM-DD>"
spec_owner: "goal-spec"
quality_gate: "PENDING | APPROVE + CLEAR"
spec_file: ".goal-specs/specs/<YYYY-MM-DD-slug>-goal-spec.md"
intermediate_dir: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/"
reference_dir: ".goal-specs/references/<YYYY-MM-DD-slug>/"
ledger_dir: ".goal-specs/ledger/<YYYY-MM-DD-slug>/"
---

# <Title> Goal Spec

## Goal Handoff Header

```yaml
goal_spec_version: 1
status: ready_for_goal_execution
aggregate_goal: "<aggregate goal objective>"
goal_mode: aggregate
story_ledger:
  - G001: pending
completion_rule: "Do not mark the aggregate goal complete until all active stories are complete or superseded and the quality gate is APPROVE + CLEAR."
spec_file: "<path to this file>"
intermediate_dir: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/"
reference_dir: ".goal-specs/references/<YYYY-MM-DD-slug>/"
ledger_dir: ".goal-specs/ledger/<YYYY-MM-DD-slug>/"
```

## Intent Summary

- Raw objective:
- Domain:
- Target outcome:
- Success shape:
- Non-goals:
- Authority boundaries:
- Assumptions:
- Unknowns:

## Final Goal

```yaml
final_goal:
  title: ""
  objective: ""
  desired_end_state: ""
  success_shape: ""
  completion_requires: []
  failure_definition: ""
  non_goals: []
  decision_boundaries: []
  tradeoff_priority: []
  completion_critical_axes: []
  goal_quality_checks: []
```

## Goal Object Model

```yaml
goal_object_model:
  primary_goal_object: ""
  primary_type: ""
  not_merely: []
  completion_surface: ""
  completion_level: ""
  owning_systems: []
  mentioned_topics: []
  topic_interpretation: {}
  excluded_surfaces: {}
  required_capability_chain: []
  missing_surface_risks: []
  surface_capability_distinctions: []
  decomposition_basis: ""
  verifier_focus: []
```

## Scope Contract

This section is intentionally both human-readable and machine-checkable. YAML
alone is not sufficient for the final goal handoff because future executors need
the rationale for scope boundaries, surface/capability distinctions, and
deferral authority.

```yaml
scope_contract:
  completion_critical_axes: []
  capability_contracts:
    - id: ""
      capability: ""
      source_terms: []
      evidence_surfaces: []
      required_outcome: ""
      verifier_obligation: ""
      allowed_statuses:
        - implemented
        - already_satisfied
        - not_applicable_with_evidence
        - user_approved_deferred
      agent_may_defer: false
  surface_contracts:
    - surface: ""
      priority: ""
      excluded_work: []
      still_valid_as_evidence_for: []
      must_not_be_interpreted_as_excluding: []
  parity_or_coverage_matrices:
    - id: ""
      purpose: ""
      rows_must_come_from: []
      each_row_requires: []
      reject_if: []
  defer_policy:
    agent_may_defer: []
    user_approval_required: []
    defer_record_must_include: []
  ambiguity_triggers: []
```

## Aggregate Goal

```yaml
aggregate_goal:
  title: ""
  objective: ""
  completion_requires:
    - "All active stories are complete or explicitly superseded."
    - "All required verifier evidence exists."
    - "Quality gate is APPROVE + CLEAR."
```

## Agent Trace

| Stage | Agent | Internal Substeps | Status | Unit Output |
| --- | --- | --- | --- | --- |
| 1 | goal-framing | intent, final goal, goal object, scope contract | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/01-framing.yaml` |
| 2 | goal-constraints | domain process, freedom policy | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/02-constraints.yaml` |
| 3 | goal-execution-design | decomposition, verifier plan | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/03-execution-design.yaml` |
| 4 | goal-runtime-policy | state/ledger, steering policy, execution discipline | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/04-runtime-policy.yaml` |
| 5 | goal-handoff | execution handoff, invocation prompt | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/05-handoff.yaml` |
| 6 | goal-review | self-deepinterview, critic | APPROVE | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/units/06-review.yaml` |

## Specialist Trace

| Stage | Specialist | Output | Status | Intermediate File |
| --- | --- | --- | --- | --- |
| 1 | goal-intent-extractor | Intent frame | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/01-intent.yaml` |
| 2 | goal-final-goal-designer | Final goal | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/02-final-goal.yaml` |
| 3 | goal-object-modeler | Goal object and completion surface | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/03-goal-object-model.yaml` |
| 4 | goal-scope-contract-designer | Scope and capability contract | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/04-scope-contract.yaml` |
| 5 | goal-domain-process-mapper | Required process and failure modes | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/05-domain-process.yaml` |
| 6 | goal-freedom-policy-designer | Freedom policy | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/06-freedom-policy.yaml` |
| 7 | goal-decomposer | Aggregate and story goals | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/07-decomposition.yaml` |
| 8 | goal-verifier-designer | Verifier plan | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/08-verifier-plan.yaml` |
| 9 | goal-state-ledger-architect | State and ledger | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/09-state-ledger.yaml` |
| 10 | goal-steering-policy-designer | Steering policy | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/10-steering-policy.yaml` |
| 11 | goal-execution-discipline-designer | Iron laws, review policy, plan granularity, rationalization checks | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/11-execution-discipline.yaml` |
| 12 | goal-handoff-writer | Execution handoff | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/12-execution-handoff.yaml` |
| 13 | goal-self-deepinterview | Intent alignment audit | ALIGNED | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/13-self-deepinterview.yaml` |
| 14 | goal-spec-critic | Critic verdict | APPROVE | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/14-critic-verdict.yaml` |

## Story Goals

```yaml
stories:
  - id: G001
    title: ""
    objective: ""
    depends_on: []
    inputs: []
    outputs: []
    success_criteria: []
    evidence_required: []
    allowed_freedom_zone: []
    execution_steps:
      granularity: story_level | checkpoint_level | bite_sized_steps
      steps: []
```

## Required Process

```yaml
required_processes:
  - id: ""
    flow: []
    enforce: true
    reason: ""
    failure_if_skipped: ""
```

## Freedom Policy

```yaml
freedom_policy:
  default: mixed_autonomy
  hard_constraints: []
  required_sequences: []
  freedom_zones: []
  escalation_points: []
```

## Guardrails

```yaml
guardrails:
  - id: ""
    rule: ""
    severity: hard
    verifier_check: ""
    failure_action: ""
```

## Verifier Plan

```yaml
verifier_plan:
  aggregate_checks: []
  story_checks: {}
```

## State And Ledger

```yaml
state_and_ledger:
  artifacts:
    spec_file: "<path>"
    intermediate_dir: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/"
    unit_outputs:
      framing: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/01-framing.yaml"
      constraints: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/02-constraints.yaml"
      execution_design: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/03-execution-design.yaml"
      runtime_policy: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/04-runtime-policy.yaml"
      handoff: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/05-handoff.yaml"
      review: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/units/06-review.yaml"
    intermediate_outputs:
      intent: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/01-intent.yaml"
      final_goal: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/02-final-goal.yaml"
      goal_object_model: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/03-goal-object-model.yaml"
      scope_contract: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/04-scope-contract.yaml"
      domain_process: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/05-domain-process.yaml"
      freedom_policy: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/06-freedom-policy.yaml"
      decomposition: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/07-decomposition.yaml"
      verifier_plan: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/08-verifier-plan.yaml"
      state_ledger: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/09-state-ledger.yaml"
      steering_policy: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/10-steering-policy.yaml"
      execution_discipline: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/11-execution-discipline.yaml"
      execution_handoff: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/12-execution-handoff.yaml"
      self_deepinterview: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/13-self-deepinterview.yaml"
      critic_verdict: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/14-critic-verdict.yaml"
    reference_dir: ".goal-specs/references/<YYYY-MM-DD-slug>/"
    ledger_dir: ".goal-specs/ledger/<YYYY-MM-DD-slug>/"
    brief: ".goal-specs/ledger/<YYYY-MM-DD-slug>/brief.md"
    goals: ".goal-specs/ledger/<YYYY-MM-DD-slug>/goals.json"
    ledger: ".goal-specs/ledger/<YYYY-MM-DD-slug>/ledger.jsonl"
    evidence_index: ".goal-specs/ledger/<YYYY-MM-DD-slug>/evidence-index.md"
    steering_log: ".goal-specs/ledger/<YYYY-MM-DD-slug>/steering-log.md"
    loop_documents_dir: ".goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/"
    loop_document_template: ".goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/iteration-NNN.md"
    runtime_mirror_optional:
      omx_brief: ".omx/ultragoal/brief.md"
      omx_goals: ".omx/ultragoal/goals.json"
      omx_ledger: ".omx/ultragoal/ledger.jsonl"
    domain_state:
      - ".goal-specs/ledger/<YYYY-MM-DD-slug>/domain-state.md"
  read_before_each_iteration: []
  write_after_each_iteration:
    - decisions
    - failed_attempts
    - blockers
    - verification_evidence
    - steering_mutations
    - lessons_learned
  loop_document_policy:
    required: true
    write_path: ".goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/iteration-NNN.md"
    must_include:
      - story_id
      - iteration_number
      - objective_for_this_loop
      - state_read
      - actions_taken
      - evidence_produced
      - verifier_result
      - decisions
      - failures_or_blockers
      - lessons_learned
      - next_loop_change
  lesson_writeback_rules: []
  evidence_index_rules: []
```

## Loop Documentation Policy

Each execution loop must write one document:

```text
.goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/iteration-NNN.md
```

Required sections: Story ID, iteration objective, state read before work, actions taken, evidence produced, verifier result, decisions, failures or blockers, lessons learned, and next-loop change.

## Steering Policy

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

## Execution Discipline

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
      required_evidence: []
      verifier_mapping: []
      exemptions: []
      violation_action: return_to_investigation
    - id: test-first-for-behavior-change
      rule: "No software behavior change without failing test evidence first unless explicitly exempted."
      applies_when: "software behavior change"
      required_evidence: []
      verifier_mapping: []
      exemptions: []
      violation_action: block_story_completion
  review_policy:
    required_reviews:
      - id: spec_compliance_review
        order: 1
        purpose: "Verify the result satisfies the goal spec, scope contract, stories, and verifier plan."
        required_when: ""
        reviewer_focus: []
        approval_required_before: quality_review
      - id: quality_review
        order: 2
        purpose: "Verify implementation quality after spec compliance passes."
        required_when: ""
        reviewer_focus: []
        may_start_only_after: "spec_compliance_review APPROVE"
  plan_granularity:
    selected_mode: story_level
    selection_reason: ""
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
    story_execution_steps: {}
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

## Checkpoint Policy

```yaml
checkpoint_policy:
  complete:
    requires:
      - success_criteria_met
      - verifier_evidence_present
  blocked:
    requires:
      - blocker_is_external_or_authority_limited
      - alternatives_attempted_or_ruled_out
  failed:
    requires:
      - failed_validation_evidence
      - recovery_or_steering_path_recorded
```

## Quality Gate

```yaml
quality_gate:
  final_status: "APPROVE + CLEAR | REVISE"
  before_update_goal_complete:
    - all_active_stories_complete_or_superseded
    - final_verifier_evidence_present
    - scope_contract_preserved
    - execution_discipline_satisfied_or_explicitly_exempted
    - self_deepinterview_aligned
    - critic_verdict_approve
    - no_unresolved_blockers
```

## Goal Invocation Prompt

Use this prompt to start goal execution from this spec:

```text
Use the goal spec at <path to this file> as the execution contract. Create one aggregate goal from its Goal Handoff Header, preserve its Scope Contract, follow its Execution Discipline, execute the story goals with the required process, verifier plan, state/ledger rules, steering policy, and loop documentation policy, and do not mark the aggregate goal complete until the spec's Quality Gate is APPROVE + CLEAR.
```

If the execution surface cannot read the file path, use this inline fallback:

```text
Create one aggregate goal for: <aggregate goal objective>.
Use these story goals: <story ids and objectives>.
Preserve this final goal: <final_goal.objective>.
Preserve this completion surface: <goal_object_model.completion_surface>.
Preserve this scope contract: <scope_contract summary, completion-critical capabilities, required matrices, and deferral policy>.
Follow this execution discipline: <iron laws, review order, selected plan granularity, rationalization red flags, and exemptions>.
Follow the required process, verifier plan, state/ledger rules, steering policy, and loop documentation policy from the goal spec.
For every execution loop, write `.goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/iteration-NNN.md`.
Do not mark the aggregate goal complete until all active stories are complete or superseded, required verifier evidence exists, the scope contract is preserved, execution discipline is satisfied or explicitly exempted, self-deepinterview is ALIGNED, critic verdict is APPROVE, and the Quality Gate is APPROVE + CLEAR.
```

## Self Deepinterview

```yaml
self_deepinterview:
  verdict: ALIGNED
  alignment_score: 0.0
  threshold: 0.85
  dimensions:
    intent_fit: 0.0
    outcome_fit: 0.0
    scope_fit: 0.0
    constraint_fit: 0.0
    success_fit: 0.0
    autonomy_fit: 0.0
    scope_contract_fit: 0.0
    execution_discipline_fit: 0.0
  unit_micro_interviews:
    framing: []
    constraints: []
    execution_design: []
    runtime_policy: []
    handoff: []
  resolved_internally: []
  unresolved_questions: []
  user_question:
    needed: false
    question: ""
    options: []
  revision_instructions: []
```

## Execution Handoff

```text
Create one aggregate Codex goal from the aggregate objective in this spec.
Execute story goals in ledger order unless structured steering changes the order.
Preserve the Scope Contract: completion-critical capabilities cannot be narrowed,
silently deferred, or hidden under broad labels.
Follow the Execution Discipline: no completion without fresh evidence; no bug
fix without root-cause evidence when debugging is in scope; no software behavior
change without test-first evidence unless explicitly exempted; run spec
compliance review before quality review; reject rationalizations such as
"simple enough", "defer for now", "verify later", "probably sufficient", or
"audit only" when they bypass evidence or scope gates.
Before each story, read the state artifacts listed above.
After each attempt, write decisions, failures, blockers, evidence, steering mutations, and lessons to the ledger.
For every execution loop/iteration, write a loop document under `.goal-specs/ledger/<YYYY-MM-DD-slug>/loop-documents/iteration-NNN.md`.
Checkpoint a story complete only when its success criteria are met and verifier evidence exists.
If a story fails verification, record the failure and either retry within its freedom zone or use structured steering.
Do not update the aggregate goal complete until every active story is complete or superseded and the quality gate is APPROVE + CLEAR.
If the self-deepinterview verdict is not ALIGNED, resolve its revision instructions or user decision before continuing execution.
```

## Critic Verdict

```yaml
critic_result:
  verdict: APPROVE
  blockers: []
  quality_gaps: []
  overconstraint_warnings: []
  missing_traceability: []
  revision_instructions: []
```
````
