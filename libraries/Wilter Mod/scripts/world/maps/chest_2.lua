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
  nextobjectid = 20,
  properties = {
    ["music"] = "garden"
  },
  tilesets = {
    {
      name = "funhouse",
      firstgid = 1,
      filename = "../tilesets/funhouse.tsx"
    }
  },
  layers = {
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 34, 33, 33, 33, 33, 33, 33, 33, 33, 32, 0, 0, 0,
        0, 0, 0, 47, 3, 59, 59, 59, 59, 59, 59, 59, 45, 0, 0, 0,
        0, 0, 0, 47, 59, 4, 59, 59, 59, 59, 29, 59, 45, 0, 0, 0,
        0, 0, 0, 60, 72, 72, 72, 72, 72, 72, 72, 72, 58, 0, 0, 0,
        0, 0, 0, 88, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 89, 0, 0, 8,
        0, 0, 0, 113, 2147483733, 84, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 111, 0, 0, 0,
        0, 20, 0, 113, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 111, 0, 0, 0,
        0, 0, 0, 113, 87, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 96, 111, 0, 0, 0,
        0, 0, 0, 77, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 2147483733, 75, 0, 0, 0,
        0, 0, 0, 112, 98, 98, 98, 100, 109, 98, 98, 98, 110, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 113, 111, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 12, 12, 37, 38, 38, 39, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 24, 25, 25, 26, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 24, 25, 25, 26, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 37, 38, 38, 39, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 12, 12, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 402.545,
          width = 158.443,
          height = 77.455,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 200,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 200,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 480,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "polygon",
          x = 480,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = 40 },
            { x = 40, y = 0 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "polygon",
          x = 120,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = -40 },
            { x = 0, y = -40 },
            { x = 0, y = 0 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "polygon",
          x = 520,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -40 },
            { x = -40, y = 0 }
          },
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "polygon",
          x = 160,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -40, y = -40 },
            { x = -40, y = 0 },
            { x = 0, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 3,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
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
      id = 5,
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
          id = 2,
          name = "chest",
          type = "",
          shape = "point",
          x = 320,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["money"] = "1"
          }
        },
        {
          id = 19,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_sound"] = "doorclose",
            ["map"] = "hallway1",
            ["marker"] = "exit1",
            ["sound"] = "dooropen"
          }
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/filters/black.png",
      id = 6,
      name = "Image Layer 1",
      class = "",
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = true,
      properties = {}
    }
  }
}
