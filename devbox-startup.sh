#!/bin/bash
set -ueo pipefail

HASH_FILE="${VENV_DIR}/.uv.lockhash"
if [[ -f "$HASH_FILE" ]]; then
  # Read the previous hash from the file
  previousHash="$(cat "${HASH_FILE}")"
else
  previousHash=""
fi
currentHash="$(sha256sum <(cat "pyproject.toml" "uv.lock") | awk '{ print $1 }')"

# Compare the current hash with the previous hash
if [[ "$currentHash" != "$previousHash" ]]; then
  echo "Python dependencies changed, running uv sync" >&2
  uv sync --active --dev
  # Update the hash file with the new hash
  echo "$currentHash" >"$HASH_FILE"
fi
