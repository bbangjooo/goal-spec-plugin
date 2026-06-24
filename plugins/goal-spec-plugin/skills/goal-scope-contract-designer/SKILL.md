---
name: goal-scope-contract-designer
description: Use in the goal-spec pipeline after goal object modeling to convert raw intent, exclusions, priorities, and discovered surfaces into a hard scope/capability contract before decomposition.
---

# Goal Scope Contract Designer

## Purpose

Prevent goal specs from becoming smaller than the user's intended outcome.
This specialist turns natural-language priorities, exclusions, mentioned topics,
and discovered evidence surfaces into an explicit scope contract.

The key distinction is surface versus capability:

- A surface is where something appears or is edited, such as UI, docs, sample
  code, reports, config files, tests, or notebooks.
- A capability is what must be true for the goal to be complete, such as runtime
  behavior, compatibility, registry coverage, policy compliance, workflow
  completion, or measurable parity.

Excluding or deprioritizing a surface does not automatically exclude
capabilities evidenced by that surface.

## Input

```yaml
raw_user_objective: required
intent_summary: required
final_goal: required
goal_object_model: required
source_material: optional
known_constraints: optional
```

## Output

```yaml
scope_contract:
  completion_critical_axes: []
  capability_contracts:
    - id: required
      capability: required
      source_terms: []
      evidence_surfaces: []
      required_outcome: required
      verifier_obligation: required
      allowed_statuses:
        - implemented
        - already_satisfied
        - not_applicable_with_evidence
        - user_approved_deferred
      agent_may_defer: false
  surface_contracts:
    - surface: required
      priority: required
      excluded_work: []
      still_valid_as_evidence_for: []
      must_not_be_interpreted_as_excluding: []
  parity_or_coverage_matrices:
    - id: required
      purpose: required
      rows_must_come_from: []
      each_row_requires: []
      reject_if: []
  defer_policy:
    agent_may_defer: []
    user_approval_required: []
    defer_record_must_include: []
  ambiguity_triggers:
    - trigger: required
      why_it_matters: required
      action: ask_user | revise_contract | document_resolution
```

## Rules

- Treat phrases like "main changes", "major axes", "must preserve", "port",
  "parity", "compatible", "same behavior", or "complete migration" as
  completion-critical unless the user clearly marks them as optional.
- Treat low priority as sequencing guidance, not exclusion, unless the user
  explicitly excludes the capability itself.
- When a low-priority or excluded surface may reveal required capabilities, list
  that surface under `still_valid_as_evidence_for`.
- A capability named or strongly implied by the user cannot be silently reduced
  to audit-only, follow-up-only, or defer-by-default.
- `user_approved_deferred` is the only acceptable deferred status for
  completion-critical capabilities unless the source material clearly proves
  `not_applicable_with_evidence`.
- Add a parity or coverage matrix whenever the goal includes migration,
  compatibility, coverage, catalog, inventory, refactor preservation, feature
  parity, policy compliance, or multi-item domain scope.
- If multiple interpretations would materially change required capabilities,
  add an `ambiguity_triggers` entry. The review stage decides whether to ask the
  user.

## Quality Bar

A later decomposer, verifier, and handoff writer should be unable to legally
complete the goal while omitting a user-critical capability, hiding it under a
broad family label, or treating a low-priority surface as a capability
exclusion.
