# Goal Spec Plugin

Goal Spec is a plugin marketplace (Codex and Claude Code) for turning ambiguous objectives into durable, verifier-gated, goal-executable specs.

The main entry point is `$goal-spec`. It orchestrates grouped agents to keep the root context small:

1. `goal-framing`
2. `goal-constraints`
3. `goal-execution-design`
4. `goal-runtime-policy`
5. `goal-handoff`
6. `goal-review`

Each grouped agent runs its internal substeps in one isolated context and writes compact unit outputs plus detailed specialist outputs under `.goal-specs/intermediate/`.

Internal specialist substeps remain available as skills:

```text
goal-intent-extractor, goal-final-goal-designer, goal-object-modeler,
goal-domain-process-mapper, goal-freedom-policy-designer,
goal-decomposer, goal-verifier-designer,
goal-state-ledger-architect, goal-steering-policy-designer,
goal-handoff-writer, goal-self-deepinterview, goal-spec-critic
```

## Install (Claude Code)

Inside a Claude Code session:

```text
/plugin marketplace add bbangjooo/goal-spec-plugin
/plugin install goal-spec-plugin@goal-spec
```

Or from the terminal:

```bash
claude plugin marketplace add bbangjooo/goal-spec-plugin
claude plugin install goal-spec-plugin@goal-spec
```

Then start a new session and ask Claude to use the `goal-spec` skill, e.g.:

```text
Use the goal-spec skill to turn this objective into a goal-executable spec:

<your objective here>
```

## Install (Codex)

Install with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/bbangjooo/goal-spec-plugin/main/install.sh | bash
```

Or run the Codex commands manually:

```bash
codex plugin marketplace add bbangjooo/goal-spec-plugin \
  --sparse .agents/plugins \
  --sparse plugins/goal-spec-plugin

codex plugin add goal-spec-plugin@goal-spec
```

## Repository Layout

```text
.claude-plugin/marketplace.json        # Claude Code marketplace catalog
.agents/plugins/marketplace.json       # Codex marketplace catalog
plugins/goal-spec-plugin/              # installable plugin (both runtimes)
  .claude-plugin/plugin.json           # Claude Code manifest
  .codex-plugin/plugin.json            # Codex manifest
  skills/
examples/
```

## What It Produces

By default, `$goal-spec` writes project-local artifacts under `.goal-specs/`:

```text
.goal-specs/
  specs/                 # final goal-executable specs
  intermediate/          # grouped unit outputs and specialist outputs
  references/            # user-provided or extracted reference notes
  ledger/                # evidence indexes, loop docs, steering logs, resumable state
```

Each final spec is a single Markdown file that can be handed to a future Codex goal executor. It includes:

- final goal
- goal object model
- aggregate goal
- story goals
- required process
- freedom policy
- guardrails
- verifier plan
- state and ledger contract
- per-loop documentation policy
- steering policy
- checkpoint policy
- copyable goal invocation prompt
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
