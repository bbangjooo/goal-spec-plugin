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
3. Run one pressure pass:
   - What assumption did the draft make that the user did not state?
   - What did the draft omit that the user emphasized?
   - What did the draft over-constrain that should remain free?
   - What did the draft leave free that should be guarded?
4. If the answer is recoverable from source material, add it to `resolved_internally`.
5. If not recoverable and it changes execution materially, set `USER_DECISION_NEEDED` and ask one concise question with 2-4 concrete options.
6. If revisions are needed but no user decision is needed, set `REVISE` and write concrete `revision_instructions`.
7. If all dimensions are at or above threshold and no material ambiguity remains, set `ALIGNED`.

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

The final goal spec should feel like a faithful operationalization of the user's natural-language intent, not merely a well-formed plan. A future executor should be able to explain why each story, guardrail, freedom zone, and completion gate follows from the user's words or from a clearly recorded internal resolution.

