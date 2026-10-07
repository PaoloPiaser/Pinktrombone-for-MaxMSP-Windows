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
      1000,
      600
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
            40
          ],
          "fontsize": 24,
          "text": "Audio-rate articulation / custom inlets"
        }
      },
      {
        "box": {
          "id": "caption",
          "maxclass": "comment",
          "patching_rect": [
            25,
            72,
            950,
            44
          ],
          "text": "@signals chooses the inlet order. Every omitted control remains available by named float message."
        }
      },
      {
        "box": {
          "id": "pitch",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            135,
            150,
            22
          ],
          "text": "sig~ 140"
        }
      },
      {
        "box": {
          "id": "lfo",
          "maxclass": "newobj",
          "patching_rect": [
            230,
            135,
            150,
            22
          ],
          "text": "cycle~ 0.4"
        }
      },
      {
        "box": {
          "id": "shape",
          "maxclass": "newobj",
          "patching_rect": [
            230,
            180,
            150,
            22
          ],
          "text": "*~ 7."
        }
      },
      {
        "box": {
          "id": "offset",
          "maxclass": "newobj",
          "patching_rect": [
            230,
            225,
            150,
            22
          ],
          "text": "+~ 20."
        }
      },
      {
        "box": {
          "id": "gate",
          "maxclass": "newobj",
          "patching_rect": [
            460,
            135,
            150,
            22
          ],
          "text": "rect~ 2."
        }
      },
      {
        "box": {
          "id": "normal",
          "maxclass": "newobj",
          "patching_rect": [
            460,
            180,
            150,
            22
          ],
          "text": ">~ 0."
        }
      },
      {
        "box": {
          "id": "voice",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            300,
            920,
            22
          ],
          "text": "pinktrombone~ @signals freq tongueIndex constriction0Gate @autoWobble 0 @modelBlockSize 1"
        }
      },
      {
        "box": {
          "id": "dc",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            360,
            220,
            22
          ],
          "text": "biquad~ 1. -1. 0. -0.995 0."
        }
      },
      {
        "box": {
          "id": "gain",
          "maxclass": "newobj",
          "patching_rect": [
            25,
            405,
            90,
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
            160,
            405,
            70,
            22
          ],
          "minimum": 0.0,
          "maximum": 0.5
        }
      },
      {
        "box": {
          "id": "dac",
          "maxclass": "ezdac~",
          "patching_rect": [
            25,
            455,
            45,
            45
          ]
        }
      },
      {
        "box": {
          "id": "note",
          "maxclass": "comment",
          "patching_rect": [
            260,
            400,
            650,
            65
          ],
          "text": "Raise gain to 0.05, then enable audio. modelBlockSize 1 updates shape targets every sample; internal tract movement smoothing remains."
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "lfo",
            0
          ],
          "destination": [
            "shape",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "shape",
            0
          ],
          "destination": [
            "offset",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gate",
            0
          ],
          "destination": [
            "normal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "pitch",
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
            "offset",
            0
          ],
          "destination": [
            "voice",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "normal",
            0
          ],
          "destination": [
            "voice",
            2
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
      }
    ]
  }
}
