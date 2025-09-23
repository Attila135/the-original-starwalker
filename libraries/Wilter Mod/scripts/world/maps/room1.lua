return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 15,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 12,
  nextobjectid = 70,
  properties = {
    ["border"] = "simple",
    ["name"] = "Funhouse - Set 3"
  },
  tilesets = {
    {
      name = "wilter_tileset_real",
      firstgid = 1,
      filename = "../tilesets/wilter_tileset_real.tsx"
    },
    {
      name = "teeth",
      firstgid = 961,
      filename = "../tilesets/teeth.tsx",
      exportfilename = "../tilesets/teeth.lua"
    },
    {
      name = "funhouse_objects",
      firstgid = 1201,
      filename = "../tilesets/funhouse_objects.tsx",
      exportfilename = "../tilesets/funhouse_objects.lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/wilter_tileset_real_image.png",
      id = 11,
      name = "background",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "polyline",
          x = 585.75,
          y = 601.375,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -120, y = -121.125 },
            { x = 77.5, y = -121.375 }
          },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "polyline",
          x = 55.913,
          y = 600.261,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 117.962, y = -120.011 },
            { x = -104.413, y = -119.761 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "polyline",
          x = 16.25,
          y = 479.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -1, y = -131.5 },
            { x = 82.75, y = -200.5 },
            { x = 261, y = -199.5 }
          },
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "polyline",
          x = 362.25,
          y = 281,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 181.25, y = -0.5 },
            { x = 261.5, y = 68.5 },
            { x = 262.25, y = 203.25 }
          },
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 182.182,
          width = 53.4545,
          height = 98.1818,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 361.636,
          y = 181.273,
          width = 60.3636,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 232.972,
          y = 186.607,
          width = 182,
          height = 70.9697,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = -32,
          y = 599.667,
          width = 619.667,
          height = 144.333,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 12,
          name = "spawn",
          type = "",
          shape = "point",
          x = 580,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "entry",
          type = "",
          shape = "point",
          x = 320.361,
          y = 306.969,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "wilter_1",
          type = "",
          shape = "point",
          x = 320,
          y = 343.762,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "kris_1",
          type = "",
          shape = "point",
          x = 320.909,
          y = 446.364,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "sus_1",
          type = "",
          shape = "point",
          x = 175.697,
          y = 442.878,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "ral_1",
          type = "",
          shape = "point",
          x = 469.818,
          y = 450.727,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "wilter_2",
          type = "",
          shape = "point",
          x = 322,
          y = -205.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "wilter_4",
          type = "",
          shape = "point",
          x = 464.667,
          y = 339.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "wilter_3",
          type = "",
          shape = "point",
          x = 445.333,
          y = -212,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "cam_pan_1",
          type = "",
          shape = "point",
          x = 320,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "sus_2",
          type = "",
          shape = "point",
          x = 370,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "entry",
          type = "",
          shape = "point",
          x = 320,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "sus_3",
          type = "",
          shape = "point",
          x = 370,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "ral_2",
          type = "",
          shape = "point",
          x = 200,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "ral_3",
          type = "",
          shape = "point",
          x = 320,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 57,
          name = "sus_4",
          type = "",
          shape = "point",
          x = 320,
          y = 500,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_player",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 14,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 143.154,
          y = 521.89,
          width = 348.6,
          height = 44.7224,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "generic.cantleave",
            ["once"] = false
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 136.482,
          y = 200,
          width = 76.7359,
          height = 47.0369,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* (There's nothing out there.)"
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 423.692,
          y = 200,
          width = 81.8864,
          height = 48.067,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* (There's nothing out there..?)",
            ["text2"] = "* (Are those eyes?)"
          }
        },
        {
          id = 19,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* This doesn't feel right... Something's off.",
            ["text2"] = "* But nevertheless, You press on.",
            ["text3"] = "* You are filled with the power of suspiciously placed save points."
          }
        },
        {
          id = 20,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 224.549,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "right",
            ["map"] = "room2",
            ["marker"] = "entry"
          }
        },
        {
          id = 27,
          name = "npc",
          type = "",
          shape = "point",
          x = 320,
          y = -240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "omeg_wilter"
          }
        },
        {
          id = 34,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 258.667,
          y = 264.667,
          width = 120,
          height = 63.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "wilt_omeg_intro.cutscene1",
            ["once"] = false
          }
        },
        {
          id = 49,
          name = "npc",
          type = "",
          shape = "point",
          x = -160,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ralsei",
            ["cond"] = "not Game:hasPartyMember(\"ralsei\")",
            ["facing"] = "up"
          }
        },
        {
          id = 50,
          name = "npc",
          type = "",
          shape = "point",
          x = 960,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "susie",
            ["cond"] = "not Game:hasPartyMember(\"susie\")",
            ["facing"] = "up"
          }
        },
        {
          id = 53,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 310,
          y = 460,
          width = 25.5,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "chase.post_chase",
            ["once"] = true
          }
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!tension_chest"
          }
        },
        {
          id = 61,
          name = "chest",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "tension_chest",
            ["item"] = "tensionpause"
          }
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 1210,
          visible = true,
          properties = {
            ["flagcheck"] = "!tension_chest"
          }
        },
        {
          id = 63,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!tension_chest",
            ["text1"] = "* The treasure of calmness.",
            ["text2"] = "* Free yourself of your stress and worries and move like the wind.",
            ["text3"] = "* Five switches, find and press them all.",
            ["text4"] = "* Only then you may be able to take a break and steady your breath."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects above",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 35,
          name = "dark_overlay",
          type = "",
          shape = "point",
          x = 327.333,
          y = 383.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
