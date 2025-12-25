-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)
require("remap")
require("lazy").setup("plugins")
-- require("dev.myplugin").setup()

-- Determine undo directory inside stdpath('data')
local undo_dir = vim.fn.stdpath('data') .. '/undo_history'

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, 'p')
end

-- Set undo options
vim.opt.undodir = undo_dir
vim.opt.undofile = true

-- Optional: increase undo history limits
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000

