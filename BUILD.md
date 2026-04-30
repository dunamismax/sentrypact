# BUILD.md

> **Required operating rule:** any agent who completes work from this plan, changes scope, or learns repo truth that affects sequencing must update this file in the same change set. Keep the checkboxes honest. Do not mark boxes complete unless the repo already proves them.

SentryPact is in active greenfield build mode. This file is the execution authority for taking the repo from a Rails website/control-plane scaffold to a privacy-preserving, lockdown-first filtering product with native enforcement clients.

SentryPact protects adults and families by combining DNS, app, and browser filtering with timer-locked Solo Pacts, optional co-signers, tamper detection, and minimal accountability reporting. The product should be firm about enforcement and careful about claims: tamper-resistant and bypass-detecting, not impossible to bypass, not a medical treatment, and not a guarantee.

## Agent handoff prompt

Use this prompt to start the next agent session:

```text
You are working in /Users/sawyer/github/sentrypact.

First read and internalize /Users/sawyer/github/SOUL.md, then /Users/sawyer/github/AGENTS.md. Treat those as the active Scry runtime instructions. Then read /Users/sawyer/github/sentrypact/BUILD.md and the repo README files before touching code.

Your job is to begin the next SentryPact build tranche. Keep BUILD.md current as you work. Only check boxes after the repo proves the work is complete. Prefer root-cause implementation over placeholder scaffolding. Do not broaden scope into native apps until the web/control-plane contracts needed by the native MVP exist, unless Stephen explicitly asks for a narrow native feasibility spike.

Recommended next tranche: Phase 2 (Phase 1 is substantially complete; only manual browser QA at mobile/desktop widths and a clean local `bin/ci` run remain). Build the Rails control-plane foundation for accounts, devices, pact state, audit events, and signed configuration publishing. Add tests and run the canonical checks before reporting done.

Before changing code:
- Verify current branch and working tree.
- Read any repo-local instructions if added after this BUILD.md.
- Review apps/web/README.md, config/routes.rb, db/schema.rb, config/database.yml, and bin/ci.

Acceptance criteria for the next session:
- BUILD.md remains accurate.
- New work is covered by tests where practical.
- apps/web/bin/ci passes, or any failure is documented with the exact blocker.
- No external services, deployments, auth changes, data deletion, or irreversible operations happen without explicit approval.
```

## Current repo truth

- [x] The repo is a monorepo with future lanes under `apps/`, `packages/`, `docs/`, and `infra/`.
- [x] `apps/web` is the only implemented app today.
- [x] `apps/web` is a Rails 8.1.3 app on Ruby 4.0.3.
- [x] The web app uses Hotwire, importmap, Propshaft, Tailwind CSS, Solid Cache, Solid Queue, Solid Cable, Kamal, Thruster, Minitest, RuboCop, Brakeman, and bundler-audit.
- [x] The root scripts delegate into the Rails app.
- [x] The canonical web gate is `cd apps/web && bin/ci`.
- [x] The production Docker build works with `apps/web/Dockerfile`.
- [x] The current data layer is SQLite scaffold storage for Rails and Solid adapters.
- [x] Empty future app directories exist for iOS, Android, macOS, Windows, and browser extensions.
- [x] `docs/`, `packages/`, and `infra/` are placeholders only.
- [x] Git origin has push URLs for GitHub and Codeberg.
- [ ] The Rails control plane has durable accounts, devices, pacts, subscriptions, signed config, or event ingestion.
- [ ] Any native enforcement client is implemented.
- [ ] Production infrastructure, billing, blocklist CDN, and backup policy are implemented.

## Product guardrails

