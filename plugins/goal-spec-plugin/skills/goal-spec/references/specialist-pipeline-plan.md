# Specialist Pipeline Refactor Plan

This plan upgrades `goal-spec` from a single all-purpose writer into an orchestrator for specialized goal-spec skills or agents. The goal is reproducible quality: the same objective should produce a similarly complete executable goal contract even when run by different agents.

## Target Shape

Current shape:

```text
goal-spec
  -> directly writes the whole goal contract
```

Target shape:

```text
goal-spec
  -> goal-intent-extractor
  -> goal-domain-process-mapper
  -> goal-freedom-policy-designer
  -> goal-decomposer
  -> goal-verifier-designer
  -> goal-state-ledger-architect
  -> goal-steering-policy-designer
  -> goal-handoff-writer
  -> goal-self-deepinterview
  -> goal-spec-critic
  -> final contract
```

The orchestrator owns routing, schema enforcement, traceability, revision loops, and final assembly. Specialists own one narrow judgment each.

## Design Principle

Do not rely on one agent being broadly wise. Make quality emerge from:

- narrow roles
- explicit input/output schemas
- verifier-backed completion
- critic review before final output
- traceability from user intent to story goals and checks
- structured revision loops when a specialist output is incomplete

## Specialist Roles

### 1. goal-intent-extractor

Purpose: turn ambiguous user intent into a stable problem frame.

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

Quality bar:

- The target outcome must describe a state change, not a vague activity.
- Authority boundaries must include external, destructive, financial, legal, production, credentialed, or irreversible actions when relevant.
- Unknowns must not block progress unless they materially change safety, scope, or authority.

### 2. goal-domain-process-mapper

Purpose: extract required domain workflows, references, and failure modes.

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

Quality bar:

- Mark a process required only when order affects correctness, validation integrity, safety, compliance, or irreversible external effects.
- Keep nonessential best practices as reference-only guidance.
- Each required process must name the failure caused by skipping or reordering it.

### 3. goal-freedom-policy-designer

Purpose: decide what is constrained, sequenced, or free.

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

Quality bar:

- Hard constraints must be externally checkable.
- Required sequences must preserve agent freedom inside each stage.
- Freedom zones should be explicit enough that executors do not ask unnecessary questions.
- Escalation points are only for destructive, irreversible, credential-gated, external-production, or materially scope-changing decisions.

### 4. goal-decomposer

Purpose: split the aggregate goal into checkpointable story goals.

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

Quality bar:

- Every story must be independently checkpointable.
- A story is too large if completion evidence would require several unrelated verifiers.
- Story success criteria must not depend on the maker saying it is done.
- Dependencies must preserve required process order.

### 5. goal-verifier-designer

Purpose: design independent checks for each story and the aggregate goal.

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

Quality bar:

- Every hard constraint maps to at least one verifier check.
- Every story has at least one required evidence artifact or observable result.
- Maker self-report is never sufficient evidence.
- Checks must state pass/fail criteria or explain why judgment is qualitative.

### 6. goal-state-ledger-architect

Purpose: define durable memory so repeated goal execution compounds.

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
    domain_state: []
  read_before_each_iteration: []
  write_after_each_iteration: []
  lesson_writeback_rules: []
  evidence_index_rules: []
