# Parameters and outlets

## Default inlets (left to right, numbered from 1)

Every listed input accepts a signal or a stored float. Positive gate values are
true; externalNoise is truncated to an integer. Frequency is additionally limited
to 20% of the current sample rate. Nonfinite signals fall back to the default;
finite out-of-range inputs are clamped.

| Inlet | Name / message | Default | Range |
| --- | --- | --- | --- |
| 1 | `freq` | 140 | 10 … 153600 |
| 2 | `tenseness` | 0.6 | 0 … 1 |
| 3 | `tongueIndex` | 12.9 | 0 … 43 |
| 4 | `tongueDiameter` | 2.43 | 2.05 … 3.5 |
| 5 | `velum` | 0.01 | 0 … 3 |
| 6 | `gate` | 0 | 0 … 1 |
| 7 | `alwaysVoice` | 1 | 0 … 1 |
| 8 | `autoWobble` | 1 | 0 … 1 |
| 9 | `vibratoAmount` | 0.005 | 0 … 1 |
| 10 | `vibratoFrequency` | 6 | 0 … 100 |
| 11 | `aspiration` | 1 | 0 … 10 |
| 12 | `frication` | 1 | 0 … 10 |
| 13 | `excitation` | 0 | -100 … 100 |
| 14 | `glottisGain` | 1 | 0 … 10 |
| 15 | `glottalReflection` | 0.75 | -0.999 … 0.999 |
| 16 | `lipReflection` | -0.85 | -0.999 … 0.999 |
| 17 | `movementSpeed` | 15 | 0 … 1000 |
| 18 | `transientTrig` | 0 | -1 … 1 |
| 19 | `transientPosition` | 30 | 0 … 43 |
| 20 | `transientStrength` | 0.3 | 0 … 10 |
| 21 | `transientLife` | 0.2 | 0 … 10 |
| 22 | `transientExponent` | 200 | 0 … 10000 |
| 23 | `reset` | 0 | -1 … 1 |
| 24 | `aspirationNoise` | 0 | -100 … 100 |
| 25 | `fricationNoise` | 0 | -100 … 100 |
| 26 | `externalNoise` | 0 | 0 … 3 |
| 27 | `noiseModulator` | -1 | -1 … 1 |

## Creation options

- Optional first number: initial frequency in Hz.
- `@seed 1`: integer 0…16777215; determines repeatable noise/modulation.
- `@modelBlockSize 512`: integer 1…512; model update cadence in samples.
- `@diagnostics 0`: 0 = four outputs; 1 = 148 outputs.
- `@constrictions 4`, `@turbulence 4`: independently allocate 0…64 point slots.
  Slots start with index 30, diameter 0.5, gate 0 (inactive).
- `@signals name name ...`: 1…96 unique parameter names; replaces the default
  inlet layout. Any scalar, cell or point-component name below is valid.
- `@parameterName value`: set the initial stored float of any live parameter,
  including names such as `@diameter12 2.8` or `@constriction0Gate 1`.

Seed, modelBlockSize, diagnostics, counts and routing are fixed at creation.
Recreate the object to change them. They are configuration, not signal inlets.

## Tract cells and points

All cell/slot numbers in messages and names are **zero-based**.

| Name available to @signals and float messages | Range | Default |
| --- | --- | --- |
| `diameter0` … `diameter43` | -1…10 | -1 |
| `noseDiameter0` … `noseDiameter27` | -1…10 | -1 |
| `constriction0Index`, `turbulence0Index`, etc. | -1…44 | 30 |
| `constriction0Diameter`, `turbulence0Diameter`, etc. | -3…10 | 0.5 |
| `constriction0Gate`, `turbulence0Gate`, etc. | 0…1 | 0 |

A negative cell diameter means automatic/model geometry. Nonnegative values
supply an explicit target/override. Point slot names exist only for the number
allocated by the creation options. With 64 slots of each kind there are 483
individually controllable live parameters; up to 96 can have signal inlets at once.

Convenient equivalent messages:

```text
diameter 12 2.8
noseDiameter 5 1.5
diameters <44 numbers>
noseDiameters <28 numbers>
constriction 0 30. 0.5 1.
turbulence 0 34. 0.4 1.
constriction0Gate 0.
param tenseness 0.8
```

Point gate transitions retain the upstream 100 ms turbulence envelope. Closing
and reopening the tract can create automatic plosive transients. Constrictions
modify geometry and turbulence; independent turbulence points inject noise
without changing the target tract geometry.

## Triggers and message timing

- `reset` (no argument) or `bang`: reset the engine at the next Max vector.
- `reset 1` / `reset 0`, or a reset signal: reset on a nonpositive-to-positive edge.
- `trigger`: create a low/high two-sample pulse for the manual transient, using
  transientPosition, transientStrength, transientLife and transientExponent.
- `transientTrig` floats/signals: trigger on a nonpositive-to-positive edge.
- `info`: print inlet names and stored float values to the Max console.

Repeated reset/trigger messages within one vector coalesce. A trigger requested
while a pulse is in progress is held for the following pulse, so consecutive
messages cannot prevent the current pulse from reaching its high sample. Reset
and sample-rate changes discard partially emitted message pulses. For precise repeated
triggers use a signal inlet. Float updates use lock-free per-parameter storage;
multiple fields in one message are not an atomic transaction with the audio thread.
Signals override floats for connected parameters, including connected zero-valued
signals. Named messages still update the value that will resume on disconnection.

Shape targets are sampled every modelBlockSize samples, with upstream movement
smoothing. Glottal coefficients change at waveform boundaries. Excitation, noise,
gates, point controls and transient edges are read every audio sample. Message
parameters first become available on the next Max vector. DSP graph changes at
the same sample rate preserve engine state; sample-rate changes reconstruct it.

## Output layout

| Max outlet (1-based) | Signal |
| --- | --- |
| 1 | Mixed voice |
| 2 | Mouth contribution |
| 3 | Nose contribution |
| 4 | Raw glottal source, including aspiration |
| 5…48 | Oral amplitude envelopes, cells 0…43 |
| 49…76 | Nasal amplitude envelopes, cells 0…27 |
| 77…120 | Actual oral diameters, cells 0…43 |
| 121…148 | Actual nasal diameters, cells 0…27 |

Outlets 5…148 exist only with `@diagnostics 1`. All are 64-bit audio-rate
signals, including envelopes and geometry. This is the same order as the
SuperCollider implementation; subtract one for its zero-based output indices.
The mixed output has the upstream 0.125 summation gain. No DC blocker, envelope,
panner, limiter, or reverb is inserted internally.

The model retains 44 oral cells, 28 nasal cells and up to 256 concurrent
transients. Further transients are dropped until a slot becomes available.
Numerical overload resets the model and produces a zero sample instead of NaNs.
