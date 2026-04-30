# SentryPact iOS

Future home for the SentryPact Solo iOS enforcement client.

This directory is a placeholder until the Rails control plane (`apps/web`)
publishes the contracts a native client needs: account and device APIs,
signed configuration, signed blocklist artifacts, pact state, and event
ingestion. See the root `BUILD.md` for the active phase plan.

## Planned stack

- Swift / SwiftUI
- Family Controls, Managed Settings, Device Activity (where Apple permits)
- Network Extension with local VPN/DNS for category filtering
- Optional configuration profiles where MDM-style policy is appropriate
- Server-verified Solo Pact release timestamps; clients never own unlock timing
- Local-first enforcement that continues to behave safely while offline

## Status

Not started. A narrow feasibility spike is appropriate once Phase 2 has API
contracts drafted; until then this directory stays empty.
