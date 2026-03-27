#!/bin/bash

set -euo pipefail

# No URL configured; nothing to do.
if [[ -z "${AGENT_CONFIG_REPO_URL:-}" ]]; then
    exit 0
fi

target_dir="/root/agent-config"

# Directory already has contents; do not overwrite.
if [[ -d "$target_dir" ]] && [[ -n "$(ls -A "$target_dir" 2>/dev/null || true)" ]]; then
    exit 0
fi

# Clone target must be a directory, not a file or other node.
if [[ -e "$target_dir" && ! -d "$target_dir" ]]; then
    echo "$target_dir exists and is not a directory" >&2
    exit 1
fi

# Ensure empty target directory exists for git clone.
if [[ ! -d "$target_dir" ]]; then
    mkdir -p "$target_dir"
fi

# Target directory non-empty; skip clone.
if [[ -n "$(ls -A "$target_dir" 2>/dev/null || true)" ]]; then
    exit 0
fi

git clone "$AGENT_CONFIG_REPO_URL" "$target_dir"
