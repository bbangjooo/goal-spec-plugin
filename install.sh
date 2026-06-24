#!/usr/bin/env bash
set -euo pipefail

MARKETPLACE_REPO="bbangjooo/goal-spec-plugin"
MARKETPLACE_NAME="goal-spec"
PLUGIN_NAME="goal-spec-plugin"

if ! command -v codex >/dev/null 2>&1; then
  echo "Error: codex CLI not found. Install Codex first, then rerun this installer." >&2
  exit 1
fi

echo "Adding Codex marketplace: ${MARKETPLACE_NAME}"
if ! codex plugin marketplace list 2>/dev/null | awk '{print $1}' | grep -qx "${MARKETPLACE_NAME}"; then
  codex plugin marketplace add "${MARKETPLACE_REPO}" \
    --sparse .agents/plugins \
    --sparse "plugins/${PLUGIN_NAME}"
else
  echo "Marketplace ${MARKETPLACE_NAME} is already registered."
  codex plugin marketplace upgrade "${MARKETPLACE_NAME}" >/dev/null || true
fi

echo "Installing plugin: ${PLUGIN_NAME}@${MARKETPLACE_NAME}"
codex plugin add "${PLUGIN_NAME}@${MARKETPLACE_NAME}"

echo
echo "Goal Spec plugin installed."
echo "Start a new Codex thread, then use: Use \$goal-spec to turn this objective into a goal-executable spec."
