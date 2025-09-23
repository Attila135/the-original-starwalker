return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 15,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 12,
  nextobjectid = 130,
  properties = {
    ["music"] = "garden"
  },
  tilesets = {
    {
      name = "set1",
      firstgid = 1,
      filename = "../tilesets/set1.tsx"
    },
    {
      name = "tv",
      firstgid = 271,
      filename = "../tilesets/tv.tsx"
    },
    {
      name = "bigchair_left",
      firstgid = 272,
      filename = "../tilesets/bigchair_left.tsx"
    },
    {
      name = "toy_car",
      firstgid = 273,
      filename = "../tilesets/toy_car.tsx"
    },
    {
      name = "toy_blocks",
      firstgid = 274,
      filename = "../tilesets/toy_blocks.tsx"
    },
    {
      name = "bigchair_right",
      firstgid = 275,
      filename = "../tilesets/bigchair_right.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 21,
      height = 15,
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
        0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 0,
        0, 0, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 0,
        0, 0, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 0,
        0, 0, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 0,
        0, 0, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 0,
        0, 0, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 0,
        0, 0, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 0,
        0, 0, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 0,
        0, 0, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 0,
        0, 0, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 0,
        0, 0, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 0,
        0, 0, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 0,
        0, 0, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 0,
        0, 0, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 0,
        0, 0, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 0
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
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 0,
          width = 160,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 520.86,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 200,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 520,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 520,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 400,
          width = 200,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 0,
          width = 160,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = -8.47355,
          width = 40,
          height = 408.474,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 171.875,
          y = 256.01,
          width = 89.1653,
          height = 49.9651,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 417.575,
          y = 255.507,
          width = 89.1653,
          height = 49.5551,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 302.539,
          y = 233.99,
          width = 72.681,
          height = 29.4298,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 82.2479,
          y = 161.097,
          width = 107.148,
          height = 56.1966,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80.7493,
          y = 471.576,
          width = 73.4302,
          height = 47.0762,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 546.807,
          y = 158.849,
          width = 26.9744,
          height = 53.1995,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 482.368,
          y = 471.46,
          width = 74.1795,
          height = 25.9951,
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
          id = 1,
          name = "spawn",
          type = "",
          shape = "point",
          x = 341.099,
          y = 390.323,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "entry",
          type = "",
          shape = "point",
          x = 375.447,
          y = 595.82,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "exit",
          type = "",
          shape = "point",
          x = 781.715,
          y = 27.714,
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
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 80.5958,
          y = 439.986,
          width = 81.5818,
          height = 80.0832,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* It's some sort of getaway vehicle.\n",
            ["text2"] = "* Looks like it's seen a few crashes."
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 528.187,
          y = 146.876,
          width = 64.7929,
          height = 68.0826,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* An oddly shaped vase, full of withered flowers."
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 472.629,
          y = 447.804,
          width = 90.8433,
          height = 56.4394,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's some toy blocks."
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 411.73,
          y = 243.754,
          width = 93.0353,
          height = 76.2573,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's an old chair, not much to say about it."
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 172.388,
          y = 243.771,
          width = 95.704,
          height = 72.3345,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's an old chair, not much to say about it."
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 79.0984,
          y = 92.5349,
          width = 122.27,
          height = 134.403,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* It's a bookshelf, full of books.\n",
            ["text2"] = "* You pick up a book, and open to a random page.",
            ["text3"] = "* ...\n* You'd rather not read the contents."
          }
        },
        {
          id = 40,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 760,
          y = -40,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "rng_door",
            ["marker"] = "spawn"
          }
        },
        {
          id = 42,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 600,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "hallway2",
            ["marker"] = "exit"
          }
        },
        {
          id = 109,
          name = "tv",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 280,
          width = 120,
          height = 120,
          rotation = 0,
          gid = 271,
          visible = true,
          properties = {}
        },
        {
          id = 110,
          name = "toy_car",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 520,
          width = 80,
          height = 80,
          rotation = 0,
          gid = 273,
          visible = true,
          properties = {}
        },
        {
          id = 111,
          name = "toy_blocks",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 520,
          width = 120,
          height = 80,
          rotation = 0,
          gid = 274,
          visible = true,
          properties = {}
        },
        {
          id = 112,
          name = "bigchair_right",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 320,
          width = 120,
          height = 120,
          rotation = 0,
          gid = 275,
          visible = true,
          properties = {}
        },
        {
          id = 113,
          name = "bigchair_left",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 120,
          height = 120,
          rotation = 0,
          gid = 272,
          visible = true,
          properties = {}
        },
        {
          id = 127,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 285.394,
          y = 266.82,
          width = 105.576,
          height = 21.1153,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tv.tv"
          }
        },
        {
          id = 129,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 160,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* You know what they say!",
            ["text2"] = "* Even a broken clock is right twice a day!",
            ["text3"] = "* Well[wait:5].[wait:5].[wait:5].[wait:10]\n* This one isn't."
          }
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/filters/black.png",
      id = 11,
      name = "Image Layer 1",
      class = "",
      visible = false,
      opacity = 0.5,
      offsetx = 80,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    }
  }
}
