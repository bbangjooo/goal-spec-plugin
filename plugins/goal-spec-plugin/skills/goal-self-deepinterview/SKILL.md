---
name: goal-self-deepinterview
description: Use after a first-draft goal spec is assembled to Socratically audit whether the spec faithfully captures the user's natural-language intent, resolve ambiguity internally where evidence allows, and ask the user a concise choice question only when a decision materially changes the goal.
---

# Goal Self Deepinterview

## Purpose

Run a self-contained deep-interview-style alignment audit on a drafted goal spec. This is not a normal critic pass. Its job is to check whether the spec the system wrote is actually the spec the user wanted.

Use it after the first full goal spec draft exists and before the final `goal-spec-critic` gate.

## Input

```yaml
raw_user_objective: required
source_material: optional
draft_goal_spec: required
specialist_outputs: required
scope_contract: required
execution_discipline: required
```

## Output

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

## Philosophy

Borrow the discipline of OMX deep-interview:

- Intent before implementation detail.
- Ask one highest-leverage question only when needed.
- Pressure-test assumptions, boundaries, non-goals, and success criteria.
- Prefer evidence and source text over vibes.
- Distinguish discoverable facts from human decisions.
- Do not keep interviewing to polish wording once execution would not materially change.
- Interview each grouped unit briefly for semantic drift, but do not run a full
  deepinterview agent per unit by default. Unit-level deep interviews are too
  expensive unless a specific unit can materially change the final goal.

Adaptation for goal specs:

- First interview the draft against the user's source material yourself.
- Treat the raw objective and provided source material as the user's voice.
- Resolve ambiguity internally when the answer is implied by the objective, source, constraints, or specialist outputs.
- Ask the user only when multiple plausible interpretations would produce materially different stories, guardrails, freedom policy, or completion gates.

## Self Interview Procedure

1. Compare the draft spec against the raw objective.
2. Score these dimensions from 0.0 to 1.0:
   - `intent_fit`: why the user wants the goal.
   - `outcome_fit`: desired final state.
   - `scope_fit`: in-scope and out-of-scope boundaries.
   - `constraint_fit`: hard rules and domain constraints.
   - `success_fit`: completion and evidence criteria.
   - `autonomy_fit`: freedom zones, required process, and escalation points.
   - `scope_contract_fit`: preservation of completion-critical capabilities,
     surface/capability distinctions, required matrices, and deferral authority.
   - `execution_discipline_fit`: preservation of iron-law gates, review order,
     selected plan granularity, and rationalization checks.
3. Run one pressure pass:
   - What assumption did the draft make that the user did not state?
   - What did the draft omit that the user emphasized?
   - What did the draft over-constrain that should remain free?
   - What did the draft leave free that should be guarded?
   - Did the draft mistake user-mentioned topics for the primary goal object?
   - Does the draft's completion surface match what would actually make the user's goal true?
   - Did any excluded surface get interpreted too broadly, removing runtime, policy, audit, or contract work that still belongs to the goal?
   - Did any completion-critical axis from the user's wording become audit-only,
     follow-up-only, broad-family-only, or agent-deferred?
   - Does every required parity or coverage matrix have row sources, per-row
     evidence, allowed statuses, and reject conditions?
   - Could an executor satisfy this spec with a result smaller than the user's
     likely expectation?
   - Could an executor checkpoint or complete work by saying "simple enough",
     "defer for now", "verify later", "probably sufficient", or "audit only"?
   - Are bug-fix, behavior-change, and completion claims blocked unless their
     required evidence or explicit exemptions exist?
4. Run unit-level micro-interviews:
   - `framing`: Did intent, final goal, object model, and scope contract preserve
     the same desired end state?
   - `constraints`: Did required processes and freedom policy preserve the scope
     contract without over-constraining optional surfaces?
   - `execution_design`: Do stories and verifier checks cover every
     completion-critical capability and required matrix?
   - `runtime_policy`: Will state, ledger, loop docs, and steering preserve
     capability status, deferral decisions, iron-law evidence, review verdicts,
     plan granularity decisions, and discipline exemptions?
   - `handoff`: Does the copyable prompt include enough scope-contract detail to
     prevent a smaller legal interpretation, and enough execution-discipline
     detail to prevent rationalized completion?
5. If the answer is recoverable from source material, add it to `resolved_internally`.
6. If not recoverable and it changes execution materially, set `USER_DECISION_NEEDED` and ask one concise question with 2-4 concrete options.
7. If revisions are needed but no user decision is needed, set `REVISE` and write concrete `revision_instructions`.
8. If all dimensions are at or above threshold and no material ambiguity remains, set `ALIGNED`.

## User Question Rule

Ask the user only when the ambiguity changes execution materially. Prefer options.

Question shape:

```yaml
question: "Which interpretation should govern the goal spec?"
options:
  - label: "Strict process"
    value: "strict_process"
    description: "Required sequence becomes a hard gate."
  - label: "Mixed autonomy"
    value: "mixed_autonomy"
    description: "Sequence is required only at verification gates; execution details remain flexible."
  - label: "Exploration first"
    value: "exploration_first"
    description: "Keep process as reference unless validation risk appears."
```

If the runtime has native structured input, use it. Otherwise ask exactly one concise plain-text question with options and wait for the answer. Do not ask multiple questions in one round.

## Quality Bar

The final goal spec should feel like a faithful operationalization of the user's natural-language intent, not merely a well-formed plan. A future executor should be able to explain why each story, guardrail, freedom zone, completion gate, and capability contract follows from the user's words or from a clearly recorded internal resolution.
