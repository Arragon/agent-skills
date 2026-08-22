---
name: write-architecture-roadmap
description: Create or substantially revise two separate, tightly coupled Markdown deliverables—a technical architecture design document and an executable development roadmap. Use when turning product ideas, prior discussions, requirements, codebase findings, feasibility conclusions, remediation findings, or an existing proposal into an implementation-ready system design plus dependency-ordered delivery plan. Trigger for technical architecture documents, system design books, architecture整改方案, phased implementation plans, MVP-to-platform roadmaps, P0/P1 remediation roadmaps, or paired architecture-and-roadmap outputs. Support greenfield products, existing-system refactors, self-hosted services, multi-client applications, AI systems, developer tools, and research or engineering software.
---

# Write Architecture Roadmap

Produce two documents that describe one engineering plan from complementary views: the architecture document defines the target system and its decisions; the roadmap defines the evidence-driven sequence for reaching it. Make each document understandable on its own while maintaining explicit bidirectional traceability between them.

## Core behavior

Act as an implementation-minded architect, not a template filler. State conclusions and tradeoffs. Convert vague ideas into bounded responsibilities, contracts, risks, validation methods, and delivery gates. Do not disguise uncertainty as fact or present an unranked catalog of technologies as a decision.

Prefer the simplest architecture that proves the core value and preserves a credible evolution path. Detect premature platformization, distributed-system complexity, speculative abstraction, and ecosystem work that does not reduce an immediate product or technical risk.

Write for two readers at once: a human who must judge whether the plan is sound, and an engineer or coding agent who must be able to implement and test it.

## Workflow

### 1. Reconstruct the project baseline

Read the current request, supplied files, repository guidance, relevant existing code or documentation, and explicitly referenced prior decisions. When the user expects continuity from earlier discussions, retrieve the relevant personal context before drafting.

Build an internal project ledger containing confirmed decisions and constraints, inferred requirements and their evidence, unresolved decisions that materially affect the design, current-system facts versus target-state proposals, and user, business, operational, security, and delivery constraints.

Apply this precedence when sources conflict: the user's latest explicit instruction; current authoritative project artifacts; previously confirmed decisions that have not been superseded; current primary technical sources; clearly labeled assumptions.

Do not expose the internal ledger as process narration. Reflect it in concise sections named decisions, assumptions, constraints, and open questions.

### 2. Decide whether clarification or research is necessary

Ask only about missing information that could materially change system boundaries, data ownership, security posture, deployment topology, compatibility commitments, cost order of magnitude, or roadmap feasibility and sequence. Otherwise, choose a conservative reasonable default, label it as an assumption, describe its impact and validation method, and proceed.

Research current primary sources when the answer depends on unstable framework behavior, product limits, APIs, licensing, security guidance, deployment constraints, or pricing. Use official documentation for facts; use issue trackers, technical communities, and practitioner reports to discover failure modes and real-world friction. Distinguish confirmed facts, community experience, and architectural inference. Record the information cutoff date and cite sources near affected decisions. Do not browse merely to decorate a design that can be derived from supplied evidence.

### 3. Establish the architecture spine

Before expanding prose, define the product thesis, core value loop, system boundary, primary actors, authoritative data owners, principal domains, critical flows, deployment shape, and highest-risk assumptions.

Assign stable identifiers to important items: `CAP-###` for architecture capabilities, `NFR-###` for non-functional requirements, `ADR-###` for consequential decisions, `RSK-###` for risks, and `RM-<phase>-###` for roadmap work packages. Use identifiers only where they improve traceability; do not turn every paragraph into a ticket.

### 4. Draft the technical architecture design document

Read [architecture-design.md](references/architecture-design.md) completely before drafting. Adapt its coverage to the project rather than blindly emitting every optional section.

Name the file `<project>-technical-architecture.md` unless the user specifies another name. Include a short relationship note linking to the roadmap filename. Make decisions concrete enough to guide implementation: define domain boundaries, ownership, contracts, state transitions, failure behavior, security boundaries, deployment assumptions, observability, and verification strategy.

For important technical choices, recommend one primary solution and retain at most one genuinely useful alternative. Default toward mature, maintainable, low-operations technology, open standards, self-hostability, and migration freedom when project constraints do not dictate otherwise. Prefer a modular monolith until independent scaling, security or failure isolation, or real team ownership justifies separate services. Explain selection reasons, rejected alternatives, accepted cost, and reconsideration triggers.

Use Mermaid only when topology, hierarchy, or event order is materially clearer visually. Use tables for exact mappings, contracts, comparisons, and traceability. Keep explanatory reasoning in prose.

### 5. Draft the development roadmap

Read [development-roadmap.md](references/development-roadmap.md) completely before drafting. Derive work from the architecture and its risks rather than independently restating a feature wishlist.

Name the file `<project>-development-roadmap.md` unless the user specifies another name. Include a short relationship note linking to the architecture filename. Order work by dependencies, risk retirement, and proof of core value. Decompose near-term work to an engineer- or agent-executable level; keep distant work at milestone level until earlier evidence gates pass. Express estimates as ranges with stated staffing, scope, and uncertainty assumptions.

For remediation-heavy requests, apply the P0/P1/P2/P3 problem-card rules in the roadmap reference. Promote structural issues such as unbounded waits, missing failure containment, unsafe resource handling, or architecture-blocking oversized modules to P0 when evidence shows they threaten system stability or make safe iteration impractical.

### 6. Couple and reconcile both documents

Read [coupling-and-quality.md](references/coupling-and-quality.md) completely. Add a roadmap mapping table to the architecture document and an architecture coverage table to the roadmap document.

Ensure every committed architecture capability has one of three roadmap states: scheduled, explicitly deferred with rationale and activation trigger, or already implemented with verification evidence. Ensure every roadmap work package maps to a capability, NFR, risk, migration need, or evidence-gathering objective.

Revise both documents together when a late decision changes boundaries, contracts, sequencing, or acceptance criteria. Never silently repair only one side.

### 7. Validate and deliver

Run the quality gates in [coupling-and-quality.md](references/coupling-and-quality.md). Verify filenames, relative links, identifiers, mappings, terminology, dependency order, acceptance criteria, and the absence of contradictory decisions.

Create two real Markdown files rather than returning one combined response, unless the user explicitly requests inline text. Save them in the requested location; otherwise follow the host environment's normal artifact-saving policy. In the final response, link both files and summarize the central architecture decision, the first executable phase, and any assumption that most needs user confirmation.

## Revision behavior

When revising existing documents, preserve valid project-specific content, identifiers, and confirmed decisions. Report meaningful changes in the documents themselves through a concise revision note or decision log; do not append a generic changelog file.

If only one paired document is supplied, reconstruct the missing counterpart from available evidence and flag unverified mappings. If the user asks to change only one document, update it and identify corresponding changes the other document now requires; edit both only when the request authorizes changes to both.

## Output language and depth

Follow the user's requested language; otherwise use the language of the request. Use precise, direct technical prose. Lead sections with the decision or outcome, then provide rationale and implementation detail.

Default to implementation-level detail with progressive depth. Specify core flows down to module responsibility, data ownership, API or event contract, representative schema, state transition, failure model, timeout and retry behavior, concurrency and idempotency, authorization boundary, deployment, observability, testing, and rollback where relevant. Keep secondary and distant capabilities at boundary, dependency, and evolution-trigger level. Do not enforce an arbitrary word count; stop when the design can guide implementation without irrelevant enterprise filler.

Avoid generic claims such as “ensure scalability,” “use microservices,” “add caching,” or “improve security” without specifying the applicable boundary, mechanism, trigger, and verification method.