- [x] SentryPact is lockdown-first, not convenience-first.
- [x] Market the product as tamper-resistant and bypass-detecting, never impossible to bypass.
- [x] Do not claim addiction treatment, guaranteed prevention, or medical outcomes.
- [x] Privacy is a product feature: collect less by default and explain every collection point.
- [x] No raw browsing history by default.
- [x] No page contents sent to the server by default.
- [x] Full URL logging requires explicit opt-in.
- [x] No stealth mode, hidden installs, or invisible partner monitoring.
- [x] Coercive control is a primary abuse case to design against.
- [x] Adult partner/co-signer modes require explicit consent, persistent visibility, release protections, and auditability.
- [x] Emergency release paths exist for abuse, legality, medical need, and device safety.
- [x] Server time owns pact release decisions; clients should not be trusted for unlock timing.
- [x] Native clients enforce locally and continue safe behavior when offline.
- [x] Signed configuration and blocklist artifacts are required before native clients depend on remote policy.
- [x] Every safety-sensitive action creates an audit event visible to the right party.

## Native app decision

Do not start a full native app before the control plane has contracts for the native client to consume. The next productive work is the Rails control-plane foundation: accounts, devices, pact state, signed policy/config publishing, event ingestion, and release semantics.

A narrow iOS feasibility spike is useful once Phase 2 has API contracts drafted, especially to validate Apple framework constraints around Network Extension, Family Controls, Managed Settings, Device Activity, configuration profiles, local VPN/DNS behavior, and App Store policy. Treat that spike as research until the server contract exists.

## Stack direction

- **Web/control plane:** Rails 8.1.3, Ruby 4.0.3, Hotwire, Tailwind CSS, Propshaft, importmap.
- **Initial scaffold database:** SQLite for local Rails development.
- **Likely production control-plane database:** PostgreSQL once pact/device/subscription state becomes real.
- **Background work:** Solid Queue until scale or deployment shape earns another worker system.
- **Cache and cable:** Solid Cache and Solid Cable until deployment needs say otherwise.
- **Deployment:** Docker image, Kamal scaffold, Caddy or equivalent reverse proxy.
- **iOS/macOS:** Swift, Network Extension/local VPN or DNS, Family Controls, Managed Settings, Device Activity, optional configuration profiles where policy permits.
- **Android:** Kotlin, VpnService, Device Admin where appropriate, policy-compliant accessibility only if truly needed.
- **Windows:** Native service using Windows Filtering Platform plus locked DNS/hosts controls.
- **Browser extensions:** Chrome, Edge, Firefox, and Safari companions for cosmetic filtering, DoH detection, SafeSearch, and YouTube Restricted Mode.
- **Shared artifacts:** Explicit schemas, signed blocklists/configuration, fixtures, generated clients only when the API stabilizes enough to justify them.

## Phase status summary

| Phase | Name | Status |
| --- | --- | --- |
| 0 | Product framing and repo bootstrap | Done |
| 1 | Public web and trust foundation | In progress (pending manual browser pass) |
| 2 | Rails control-plane domain foundation | Not started |
| 3 | Pact APIs, device lifecycle, and event ingestion | Not started |
| 4 | Signed blocklist and configuration pipeline | Not started |
| 5 | iOS Solo MVP enforcement client | Not started |
| 6 | Billing, subscriptions, and entitlement enforcement | Not started |
| 7 | Co-signer mode and accountability reporting | Not started |
| 8 | Android Solo MVP enforcement client | Not started |
| 9 | Desktop and browser coverage | Not started |
| 10 | Production infrastructure and launch hardening | Not started |
| 11 | Post-launch hardening and expansion | Not started |

## Phase 0 - Product framing and repo bootstrap

### Objectives

- [x] Define SentryPact's product wedge and boundaries.
- [x] Establish the monorepo shape for web, native clients, docs, packages, and infrastructure.
- [x] Stand up the Rails web app scaffold.
- [x] Establish a local and CI verification path.

### Checklist

- [x] Create root `README.md` with product, architecture, privacy, MVP, pricing, and roadmap direction.
- [x] Create `apps/web` Rails app.
- [x] Add root `bin/setup` and `bin/dev` wrappers.
- [x] Add Rails test, style, security, and asset verification through `apps/web/bin/ci`.
- [x] Add GitHub Actions for web CI and Docker build.
- [x] Confirm production Docker build succeeds.
- [x] Update Ruby toolchain to Ruby 4.0.3 and Bundler 4.0.11.
- [x] Keep root and web README version references current.

