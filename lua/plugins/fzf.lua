return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      files = {
        -- Use fd (Ubuntu: you symlink fdfind → fd)
        cmd = "fd --type f --hidden --exclude .git",
      },

      winopts = {
        height = 0.90,   -- 85% of the screen height
        width  = 0.90,   -- 80% of the screen width
      },

      grep = {
        rg_opts = table.concat({
          "--column",
          "--line-number",
          "--no-heading",
          "--color=always",
          "--smart-case",
          "--max-columns=200",
          "--hidden",
          "--glob=!{.git,node_modules,.cache,build}/*"
        }, " "),
      },

      fzf_opts = {
        -- Enables persistent search history caching
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
        -- ["--delimiter"] = "[:/]",
        -- ["--with-nth"] = "1,2,-5,-4,-3,-2,-1..",
        ["--with-nth"] = "1..",
      },

      -- **Add this block to enable icons**
      icons = {
        enable = true,       -- enable icons
        git_icons = true,    -- enable git status icons
        file_icons = true,   -- enable file type icons
      },
    })

    local map = vim.keymap.set

    -- Files
    map("n", "<leader>ff", fzf.files, { desc = "Find files" })

    -- Live grep (fast, streaming)
    map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })

    -- Recently opened files (fzf-lua cached)
    map("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })

    -- Grep in current buffer
    map("n", "<leader>fb", fzf.grep_curbuf, { desc = "Grep buffer" })

    -- Grep word under cursor
    map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word" })
  end,
}

