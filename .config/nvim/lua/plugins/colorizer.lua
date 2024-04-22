-- show colors in files where colors variable are defined or in css
return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    "css",
    "scss",
    "javascript",
    html = {
      mode = "foreground",
    },
  },
}
