# Goal Spec Plugin

Goal Spec is a Codex plugin marketplace for turning ambiguous objectives into durable, verifier-gated, goal-executable specs.

The main entry point is `$goal-spec`. It orchestrates specialist skills that each own one narrow part of the goal-spec pipeline:

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

## Marketplace Install

Add this repository as a Codex plugin marketplace:

```bash
codex plugin marketplace add bbangjooo/goal-spec-plugin
```

Then open the Codex plugin directory, select the `Goal Spec` marketplace, and install `goal-spec-plugin`.

You can also install from CLI after adding the marketplace:

```bash
codex plugin add goal-spec-plugin@goal-spec
```

## Repository Layout

```text
.agents/plugins/marketplace.json       # marketplace catalog
plugins/goal-spec-plugin/              # installable Codex plugin
  .codex-plugin/plugin.json
  skills/
examples/
```

## What It Produces

By default, `$goal-spec` writes project-local artifacts under `.goal-specs/`:

```text
.goal-specs/
  specs/                 # final goal-executable specs
  intermediate/          # specialist outputs used to build final specs
  references/            # user-provided or extracted reference notes
  ledger/                # evidence indexes, steering logs, resumable state
```

Each final spec is a single Markdown file that can be handed to a future Codex goal executor. It includes:

- aggregate goal
- story goals
- required process
- freedom policy
- guardrails
- verifier plan
- state and ledger contract
- steering policy
- checkpoint policy
- self-deepinterview alignment result
- critic verdict
- direct execution handoff

## Usage

```text
Use $goal-spec to turn this objective into a goal-executable spec:

<your objective here>
```

For an already drafted spec:

```text
Use $goal-self-deepinterview to audit whether this drafted goal spec matches the user's intent.
```

## Development

Validate the plugin:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py ~/goal-spec-plugin/plugins/goal-spec-plugin
```

Validate individual skills:

```bash
for d in ~/goal-spec-plugin/plugins/goal-spec-plugin/skills/*; do
  python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py "$d"
done
```

## License

MIT
