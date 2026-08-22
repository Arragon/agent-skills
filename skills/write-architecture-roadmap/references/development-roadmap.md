# Development roadmap guide

Build the roadmap from architecture capabilities, non-functional requirements, migration needs, and risks. Treat it as an executable risk-reduction plan, not a calendar-shaped feature list.

## Roadmap opening

Start with roadmap status, planning horizon, estimation basis, team and availability assumptions, and companion architecture link. State the delivery strategy in one paragraph: what must be proven first, what forms the first usable closed loop, what must become reliable before expansion, and which ambitions are deliberately deferred.

Summarize the current baseline: existing assets, missing foundations, high-risk unknowns, external dependencies, and the definition of a usable first release.

## Prioritization

Use priority labels consistently:

- `P0`: blocks safe development, core-value validation, data integrity, security, or basic system stability; start immediately;
- `P1`: required for the first credible and repeatable user workflow;
- `P2`: improves maintainability, reach, performance, or secondary workflows after the core loop works;
- `P3`: optional expansion, optimization, platform, or ecosystem work whose trigger has not yet occurred.

Priority is not chronology by itself. Respect technical dependencies and explicitly explain any lower-priority prerequisite that must precede a higher-priority feature.

## Phase design

Choose phases based on the project rather than forcing a standard sequence. Common shapes include discovery or technical spikes, foundation, vertical-slice MVP, stabilization, migration, collaboration, multi-platform expansion, and ecosystem work.

For every phase, define outcome and why it occurs now; entry conditions and prerequisites; in-scope and explicitly excluded work; work packages and deliverables; acceptance criteria and required evidence; test and operational readiness requirements; risks retired or reduced; and an exit gate, stop condition, or replanning trigger.

Prefer a thin end-to-end vertical slice over completing all layers horizontally. Make the earliest meaningful phase prove the most important value proposition or riskiest technical assumption with the least irreversible work.

## Work packages

Assign work package IDs as `RM-<phase>-###`. Each work package must name its priority, architecture references, outcome, implementation scope, dependency, artifact or code change, verification method, estimated effort range, and responsible role when team information is available.

Size near-term packages so a developer or coding agent can execute and review them without rediscovering architecture. Keep distant phases coarser and mark them for decomposition at a named gate. Do not fabricate issue-level detail for work whose design depends on unvalidated earlier results.

Express estimates using ranges and state assumptions. Separate active engineering time from calendar time when approvals, user recruitment, external APIs, hardware, app review, or data collection can dominate elapsed duration. Present alternative schedules when staffing materially changes the critical path.

## Acceptance and evidence

Write acceptance criteria as observable outcomes. Include concrete commands, tests, metrics, scenarios, artifacts, or review evidence when known. Avoid criteria such as “completed,” “optimized,” “stable,” or “user-friendly” without thresholds or scenarios.

Use evidence gates to prevent premature expansion. Examples include a working core workflow, recovery from a specified failure, compatibility against named clients, a migration dry run, performance under an expected workload, or repeated use by a defined pilot group.

Connect technical acceptance to product evidence when relevant. Passing tests shows the system works as designed; it does not by itself prove users value it.

## Remediation mode

When the input contains defects, audit findings, or architecture debt, create a problem card for each material issue. Include the problem ID and priority, evidence or observed symptom, user or system impact, likely root cause, governing remediation principle, concrete implementation steps, affected modules and contracts, dependencies, tests and acceptance criteria, observability changes, rollback approach, and residual risk.

Treat infinite loops, missing timeouts, unbounded retries, swallowed exceptions, resource leaks, unsafe concurrent access, data corruption paths, secret exposure, and uncontained hardware or network failures as potential P0 issues based on evidence and blast radius.

Treat oversized modules as an architecture problem rather than a cosmetic line-count problem when they mix domains, hide state, prevent isolated testing, create high merge risk, or make safe automated modification impractical. Define target boundaries, characterization tests, extraction order, compatibility seams, and rollback checkpoints before splitting them.

Do not schedule a large rewrite as one task. Preserve behavior through characterization tests and incremental seams unless there is a documented reason an incremental path is more dangerous.

## Cross-cutting planning

Show the critical path and major dependency graph when sequencing is not obvious. Identify external blockers and decisions with deadlines.

Include a compact resourcing view when useful: roles, bottlenecks, parallelizable streams, specialist needs, and assumptions. Do not imply nominally parallel work is safe when it modifies the same unstable boundary.

Include testing, documentation, migration, telemetry, release, rollback, and cleanup work in the phases that need them. Do not collect all quality work into a final hardening phase.

End with an architecture coverage table, deferred-items table with activation triggers, risk and contingency summary, and the next immediately executable work package or short iteration.
