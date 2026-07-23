#!/usr/bin/env bash
# Offline validation of every configuration (no AWS/backend required).
set -euo pipefail
cd "$(dirname "$0")/.."

for dir in bootstrap dev qa stage production shared; do
  echo "== validate: $dir =="
  (
    cd "$dir"
    rm -rf .terraform .terraform.lock.hcl
    terraform init -backend=false -input=false >/dev/null
    terraform validate
    rm -rf .terraform .terraform.lock.hcl
  )
done
