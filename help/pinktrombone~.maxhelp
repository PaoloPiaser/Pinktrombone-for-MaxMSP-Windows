{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 1,
      "revision": 3,
      "architecture": "x64",
      "modernui": 1
    },
    "rect": [
      70,
      70,
      1100,
      730
    ],
    "default_fontsize": 12,
    "default_fontname": "Arial",
    "openinpresentation": 0,
    "boxes": [
      {
        "box": {
          "id": "title",
          "maxclass": "comment",
          "patching_rect": [
            25,
            20,
            950,
            38
          ],
          "fontsize": 26,
          "text": "pinktrombone~ | articulatory voice model"
        }
      },
      {
        "box": {
          "id": "intro",
          "maxclass": "comment",
          "patching_rect": [
            25,
            67,
            1030,
            40
          ],
          "text": "Float messages and audio-rate modulation share the same controls. Four outputs: mixed voice, mouth, nose, raw glottis."
        }
      },
      {
        "box": {
          "id": "freq",
          "maxclass": "flonum",
          "patching_rect": [
            25,
            135,
            90,
            22
          ]
        }
      },
      {
        "box": {
          "id": "init",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            108,
            95,
            22
          ],
          "text": "loadmess 140."
        }
      },
      {
        "box": {
          "id": "lab",
          "maxclass": "comment",
          "patching_rect": [
            125,
            135,
            180,
            22
          ],
          "text": "Frequency in Hz"
        }
      },
      {
        "box": {
          "id": "tense",
          "maxclass": "message",
          "patching_rect": [
            25,
            185,
            215,
            22
          ],
          "text": "tenseness 0.6"
        }
      },
      {
        "box": {
          "id": "tongue",
          "maxclass": "message",
          "patching_rect": [
            255,
            185,
            215,
            22
          ],
          "text": "tongueIndex 27"
        }
      },
      {
        "box": {
          "id": "diameter",
          "maxclass": "message",
          "patching_rect": [
            485,
            185,
            215,
            22
          ],
          "text": "tongueDiameter 2.1"
        }
      },
      {
        "box": {
          "id": "nose",
          "maxclass": "message",
          "patching_rect": [
            715,
            185,
            215,
            22
          ],
          "text": "velum 0.4"
        }
      },
      {
        "box": {
          "id": "constrict",
          "maxclass": "message",
          "patching_rect": [
            25,
            223,
            215,
            22
          ],
          "text": "constriction 0 30 0.5 1"
        }
      },
      {
        "box": {
          "id": "release",
          "maxclass": "message",
          "patching_rect": [
            255,
            223,
            215,
            22
          ],
          "text": "constriction 0 30 0.5 0"
        }
      },
      {
        "box": {
          "id": "trigger",
          "maxclass": "message",
          "patching_rect": [
            485,
            223,
            215,
            22
          ],
          "text": "trigger"
        }
      },
      {
        "box": {
          "id": "info",
          "maxclass": "message",
          "patching_rect": [
            715,
            223,
            215,
            22
          ],
          "text": "info"
        }
      },
      {
        "box": {
          "id": "voice",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            290,
            1000,
            24
          ],
          "text": "pinktrombone~ @autoWobble 0"
        }
      },
      {
        "box": {
          "id": "outputs",
          "maxclass": "comment",
          "patching_rect": [
            25,
            325,
            990,
            24
          ],
          "text": "Outlet 1 = mixed voice. Outlets 2 / 3 / 4 = mouth / nose / glottis (not a stereo arrangement)."
        }
      },
      {
        "box": {
          "id": "dc",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            375,
            215,
            22
          ],
          "text": "biquad~ 1. -1. 0. -0.995 0."
        }
      },
      {
        "box": {
          "id": "dcinfo",
          "maxclass": "comment",
          "patching_rect": [
            260,
            372,
            740,
            44
          ],
          "text": "DC removal: same difference equation as LeakDC with coefficient 0.995. Keep this before envelopes, gain and panning."
        }
      },
      {
        "box": {
          "id": "gain",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            420,
            75,
            22
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "level",
          "maxclass": "flonum",
          "patching_rect": [
            130,
            420,
            80,
            22
          ],
          "minimum": 0.0,
          "maximum": 0.5
        }
      },
      {
        "box": {
          "id": "levelinfo",
          "maxclass": "comment",
          "patching_rect": [
            230,
            420,
            720,
            25
          ],
          "text": "Start at 0.05; gain starts at zero. Click the speaker to enable audio."
        }
      },
      {
        "box": {
          "id": "dac",
          "maxclass": "ezdac~",
          "patching_rect": [
            25,
            470,
            45,
            45
          ]
        }
      },
      {
        "box": {
          "id": "scope",
          "maxclass": "scope~",
          "patching_rect": [
            270,
            470,
            720,
            115
          ],
          "numinlets": 2,
          "numoutlets": 0
        }
      },
      {
        "box": {
          "id": "tips",
          "maxclass": "comment",
          "patching_rect": [
            25,
            605,
            1030,
            60
          ],
          "text": "Signals connected to an inlet override its stored float. Disconnect to resume the stored float. Use a line~ ramp for smooth message changes.\nThe excitation input is external audio: a constant adds DC. Use distinct @seed values for independent voices."
        }
      },
      {
        "box": {
          "id": "advanced",
          "maxclass": "comment",
          "patching_rect": [
            25,
            665,
            1030,
            50
          ],
          "text": "Custom inlet order: pinktrombone~ @signals freq tongueIndex diameter12 constriction0Gate\nSee docs/PARAMETERS.md for all controls, timing and optional 148-channel diagnostics."
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "init",
            0
          ],
          "destination": [
            "freq",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tense",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tongue",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "diameter",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "nose",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "constrict",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "release",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "trigger",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "info",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "freq",
            0
          ],
          "destination": [
            "voice",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "voice",
            0
          ],
          "destination": [
            "dc",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "dc",
            0
          ],
          "destination": [
            "gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "level",
            0
          ],
          "destination": [
            "gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gain",
            0
          ],
          "destination": [
            "dac",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gain",
            0
          ],
          "destination": [
            "dac",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gain",
            0
          ],
          "destination": [
            "scope",
            0
          ]
        }
      }
    ]
  }
}
