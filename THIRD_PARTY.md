# Attribution and licensing

The DSP files under `dsp/` are byte-identical to the MIT-licensed standalone
engine in PinkTrombone for SuperCollider, commit
`3752e5f5000733a63eda229c717424786745d874`.
They port chdh/pink-trombone-mod commit
`359c2d3b42b10280404c1650dc601902112b4c90`.
Original Pink Trombone: Copyright 2017 Neil Thapen. Modularization and TypeScript
conversion: Christian d'Heureuse. Simplex noise: public-domain code by Stefan
Gustavson, optimized by Peter Eastman, JavaScript conversion by Joseph Gentle.

The Max adapter, parameter bridge, tests, help patches and scripts are MIT
licensed under the included LICENSE. This package does not incorporate the
GPL SuperCollider adapter or SuperCollider SDK headers.

Cycling '74's official max-sdk-base is pinned to commit
`c03a2922a2a8ff149165a1e2ea134e9321d6e202`. Its c74support files and license
are under `vendor/max-sdk-base`. The LICENSE.md at that revision explicitly
permits redistribution with its notice. The bundle links to the MaxAudioAPI
framework supplied by the running Max application; no SDK framework is embedded
in the binary package. SDK files are included only in the source archive.

Upstream sources:
- https://github.com/chdh/pink-trombone-mod
- https://github.com/little-scale/pink-trombone-for-sc
- https://github.com/Cycling74/max-sdk-base