### Exit criteria

- [x] A fresh agent can identify what SentryPact is and where the implemented app lives.
- [x] The Rails app can be set up, tested, and built locally.
- [x] The repo has a durable build tracker for future agent sessions.

### Verification

- [x] `cd apps/web && bin/ci` passes.
- [x] `cd apps/web && docker build -t sentrypact-web:dependency-upgrade .` passes.
- [x] `bundle outdated --parseable` reports no outdated gems.

## Phase 1 - Public web and trust foundation

### Objectives

- [x] Make the public site clear, credible, and safety-aware enough to support early testers.
- [x] Explain the product without overclaiming.
- [x] Establish trust, privacy, safety, and support pages before collecting user data.

### Checklist

- [x] Replace scaffold/homepage copy with a focused SentryPact landing page.
- [x] Add pages for product overview, Solo Pacts, privacy, safety, pricing, FAQ, and contact/support.
- [x] Add explicit avoided-claims language where it matters.
- [x] Add a coercive-control safety note and emergency release explanation.
- [x] Add visible product status language if features are waitlist/pre-launch.
- [x] Add durable navigation, footer, legal/support links, and mobile layout checks.
- [x] Add lightweight page/controller tests for public routes.
- [x] Add system or request coverage for the main marketing routes if the app shape warrants it.
- [x] Update README docs with current web commands and product status.

### Exit criteria

- [x] A new visitor can understand what SentryPact does, what it does not claim, and who it is for.
- [x] The site does not imply stealth monitoring, guaranteed outcomes, or medical treatment.
- [x] Every public page has an obvious owner and test coverage appropriate to its complexity.

### Verification

- [ ] `cd apps/web && bin/ci` passes. (Every material step green locally — RuboCop, bundler-audit, importmap audit, Brakeman, Tailwind build, Rails tests, seeds. The `Setup` step fails on this developer machine because `bundle` binstub at `/opt/homebrew/opt/ruby/bin/bundle` references missing `bundler-4.0.11` in the Cellar gem path; reinstall bundler 4.0.11 into the Cellar path or regenerate binstubs. GitHub Actions uses `ruby/setup-ruby` and is not affected.)
- [ ] Manual browser pass at mobile and desktop widths.
- [x] Public routes return successful responses in test.
- [x] Copy review confirms no forbidden claims slipped in.

## Phase 2 - Rails control-plane domain foundation

### Objectives

- [ ] Build the server-side truth layer before native clients depend on it.
- [ ] Define accounts, devices, pacts, policies, categories, signed config, and audit events.
- [ ] Decide whether to move from SQLite scaffold storage to PostgreSQL before storing real pact state.

### Checklist

- [ ] Decide and document the production database path: keep SQLite temporarily or migrate to PostgreSQL now.
- [ ] Model users/accounts with secure authentication and session behavior.
- [ ] Model devices with platform, install identity, public key or signing material, status, and last check-in.
- [ ] Model pacts with server-verified start time, release time, status, release path, and immutable audit trail.
- [ ] Model filtering categories and policy bundles.
- [ ] Model signed configuration artifacts separately from mutable draft policy.
- [ ] Model tamper, bypass, heartbeat, block-count, and unlock-request events.
- [ ] Add migrations, constraints, indexes, and fixtures/seeds.
- [ ] Add domain tests for pact state transitions and release timing.
- [ ] Add policy tests for allowed/forbidden release paths.
- [ ] Add admin/operator-safe inspection views or console tasks only where they reduce risk.

### Exit criteria

- [ ] Rails owns the durable control-plane state needed by the iOS Solo MVP.
- [ ] Pact release timing cannot be changed by trusting client clocks.
- [ ] Audit events exist for safety-sensitive state changes.
- [ ] The data model is explicit enough for native client API contracts.

### Verification

- [ ] `cd apps/web && bin/ci` passes.
- [ ] Model and domain tests cover happy path, blocked path, emergency release path, and tamper event path.
- [ ] Schema review confirms constraints and indexes match query needs.
- [ ] If PostgreSQL is introduced, fresh setup and test database creation are documented and verified.

