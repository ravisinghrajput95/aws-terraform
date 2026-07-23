#!/usr/bin/env bash
# Plan the spoke environments (needs AWS credentials + state backends).
# `shared` is intentionally excluded — it depends on the spokes' remote state.
set -euo pipefail
cd "$(dirname "$0")/.."

for env in dev qa stage production; do
  echo "== plan: $env =="
  terraform -chdir="$env" init -input=false >/dev/null
  terraform -chdir="$env" plan -input=false -lock=false
done
