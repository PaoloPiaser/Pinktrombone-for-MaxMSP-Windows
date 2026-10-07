# Unofficial Windows build

This package contains an **unofficial** 64-bit Windows build of `pinktrombone~`
0.1.0, made on 7 October 2026 from the unmodified sources of
https://github.com/little-scale/pink-trombone-for-max (tag v0.1, commit 16366cf).
The upstream project only publishes a macOS build; it is not responsible for this file.

## What changed

Only the build configuration: a Windows branch was added to `CMakeLists.txt`
(see `CMakeLists-windows.patch`, distributed next to this package). No C++ source
file was modified. The external was cross-compiled with Clang (zig 0.16,
target x86_64-windows-gnu); the C++ runtime is linked statically, so it needs
only Windows 10 or newer and Max 8.2+/9 (64-bit).

## What was tested

- The project's own test program, compiled for Windows and run under Wine 9:
  30 exact 148-channel engine comparisons pass.
- The actual `pinktrombone~.mxe64` was loaded under Wine by a small fake Max host:
  class registration, object creation (27 inlets, 4 outlets), DSP setup, 1.6 s
  of audio, a parameter message, an invalid message and object freeing. The audio
  matches a Linux reference build to within 4.5e-16.

## What was NOT tested

It has **not** been loaded in a real Max on a real Windows machine. If Max
reports an error when you create the object, that is the first thing to report.

## Install

Copy the whole `PinkTromboneMax` folder into `Documents\Max 9\Packages\`
(or `Documents\Max 8\Packages\`), restart Max, create `pinktrombone~`.
The help patch starts with zero gain: raise it to about 0.05.

SHA-256 of `externals/pinktrombone~.mxe64`:
ecca87592ec5745cda24a99336f487ce21d816e90245b28be6e04c92585d1a53
