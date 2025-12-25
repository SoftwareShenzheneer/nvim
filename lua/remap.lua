-- General keymaps - not specifically ranked
vim.g.mapleader = " "

-- Toggle line numbers dynamically based on active window
vim.api.nvim_create_autocmd({"Filetype"}, {
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.showbreak = "↪ "
    vim.o.signcolumn = "yes"
  end,
})

-- Go back to explorer view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Try to keep 8 lines visible in screen
vim.o.scrolloff = 8

-- Allow mouse usage
vim.o.mouse = 'a'

-- Kind of obvious
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Show tabs/spaces
vim.cmd [[set list]]

-- Convert tabs into spaces automatically - consider turning this off..
vim.opt.expandtab = true
-- vim.opt.expandtab = false

-- Filetype specific highlighting
vim.cmd [[filetype plugin indent on]]

-- Clear highlighting on Esc
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Prevent getting the shada warning
vim.opt.swapfile = false;

-- Paste yanked line before to-delete-line
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true })

-- Set line at 100 char limit
vim.opt.colorcolumn = "100"
vim.cmd("highlight ColorColumn guibg=#2e2e2e")

-- Jump up and down through code, centre around next jump
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Shift focus to next buffer
vim.keymap.set("n", "<C-S-Right>", "<C-w>w", { noremap = true, silent = true })

-- Jump to next/previous search term
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Move selected region up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Delete into the void
vim.keymap.set("n", "<leader>d", "\"_d", { noremap = true, silent = true })

-- Global yank commands: yank with a motino, yank a whole line, yank selected section
vim.keymap.set("n", "<leader>y", "\"+y", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", "\"+Y", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", "\"+y", { noremap = true, silent = true })

-- Obsidian remap
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })

-- Custom remap for builds and shit
-- vim.keymap.set('n', '<C-b>', '<Cmd>Build<CR>', { noremap = true, silent = true })