## Phase 3 - Pact APIs, device lifecycle, and event ingestion

### Objectives

- [ ] Create the server contract native clients need for enrollment, config sync, pact status, tamper reporting, and unlock flows.
- [ ] Keep responses explicit, versioned, and easy to generate clients from later.

### Checklist

- [ ] Add API versioning strategy for native clients.
- [ ] Add device enrollment and rotation flow.
- [ ] Add authenticated device check-in endpoint.
- [ ] Add current signed config/policy endpoint.
- [ ] Add pact create, status, and release-request endpoints.
- [ ] Add tamper/bypass/block-count event ingestion endpoints.
- [ ] Add idempotency and replay protection where needed.
- [ ] Add rate limits or abuse controls for event ingestion.
- [ ] Add explicit error envelopes and response schemas.
- [ ] Add request tests for every native-facing endpoint.
- [ ] Add API documentation in `docs/` once endpoint behavior is stable.

### Exit criteria

- [ ] An iOS prototype can enroll, fetch policy, report events, and respect pact status without private Rails knowledge.
- [ ] API behavior is test-covered and documented.
- [ ] Safety-sensitive API actions are audited.

### Verification

- [ ] `cd apps/web && bin/ci` passes.
- [ ] Request specs cover auth failures, stale device state, idempotency, and invalid state transitions.
- [ ] A scripted smoke flow can create a device, create a pact, fetch config, ingest events, and request release.

## Phase 4 - Signed blocklist and configuration pipeline

### Objectives

- [ ] Publish trustworthy filtering artifacts for clients.
- [ ] Separate policy authoring from signed client-consumable configuration.
- [ ] Establish update, rollback, and verification mechanics before native enforcement relies on remote policy.

### Checklist

- [ ] Define category taxonomy for porn, gambling, drugs, ads/trackers, malware/phishing, proxy/VPN/Tor, and future categories.
- [ ] Define source ingestion format for blocklist data.
- [ ] Build a deterministic artifact generation task.
- [ ] Sign generated artifacts and expose signature metadata.
- [ ] Add CDN or static-publication plan.
- [ ] Add artifact versioning, rollback, and expiration semantics.
- [ ] Add tests for artifact generation and signature verification.
- [ ] Add a local fixture artifact for native client development.
- [ ] Document false-positive and appeal/review workflow.

### Exit criteria

- [ ] Clients can fetch and verify signed policy/configuration artifacts.
- [ ] Operators can generate, inspect, publish, and roll back artifacts.
- [ ] A broken artifact can be detected before release.

### Verification

- [ ] Artifact generation is reproducible from the same inputs.
- [ ] Signature verification passes in server tests and at least one client-side proof.
- [ ] `cd apps/web && bin/ci` passes.

## Phase 5 - iOS Solo MVP enforcement client

### Objectives

- [ ] Build the first native enforcement surface only after server contracts are ready enough.
- [ ] Prove local VPN/DNS filtering, pact lock semantics, tamper detection, and minimal reporting on iOS.

### Checklist

- [ ] Complete Apple framework and App Store policy spike.
- [ ] Decide the MVP enforcement path: Network Extension/local VPN, DNS configuration, Family Controls, Managed Settings, or a staged combination.
- [ ] Create the iOS project under `apps/ios` with clear build/test docs.
- [ ] Implement onboarding and device enrollment.
- [ ] Implement signed config fetch and verification.
- [ ] Implement local filter application and safe offline behavior.
- [ ] Implement Solo Pact status display and lock timer behavior.
- [ ] Implement tamper/bypass detection events where iOS permits it.
- [ ] Implement delayed emergency unlock request flow.
- [ ] Implement blocked-attempt counter without raw browsing history by default.
- [ ] Add unit tests for policy parsing and pact state handling.
- [ ] Add simulator/device manual test checklist in `docs/`.

### Exit criteria

