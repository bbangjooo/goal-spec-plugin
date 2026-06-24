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
  decomposition_basis: ""
  verifier_focus: []
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

## Specialist Trace

| Stage | Specialist | Output | Status | Intermediate File |
| --- | --- | --- | --- | --- |
| 1 | goal-intent-extractor | Intent frame | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/01-intent.yaml` |
| 2 | goal-final-goal-designer | Final goal | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/02-final-goal.yaml` |
| 3 | goal-object-modeler | Goal object and completion surface | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/03-goal-object-model.yaml` |
| 4 | goal-domain-process-mapper | Required process and failure modes | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/04-domain-process.yaml` |
| 5 | goal-freedom-policy-designer | Freedom policy | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/05-freedom-policy.yaml` |
| 6 | goal-decomposer | Aggregate and story goals | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/06-decomposition.yaml` |
| 7 | goal-verifier-designer | Verifier plan | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/07-verifier-plan.yaml` |
| 8 | goal-state-ledger-architect | State and ledger | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/08-state-ledger.yaml` |
| 9 | goal-steering-policy-designer | Steering policy | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/09-steering-policy.yaml` |
| 10 | goal-handoff-writer | Execution handoff | complete | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/10-execution-handoff.yaml` |
| 11 | goal-self-deepinterview | Intent alignment audit | ALIGNED | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/11-self-deepinterview.yaml` |
| 12 | goal-spec-critic | Critic verdict | APPROVE | `.goal-specs/intermediate/<YYYY-MM-DD-slug>/12-critic-verdict.yaml` |

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
    intermediate_outputs:
      intent: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/01-intent.yaml"
      final_goal: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/02-final-goal.yaml"
      goal_object_model: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/03-goal-object-model.yaml"
      domain_process: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/04-domain-process.yaml"
      freedom_policy: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/05-freedom-policy.yaml"
      decomposition: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/06-decomposition.yaml"
      verifier_plan: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/07-verifier-plan.yaml"
      state_ledger: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/08-state-ledger.yaml"
      steering_policy: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/09-steering-policy.yaml"
      execution_handoff: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/10-execution-handoff.yaml"
      self_deepinterview: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/11-self-deepinterview.yaml"
      critic_verdict: ".goal-specs/intermediate/<YYYY-MM-DD-slug>/12-critic-verdict.yaml"
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
    - self_deepinterview_aligned
    - critic_verdict_approve
    - no_unresolved_blockers
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
