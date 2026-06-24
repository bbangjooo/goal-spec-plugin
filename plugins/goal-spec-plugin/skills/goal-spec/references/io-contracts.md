# Goal Spec IO Contracts

Use these contracts when orchestrating grouped agents and their internal specialist substeps. Required fields must be present before the next stage starts.

## Root Agent Pipeline

When subagents are available, root `goal-spec` must call these grouped agents as separate bounded agents:

```yaml
agent_pipeline:
  - goal-framing
  - goal-constraints
  - goal-execution-design
  - goal-runtime-policy
  - goal-handoff
  - goal-review
```

The root orchestrator reads compact unit outputs by default and opens detailed specialist outputs only for validation, repair, final assembly, or review-driven revision.

### goal-framing

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/01-framing.yaml"
specialist_outputs:
  intent: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/01-intent.yaml"
  final_goal: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/02-final-goal.yaml"
  goal_object_model: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/03-goal-object-model.yaml"
  scope_contract: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/04-scope-contract.yaml"
```

### goal-constraints

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/02-constraints.yaml"
specialist_outputs:
  domain_process: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/05-domain-process.yaml"
  freedom_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/06-freedom-policy.yaml"
```

### goal-execution-design

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/03-execution-design.yaml"
specialist_outputs:
  decomposition: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/07-decomposition.yaml"
  verifier_plan: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/08-verifier-plan.yaml"
```

### goal-runtime-policy

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/04-runtime-policy.yaml"
specialist_outputs:
  state_ledger: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/09-state-ledger.yaml"
  steering_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/10-steering-policy.yaml"
```

### goal-handoff

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/05-handoff.yaml"
specialist_outputs:
  execution_handoff: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/11-execution-handoff.yaml"
```

### goal-review

Writes:

```yaml
unit_output: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/06-review.yaml"
specialist_outputs:
  self_deepinterview: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/12-self-deepinterview.yaml"
  critic_verdict: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/13-critic-verdict.yaml"
```

## Internal Specialist Contracts

## 1. goal-intent-extractor

Input:

```yaml
raw_user_objective: required
source_material: optional
known_constraints: optional
```

Output:

```yaml
intent_summary: required
domain: required
target_outcome: required
success_shape: required
non_goals: []
authority_boundaries: []
assumptions: []
unknowns: []
high_risk_ambiguities: []
```

## 2. goal-final-goal-designer

Input:

```yaml
intent_summary: required
domain: required
target_outcome: required
success_shape: required
non_goals: []
authority_boundaries: []
assumptions: []
unknowns: []
source_material: optional
```

Output:

```yaml
final_goal:
  title: required
  objective: required
  desired_end_state: required
  success_shape: required
  completion_requires: []
  failure_definition: required
  non_goals: []
  decision_boundaries: []
  tradeoff_priority: []
  goal_quality_checks: []
```

## 3. goal-object-modeler

Input:

```yaml
intent_summary: required
domain: required
final_goal: required
source_material: optional
known_constraints: optional
```

Output:

```yaml
goal_object_model:
  primary_goal_object: required
  primary_type: required
  not_merely: []
  completion_surface: required
  completion_level: required
  owning_systems: []
  mentioned_topics: []
  topic_interpretation: {}
  excluded_surfaces: {}
  required_capability_chain: []
  missing_surface_risks: []
  decomposition_basis: required
  verifier_focus: []
```

## 4. goal-scope-contract-designer

Input:

```yaml
raw_user_objective: required
intent_summary: required
final_goal: required
goal_object_model: required
source_material: optional
known_constraints: optional
```

Output:

```yaml
scope_contract:
  completion_critical_axes: []
  capability_contracts:
    - id: required
      capability: required
      source_terms: []
      evidence_surfaces: []
      required_outcome: required
      verifier_obligation: required
      allowed_statuses:
        - implemented
        - already_satisfied
        - not_applicable_with_evidence
        - user_approved_deferred
      agent_may_defer: false
  surface_contracts:
    - surface: required
      priority: required
      excluded_work: []
      still_valid_as_evidence_for: []
      must_not_be_interpreted_as_excluding: []
  parity_or_coverage_matrices:
    - id: required
      purpose: required
      rows_must_come_from: []
      each_row_requires: []
      reject_if: []
  defer_policy:
    agent_may_defer: []
    user_approval_required: []
    defer_record_must_include: []
  ambiguity_triggers: []
```

## 5. goal-domain-process-mapper

Input:

```yaml
intent_summary: required
domain: required
final_goal: required
goal_object_model: required
scope_contract: required
source_material: optional
domain_references: optional
```

Output:

```yaml
required_processes:
  - id: ""
    flow: []
    enforce: true
    reason: ""
    failure_if_skipped: ""
reference_only_guidance: []
domain_failure_modes: []
domain_guardrail_candidates: []
```

## 6. goal-freedom-policy-designer

Input:

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
scope_contract: required
required_processes: required
domain_failure_modes: required
authority_boundaries: required
```

Output:

```yaml
freedom_policy:
  default: mixed_autonomy
  hard_constraints: []
  required_sequences: []
  freedom_zones: []
  escalation_points: []
```

## 7. goal-decomposer

Input:

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
scope_contract: required
required_processes: required
freedom_policy: required
guardrail_candidates: required
```

Output:

```yaml
aggregate_goal:
  title: required
  objective: required
  derived_from_final_goal: required
  completion_requires: []
stories:
  - id: G001
    title: required
    objective: required
    depends_on: []
    inputs: []
    outputs: []
    success_criteria: []
    evidence_required: []
    allowed_freedom_zone: []