```

Quality bar:

- State must record decisions, failures, blockers, verification evidence, steering mutations, and lessons learned.
- Each repeated loop must read prior state before acting.
- Failure writeback must be specific enough to change the next iteration.

### 7. goal-steering-policy-designer

Purpose: define safe plan mutation during execution.

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

Quality bar:

- Steering must allow learning without allowing silent scope drift.
- Superseding a story requires evidence that it is invalid, obsolete, duplicate, or blocked by an external decision.
- Reordering may not violate required sequences unless the required sequence is explicitly revised with rationale.

### 8. goal-handoff-writer

Purpose: turn the contract into execution instructions for Codex/OMX goal mode.

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

Quality bar:

- Handoff must be executable by an agent without rereading the whole design discussion.
- It must say when to call create_goal, when to checkpoint stories, and when update_goal complete is forbidden.
- Final completion requires all active stories complete or superseded and quality gate APPROVE + CLEAR.

### 9. goal-self-deepinterview

Purpose: audit the first full draft against the user's natural-language intent before final structural critique.

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

Quality bar:

- REVISE when the draft makes an unsupported assumption, misses a user-emphasized boundary, or encodes the wrong autonomy level.
- USER_DECISION_NEEDED only when multiple plausible interpretations materially change stories, guardrails, freedom policy, or completion gates.
- Ask at most one concise option-based user question per round.
- ALIGNED only when the draft faithfully operationalizes the user's natural language.

### 10. goal-spec-critic

Purpose: adversarially inspect the final contract before presentation or execution.

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

Quality bar:

- REVISE if any story lacks evidence, verifier checks, or checkpoint criteria.
- REVISE if any hard constraint lacks a verifier.
- REVISE if the handoff permits completion by maker self-report.
- REVISE if required process and story dependencies disagree.
- Warn, but do not always block, when the contract over-constrains creative choices.

## Orchestrator Responsibilities

The orchestrator must:

1. Run specialists in the fixed order unless a prior output proves a stage is not applicable.
2. Preserve each stage output in the final trace.
3. Validate every specialist output against its schema before moving on.
4. Send incomplete outputs back to the same specialist with concrete repair instructions.
5. Assemble the final prose and YAML contract.
6. Run `goal-self-deepinterview` after the first complete draft.
7. Apply self-deepinterview revisions or ask its one required user decision before critic review.
8. Run `goal-spec-critic`.
9. Apply critic revisions or clearly label unresolved gaps.
10. Produce a final execution handoff.

The orchestrator must not:

- silently invent missing verifier evidence
- collapse all specialist roles into one broad plan
- weaken hard constraints during handoff
- let quality gate checks become optional
- ask the user for decisions that are already covered by freedom zones

## Revision Loop

```text
specialist output
  -> schema check
  -> if missing required fields, return to same specialist
  -> if semantically inconsistent, return to the upstream specialist that introduced the inconsistency
  -> after assembly, critic review
  -> if critic says REVISE, patch the relevant specialist section
  -> rerun critic
  -> final contract
```

Examples:

- Story has no evidence requirement: return to `goal-decomposer`.
- Guardrail has no verifier check: return to `goal-verifier-designer`.
- Required process conflicts with dependency order: return to `goal-decomposer` after consulting `goal-domain-process-mapper`.
- Handoff allows final completion too early: return to `goal-handoff-writer`.
- Contract forces unnecessary process: return to `goal-freedom-policy-designer`.
- Self-deepinterview finds wrong intent fit: return to the specialist section that introduced the misalignment, then rerun self-deepinterview.

## Implementation Plan

### Phase 1: Refactor Orchestrator

- Rewrite `goal-spec/SKILL.md` so it is a router and assembler.
- Move detailed direct-writing guidance into references.
- Add a `Specialist Pipeline` section that references this plan.

### Phase 2: Add IO Contracts

- Create `references/io-contracts.md`.
- Put every specialist input/output schema in one canonical file.
- Require orchestrator to validate outputs against that file.

### Phase 3: Create Specialist Skills

Create these folders under `~/.codex/skills/`:

- `goal-intent-extractor`
- `goal-domain-process-mapper`
- `goal-freedom-policy-designer`
- `goal-decomposer`
- `goal-verifier-designer`
- `goal-state-ledger-architect`
- `goal-steering-policy-designer`
- `goal-handoff-writer`
- `goal-self-deepinterview`
- `goal-spec-critic`

Each specialist skill should contain:

- a narrow trigger description
- one responsibility
- required input schema
- required output schema
- quality bar
- common failure modes

### Phase 4: Add Final Contract Template

- Rename or replace `references/spec-template.md` with `references/final-spec-template.md`.
- Include slots for every specialist output.
- Include a traceability table from user intent to story to verifier to evidence.

### Phase 5: Add Critic Checklist

- Create `references/critic-checklist.md`.
- Make it the mandatory final gate.
- Include both under-specification and over-constraint checks.

### Phase 6: Validate

- Run skill validation on all new skill folders.
- Smoke test with at least two domains:
  - quant research loop
  - non-quant creative or software objective
- Confirm both outputs include the same structural guarantees while preserving domain-specific freedom.

## Completion Criteria For This Refactor

The refactor is complete when:

- The orchestrator no longer acts as the only writer.
- Every specialist has a clear role and schema.
- The final contract includes all specialist outputs.
- The critic can block incomplete or unsafe contracts.
- A generated execution handoff forbids premature `update_goal complete`.
- Smoke tests show consistent structure across at least two domains.
