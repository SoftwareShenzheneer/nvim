local home = vim.fn.expand("~")
local vault_path = home .. "/vaults"

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  event = "VeryLazy",

  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = {
      enable = false,
    },

    workspaces = {
      {
        name = "personal",
        path = vault_path .. "/personal"
      },
      {
        name = "work",
        path = vault_path .. "/work"
      },
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      template = "template.md",
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },
  },
}
