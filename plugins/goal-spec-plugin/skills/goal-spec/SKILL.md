---
name: goal-spec
description: Use when converting an objective into a single goal-executable spec file by orchestrating specialist goal-spec skills for intent extraction, final goal design, goal object modeling, domain process mapping, freedom policy, decomposition, verification, state/ledger, steering, handoff, and critic review.
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
  ledger/                # goal-spec execution notes, loop docs, evidence indexes, steering logs
```

For each generated spec, create a slug-specific subdirectory and write specialist outputs there:

```text
.goal-specs/intermediate/YYYY-MM-DD-<slug>/
  01-intent.yaml
  02-final-goal.yaml
  03-goal-object-model.yaml
  04-domain-process.yaml
  05-freedom-policy.yaml
  06-decomposition.yaml
  07-verifier-plan.yaml
  08-state-ledger.yaml
  09-steering-policy.yaml
  10-execution-handoff.yaml
  11-self-deepinterview.yaml
  12-critic-verdict.yaml
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
3. `Final Goal`
4. `Goal Object Model`
5. `Aggregate Goal`
6. `Specialist Trace`
7. `Story Goals`
8. `Required Process`
9. `Freedom Policy`
10. `Guardrails`
11. `Verifier Plan`
12. `State And Ledger`
13. `Steering Policy`
14. `Checkpoint Policy`
15. `Loop Documentation Policy`
16. `Quality Gate`
17. `Goal Invocation Prompt`
18. `Execution Handoff`
19. `Self Deepinterview`
20. `Critic Verdict`

Read `references/goal-spec-file-template.md` for the canonical file template.

## Specialist Pipeline

Run the work in this order. If actual separate skill invocation is unavailable in the current surface, simulate each role explicitly and keep the same input/output contracts.

1. `goal-intent-extractor`
2. `goal-final-goal-designer`
3. `goal-object-modeler`
4. `goal-domain-process-mapper`
5. `goal-freedom-policy-designer`
6. `goal-decomposer`
7. `goal-verifier-designer`
8. `goal-state-ledger-architect`
9. `goal-steering-policy-designer`
10. `goal-handoff-writer`
11. `goal-self-deepinterview`
12. `goal-spec-critic`

Read `references/io-contracts.md` for each specialist's required input/output schema.

After each specialist stage, write that stage's raw structured output to the matching file in `.goal-specs/intermediate/YYYY-MM-DD-<slug>/`. The final spec must summarize those outputs and link to the intermediate files.

The final assistant response after creating the spec must include:

- The final spec file path.
- A `Goal Invocation Prompt` block that the user can paste into a new Codex goal execution turn.
- A shorter path-based prompt when the executor can read the workspace file.
- An inline fallback prompt when the executor cannot access the file path.

The first complete draft is created after `goal-handoff-writer`. Before running the final critic, run `goal-self-deepinterview` to audit whether that draft faithfully operationalizes the user's natural-language intent. If it returns `REVISE`, update the relevant specialist sections and rerun self-deepinterview. If it returns `USER_DECISION_NEEDED`, ask one concise option-based question and apply the answer before continuing.

## Orchestrator Rules

- Preserve traceability from raw objective to aggregate goal, story goals, verifier checks, and final handoff.
- Do not decompose mentioned topics directly. First classify the real goal object, completion surface, owning systems, and decomposition basis with `goal-object-modeler`.
- Treat user exclusions as surface-specific. Excluding an implementation surface does not automatically exclude runtime, policy, audit, or contract surfaces that are required for the goal object to be complete.
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

The `Goal Invocation Prompt` section must include copyable prompts like:

```text
Use the goal spec at <spec_file_path> as the execution contract. Create one aggregate goal from its Goal Handoff Header, execute the story goals with the required process, verifier plan, state/ledger rules, steering policy, and loop documentation policy, and do not mark the aggregate goal complete until the spec's Quality Gate is APPROVE + CLEAR.
```

```text
Create one aggregate Codex goal from the aggregate objective below.
Execute stories in order unless structured steering changes the order.
Before each story, read state. After each attempt, write evidence, decisions, failures, blockers, and lessons.
For every execution loop/iteration, write a loop document under `.goal-specs/ledger/YYYY-MM-DD-<slug>/loop-documents/iteration-NNN.md`.
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
