#!/usr/bin/env bash
set -euo pipefail

SERVER="root@86.48.5.120"
REMOTE_BASE="/root"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PROJECT_NAME="${1:-$(basename "${PROJECT_ROOT}")}"
REMOTE_DIR="${REMOTE_BASE}/${PROJECT_NAME}"

echo "Creating remote directory: ${SERVER}:${REMOTE_DIR}"
ssh "${SERVER}" "mkdir -p '${REMOTE_DIR}'"

echo "Syncing project to server..."
rsync -az --delete \
  --exclude ".git" \
  --exclude ".github" \
  --exclude "node_modules" \
  "${PROJECT_ROOT}/" "${SERVER}:${REMOTE_DIR}/"

echo "Deploy complete: ${SERVER}:${REMOTE_DIR}"
