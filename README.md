# SentryPact

Filtering that stays on.

SentryPact is a privacy-preserving, lockdown-first blocker for adults and
families who want protection that cannot be impulsively switched off at the
exact moment it is needed most. It combines DNS, app, and browser filtering
with timer-locked Solo Pacts, optional co-signers, tamper detection, and
minimal accountability reporting.

SentryPact is designed to be tamper-resistant and bypass-detecting. It is
not marketed as impossible to bypass, a medical treatment, or a guaranteed
prevention tool.

The public site lives at [sentrypact.com](https://sentrypact.com).

## Monorepo

This repository is the home for every SentryPact surface. Each app
directory has its own README with the details for that surface; the
table below links to all of them.

| Surface                                    | Status        | What lives here |
| ------------------------------------------ | ------------- | --------------- |
| [`apps/web`](apps/web/README.md)           | Implemented   | Rails 8.1.3 website, control plane, dashboard, and the production deployment for `sentrypact.com`. |
| [`apps/ios`](apps/ios/README.md)           | Placeholder   | Future Swift iOS Solo enforcement client (Network Extension, Family Controls). |
| [`apps/android`](apps/android/README.md)   | Placeholder   | Future Kotlin Android enforcement client (`VpnService`, Device Admin). |
| [`apps/macos`](apps/macos/README.md)       | Placeholder   | Future Swift macOS enforcement client (Network Extension, Managed Settings). |
| [`apps/windows`](apps/windows/README.md)   | Placeholder   | Future native Windows service client (Windows Filtering Platform). |
| [`apps/extensions`](apps/extensions/README.md) | Placeholder | Future Chrome / Edge / Firefox / Safari companions. |

Top-level layout:

```text
apps/         Per-surface code, one app per subdirectory (links above)
docs/         Product, architecture, trust, policy, and security notes
packages/     Shared rules, schemas, fixtures, and generated clients
infra/        Deployment, DNS, CDN, observability, and environments
bin/          Root scripts that delegate into apps/web
BUILD.md      Active execution plan and phase tracker for the build
```

The first checked-in app is [`apps/web`](apps/web/README.md), generated
with Rails 8.1.3, Ruby 4.0.3, Hotwire, Propshaft, Tailwind CSS, Solid
Queue, Solid Cache, Solid Cable, Kamal, Brakeman, bundler-audit, and
Rails' default test stack. Native client directories are placeholders
until the Rails control plane publishes the contracts they need.

## Product wedge

Most blockers fail at the same point: the user can disable them when
impulse is strongest. SentryPact starts from the opposite assumption.
The product asks the user to make a clear pact up front, records the
server-verified release time, and then keeps enforcement active until
the pact is fulfilled or a documented release path completes.

Core language:

- Lockdown-first filtering
- Timer-locked Solo Pacts
- Optional co-signer approvals
- Tamper and bypass detection
- Privacy-preserving accountability

Avoided claims:

- Impossible to bypass
- Unbreakable
- Addiction cure
- Guaranteed protection
- Secret monitoring

## MVP

The first product target is SentryPact Solo for iOS:

- Account creation
- Local VPN/DNS filtering
- Categories for porn, gambling, drugs, ads and trackers, malware and
  phishing, proxy/VPN/Tor
- Solo Pact timers for 24h, 72h, 7d, and 30d
- Server-verified release timestamps
- Basic tamper detection
- Emergency unlock with a 24h cooling-off period
- Blocked-attempt counter
- Minimal dashboard
- Signed blocklist CDN
- Privacy-first weekly summary

Out of scope for v0.1: partner dashboard, family accounts, desktop apps,
router DNS, AI classification, deep reports, group plans, and MDM
features.

## Architecture direction

The enforcement layer should stay native:

- iOS and macOS: Swift, Family Controls where approved, Managed Settings,
  Device Activity, Network Extension, local VPN/DNS, optional
  configuration profiles
- Android: Kotlin, `VpnService`, Device Admin where appropriate,
  policy-compliant accessibility only if needed
- Windows: native service using Windows Filtering Platform and locked
  DNS/hosts controls
- Browser extensions: Chrome, Edge, Firefox, Safari companions for
  cosmetic filtering, DoH detection, SafeSearch, and YouTube
  Restricted Mode
- Web/backend: Rails, server-rendered dashboard, JSON APIs where clients
  need them

The cloud control plane owns accounts, subscriptions, devices, pact
state, server-side time, partner relationships, approvals, tamper
ingestion, reports, and signed configuration publishing. SQLite is used
for the initial local Rails scaffold and the current production
deployment; PostgreSQL is the likely production database once the
control plane starts storing real pact, device, and subscription state.

## Privacy and safety

SentryPact should earn trust by collecting less:

- No raw browsing history by default
- No page contents sent to the server
- No partner screenshots by default
- Category counts and tamper events by default
- Full URL logging only if the user explicitly opts in
- Visible partner status and partner access logs
- No stealth mode or hidden installs
- Emergency safety release paths for abuse, legality, and medical
  situations

Coercive control is a primary abuse case to design against. Adult
partner mode must require explicit consent, persistent visibility,
release protections, and auditability.

## Quick start

For the only implemented app today:

```sh
bin/setup
bin/dev
```

Then open [http://localhost:3000](http://localhost:3000). The root
`bin/setup` and `bin/dev` scripts delegate into `apps/web`; full
development, CI, and production deployment instructions live in
[`apps/web/README.md`](apps/web/README.md).

## Pricing draft

- Free: 1 device, basic ad/tracker and porn DNS filtering, manual mode
  only
- Solo Pact: $6/mo or $60/yr, core categories, lock timer, delayed
  emergency unlock, up to 3 devices
- Pact Plus: $12/mo or $120/yr, Solo plus co-signer approvals, tamper
  alerts, partner reports, up to 5 devices
- Family: $18/mo or $180/yr, up to 10 devices, parent dashboard, child
  profiles, schedules, app blocking

Lifetime plans may be useful for recovery users, but they should not be
priced so low that the subscription business breaks.

## Roadmap

1. Rails website and backend foundation.
2. iOS Solo MVP with local VPN/DNS filtering and server-verified Solo
   Pact release.
3. Android Solo MVP with `VpnService` and Device Admin where
   appropriate.
4. Co-signed Pact mode with approval requests, tamper alerts, and
   weekly privacy-preserving reports.
5. Desktop and browser coverage.
6. Family and group plans.
7. Intelligence layer for on-device classification, bypass research,
   and false-positive review.

For the active phase plan and acceptance gates, see [`BUILD.md`](BUILD.md).
