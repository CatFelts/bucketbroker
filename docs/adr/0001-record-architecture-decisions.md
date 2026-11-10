# 1. Record architecture decisions

- Status: Accepted
- Date: 2026-10-29

## Context
Design choices in this project (state storage, tenant isolation, API shape) involve trade-offs.
Six months from now, or in an interview, the *why* matters more than the *what*.

## Decision
Use lightweight Architecture Decision Records (ADRs), following Michael Nygard's format.
Each ADR is a short markdown file in `docs/adr/`, numbered in order, and never deleted.
When a decision changes, write a new ADR that supersedes the old one.

## Consequences
- Every significant choice has a written rationale.
- ADRs cost a few minutes each. Write one when you catch yourself weighing two or more real options.
