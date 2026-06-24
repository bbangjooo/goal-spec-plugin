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

## Rules

- Every repeated loop must read prior state before acting.
- State writes must include decisions, failures, blockers, verification evidence, steering mutations, and lessons learned.
- Failure writeback must be specific enough to influence the next iteration.
- Evidence should be indexable by story id.
- The single goal spec file is itself a state artifact and must be listed.
- Canonical goal-spec documents live under the project root's `.goal-specs/`; `.omx/ultragoal` paths are optional runtime mirrors only.

## Quality Bar

Another agent should be able to resume execution from the state and ledger without relying on conversation memory.
