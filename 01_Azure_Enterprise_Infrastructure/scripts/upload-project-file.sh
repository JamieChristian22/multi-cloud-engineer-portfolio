#!/usr/bin/env bash
set -euo pipefail

STORAGE_ACCOUNT="${STORAGE_ACCOUNT:-stenterprisefiles}"
CONTAINER_NAME="${CONTAINER_NAME:-project-files}"
FILE_PATH="${1:-README.md}"

if [[ ! -f "$FILE_PATH" ]]; then
  echo "File not found: $FILE_PATH"
  exit 1
fi

az storage blob upload   --account-name "$STORAGE_ACCOUNT"   --container-name "$CONTAINER_NAME"   --name "$(basename "$FILE_PATH")"   --file "$FILE_PATH"   --auth-mode login   --overwrite true

echo "Uploaded $FILE_PATH to container $CONTAINER_NAME."
