# Goal Spec Specialist IO Contracts

Use these contracts when orchestrating specialist skills or simulating specialist roles in one session. Required fields must be present before the next stage starts.

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

## 2. goal-domain-process-mapper

Input:

```yaml
intent_summary: required
domain: required
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

## 3. goal-freedom-policy-designer

Input:

```yaml
intent_summary: required
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

## 4. goal-decomposer

Input:

```yaml
intent_summary: required
target_outcome: required
required_processes: required
freedom_policy: required
guardrail_candidates: required
```

Output:

```yaml
aggregate_goal:
  title: required
  objective: required
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

## 5. goal-verifier-designer

Input:

```yaml
stories: required
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

## 6. goal-state-ledger-architect

Input:

```yaml
intent_summary: required
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
    intermediate_outputs:
      intent: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/01-intent.yaml"
      domain_process: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/02-domain-process.yaml"
      freedom_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/03-freedom-policy.yaml"
      decomposition: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/04-decomposition.yaml"
      verifier_plan: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/05-verifier-plan.yaml"
      state_ledger: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/06-state-ledger.yaml"
      steering_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/07-steering-policy.yaml"
      execution_handoff: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/08-execution-handoff.yaml"
      self_deepinterview: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/09-self-deepinterview.yaml"
      critic_verdict: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/10-critic-verdict.yaml"
    reference_dir: ".goal-specs/references/YYYY-MM-DD-<slug>/"
    ledger_dir: ".goal-specs/ledger/YYYY-MM-DD-<slug>/"
    brief: ".goal-specs/ledger/YYYY-MM-DD-<slug>/brief.md"
    goals: ".goal-specs/ledger/YYYY-MM-DD-<slug>/goals.json"
    ledger: ".goal-specs/ledger/YYYY-MM-DD-<slug>/ledger.jsonl"
    evidence_index: ".goal-specs/ledger/YYYY-MM-DD-<slug>/evidence-index.md"
    steering_log: ".goal-specs/ledger/YYYY-MM-DD-<slug>/steering-log.md"
    runtime_mirror_optional:
      omx_brief: ".omx/ultragoal/brief.md"
      omx_goals: ".omx/ultragoal/goals.json"
      omx_ledger: ".omx/ultragoal/ledger.jsonl"
    domain_state:
      - ".goal-specs/ledger/YYYY-MM-DD-<slug>/domain-state.md"
  read_before_each_iteration: []
  write_after_each_iteration: []
  lesson_writeback_rules: []
  evidence_index_rules: []
```

## 7. goal-steering-policy-designer

Input:

```yaml
stories: required
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

## 8. goal-handoff-writer

Input:

```yaml
aggregate_goal: required
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
  story_execution_rules: []
  checkpoint_rules: []
  steering_rules: []
  update_goal_complete_rule: required
  blocked_rule: required
```

## 9. goal-self-deepinterview

Input:

```yaml
raw_user_objective: required
source_material: optional
draft_goal_spec: required
specialist_outputs: required
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
  resolved_internally: []
  unresolved_questions: []
  user_question:
    needed: false
    question: ""
    options: []
  revision_instructions: []
```

## 10. goal-spec-critic

Input:

```yaml
full_goal_contract: required
raw_user_objective: required
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
- Every story has success criteria and evidence requirements.
- Every required process is reflected in story dependencies or checkpoint rules.
- Every verifier failure has a writeback path.
- Every plan mutation has evidence and rationale.
- `goal-self-deepinterview` has returned `ALIGNED` or its required revisions/user decision have been applied before final critic approval.
- Final completion requires `APPROVE + CLEAR`.
