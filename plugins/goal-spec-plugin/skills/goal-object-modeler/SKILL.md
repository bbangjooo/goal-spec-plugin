---
name: goal-object-modeler
description: Use in the goal-spec pipeline after final goal design to classify the real goal object, completion surface, system ownership, and topic-to-goal interpretation before domain mapping or decomposition.
---

# Goal Object Modeler

## Purpose

Identify what kind of thing must become true for the goal to be complete. This
skill prevents the pipeline from treating user-mentioned topics as the goal
itself.

The output is an ontology bridge between natural-language intent and executable
story decomposition. It names the primary goal object, the completion surface,
the system level that owns completion, and how mentioned topics should be
interpreted inside that object.

## Input

```yaml
intent_summary: required
domain: required
final_goal: required
source_material: optional
known_constraints: optional
```

## Output

```yaml
goal_object_model:
  primary_goal_object: required
  primary_type: required
  not_merely: []
  completion_surface: required
  completion_level: required
  owning_systems: []
  mentioned_topics: []
  topic_interpretation: {}
  excluded_surfaces: {}
  required_capability_chain: []
  missing_surface_risks: []
  surface_capability_distinctions:
    - surface: ""
      excluded_or_low_priority_work: []
      capabilities_still_in_scope: []
      evidence_value: ""
  decomposition_basis: required
  verifier_focus: []
```

## Rules

- Separate `mentioned_topics` from the `primary_goal_object`.
- Classify the completion level before any story decomposition begins.
- Prefer capability/workflow/state completion over file/module completion unless
  the user explicitly asked only for file/module edits.
- If the user excludes a surface, distinguish excluded implementation detail
  from any runtime, policy, audit, or contract that still belongs to completion.
- If the user lowers priority for a surface, distinguish sequencing priority
  from scope exclusion. Low priority does not remove capabilities evidenced by
  that surface.
- `required_capability_chain` must name the end-to-end surface that proves the
  goal object is real, not just implemented locally.
- Use `surface_capability_distinctions` whenever a UI, document, report, config,
  test, notebook, sample, or external system is excluded or deprioritized but
  may reveal required behavior, compatibility, catalog, policy, or parity.
- `decomposition_basis` must say what later story goals should be organized
  around: capability chain, artifact lifecycle, workflow phases, policy gates,
  repair sequence, investigation questions, or another explicit basis.
- Add a `missing_surface_risks` item whenever a spec could satisfy mentioned
  topics while failing the real goal object.

## Quality Bar

A later decomposer should be unable to mistake a user's named topics for the
goal object. A later critic should be able to reject any spec whose stories
cover topics but not the declared completion surface.
