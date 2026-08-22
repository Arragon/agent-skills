# Coupling and quality gates

Use these checks after both drafts exist. Revise the documents until all applicable gates pass.

## Bidirectional coupling

The architecture document must contain a mapping with these semantics: architecture ID, capability/requirement/risk summary, current state, roadmap work package, target phase, and verification evidence.

The roadmap must contain a reciprocal mapping with these semantics: work package ID, priority, architecture IDs, dependency, deliverable, acceptance evidence, and target state.

Check for orphans in both directions. Every committed `CAP-###`, `NFR-###`, and material `RSK-###` must be implemented, verified as already present, or explicitly deferred with rationale and activation trigger. Every `RM-<phase>-###` must trace to an architecture item, risk, migration requirement, or evidence-gathering decision.

Keep identifiers and terminology identical across documents. A domain, service, data entity, phase, or milestone must not acquire a second casual name.

Use relative Markdown links between the two files. Link to stable headings only when heading anchors are known to work in the target renderer; otherwise link to the companion file and cite identifiers in text.

## Architecture gates

Confirm that the design states the core value loop and non-goals before expanding the system. Confirm that domain boundaries follow responsibility and data ownership rather than UI panels.

For every important component, ask whether its responsibility, owned state, dependencies, interface, failure behavior, and verification boundary are clear. For every consequential technology, ask why it is needed now, what credible alternative was rejected, what downside is accepted, and what event would justify revisiting the decision.

Trace critical flows across client, server, storage, providers, and external systems. Include failure, cancellation, retry, concurrency, partial completion, and recovery semantics where relevant.

Reject vague architecture language. Replace “scalable” with workload and scaling trigger; “secure” with threat and control; “reliable” with failure and recovery behavior; “real-time” with latency and delivery semantics; “modular” with ownership and dependency rules.

Check that security, privacy, operations, observability, testing, migration, and rollback are proportional to actual risk. Their absence and their overengineering are both defects.

## Roadmap gates

Confirm that dependency order is technically possible and that first phases retire the largest uncertainty or prove the core value. Ensure platform, ecosystem, broad multi-client, and speculative scale work are deferred until an explicit evidence gate when they are not required for the first closed loop.

Every near-term work package must have an observable deliverable and acceptance method. Acceptance criteria must test outcomes rather than task completion. Include negative and recovery scenarios for risky paths.

Check that estimates state scope, staffing, and uncertainty. Do not provide day-precise calendar promises without those inputs. Separate implementation effort from external waiting time.

Ensure refactoring and remediation tasks define safety seams, characterization tests, migration order, and rollback. Reject “rewrite module,” “improve error handling,” or “add tests” as complete tasks.

## Consistency gates

Search both files for contradictory deployment models, storage choices, authentication assumptions, supported platforms, delivery guarantees, priorities, phase names, and compatibility promises.

Verify that deferred capabilities do not appear as hidden prerequisites for an earlier phase. Verify that roadmap acceptance criteria are feasible under the architecture's chosen contracts and runtime topology.

Confirm that assumptions are not presented as confirmed facts and that unresolved decisions have an owner role, decision deadline, experiment, or triggering event when material.

## Usability gates

Each document must stand alone: define the project, its scope, essential terminology, current or target state, and relationship to the companion document. Avoid copying full sections between files; summarize shared context and link to authoritative detail.

Lead each major section with its conclusion. Use tables only for exact comparison or mapping, Mermaid only for relationships that prose cannot convey as clearly, and prose for reasoning and tradeoffs.

The final result must be detailed enough that a developer can identify the next change and its test, while concise enough that major decisions and critical path remain visible.
