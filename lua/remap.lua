vim.g.mapleader = " "

-- vim.wo.number = true
-- vim.wo.relativenumber = true

-- Toggle line numbers dynamically based on active window
vim.api.nvim_create_autocmd({"Filetype"}, {
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

-- vim.api.nvim_create_autocmd({"Filetype", "WinEnter", "BufEnter"}, {
--   callback = function()
--     vim.wo.number = true
--     vim.wo.relativenumber = true
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({"Filetype", "WinLeave", "BufLeave"}, {
--   callback = function()
--     -- vim.wo.number = false
--     vim.wo.number = true
--     vim.wo.relativenumber = false
--   end,
-- })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.o.scrolloff = 8
vim.o.mouse = 'a'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.cmd [[filetype plugin indent on]]
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

vim.opt.swapfile = false;

vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true })
vim.opt.colorcolumn = "100"
vim.cmd("highlight ColorColumn guibg=#2e2e2e")
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Right>", "<C-w>w", { noremap = true, silent = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", "\"_d", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>y", "\"+y", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", "\"+Y", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", "\"+y", { noremap = true, silent = true })

-- Obsidian remap
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true })

