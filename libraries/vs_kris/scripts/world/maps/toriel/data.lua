return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 11,
  nextobjectid = 35,
  properties = {
    ["border"] = "leaves_night",
    ["light"] = true,
    ["name"] = "Toriel's House - Kris Room",
    ["night"] = true
  },
  tilesets = {
    {
      name = "computer",
      firstgid = 1,
      filename = "../../tilesets/computer.tsx",
      exportfilename = "../../tilesets/computer.lua"
    },
    {
      name = "toriel_room12",
      firstgid = 2,
      filename = "../../tilesets/toriel_rm1.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 10,
      name = "tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 374.5,
          y = 161.5,
          width = 90.5,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80.5,
          y = 80.5,
          width = 98.5,
          height = 216,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 180,
          y = 80.5,
          width = 97,
          height = 145,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 277.5,
          y = 80.5,
          width = 96,
          height = 104,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 466,
          y = 161.5,
          width = 93.5,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 467.5,
          y = 277.5,
          width = 91.5,
          height = 22,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80.5,
          y = 400.5,
          width = 209,
          height = 79.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80.5,
          y = 400.5,
          width = 208,
          height = 79.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 371,
          y = 401.75,
          width = 188,
          height = 78,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 70,
          y = 80.5,
          width = 9.5,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 81,
          width = 11.5,
          height = 321,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 81,
          y = 371.5,
          width = 101,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 468,
          y = 215.5,
          width = 21,
          height = 60.5,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 2,
          name = "spawn",
          type = "",
          shape = "point",
          x = 512,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "entry",
          type = "",
          shape = "point",
          x = 329.5,
          y = 440,
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
      id = 7,
      name = "objects",
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
          id = 22,
          name = "wing",
          type = "",
          shape = "rectangle",
          x = 292,
          y = 165.5,
          width = 69.5,
          height = 33.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 377.5,
          y = 167,
          width = 84.5,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* This is a lamp.",
            ["text2"] = "* Under the lamp you found a trading card.",
            ["text3"] = "* It has a mage on it.[wait:10]\n* With surprisingly low magicka."
          }
        },
        {
          id = 24,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 185,
          y = 178.5,
          width = 88.5,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "start.int1"
          }
        },
        {
          id = 25,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 211.5,
          width = 90,
          height = 61,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* There are CDs under the bed.[wait:10]\n* Classical,[wait:5] jazz,[wait:5] religious ska...",
            ["text2"] = "* Some of the discs are scratched.",
            ["text3"] = "* There's also a game console.[wait:10]\n* It has one normal controller,[wait:5] and one knock-off one.",
            ["text4"] = "* The controllers are missing buttons."
          }
        },
        {
          id = 26,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 89,
          y = 371,
          width = 92.5,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* It's a computer desk.[wait:10]\n* There are many boxes under it filled with old books.",
            ["text2"] = "* Two letters are scratched into the desk,[wait:5] followed by an unfinished third.",
            ["text3"] = "* \"Kni...\"."
          }
        },
        {
          id = 27,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 481,
          y = 209.5,
          width = 64.5,
          height = 70,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "secret/start.begin"
          }
        },
        {
          id = 28,
          name = "bed",
          type = "",
          shape = "rectangle",
          x = 485.5,
          y = 225.5,
          width = 49.5,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 475,
          y = 228.5,
          width = 45,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "start.endgame"
          }
        },
        {
          id = 31,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 290.5,
          y = 465.5,
          width = 79.5,
          height = 14,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "toriel_rm2",
            ["marker"] = "entry"
          }
        },
        {
          id = 34,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 545.5,
          y = 334.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's stained."
          }
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 9,
      name = "obj",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 89.9205,
      offsety = 41.9318,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
