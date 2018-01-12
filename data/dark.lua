return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 1,
  height = 1,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 1,
  backgroundcolor = { 141, 196, 53 },
  properties = {},
  tilesets = {
    {
      name = "roguelikeSheet_transparent",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../images/roguelikeSheet_transparent.png",
      imagewidth = 3648,
      imageheight = 1984,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      terrains = {},
      tilecount = 1767,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Grass",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AQAAAA=="
    },
    {
      type = "tilelayer",
      name = "Objects",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      data = "AQAAAA=="
    },
    {
      type = "tilelayer",
      name = "Border",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      data = "AQAAAA=="
    },
    {
      type = "tilelayer",
      name = "Decor",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AAAAAA=="
    }
  }
}
