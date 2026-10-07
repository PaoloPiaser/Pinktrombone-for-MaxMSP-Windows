# Changelog

## v0.1 — 2026-09-14

Initial public release (package/bundle version 0.1.0).

- Universal Apple Silicon and Intel macOS external, `pinktrombone~`.
- 27 default float/signal inlets; configurable routing for tract cells and points.
- Four audio outputs, or 148 with diagnostics enabled.
- Help patch, audio-rate articulation example, parameter reference and DC guidance.
- Reproducible builds, pinned Max SDK, DSP parity tests and host validation report.
- Pre-release review: prevent rapid message triggers from starving a pulse;
  clear partial message pulses when the sample rate changes or the engine resets;
  preserve the previous inlet routing when rejecting an invalid configuration.

Binaries are ad-hoc signed, not Developer ID signed or Apple notarized.
