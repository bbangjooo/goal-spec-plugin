---
name: goal-state-ledger-architect
description: Use in the goal-spec pipeline to design durable state, ledger artifacts, read/write rules, evidence indexes, and lesson writeback so repeated goal execution compounds over time.
---

# Goal State Ledger Architect

## Purpose

Define the durable memory contract for a goal spec.

## Input

```yaml
intent_summary: required
final_goal: required
goal_object_model: required
stories: required
verifier_plan: required
required_processes: required
```

## Output

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
      domain_process: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/04-domain-process.yaml"
      freedom_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/05-freedom-policy.yaml"
      decomposition: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/06-decomposition.yaml"
      verifier_plan: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/07-verifier-plan.yaml"
      state_ledger: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/08-state-ledger.yaml"
      steering_policy: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/09-steering-policy.yaml"
      execution_handoff: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/10-execution-handoff.yaml"
      self_deepinterview: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/11-self-deepinterview.yaml"
      critic_verdict: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/12-critic-verdict.yaml"
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

## Rules

- Every repeated loop must read prior state before acting.
- Every repeated loop must write one loop document under `loop_documents_dir`.
- State writes must include decisions, failures, blockers, verification evidence, steering mutations, and lessons learned.
- Failure writeback must be specific enough to influence the next iteration.
- Evidence should be indexable by story id.
- The single goal spec file is itself a state artifact and must be listed.
- Unit outputs must be listed because the root orchestrator reads them before detailed specialist outputs.
- The goal object model must be listed as an intermediate artifact because it defines the completion surface that later stories and verifiers must preserve.
- Canonical goal-spec documents live under the project root's `.goal-specs/`; `.omx/ultragoal` paths are optional runtime mirrors only.

## Quality Bar

Another agent should be able to resume execution from the state and ledger without relying on conversation memory.
