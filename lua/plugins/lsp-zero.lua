return {
  "williamboman/mason.nvim",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
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
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "clangd", "pyright", "bashls", "marksman", "html", "cssls" },
      automatic_installation = true,
    }

    local mason_bin = vim.fn.stdpath("data") .. "\\mason\\bin\\"

    -- C/C++
    vim.lsp.config["clangd"] = {
      cmd = { "clangd" },
      filetypes = { "c", "cpp" },
      root_dir = vim.fs.dirname(vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]),

      on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      callback = function(event)
        vim.lsp.start(vim.lsp.config["clangd"], { bufnr = event.buf })
      end,
    })

    -- HTML
    vim.lsp.config["html"] = {
		cmd = { mason_bin .. "vscode-html-language-server.cmd", "--stdio" },
        filetypes = { "html" },
        root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html" },
        callback = function(event)
            vim.lsp.start(vim.lsp.config["html"], { bufnr = event.buf })
        end,
    })
    -- CSS
    vim.lsp.config["cssls"] = {
        cmd = { "css-lsp" },
		cmd = { mason_bin .. "vscode-css-language-server.cmd", "--stdio" },
        filetypes = { "css" },
        root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "css" },
        callback = function(event)
            vim.lsp.start(vim.lsp.config["cssls"], { bufnr = event.buf })
        end,
    })
    -- JavaScript
    vim.lsp.config["ts_ls"] = {
        cmd = { "typescript-language-server", "--stdio" },
		cmd = { mason_bin .. "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = vim.fs.dirname(vim.fs.find({ "package.json", ".git" }, { upward = true })[1]),

        on_attach = function(client, bufnr)
            -- Optional: disable semantic tokens like clangd
            -- client.server_capabilities.semanticTokensProvider = nil
        end,
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function(event)
            vim.lsp.start(vim.lsp.config["ts_ls"], { bufnr = event.buf })
        end,
    })

    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
      update_in_insert = false,
    })

    -- lsp.nvim_workspace()
    --
    -- lsp.setup()

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
        -- Confirm completion with Enter
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

