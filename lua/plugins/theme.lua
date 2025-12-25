return {
  "folke/tokyonight.nvim",
  lazy = false;
  opts = {},
  config = function()
      local colour = colour or "tokyonight-storm"
      vim.cmd.colorscheme(colour)
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  }
