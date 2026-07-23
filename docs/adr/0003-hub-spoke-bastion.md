# 3. Hub-and-spoke with a single private SSM bastion

Date: 2026-07-23

## Status

Accepted

## Context

Each environment is an isolated VPC. Operators need to reach every environment's
EKS API and RDS instance. Options considered: a bastion per environment; a
public IP-allowlisted bastion; or one shared bastion peered to all environments.

## Decision

A dedicated **shared** VPC hosts one bastion, peered to every spoke. The bastion
is **private** (no public IP), reachable only via **SSM Session Manager**, and
uses VPC interface endpoints so no NAT/internet is required. EKS endpoints are
private; the bastion connects over peering. Spokes depend on a *static* hub CIDR,
never the hub's remote state, keeping dependencies one-directional.

## Consequences

One jump host instead of N; no internet-facing bastion; no key pairs; access is
IAM-gated and logged. Cost: VPC peering + interface endpoints. Removing the
per-environment bastion also removed a prod→dev remote-state coupling.
