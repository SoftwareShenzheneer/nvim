local M = {}

function M.setup()
  -- run()
end

function M.run()
  local filename_temp = vim.fn.expand("%")
  local filename = '"' .. filename_temp .. '"'

  local res = vim.fn.system("python " .. filename)

  create_floating_window({res}, {})
end

function create_floating_window(content, opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Get the current screen dimensions
  local screen_width = vim.o.columns
  local screen_height = vim.o.lines

  -- Calculate the position to center the window
  local row = math.floor((screen_height - height) / 2)
  local col = math.floor((screen_width - width) / 2)

  -- Create the floating window
  local bufnr = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(content[1], "\n"))

  -- Create the floating window with given options
  vim.api.nvim_open_win(bufnr, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
  })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"Done running.. Press enter to continue."})
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':q<CR>', { noremap = true, silent = true})

  -- Example usage
  -- This is only true if nvim_buf_set_lines is *slightly* adjusted; correct form in comment
  -- create_floating_window({"This is my personal message"}, {})
  -- create_floating_window({"Hello, this is a floating window!", "You can add more lines here."}, {width = 100, height = 10})
end

return M

