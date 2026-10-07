# PinkTrombone for Max/MSP


## Windows port

> [!IMPORTANT]
>
> ### This is a Windows port of the Pinktrombone~ object created by [little-scale](https://github.com/little-scale)
>
> I take no credit for it: I asked Claude how to compile the object for
> Windows, and it did the whole port for me (without even being asked).
>
> The installation procedure is the same as the one described below.
>

<br>
<br>
<br>
<br>

`pinktrombone~` is a native 64-bit MSP external using the same MIT-licensed,
standalone DSP as [PinkTrombone for SuperCollider](https://github.com/little-scale/pink-trombone-for-sc).
It implements the sound model in Christian d'Heureuse's modular version of
Neil Thapen's Pink Trombone, without requiring a browser or SuperCollider.

The macOS bundle is universal **arm64 + x86_64**, targeting macOS 11 or newer
and the Max 8.2+/9 64-bit MSP API. It is **ad-hoc signed**, not Developer ID
signed or notarized. See [validation](docs/VALIDATION.md) for tested host versions.

## Install

Download the [v0.1 macOS package](https://github.com/little-scale/pink-trombone-for-max/releases/download/v0.1/PinkTromboneMax-0.1.0-macOS-universal.zip),
unzip it, and copy the entire
`PinkTromboneMax` package folder into `~/Documents/Max 9/Packages/`
(or your Max 8 Packages folder). Restart Max, create `pinktrombone~`, and
Option-click it to open its help patch. Alternatively, put the `.mxo` next to
your own patch. The external itself has no third-party runtime dependency.

The help patch starts with **zero output gain**. Set gain to about `0.05`, then
click its speaker button. It includes frequency and articulation messages,
constriction controls, a transient trigger, DC removal and a scope.

## Floats and signals

By default, there are 27 signal inlets. Every inlet also accepts integer/float
messages. A connected signal overrides the stored float for that parameter;
disconnecting resumes the stored float. Stored values are sampled once per Max
signal vector. All named parameter messages can be sent to the left inlet:

```text
freq 220.
tenseness 0.7
tongueIndex 27.
velum 0.4
constriction 0 30. 0.5 1.
diameter 12 2.8
trigger
reset
```

You can choose the number and order of inlets when creating the object:

```text
pinktrombone~ @signals freq tongueIndex diameter12 constriction0Gate
```

That makes four float/signal inlets, in that order. Every omitted parameter is
still available through messages. Up to 96 distinct parameters can be routed
to signal inlets in one instance, chosen from the complete parameter surface
(including every oral/nasal cell and every configured point component).
The standard 27 inlets remain the default when `@signals` is omitted.

`examples/audio-rate-articulation.maxpat` demonstrates pitch, tongue and
constriction-gate signals. Use `line~` to smooth changes if desired.

See [PARAMETERS.md](docs/PARAMETERS.md) for the complete inlet table, ranges,
array/point messages, creation options and all 148 optional diagnostic outlets.

## Outputs and DC removal

Outlets from left to right are **mixed voice, mouth, nose, raw glottal source**.
The mixed voice equals mouth plus nose. These four outlets are not a stereo pair.
Use the first outlet for ordinary listening.

As in the SuperCollider port, the DSP exposes the original waveform without an
internal DC filter. Use this Max filter before gain, envelopes and panning:

```text
pinktrombone~ → biquad~ 1. -1. 0. -0.995 0. → gain/envelope → output
```

Its equation is `y[n] = x[n] - x[n-1] + 0.995*y[n-1]`, equivalent to `LeakDC`
with coefficient 0.995. A constant `excitation` value injects DC; leave it at
zero for the internal voice alone. Waveform asymmetry is not necessarily DC.

## Timing and voice behavior

The default `@modelBlockSize 512` preserves the upstream control-update cadence,
independent of the Max vector size. Shape targets update at model boundaries;
pitch coefficients update at glottal-cycle boundaries. `@modelBlockSize 1`
allows per-sample shape targets, with higher CPU cost. Tract movement smoothing
and glottal-cycle timing remain; signal input does not bypass the model's physics.

Use distinct `@seed` values for independent voices. `autoWobble 0` retains the
upstream small simplex fluctuations. `alwaysVoice` has no effect while `gate`
is positive. Frication requires an active constriction or turbulence point.
The external has no built-in amplitude envelope, panner or reverb: those were
SynthDef processing around the SuperCollider UGen and belong in the Max patch.
Each instance uses roughly 0.55 MiB of DSP state, allocated outside performance.

## Build and test

Apple Command Line Tools, CMake and Python 3 are required. The official Max SDK
headers and framework stubs are pinned and included for an offline build.

```sh
git clone https://github.com/little-scale/pink-trombone-for-max.git
cd pink-trombone-for-max
./scripts/build_macos.sh
./scripts/package_macos.sh
```

The standalone tests compare all 148 outputs with the shared engine across
sample rates and vector sizes, and check float/signal precedence, geometry,
noise, point gates, resets, trigger edges and allocation-free processing.
The editable Max host recording test can be generated with
`python3 scripts/make_patches.py`; it is written next to the built external.

For a Developer ID signature, set `SIGN_IDENTITY` to an identity in your Keychain
when invoking the build/package script. The scripts do not notarize, change
Gatekeeper settings or remove quarantine flags. Source and attribution are
included; see [THIRD_PARTY.md](THIRD_PARTY.md).