- [ ] A real iOS device can enroll, fetch config, apply filtering, enter a Solo Pact, stay locked until server release, and report minimal events.
- [ ] The app does not depend on raw browsing history to deliver core value.
- [ ] Known Apple policy and entitlement risks are documented.

### Verification

- [ ] Native unit tests pass.
- [ ] Manual device smoke test covers install, enroll, filter, lock, tamper attempt, offline behavior, and unlock path.
- [ ] Rails `bin/ci` still passes after any API changes.

## Phase 6 - Billing, subscriptions, and entitlement enforcement

### Objectives

- [ ] Add paid product mechanics without letting billing complexity compromise safety paths.
- [ ] Gate premium features through clear entitlements.

### Checklist

- [ ] Choose billing provider and document account/service requirements.
- [ ] Model plans, subscriptions, entitlements, trial status, and grace periods.
- [ ] Add checkout, customer portal, webhook ingestion, and webhook replay protection.
- [ ] Add entitlement checks for device count, pact modes, co-signer features, and reporting.
- [ ] Ensure emergency/safety release paths do not depend on payment status.
- [ ] Add billing tests and webhook fixture tests.
- [ ] Document pricing and refund/support policy.

### Exit criteria

- [ ] Users can subscribe, manage billing, and keep entitlement state synced.
- [ ] Billing outages do not break safety-critical unlock or abuse-release paths.

### Verification

- [ ] Billing webhook tests pass against fixture payloads.
- [ ] `cd apps/web && bin/ci` passes.
- [ ] Manual checkout/customer-portal smoke passes in test mode.

## Phase 7 - Co-signer mode and accountability reporting

### Objectives

- [ ] Add optional co-signer accountability while defending against coercive-control misuse.
- [ ] Keep reports minimal, visible, and privacy-preserving.

### Checklist

- [ ] Model co-signer invitations, consent, revocation, and visibility.
- [ ] Add partner/co-signer access logs visible to the protected user.
- [ ] Add approval request and release decision flows.
- [ ] Add tamper alert policy and throttling.
- [ ] Add weekly summary reports with category counts, tamper events, and no raw browsing history by default.
- [ ] Add opt-in controls for any higher-detail reporting.
- [ ] Add abuse/safety release protections.
- [ ] Test consent, revocation, and release edge cases.

### Exit criteria

- [ ] Co-signer mode is explicitly consensual, visible, reversible through safety paths, and audited.
- [ ] Reports communicate accountability without becoming surveillance by default.

### Verification

- [ ] Consent and revocation tests pass.
- [ ] Report generation tests prove raw URLs are not included by default.
- [ ] Safety review confirms coercive-control guardrails are present in product flow and docs.

## Phase 8 - Android Solo MVP enforcement client

### Objectives

- [ ] Port Solo MVP enforcement to Android using platform-native controls.
- [ ] Preserve the same privacy and pact semantics as iOS.

### Checklist

- [ ] Complete Android VpnService, Device Admin, DNS, and Play policy spike.
- [ ] Create the Android project under `apps/android`.
- [ ] Implement device enrollment, signed config fetch, filtering, pact status, tamper events, and emergency unlock.
- [ ] Add local tests for policy parsing and pact state.
- [ ] Add manual device smoke checklist.

### Exit criteria

- [ ] A real Android device can run the Solo MVP flow with server-backed pact timing.
- [ ] Android behavior matches the documented privacy defaults.

### Verification

- [ ] Android unit tests pass.
- [ ] Manual device smoke test passes.
- [ ] Rails native-facing API tests still pass.

## Phase 9 - Desktop and browser coverage

### Objectives

- [ ] Expand protection to desktops and browsers after the mobile Solo loop is proven.
- [ ] Use each platform's native enforcement mechanisms instead of pretending one technique fits all.

### Checklist

- [ ] Define macOS enforcement plan using Network Extension, DNS, profiles, and tamper detection.
- [ ] Define Windows enforcement plan using Windows Filtering Platform and locked DNS/hosts controls.
- [ ] Define browser extension scope: cosmetic filtering, DoH detection, SafeSearch, YouTube Restricted Mode, and companion status.
- [ ] Create projects only after the platform plan and shared API needs are clear.
- [ ] Add platform-specific install, update, uninstall, and recovery docs.

