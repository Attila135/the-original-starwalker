return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 29,
  properties = {
    ["footsteps"] = true
  },
  tilesets = {
    {
      name = "entrance",
      firstgid = 1,
      filename = "../tilesets/entrance.tsx"
    },
    {
      name = "floor",
      firstgid = 131,
      filename = "../tilesets/floor.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 6,
      name = "Tile Layer 2",
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
        0, 0, 0, 138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 138, 0, 0, 0, 0, 138, 138, 138, 138, 138, 138, 0, 0,
        0, 0, 0, 136, 138, 138, 138, 138, 138, 138, 138, 138, 138, 137, 0, 0,
        0, 0, 0, 0, 135, 138, 138, 138, 138, 138, 138, 138, 134, 0, 0, 0,
        0, 0, 0, 0, 0, 138, 138, 138, 138, 138, 138, 138, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 138, 138, 138, 138, 138, 138, 138, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 138, 138, 138, 138, 138, 138, 138, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 138, 138, 138, 138, 138, 138, 138, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "Tile Layer 1",
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
        0, 0, 0, 0, 0, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0,
        0, 0, 0, 0, 16, 17, 18, 19, 20, 21, 22, 23, 24, 0, 0, 0,
        0, 0, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 0,
        0, 0, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 0,
        0, 0, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 0,
        0, 0, 0, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 0, 0,
        0, 0, 0, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 0, 0,
        0, 0, 0, 0, 0, 95, 96, 97, 0, 99, 100, 101, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 108, 109, 110, 0, 112, 113, 114, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 121, 122, 123, 0, 125, 126, 127, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
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
          shape = "rectangle",
          x = 209.416,
          y = 239.427,
          width = 95.5288,
          height = 120.29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 375.878,
          y = 239.33,
          width = 95.5288,
          height = 120.29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 157.861,
          y = 0,
          width = 137.468,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 383,
          y = 0,
          width = 137.468,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 680,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 0,
          width = 200,
          height = 133.153,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 200,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 240,
          width = 200,
          height = 240,
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
          id = 24,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 680,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "intro.intro",
            ["once"] = true
          }
        },
        {
          id = 25,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 480,
          width = 280,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "enter2",
            ["marker"] = "exit"
          }
        },
        {
          id = 27,
          name = "npc",
          type = "",
          shape = "point",
          x = 345.045,
          y = -69.3694,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "wilter"
          }
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
          id = 7,
          name = "kris",
          type = "",
          shape = "point",
          x = 341.773,
          y = 449.775,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "susie",
          type = "",
          shape = "point",
          x = 240,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "rals",
          type = "",
          shape = "point",
          x = 440,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "spawn",
          type = "",
          shape = "point",
          x = 340.357,
          y = 474.514,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "wilt",
          type = "",
          shape = "point",
          x = 341,
          y = 284,
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
