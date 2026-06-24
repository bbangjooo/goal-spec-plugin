---
name: goal-freedom-policy-designer
description: Use in the goal-spec pipeline to decide what must be hard-constrained, what sequence must be required, what can stay creatively free, and when execution should escalate to the user.
---

# Goal Freedom Policy Designer

## Purpose

Design the autonomy boundary for a goal spec.

## Input

```yaml
intent_summary: required
required_processes: required
domain_failure_modes: required
authority_boundaries: required
```

## Output

```yaml
freedom_policy:
  default: mixed_autonomy
  hard_constraints: []
  required_sequences: []
  freedom_zones: []
  escalation_points: []
```

## Rules

- Use mixed autonomy by default.
- Hard constraints must be externally checkable.
- Required sequences preserve order but leave implementation details flexible.
- Freedom zones should be broad enough to prevent unnecessary user questions.
- Escalation points are only for destructive, irreversible, credential-gated, external-production, or materially scope-changing choices.
- Do not turn style preferences or familiar workflows into blockers without a domain reason.

## Quality Bar

An executor should know exactly where it may improvise and where it must obey the contract.