```

## 8. goal-verifier-designer

Input:

```yaml
stories: required
final_goal: required
goal_object_model: required
scope_contract: required
hard_constraints: required
required_sequences: required
domain_failure_modes: required
```

Output:

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

## 9. goal-state-ledger-architect

Input:

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
scope_contract: required
stories: required
verifier_plan: required
required_processes: required
```

Output:

```yaml
state_and_ledger:
  artifacts:
    spec_file: ".goal-specs/specs/YYYY-MM-DD-<slug>-goal-spec.md"
    intermediate_dir: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/"
    unit_outputs:
      framing: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/01-framing.yaml"
      constraints: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/02-constraints.yaml"
      execution_design: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/03-execution-design.yaml"
      runtime_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/04-runtime-policy.yaml"
      handoff: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/05-handoff.yaml"
      review: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/units/06-review.yaml"
    intermediate_outputs:
      intent: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/01-intent.yaml"
      final_goal: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/02-final-goal.yaml"
      goal_object_model: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/03-goal-object-model.yaml"
      scope_contract: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/04-scope-contract.yaml"
      domain_process: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/05-domain-process.yaml"
      freedom_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/06-freedom-policy.yaml"
      decomposition: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/07-decomposition.yaml"
      verifier_plan: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/08-verifier-plan.yaml"
      state_ledger: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/09-state-ledger.yaml"
      steering_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/10-steering-policy.yaml"
      execution_handoff: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/11-execution-handoff.yaml"
      self_deepinterview: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/12-self-deepinterview.yaml"
      critic_verdict: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/13-critic-verdict.yaml"
    reference_dir: ".goal-specs/references/YYYY-MM-DD-<slug>/"
    ledger_dir: ".goal-specs/ledger/YYYY-MM-DD-<slug>/"
    brief: ".goal-specs/ledger/YYYY-MM-DD-<slug>/brief.md"
    goals: ".goal-specs/ledger/YYYY-MM-DD-<slug>/goals.json"
    ledger: ".goal-specs/ledger/YYYY-MM-DD-<slug>/ledger.jsonl"
    evidence_index: ".goal-specs/ledger/YYYY-MM-DD-<slug>/evidence-index.md"
    steering_log: ".goal-specs/ledger/YYYY-MM-DD-<slug>/steering-log.md"
    loop_documents_dir: ".goal-specs/ledger/YYYY-MM-DD-<slug>/loop-documents/"
    loop_document_template: ".goal-specs/ledger/YYYY-MM-DD-<slug>/loop-documents/iteration-NNN.md"
    runtime_mirror_optional:
      omx_brief: ".omx/ultragoal/brief.md"
      omx_goals: ".omx/ultragoal/goals.json"
      omx_ledger: ".omx/ultragoal/ledger.jsonl"
    domain_state:
      - ".goal-specs/ledger/YYYY-MM-DD-<slug>/domain-state.md"
  read_before_each_iteration: []
  write_after_each_iteration: []
  loop_document_policy:
    required: true
    write_path: ".goal-specs/ledger/YYYY-MM-DD-<slug>/loop-documents/iteration-NNN.md"
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

## 10. goal-steering-policy-designer

Input:

```yaml
stories: required
final_goal: required
goal_object_model: required
scope_contract: required
freedom_policy: required
state_and_ledger: required
authority_boundaries: required
```

Output:

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

## 11. goal-handoff-writer

Input:

```yaml
aggregate_goal: required
final_goal: required
goal_object_model: required
scope_contract: required
stories: required
verifier_plan: required
state_and_ledger: required
steering_policy: required
quality_gate: required
```

Output:

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

## 12. goal-self-deepinterview

Input:

```yaml
raw_user_objective: required
source_material: optional
draft_goal_spec: required
specialist_outputs: required
scope_contract: required
```

Output:

```yaml
self_deepinterview:
  verdict: ALIGNED | REVISE | USER_DECISION_NEEDED
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

## 13. goal-spec-critic

Input:

```yaml
full_goal_contract: required
raw_user_objective: required
goal_object_model: required
scope_contract: required
```

Output:

```yaml
critic_result:
  verdict: APPROVE | REVISE
  blockers: []
  quality_gaps: []
  overconstraint_warnings: []
  missing_traceability: []
  revision_instructions: []
```

## Cross-Stage Invariants

- Every hard constraint has a verifier check.
- Final goal is explicit, state-shaped, and reflected in aggregate goal and stories.
- Goal object model separates user-mentioned topics from the primary goal object.
- Story decomposition follows the declared `decomposition_basis`, not merely the mentioned topics.
- Required processes and verifier checks cover the declared completion surface and required capability chain.
- Excluded surfaces are interpreted narrowly; excluding an implementation surface does not silently remove runtime, policy, audit, or contract surfaces required by the goal object.
- Completion-critical capability contracts are preserved in stories, verifier
  checks, state/ledger, and handoff.
- Agent-decided deferral is forbidden for completion-critical capabilities;
  deferral must be user-approved or proven not applicable with evidence.
- Any required parity or coverage matrix has a story owner, row source rules,
  per-row evidence requirements, and reject conditions.
- Every story has success criteria and evidence requirements.
- Every execution loop writes a loop document under `.goal-specs/ledger/YYYY-MM-DD-<slug>/loop-documents/`.
- Every required process is reflected in story dependencies or checkpoint rules.
- Every verifier failure has a writeback path.
- Every plan mutation has evidence and rationale.
- `goal-self-deepinterview` has returned `ALIGNED` or its required revisions/user decision have been applied before final critic approval.
- Final completion requires `APPROVE + CLEAR`.
