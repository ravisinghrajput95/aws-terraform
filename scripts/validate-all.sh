#!/usr/bin/env bash
# Offline validation of every configuration (no AWS/backend required).
set -euo pipefail
cd "$(dirname "$0")/.."

for dir in bootstrap environments/dev environments/qa environments/stage environments/production environments/shared; do
  echo "== validate: $dir =="
  (
    cd "$dir"
    rm -rf .terraform .terraform.lock.hcl
    terraform init -backend=false -input=false >/dev/null
    terraform validate
    rm -rf .terraform .terraform.lock.hcl
  )
done
