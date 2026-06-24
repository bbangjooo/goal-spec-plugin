---
name: goal-domain-process-mapper
description: Use in the goal-spec pipeline to extract required domain workflows, reference-only guidance, failure modes, and guardrail candidates from an objective, article, process note, or domain reference.
---

# Goal Domain Process Mapper

## Purpose

Identify which domain processes must be enforced and which guidance should remain optional reference material.

## Input

```yaml
intent_summary: required
domain: required
source_material: optional
domain_references: optional
```

## Output

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

## Rules

- Mark a process required only when sequence affects correctness, validation integrity, safety, compliance, or irreversible external effects.
- Keep ordinary best practices as reference-only guidance.
- Every required process must name what breaks if it is skipped or reordered.
- Failure modes should be concrete enough to become guardrails or verifier checks.
- Do not decompose the goal into stories. Stop at domain process mapping.

## Quality Bar

A later verifier designer should be able to turn every hard failure mode into a check.

