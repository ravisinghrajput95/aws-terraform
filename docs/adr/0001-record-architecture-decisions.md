# 1. Record architecture decisions

Date: 2026-07-23

## Status

Accepted

## Context

We want a lightweight, durable record of the significant architectural choices
behind this platform, so future engineers understand *why* — not just *what*.

## Decision

We use Architecture Decision Records (ADRs), one Markdown file per decision in
`docs/adr/`, numbered sequentially. Format: Context / Decision / Consequences.

## Consequences

Decisions are reviewable in PRs and versioned with the code. New significant
decisions get a new ADR; superseded ones are marked, not deleted.
