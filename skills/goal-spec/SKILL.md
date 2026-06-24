---
name: goal-spec
description: Use when converting an objective into a single goal-executable spec file by orchestrating specialist goal-spec skills for intent extraction, domain process mapping, freedom policy, decomposition, verification, state/ledger, steering, handoff, and critic review.
---

# Goal Spec

## Purpose

Use this skill to produce one complete spec that can be handed to a Codex goal or OMX ultragoal execution flow. The spec must be executable, verifier-gated, and durable: it should preserve intent, story goals, required process, freedom zones, guardrails, state/ledger rules, steering rules, and completion gates in one file.

This skill is an orchestrator. It should not rely on one broad pass. It routes the objective through specialist skills or equivalent specialist agent roles, checks their outputs, assembles the final contract, and runs a final critic pass.

## Required Output

Always produce or update a single Markdown spec file unless the user explicitly asks for inline-only output. All documents created to prepare the final goal spec, plus intermediate documents that goal execution should consult later, must live under the project root's `.goal-specs/` directory.

Default path:

```text
.goal-specs/specs/YYYY-MM-DD-<slug>-goal-spec.md
```

If outside a repo or no suitable project folder exists, use:

```text
~/.codex/.goal-specs/specs/YYYY-MM-DD-<slug>-goal-spec.md
```

Use this directory layout:

```text
.goal-specs/
  specs/                 # final goal-executable specs
  intermediate/          # specialist outputs used to build final specs
  references/            # user-provided or extracted reference notes
  ledger/                # goal-spec execution notes, evidence indexes, steering logs
```

For each generated spec, create a slug-specific subdirectory and write specialist outputs there:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/
  01-intent.yaml
  02-domain-process.yaml
  03-freedom-policy.yaml
  04-decomposition.yaml
  05-verifier-plan.yaml
  06-state-ledger.yaml
  07-steering-policy.yaml
  08-execution-handoff.yaml
  09-self-deepinterview.yaml
  10-critic-verdict.yaml
```

Reference notes that future goal execution should consult go under:

```text
.goal-specs/references/YYYY-MM-DD-<slug>/
```

Execution evidence, steering logs, and resumable state go under:

```text
.goal-specs/ledger/YYYY-MM-DD-<slug>/
```

The final spec file must contain:

1. `Goal Handoff Header`
2. `Intent Summary`
3. `Aggregate Goal`
4. `Specialist Trace`
5. `Story Goals`
6. `Required Process`
7. `Freedom Policy`
8. `Guardrails`
9. `Verifier Plan`
10. `State And Ledger`
11. `Steering Policy`
12. `Checkpoint Policy`
13. `Quality Gate`
14. `Execution Handoff`
15. `Self Deepinterview`
16. `Critic Verdict`

Read `references/goal-spec-file-template.md` for the canonical file template.

## Specialist Pipeline

Run the work in this order. If actual separate skill invocation is unavailable in the current surface, simulate each role explicitly and keep the same input/output contracts.

1. `goal-intent-extractor`
2. `goal-domain-process-mapper`
3. `goal-freedom-policy-designer`
4. `goal-decomposer`
5. `goal-verifier-designer`
6. `goal-state-ledger-architect`
7. `goal-steering-policy-designer`
8. `goal-handoff-writer`
9. `goal-self-deepinterview`
10. `goal-spec-critic`

Read `references/io-contracts.md` for each specialist's required input/output schema.

After each specialist stage, write that stage's raw structured output to the matching file in `.goal-specs/intermediate/YYYY-MM-DD-<slug>/`. The final spec must summarize those outputs and link to the intermediate files.

The first complete draft is created after `goal-handoff-writer`. Before running the final critic, run `goal-self-deepinterview` to audit whether that draft faithfully operationalizes the user's natural-language intent. If it returns `REVISE`, update the relevant specialist sections and rerun self-deepinterview. If it returns `USER_DECISION_NEEDED`, ask one concise option-based question and apply the answer before continuing.

## Orchestrator Rules

- Preserve traceability from raw objective to aggregate goal, story goals, verifier checks, and final handoff.
- Do not pass incomplete specialist output to the next stage.
- If a required field is missing, repair that specialist section before continuing.
- Do not weaken hard constraints during assembly.
- Do not allow maker self-report to count as completion evidence.
- Do not allow `update_goal complete` until all active stories are complete or superseded and the final quality gate is `APPROVE + CLEAR`.
- Do not send a draft to `goal-spec-critic` until `goal-self-deepinterview` returns `ALIGNED` or its required revisions/user decision have been applied.
- If the critic returns `REVISE`, patch the relevant specialist section and rerun the critic pass before finalizing.

## Freedom Policy Default

Use mixed autonomy:

- High freedom inside each stage.
- Strict gates between stages.
- Hard guardrails for known failure modes.
- Verifier-enforced completion.
- User escalation only for destructive, irreversible, credential-gated, external-production, or materially scope-changing decisions.

## File Handoff Contract

The spec file must begin with a compact handoff block that a future goal executor can read first:

```yaml
goal_spec_version: 1
status: ready_for_goal_execution
aggregate_goal: ""
goal_mode: aggregate
story_ledger: []
spec_file: ".goal-specs/specs/YYYY-MM-DD-<slug>-goal-spec.md"
intermediate_dir: ".goal-specs/intermediate/YYYY-MM-DD-<slug>/"
reference_dir: ".goal-specs/references/YYYY-MM-DD-<slug>/"
ledger_dir: ".goal-specs/ledger/YYYY-MM-DD-<slug>/"
completion_rule: "Do not mark the aggregate goal complete until all active stories are complete or superseded and the quality gate is APPROVE + CLEAR."
```

The `Execution Handoff` section must be written as direct instructions to the next agent:

```text
Create one aggregate Codex goal from the aggregate objective below.
Execute stories in order unless structured steering changes the order.
Before each story, read state. After each attempt, write evidence, decisions, failures, blockers, and lessons.
Checkpoint a story complete only after verifier evidence exists.
Use structured steering for plan changes.
Update the aggregate goal complete only after the quality gate is APPROVE + CLEAR.
```

## References

Read `references/goal-spec-file-template.md` when writing the final single spec file.

Read `references/io-contracts.md` when checking specialist outputs or implementing the split-skill architecture.

Read `references/specialist-pipeline-plan.md` when changing the skill architecture or adding new specialist roles.

Read `references/domain-extraction.md` when the user provides a domain article, process note, or messy natural-language source and asks you to extract the goal framework.

Read `references/quant-example.md` only when the domain is quant trading, backtesting, alpha research, trading automation, or when the user asks for a concrete example based on the original quant-loop discussion.
