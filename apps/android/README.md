# SentryPact Android

Future home for the SentryPact Solo Android enforcement client.

This directory is a placeholder until the Rails control plane (`apps/web`)
publishes the contracts a native client needs. See the root `BUILD.md` for
the active phase plan.

## Planned stack

- Kotlin
- `VpnService` for local VPN/DNS filtering
- Device Admin where appropriate, accessibility services only when truly needed
  and policy-compliant
- Server-verified Solo Pact release timestamps
- Local-first enforcement that continues to behave safely while offline

## Status

Not started. Work begins after the iOS Solo MVP proves the contract surface
on at least one platform.
