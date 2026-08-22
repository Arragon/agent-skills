# Technical architecture design guide

Use this reference to decide what the architecture document must establish. Adapt the section set to the project's scale, maturity, and risk profile. Omit irrelevant enterprise ceremony; do not omit a relevant decision merely because the project is small.

## Document opening

Start with document status, scope, information cutoff date when current research was used, and the companion roadmap link. Follow with an executive design summary stating the target system shape, decisive technical choices, most important constraint, and principal unresolved risk.

Define the product thesis and core value loop before describing components. State intended users, primary jobs, success signals, scope, non-goals, and the boundary between MVP requirements and later possibilities.

Separate known facts, confirmed decisions, assumptions, constraints, and open questions. For each high-impact assumption, state how it will be validated and what design changes if it proves false.

## Architecture principles and decisions

State a small set of project-specific principles. Examples include local-first operation, self-hostability, single-writer ownership, offline tolerance, schema-first client compatibility, or privacy-preserving processing. Explain the concrete consequence of each principle; avoid slogans.

Record each consequential choice as `ADR-###` with context, decision, alternatives considered, reason for selection, accepted downside, and reconsideration trigger. Compare only credible alternatives. Make a recommendation rather than leaving a menu.

## System boundary and decomposition

Describe actors, external systems, trust boundaries, and what the system explicitly does not own. Include a compact context diagram when it clarifies the boundary.

Decompose the system by domain responsibility and data ownership, not by visible screens. For each important component or domain, define its capability ID, responsibilities, owned data, exposed contracts, dependencies, forbidden responsibilities, and likely evolution boundary.

Prefer a modular monolith when independent deployment, scaling, security isolation, or team ownership does not yet justify services. If services are chosen, document why process boundaries are necessary and how partial failure, version skew, discovery, and observability are handled.

## Critical flows and state

Describe the success path and important failure paths for each critical user or system flow. Use sequence or state diagrams when order, retries, cancellation, or branching matters.

Define authoritative state, transient state, derived state, and client cache state. Specify lifecycle transitions, invariants, idempotency boundaries, concurrency behavior, timeout and cancellation semantics, retry ownership, deduplication, and recovery after interruption where relevant.

For AI or agent systems, also specify context assembly, provider abstraction limits, tool and permission boundaries, streaming events, cancellation, run persistence, reproducibility metadata, model/provider opaque state, cost tracking, and unsafe-output containment where applicable.

## Data and contracts

Define core entities, identifiers, ownership, relationships, lifecycle, retention, versioning, and migration rules. State consistency expectations and transaction boundaries. Explain storage selection in terms of access patterns, failure recovery, portability, and operational cost.

For important APIs or events, provide representative request, response, event, or schema examples. Specify authentication, authorization, validation, pagination, error codes, idempotency, compatibility, and versioning. Shared clients should depend on stable domain contracts or DTO semantics rather than server implementation details.

Do not claim an interface is “RESTful,” “real-time,” or “event-driven” as a substitute for defining its behavior.

## Runtime and operations

Define the intended deployment topology for development and production, including runtime processes, data stores, network exposure, configuration, secrets, environment separation, startup order, health checks, backups, restore procedure, upgrades, and rollback.

Cover security and privacy proportionally to actual risk: assets, threat actors, trust boundaries, identity, authorization, tenant isolation, input and file handling, secret storage, encryption, auditability, retention, abuse controls, and dependency or supply-chain exposure.

Define reliability targets only when meaningful and measurable. Specify failure containment, degraded modes, recovery objectives, data-loss tolerance, rate or resource limits, and operational runbooks for the highest-impact incidents.

Define observability through decisions it must support. Identify key logs, metrics, traces, audit events, correlation identifiers, dashboards, and alerts. Avoid “add monitoring” without naming what failure or user harm it detects.

## Quality, performance, and evolution

Map the test strategy to architecture boundaries: unit tests for domain rules, contract tests for interfaces, integration tests for storage and providers, end-to-end tests for core flows, migration tests for schema changes, and failure-injection or recovery tests for critical risks.

State performance and capacity assumptions with expected workload ranges. Identify latency-sensitive paths, resource ceilings, backpressure points, cost drivers, and the measurements that trigger optimization. Do not optimize hypothetical scale.

For an existing system, describe current state separately from target state. Include compatibility commitments, migration stages, parallel-run or adapter strategies, rollback checkpoints, and deletion criteria for legacy paths.

## Closing sections

Maintain a risk register keyed as `RSK-###`, including likelihood, impact, early signal, mitigation, contingency, owner role, and roadmap reference.

Conclude with an architecture-to-roadmap mapping containing capability/NFR/risk IDs, implementation state, roadmap work package IDs, and verification evidence. List unresolved decisions with a decision deadline or triggering event.
