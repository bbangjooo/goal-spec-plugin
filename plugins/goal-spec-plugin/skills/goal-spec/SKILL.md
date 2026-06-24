---
name: goal-spec
description: Use when converting an objective into a single goal-executable spec file by orchestrating separate grouped goal-spec agents for framing, constraints, execution design, runtime policy, handoff, and review.
---

# Goal Spec

## Purpose

Use this skill to produce one complete spec that can be handed to a Codex goal or OMX ultragoal execution flow. The spec must be executable, verifier-gated, and durable: it should preserve intent, story goals, required process, freedom zones, guardrails, state/ledger rules, steering rules, and completion gates in one file.

This skill is the root orchestrator. It should not rely on one broad pass and should not directly perform all specialist work when subagents are available. It routes the objective through grouped separate agents, checks their compact outputs, assembles the final contract, and sends the draft to an independent review agent.

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
  units/
    01-framing.yaml
    02-constraints.yaml
    03-execution-design.yaml
    04-runtime-policy.yaml
    05-handoff.yaml
    06-review.yaml
  01-intent.yaml
  02-final-goal.yaml
  03-goal-object-model.yaml
  04-scope-contract.yaml
  05-domain-process.yaml
  06-freedom-policy.yaml
  07-decomposition.yaml
  08-verifier-plan.yaml
  09-state-ledger.yaml
  10-steering-policy.yaml
  11-execution-handoff.yaml
  12-self-deepinterview.yaml
  13-critic-verdict.yaml
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
6. `Agent Trace`
7. `Specialist Trace`
8. `Scope Contract`
9. `Story Goals`
10. `Required Process`
11. `Freedom Policy`
12. `Guardrails`
13. `Verifier Plan`
14. `State And Ledger`
15. `Steering Policy`
16. `Checkpoint Policy`
17. `Loop Documentation Policy`
18. `Quality Gate`
19. `Goal Invocation Prompt`
20. `Execution Handoff`
21. `Self Deepinterview`
22. `Critic Verdict`

Read `references/goal-spec-file-template.md` for the canonical file template.

## Agent Pipeline

When subagents are available, run each grouped stage as a separate bounded agent in this fixed order:

1. `goal-framing`
2. `goal-constraints`
3. `goal-execution-design`
4. `goal-runtime-policy`
5. `goal-handoff`
6. `goal-review`

Each grouped agent executes its internal substeps in one agent context and writes both a compact unit output and detailed specialist outputs. The root orchestrator must read compact unit outputs and file paths by default. Open detailed specialist outputs only for schema validation, inconsistency repair, final assembly, or review-driven revision.

Use the leaf specialist skills as internal substep contracts:

- `goal-framing`: `goal-intent-extractor`, `goal-final-goal-designer`, `goal-object-modeler`, `goal-scope-contract-designer`
- `goal-constraints`: `goal-domain-process-mapper`, `goal-freedom-policy-designer`
- `goal-execution-design`: `goal-decomposer`, `goal-verifier-designer`
- `goal-runtime-policy`: `goal-state-ledger-architect`, `goal-steering-policy-designer`
- `goal-handoff`: `goal-handoff-writer`
- `goal-review`: `goal-self-deepinterview`, `goal-spec-critic`

Fallback: if the current runtime cannot spawn subagents, simulate the six grouped agents sequentially, but still keep the same unit outputs, specialist outputs, file paths, and trace.

Read `references/io-contracts.md` for each grouped agent and internal specialist input/output schema.

After each grouped agent finishes, validate its unit output before moving to the next grouped agent. The final spec must summarize unit outputs, specialist outputs, and file paths.

The final assistant response after creating the spec must include:

- The final spec file path.
- A `Goal Invocation Prompt` block that the user can paste into a new Codex goal execution turn.
- A shorter path-based prompt when the executor can read the workspace file.
- An inline fallback prompt when the executor cannot access the file path.

The first complete draft is created after `goal-handoff`. Before finalizing, run `goal-review` as a separate checker agent. If it returns `REVISE`, update the relevant upstream grouped agent section and rerun the affected agent(s), then rerun `goal-review`. If it returns `USER_DECISION_NEEDED`, ask one concise option-based question and apply the answer before continuing.

## Orchestrator Rules

- Preserve traceability from raw objective to aggregate goal, story goals, verifier checks, and final handoff.
- Prefer separate grouped agents over a flat 12-agent pipeline to reduce root context growth.
- Do not keep all detailed intermediate outputs in root context; keep summaries and file paths unless detail is needed for validation or repair.
- Do not decompose mentioned topics directly. First classify the real goal object, completion surface, owning systems, and decomposition basis with `goal-object-modeler`.
- Treat user exclusions as surface-specific. Excluding an implementation surface does not automatically exclude runtime, policy, audit, or contract surfaces that are required for the goal object to be complete.
- Preserve capability contracts. A low-priority or excluded surface may still be
  an evidence source for required capabilities; downstream agents must not
  silently convert it into a capability exclusion.
- Do not allow agent-decided deferral of completion-critical capabilities.
  Deferral must be either user-approved or proven not applicable with evidence.
- Use Markdown for the final executable contract and YAML for machine-readable
  intermediate contracts. YAML alone is insufficient for handoff because future
  executors need narrative intent, rationale, and human-readable ambiguity
  resolution alongside structured fields.
- Do not pass incomplete specialist output to the next stage.
- If a required field is missing, repair that specialist section before continuing.
- Do not weaken hard constraints during assembly.
- Do not allow maker self-report to count as completion evidence.
- Do not allow `update_goal complete` until all active stories are complete or superseded and the final quality gate is `APPROVE + CLEAR`.
- Do not finalize until `goal-review` returns `APPROVE` or its required revisions/user decision have been applied.
- Keep `goal-review` separate from `goal-handoff`; handoff is maker work, review is checker work.

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
