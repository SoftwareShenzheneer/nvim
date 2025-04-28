return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        name = 'minimal',
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })

      -- (Optional) Configure lua language server for neovim
      -- vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      -- vim.diagnostic.disable()

      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = false,
        update_in_insert = false,
      })

      lsp.nvim_workspace()

      lsp.setup()

      -- Snippet Keybindings (Tab and Shift-Tab for placeholder navigation)
      local luasnip = require('luasnip')
      local cmp = require('cmp')

      -- Map Tab to jump to next placeholder or expand snippet
      config = function()
        local function jump_param()
          local col = vim.fn.col('.') - 1
          local line = vim.fn.getline('.')
          local before_cursor = line:sub(1, col)
          if before_cursor:match('%b()') then
            require'luasnip'.expand_or_jump()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true) 
          end
        end
      end

      -- Map Shift+Tab to jump to the previous placeholder
      vim.api.nvim_set_keymap('i', '<S-Tab>', [[lua require'luasnip'.jump(-1)]], { noremap = true, silent = true })

      -- Set up nvim-cmp with LuaSnip integration
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- Expand the LSP completion item with Luasnip
          end,
        },
        mapping = {
          -- Tab to trigger snippet expansion or jump
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()  -- Jump to the next placeholder or expand the snippet
            else
              fallback()  -- If not jumpable, fall back to regular completion
            end
          end, {'i', 's'}),

          -- Shift+Tab to jump backward through placeholders
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)  -- Jump backward through placeholders
            else
              fallback()  -- If not jumpable, fall back to regular completion
            end
          end, {'i', 's'}),

          -- Regular completion item selection
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },  -- Include LuaSnip for snippet completion
        },
      })
    end,
  }
}
