return {
  "iamcco/markdown-preview.nvim",
  -- build = "cd app && npm install",
  -- Might have to manually call: :call mkdp#util#install()
  build = function() vim.fn["mkdp#util#install"]() end,
  config = function()
    vim.g.mkdp_auto_start = 1 -- Automatically start preview on opening .md files
  end,
}
