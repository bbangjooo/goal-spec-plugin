# Goal Spec Plugin

Goal Spec is a Codex plugin for turning ambiguous objectives into durable, verifier-gated, goal-executable specs.

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

## Installation

Clone this repository, then install it as a local Codex plugin using your normal Codex plugin workflow.

During local development, you can also copy the `skills/` folders into `~/.codex/skills/`.

## Development

Validate the plugin:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py ~/goal-spec-plugin
```

Validate individual skills:

```bash
for d in ~/goal-spec-plugin/skills/*; do
  python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py "$d"
done
```

## License

MIT

