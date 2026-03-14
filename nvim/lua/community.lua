---@type LazySpec
return {
  -- 1. Add the community repository itself
  "AstroNvim/astrocommunity",

  -- 2. Import specific modules (each must be its own table)
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Add more imports here...
}
