return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "javascript", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "rust" },
          additional_vim_regex_highlighting = false,
        }
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      })
    end,
  },
  {
    
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable context display
        throttle = true, -- Throttle updates for performance
        max_lines = 0, -- Always show all context lines
        patterns = { -- Match patterns for various filetypes
          default = {
            "class",
            "function",
            "method",
          },
        },
        trim_scope = "outer", -- Trim context lines that exceed window width
      })
    end,
  },
}


