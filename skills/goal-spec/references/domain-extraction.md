# Domain Extraction Guide

Use this when turning a domain article, rough notes, or user explanation into a goal contract.

## Extraction Questions

Extract these facts from the source:

- What is the repeated loop?
- What outcome should compound over iterations?
- What must be remembered between runs?
- What stage order matters?
- What mistakes would make results invalid?
- What actions are safe, risky, irreversible, or authority-limited?
- What evidence proves each stage worked?
- Who or what should verify the maker's output?
- What should happen after failure?
- What should be learned and written back?

## Classification

Classify source material into:

- `Goal`: desired durable state.
- `Stage`: repeatable unit of work.
- `Guardrail`: failure-prevention rule.
- `Verifier check`: independent pass/fail test.
- `State`: memory or ledger item.
- `Connector`: external system or action surface.
- `Freedom zone`: creative or implementation choice.
- `Stop condition`: evidence-backed completion rule.

## Rewrite Heuristics

- Convert vague ambition into measurable state.
- Convert advice into guardrails only when violating it creates invalid, unsafe, or non-repeatable results.
- Convert examples into optional references unless the exact sequence is necessary.
- Convert "the agent should decide" into a freedom zone plus verifier gate.
- Convert "keep improving" into an iteration policy with state writes and failure feedback.
- Convert "done" into an external artifact, metric, test, review, or observed state.

## Anti-Patterns

- Treating a checklist as a goal contract.
- Letting the maker grade its own work.
- Encoding every preference as a hard constraint.
- Omitting the state writeback step.
- Allowing plan changes without evidence and rationale.
- Calling the aggregate goal complete while unresolved story blockers remain.

