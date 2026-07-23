# 2. S3-native state locking (no DynamoDB)

Date: 2026-07-23

## Status

Accepted

## Context

Terraform's S3 backend historically required a DynamoDB table for state locking.
Terraform 1.10 added native S3 locking via a lock file object in the state
bucket (`use_lockfile = true`), removing the need for a separate table.

## Decision

Use `use_lockfile = true` in every backend and require Terraform `>= 1.10`. No
DynamoDB lock tables. State buckets are created by the `bootstrap/` config with
versioning, SSE, public-access blocking, and a TLS-only policy.

## Consequences

One fewer resource type to provision and pay for. Locking lives with the state.
The whole platform is pinned to Terraform 1.10+ (enforced by `required_version`).