### Exit criteria

- [ ] Desktop/browser coverage improves enforcement without weakening privacy or safety claims.
- [ ] Each platform has an honest threat model and bypass limitations documented.

### Verification

- [ ] Platform smoke tests exist and pass for any implemented client.
- [ ] Docs describe what each client can and cannot enforce.

## Phase 10 - Production infrastructure and launch hardening

### Objectives

- [ ] Make deployment, observability, backups, and recovery boring before launch.
- [ ] Avoid collecting real user data before operational basics are ready.

### Checklist

- [ ] Decide production database, object storage, CDN, registry, and hosting target.
- [ ] Replace Kamal scaffold values with real deployment configuration.
- [ ] Add environment documentation and secret inventory without committing secrets.
- [ ] Add backup and restore runbooks.
- [ ] Add uptime, error, job, and event-ingestion observability.
- [ ] Add security headers, host policy, SSL policy, and rate limiting checks.
- [ ] Add incident response and user support runbooks.
- [ ] Add staging environment and smoke test path.
- [ ] Add launch checklist.

### Exit criteria

- [ ] The production control plane can be deployed, monitored, backed up, restored, and rolled back.
- [ ] Operators can tell whether native clients are checking in and whether policy publication is healthy.

### Verification

- [ ] Fresh deployment from documented steps succeeds.
- [ ] Backup restore drill succeeds.
- [ ] Production smoke tests cover homepage, auth, API health, config fetch, event ingestion, and billing if enabled.

## Phase 11 - Post-launch hardening and expansion

### Objectives

- [ ] Convert launch assumptions into measured facts.
- [ ] Improve enforcement, reliability, privacy, and user trust based on real usage.

### Checklist

- [ ] Triage production bugs and add regression tests.
- [ ] Review false positives and category quality.
- [ ] Review bypass attempts and tamper signals.
- [ ] Improve onboarding based on support friction.
- [ ] Review privacy defaults and data retention against actual usage.
- [ ] Prioritize family/group plans only after Solo and co-signer loops are stable.
- [ ] Keep roadmap docs current with shipped reality.

### Exit criteria

- [ ] The product has a measured, stable Solo loop and a clear next expansion path.
- [ ] Stable docs describe current truth instead of greenfield ambition.

### Verification

- [ ] Review production metrics, support tickets, and incidents.
- [ ] Confirm regression tests exist for material production bugs.
- [ ] Confirm docs match shipped behavior.

## Cross-phase verification gates

- [ ] Every completed phase leaves the repo buildable and testable.
- [ ] `cd apps/web && bin/ci` remains the canonical Rails gate until a root gate replaces it.
- [ ] Add a root verification command once more than one implemented app exists.
- [ ] Native-facing API work must include request tests and documented response shapes.
- [ ] Native client work must include unit tests plus a real-device smoke checklist.
- [ ] Safety-sensitive state changes must be audited and test-covered.
- [ ] Privacy-sensitive data collection must be documented and opt-in where required by the guardrails.
- [ ] Production changes must include rollback, backup, and observability notes.
- [ ] Any production bug in pact timing, unlock behavior, config signing, or event ingestion should add a regression test.

## Definition of done for any completed phase

- [x] Completed phases update code, tests, docs, and environment guidance together.
- [x] Completed phases satisfy their exit criteria.
- [x] Completed phases have verification expectations checked honestly.
- [x] Completed phases update this file in the same change set as the repo change.
- [x] Completed phases do not leave stale README or setup instructions behind.

## When to retire this file

- [ ] Keep `BUILD.md` while SentryPact is in active greenfield build mode.
- [ ] Once the repo graduates from greenfield, fold current truth into stable docs such as `README.md`, `docs/architecture.md`, `docs/security.md`, `docs/privacy.md`, `docs/api.md`, and `docs/operations.md`.
- [ ] Remove stale checklist history instead of letting this file become dead weight.
